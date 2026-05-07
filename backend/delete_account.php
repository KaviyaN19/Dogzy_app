<?php
include "config.php";

$email = $_POST['email'] ?? '';

if ($email == '') {
    echo "Email required";
    exit;
}

/* GET PROFILE IMAGE PATH */
$getImg = mysqli_query($conn, "SELECT profile_image FROM users WHERE email='$email'");
if ($row = mysqli_fetch_assoc($getImg)) {
    if ($row['profile_image'] != "" && file_exists($row['profile_image'])) {
        unlink($row['profile_image']);
    }
}

/* DELETE ALL USER DATA */
mysqli_begin_transaction($conn);

mysqli_query($conn, "DELETE FROM health_records WHERE email='$email'");
mysqli_query($conn, "DELETE FROM users WHERE email='$email'");

mysqli_commit($conn);

echo "Account deleted successfully";
?>
