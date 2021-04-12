<?php

use app\Request;
use app\ExceptionHandle;
use app\common\exception\Provider;

// 容器Provider定义文件
return [
    'think\Request'          => Request::class,
    'think\exception\Handle' => Provider::class,
];
