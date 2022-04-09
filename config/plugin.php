<?php
return [
  'autoload' => false,
  'hooks' => [
    'appInit' => [
      0 => 'demo',
    ],
    'user_sidenav_after' => [
      0 => 'demo',
    ]
  ],
  'router' => [
    '/demo1$' => 'demo/index/index',
    '/demo2$' => 'demo/index/list',
    '/demo3$' => 'demo/index/query',
  ],
  'priority' => [
  ],
];