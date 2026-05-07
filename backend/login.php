<?php
include "config.php";

header('Content-Type: application/json');

// ===============================
// 📥 FORM DATA
// ===============================
$email    = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';

// ===============================
// ❌ BASIC VALIDATION
// ===============================
if ($email === "" || $password === "") {
    echo json_encode([
        "status" => false,
        "message" => "Email and password required"
    ]);
    exit;
}

// ===============================
// 🔍 FETCH USER (SECURE QUERY)
// ===============================
$stmt = $conn->prepare(
    "SELECT id, full_name, email, mobile, pet_name, pet_breed, password 
     FROM users 
     WHERE email = ?"
);
$stmt->bind_param("s", $email);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "User not found"
    ]);
    exit;
}

$user = $result->fetch_assoc();

// ===============================
// ❌ PLAIN TEXT PASSWORD CHECK
// ===============================
if ($password !== $user['password']) {
    echo json_encode([
        "status" => false,
        "message" => "Invalid password"
    ]);
    exit;
}

// ===============================
// ✅ LOGIN SUCCESS
// ===============================
echo json_encode([
    "status" => true,
    "message" => "Login successful",
]);

$stmt->close();
$conn->close();
?>
