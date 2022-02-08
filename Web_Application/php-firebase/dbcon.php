<?php

     require 'vendor/autoload.php';
     require 'vendor/google/gax/src/Serializer.php';

     use Kreait\Firebase\Factory;

     $factory = (new Factory)->withServiceAccount(__DIR__.'/techdemo1healthlit-firebase-adminsdk-mqveu-9d309dc732.json');
     $database = $factory->createFirestore();

 ?>
