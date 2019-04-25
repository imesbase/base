<?php

    session_start();
    echo "<h1>Bienvenue ".$_SESSION['admin']['login']."</h1>";