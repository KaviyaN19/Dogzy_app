<?php
include "config.php";

header("Content-Type: application/json");

// ACCEPT EMAIL FROM GET (URL PARAM)
$email = $_GET['email'] ?? '';

// VALIDATION
if (trim($email) === "") {
    echo json_encode([
        "status" => false,
        "message" => "Email is required"
    ]);
    exit;
}

// ✅ USE PREPARED STATEMENT (SECURE)

// CHECK USER EXISTS
$checkStmt = $conn->prepare(
    "SELECT id FROM users WHERE email = ?"
);
$checkStmt->bind_param("s", $email);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if ($checkResult->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "User not found"
    ]);
    exit;
}

// FETCH HEALTH RECORDS
$recordStmt = $conn->prepare(
    "SELECT disease_name, likelihood, symptoms, precautions, created_at
     FROM health_records
     WHERE email = ?
     ORDER BY created_at DESC"
);
$recordStmt->bind_param("s", $email);
$recordStmt->execute();
$result = $recordStmt->get_result();

$records = [];

while ($row = $result->fetch_assoc()) {
    $records[] = [
        "disease_name" => $row["disease_name"],
        "likelihood"   => (float)$row["likelihood"],
        "symptoms"     => json_decode($row["symptoms"], true) ?? [],
        "precautions"  => json_decode($row["precautions"], true) ?? [],
        "created_at"   => $row["created_at"]
    ];
}

// SUCCESS RESPONSE
echo json_encode([
    "status" => true,
    "data" => $records
]);
