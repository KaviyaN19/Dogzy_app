<?php
$host = "localhost";
$user = "root";        // change if needed
$password = "";        // change if needed
$dbname = "dogzy_db";

$conn = mysqli_connect($host, $user, $password, $dbname);

if (!$conn) {
    echo json_encode([
        "status" => false,
        "message" => "Database connection failed"
    ]);
    exit;
}
?>
