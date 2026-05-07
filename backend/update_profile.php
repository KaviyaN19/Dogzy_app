<?php
include "config.php";

/* ---------------------------------------
   ENABLE ERRORS (DEV ONLY)
--------------------------------------- */
error_reporting(E_ALL);
ini_set('display_errors', 1);

/* ---------------------------------------
   READ FORM-DATA
--------------------------------------- */
$email      = trim($_POST['email'] ?? '');
$full_name  = trim($_POST['full_name'] ?? '');
$mobile     = trim($_POST['mobile'] ?? '');
$password   = $_POST['password'] ?? '';

$pet_name   = trim($_POST['pet_name'] ?? '');
$pet_age    = trim($_POST['pet_age'] ?? '');
$pet_weight = trim($_POST['pet_weight'] ?? '');
$pet_breed  = trim($_POST['pet_breed'] ?? '');

/* ---------------------------------------
   BASIC VALIDATION
--------------------------------------- */
if ($email === '') {
    echo json_encode([
        "status" => false,
        "message" => "Email is required"
    ]);
    exit;
}

/* ---------------------------------------
   PASSWORD UPDATE (OPTIONAL)
--------------------------------------- */
$password_sql = "";
$password_param = null;

if (!empty($password)) {
    $password_param = password_hash($password, PASSWORD_BCRYPT);
    $password_sql = ", password = ?";
}

/* ---------------------------------------
   IMAGE UPLOAD (OPTIONAL)
--------------------------------------- */
$image_sql = "";
$image_param = null;

if (isset($_FILES['profile_image']) && $_FILES['profile_image']['error'] === 0) {

    $uploadDir = __DIR__ . "/uploads/profile_images/";
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    $extension = pathinfo($_FILES['profile_image']['name'], PATHINFO_EXTENSION);
    $newFileName = uniqid("profile_", true) . "." . $extension;
    $targetPath = $uploadDir . $newFileName;
    $dbImagePath = "uploads/profile_images/" . $newFileName;

    if (move_uploaded_file($_FILES['profile_image']['tmp_name'], $targetPath)) {
        $image_sql = ", profile_image = ?";
        $image_param = $dbImagePath;
    }
}

/* ---------------------------------------
   BUILD QUERY (PREPARED)
--------------------------------------- */
$sql = "
UPDATE users SET
    full_name = ?,
    mobile = ?,
    pet_name = ?,
    pet_age = ?,
    pet_weight = ?,
    pet_breed = ?
    $password_sql
    $image_sql
WHERE email = ?
";

$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode([
        "status" => false,
        "message" => "Prepare failed",
        "error" => $conn->error
    ]);
    exit;
}

/* ---------------------------------------
   BIND PARAMETERS DYNAMICALLY
--------------------------------------- */
$params = [
    $full_name,
    $mobile,
    $pet_name,
    $pet_age,
    $pet_weight,
    $pet_breed
];

$types = "ssssss";

if ($password_sql !== "") {
    $params[] = $password_param;
    $types .= "s";
}

if ($image_sql !== "") {
    $params[] = $image_param;
    $types .= "s";
}

$params[] = $email;
$types .= "s";

$stmt->bind_param($types, ...$params);

/* ---------------------------------------
   EXECUTE
--------------------------------------- */
if ($stmt->execute()) {
    echo json_encode([
        "status" => true,
        "message" => "Profile updated successfully"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Profile update failed",
        "error" => $stmt->error
    ]);
}

$stmt->close();
$conn->close();
