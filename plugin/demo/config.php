<?php
return [
  'name' => 'demo',
  'title' => '测试插件',
  'intro' => '这是一个测试插件',
  'author' => '官方',
  'website' => 'www.swiftadmin.net',
  'version' => '1.0.1',
  'status' => 0,
  'extends' => [
    'title' => '这里是扩展配置信',
  ],
  'rewrite' => [
    '/demo1$' => 'index/index',
    '/demo2$' => 'index/list',
    '/demo3$' => 'index/query',
  ],
  'area' => [
    0 => '600px',
    1 => '650px',
  ],
  'auto' => true,
  'config' => 1,
  'url' => '/plugin/demo',
];