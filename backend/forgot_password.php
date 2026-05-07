<?php
include "config.php";

// FORM-DATA values
$full_name        = $_POST['full_name'] ?? '';
$email            = $_POST['email'] ?? '';
$new_password     = $_POST['new_password'] ?? '';
$confirm_password = $_POST['confirm_password'] ?? '';

// validation
if ($full_name == "" || $email == "" || $new_password == "" || $confirm_password == "") {
    echo json_encode([
        "status" => false,
        "message" => "All fields are required"
    ]);
    exit;
}

if ($new_password !== $confirm_password) {
    echo json_encode([
        "status" => false,
        "message" => "Passwords do not match"
    ]);
    exit;
}

// check user existence
$query = "SELECT id FROM users WHERE full_name='$full_name' AND email='$email'";
$result = mysqli_query($conn, $query);

if (mysqli_num_rows($result) == 0) {
    echo json_encode([
        "status" => false,
        "message" => "User not found"
    ]);
    exit;
}

// hash new password
$hashed_password = password_hash($new_password, PASSWORD_BCRYPT);

// update password
$update = "UPDATE users SET password='$hashed_password' WHERE email='$email'";

if (mysqli_query($conn, $update)) {
    echo json_encode([
        "status" => true,
        "message" => "Password updated successfully"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Password update failed"
    ]);
}
?>
