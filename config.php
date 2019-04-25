<?php
    define('HOST','localhost');
    define('USER','root');
    define('PWD','');
    define('DB','basedb');

    $con = mysqli_connect(HOST, USER, PWD, DB) or die("Impossible de se connecter au serveur de base de donnees!");
