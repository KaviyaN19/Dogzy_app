<?php
header("Content-Type: application/json");
include "config.php";

// ✅ Get breed from query params
$breed = isset($_GET['breed']) ? trim($_GET['breed']) : "";

// ✅ Validation
if ($breed === "") {
    echo json_encode([
        "status" => false,
        "message" => "Breed is required"
    ]);
    exit;
}

// ✅ Prepared statement (SECURE)
$stmt = $conn->prepare(
    "SELECT 
        breed_name,
        portion_guide,
        portion_details,
        recommended_foods,
        foods_to_avoid
     FROM diet_plans
     WHERE breed_name = ?"
);

$stmt->bind_param("s", $breed);
$stmt->execute();
$result = $stmt->get_result();

// ❌ No data found
if ($result->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "Diet plan not found"
    ]);
    exit;
}

// ✅ Fetch data
$row = $result->fetch_assoc();

// ✅ Final response
echo json_encode([
    "status" => true,
    "breed" => $row['breed_name'],
    "portion_guide" => $row['portion_guide'],
    "portion_details" => json_decode($row['portion_details'], true),
    "recommended_foods" => json_decode($row['recommended_foods'], true),
    "foods_to_avoid" => json_decode($row['foods_to_avoid'], true)
]);

$stmt->close();
$conn->close();
