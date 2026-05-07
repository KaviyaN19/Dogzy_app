<?php
include "config.php";

// FORM-DATA inputs
$full_name  = $_POST['full_name'] ?? '';
$email      = $_POST['email'] ?? '';
$password   = $_POST['password'] ?? '';
$mobile     = $_POST['mobile'] ?? '';

$pet_name   = $_POST['pet_name'] ?? '';
$pet_age    = $_POST['pet_age'] ?? '';
$pet_breed  = $_POST['pet_breed'] ?? '';
$pet_weight = $_POST['pet_weight'] ?? '';

// Allowed dog breeds
$allowed_breeds = [
    "Labrador Retriever",
    "German Shepherd",
    "Golden Retriever",
    "Bulldog",
    "Poodle",
    "Beagle",
    "Rottweiler",
    "Doberman Pinscher",
    "Siberian Husky",
    "Pug",
    "Chihuahua",
    "Boxer"
];

// Basic validation
if ($full_name === "" || $email === "" || $password === "") {
    echo json_encode([
        "status" => false,
        "message" => "Required fields missing"
    ]);
    exit;
}

// Breed validation
if ($pet_breed !== "" && !in_array($pet_breed, $allowed_breeds)) {
    echo json_encode([
        "status" => false,
        "message" => "Invalid dog breed selected"
    ]);
    exit;
}

// Check email already exists
$check = mysqli_query($conn, "SELECT id FROM users WHERE email='$email'");
if (mysqli_num_rows($check) > 0) {
    echo json_encode([
        "status" => false,
        "message" => "Email already registered"
    ]);
    exit;
}

// Insert user (NO HASHING)
$query = "INSERT INTO users 
(full_name, email, password, mobile, pet_name, pet_age, pet_breed, pet_weight)
VALUES
('$full_name', '$email', '$password', '$mobile',
 '$pet_name', '$pet_age', '$pet_breed', '$pet_weight')";

if (mysqli_query($conn, $query)) {
    echo json_encode([
        "status" => true,
        "message" => "Registration successful"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Registration failed"
    ]);
}
?>
