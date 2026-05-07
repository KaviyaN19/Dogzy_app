<?php
include "config.php";

// FORM DATA
$email        = $_POST['email'] ?? '';
$disease_name = $_POST['disease_name'] ?? '';
$likelihood   = $_POST['likelihood'] ?? '';
$symptoms     = $_POST['symptoms'] ?? '[]';
$precautions  = $_POST['precautions'] ?? '[]';

// BASIC VALIDATION
if ($email == "" || $disease_name == "") {
    echo json_encode([
        "status" => false,
        "message" => "Required fields missing"
    ]);
    exit;
}

// CHECK USER EXISTS
$checkUser = mysqli_query(
    $conn,
    "SELECT id FROM users WHERE email='$email'"
);

if (mysqli_num_rows($checkUser) == 0) {
    echo json_encode([
        "status" => false,
        "message" => "User not found"
    ]);
    exit;
}

// INSERT HEALTH RECORD (NO RECORD DATE)
$query = "INSERT INTO health_records
(email, disease_name, likelihood, symptoms, precautions)
VALUES
('$email', '$disease_name', '$likelihood', '$symptoms', '$precautions')";

if (mysqli_query($conn, $query)) {
    echo json_encode([
        "status" => true,
        "message" => "Health record saved successfully"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Failed to save health record"
    ]);
}
?>
