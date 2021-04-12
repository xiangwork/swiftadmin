<?php
// +----------------------------------------------------------------------
// | 应用设置
// +----------------------------------------------------------------------

return [
    // 应用地址
    'app_host'         => env('app.host', ''),
    // 应用的命名空间
    'app_namespace'    => '',

    // 是否启用路由
    'with_route'       => true,
    // 默认应用
    'default_app'      => 'index',
    // 默认时区
    'default_timezone' => 'Asia/Shanghai',

    // 应用映射（自动多应用模式有效）
    'app_map'          => [],
    
    // 域名绑定（自动多应用模式有效）
    'domain_bind'      => [
        'api'        =>  'api', 
        '*'          =>  'index', 
    ],
    // 禁止URL访问的应用列表（自动多应用模式有效）
    'deny_app_list'    => ['common'],
    
	// 自定义页面abort抛出异常
	'http_exception_template'    =>  [
		404 =>  public_path() . '404.html',
		401 =>  public_path() . '401.html',
		500 =>  public_path() . '500.html',
    ],

    // 默认跳转页面对应的模板文件
    'dispatch_error'   => app_path(). 'admin/view/public/tplerror.html',
    'dispatch_success' => app_path(). 'admin/view/public/tplsuccess.html',
    
    // 异常页面的模板文件
    'exception_tmpl'   => app()->getThinkPath() . 'tpl/think_exception.tpl',

    // 错误显示信息,非调试模式有效
    'error_message'    => '页面错误！请稍后再试～',

    //API接口地址
    'api_url'          => 'http://api.swiftadmin.net',

    // 显示错误信息
    'show_error_msg'   => false,
];
