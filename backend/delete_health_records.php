<?php
header("Content-Type: application/json; charset=UTF-8");
include "config.php";

// Read input (POST or JSON)
$input = json_decode(file_get_contents("php://input"), true);
$email = $_POST['email'] ?? ($input['email'] ?? '');

if (empty($email)) {
    echo json_encode([
        "status" => false,
        "message" => "Email is required"
    ]);
    exit;
}

// Delete user
$stmt = mysqli_prepare(
    $conn,
    "DELETE FROM users WHERE email = ?"
);

mysqli_stmt_bind_param($stmt, "s", $email);

if (mysqli_stmt_execute($stmt)) {
    echo json_encode([
        "status" => true,
        "message" => "Account deleted successfully"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Failed to delete account"
    ]);
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
exit;
?>
