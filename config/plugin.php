<?php
return [
  'autoload' => false,
  'hooks' => [
    'appInit' => [
      0 => 'cloudfiles',
    ],
    'clouduploads' => [
      0 => 'cloudfiles',
    ],
  ],
  'router' => [
  ],
  'priority' => [
  ],
];