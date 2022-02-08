<html>

<head>
     <title>HealthLit Admin Portal</title>
</head>
<body>
     <?php
          echo "Modules";
      ?>
      <div id="portalNav">
        <a href="index.php">Home</a>
        <a href="Users.php">Users</a>
        <a href="Modules.php">Modules</a>
      </div>

      <?php
          require 'php-firebase/dbcon.php';
          
       ?>

</html>
