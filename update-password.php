<!doctype html>
<html lang="en">
<?php include 'partials/head.php'; ?>
<body>
<?php include 'partials/header.php' ?>
<?php global $errors, $db, $mail; ?>
<!----------------------------------------------------------------------------------->
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(!isset($_GET['token'])) return array_push($errors, "No token provided");
    if(empty($_POST['password'])) return array_push($errors, "Password is required");

    $token = $_GET['token'];
    [$result, $error] = $db->query("SELECT users.id, users.email FROM users JOIN tokens ON users.id = tokens.user_id WHERE tokens.token = ? AND tokens.is_valid = true", $token);
    if ($error) return array_push($errors, $error);

    $user = $result->first();
    if (!$user) return array_push($errors, "Invalid Token");

    $user_id = $user->get('id');
    $password = $_POST['password'];

    [$result, $error] = $db->query("UPDATE users SET password = ? WHERE id = ?", $password, $user_id);
    if ($error) return array_push($errors, $error);

    [$result, $error] = $db->query("UPDATE tokens SET is_valid = false WHERE user_id = ?", $user_id);
    if ($error) return array_push($errors, $error);

    redirect("/login.php");
}
?>
<main>

</main>

<!---------------------------------------------------------------------------------->
<?php include 'partials/footer.php'; ?>
</body>
</html>