<?php
return [
  'autoload' => false,
  'hooks' => [
    'appInit' => [
      0 => 'cloudfiles',
      1 => 'demo',
    ],
    'clouduploads' => [
      0 => 'cloudfiles',
    ],
    'user_sidenav_after' => [
      0 => 'demo',
    ],
  ],
  'router' => [
    '/demo1$' => 'demo/index/index',
    '/demo2$' => 'demo/index/list',
    '/demo3$' => 'demo/index/query',
  ],
  'priority' => [
  ],
];