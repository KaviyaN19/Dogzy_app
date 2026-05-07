<?php
include "config.php";

/* ---------------------------------------
   DEV MODE (TURN OFF IN PROD)
--------------------------------------- */
error_reporting(E_ALL);
ini_set('display_errors', 1);

/* ---------------------------------------
   INPUT
--------------------------------------- */
$email = trim($_POST['email'] ?? '');

if ($email === '') {
    echo json_encode([
        "status" => false,
        "message" => "Email is required"
    ]);
    exit;
}

/* ---------------------------------------
   QUERY
--------------------------------------- */
$sql = "
SELECT 
    full_name,
    email,
    mobile,
    pet_name,
    pet_age,
    pet_weight,
    pet_breed,
    profile_image
FROM users
WHERE email = ?
LIMIT 1
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

$stmt->bind_param("s", $email);
$stmt->execute();

$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {

    echo json_encode([
        "status" => true,
        "data" => [
            "full_name"     => $row['full_name'],
            "email"         => $row['email'],
            "mobile"        => $row['mobile'],
            "pet_name"      => $row['pet_name'],
            "pet_age"       => $row['pet_age'],
            "pet_weight"    => $row['pet_weight'],
            "pet_breed"     => $row['pet_breed'],
            "profile_image" => $row['profile_image']
                ? "http://localhost/dogzy_api/" . $row['profile_image']
                : null
        ]
    ]);

} else {

    echo json_encode([
        "status" => false,
        "message" => "User not found"
    ]);
}

$stmt->close();
$conn->close();
