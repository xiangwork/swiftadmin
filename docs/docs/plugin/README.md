## 目录结构
---
``` php
demo
├── app             // 此文件夹中所有文件会覆盖到根目录的/app文件夹
├── controller      // 此文件夹为插件前台控制器目录
├── lang            // 此文件夹为插件语言包目录
├── model           // 此文件夹为插件模型目录
├── public          // 此文件夹中所有文件会覆盖到根目录的/public文件夹
├── view            // 此文件夹为插件视图目录
├── Demo.php        // 此文件为插件核心安装卸载控制器,必需存在
├── config.php      // 插件配置文件,我们在后台插件管理中点配置按钮时配置的文件,必需存在
├── config.html     // 插件配置模板，如不存在则无配置项
├── function.php    // 全局的插件函数文件
├── Service.php     // 插件服务文件
├── install.sql     // 插件数据库安装文件,此文件仅在插件安装时会进行导入
├── LICENSE         // 版权文件
```

## 插件配置

``` php
return [
  'name' => 'demo',
  'title' => '测试插件',
  'intro' => '这是一个测试插件',
  'author' => '这里是作者信息',
  'website' => 'swiftadmin',
  'version' => '1.0',
  'status' => 1,
  'extends' => 
    [
      'title' => '这里是扩展配置信息',
    ],
    'rewrite'=>  // 插件的伪静态信息
    [
      '/abc$' => 'abc/index',
    ],
];
```
### 插件菜单
---
``` php
$menu = [
    [
        'title'    => '测试插件',
        'router'   => '/command/index', // 如果你当前菜单下存在子菜单，那么请将路由设置为# 
                                        // 请参考控制台 数据库表
        'icons'    => 'layui-icon-app',
        'auth'    => '1', // 是否鉴权
        'children' => [
            ['router' => '/command/index', 'title' => '查看'],
            ['router' => '/command/add', 'title' => '添加'],
            ['router' => '/command/detail', 'title' => '详情'],
            ['router' => '/command/execute', 'title' => '运行'],
            ['router' => '/command/del', 'title' => '删除'],
            ['router' => '/command/multi', 'title' => '批量更新'],
        ]
    ]
];

// 二级菜单设置
    [
        'title'    => '测试插件2',
        'router'   => '#',
        'icons'    => 'layui-icon-app',
        'auth'    => '1', 
        'children' => [
            [
                'router' => '/fenlei1/index', 
                'title' => '分类1',
                'children'=> [
                    ['router' => '/fenlei1/add', 'title' => '添加'],
                    ['router' => '/fenlei1/detail', 'title' => '详情'],
                    ['router' => '/fenlei1/execute', 'title' => '运行'],
                    ['router' => '/fenlei1/del', 'title' => '删除'],
                    ['router' => '/fenlei1/multi', 'title' => '批量更新'],
                ],
            ],
            [
                'router' => '/fenlei2/index', 
                'title' => '分类2',
                'children'=> [
                    ['router' => '/fenlei2/add', 'title' => '添加'],
                    ['router' => '/fenlei2/detail', 'title' => '详情'],
                    ['router' => '/fenlei2/execute', 'title' => '运行'],
                    ['router' => '/fenlei2/del', 'title' => '删除'],
                    ['router' => '/fenlei2/multi', 'title' => '批量更新'],
                ],
            ],                   
        ]
    ],
```
## 插件服务

::: tip 提示
插件服务需要自行进行注册，你可以在插件根目录建立service.php,并在自己插件的启用和关闭的时候，<br/>
修改vendor目录下的service.php文件进行自动加载！服务文件的编写规则请参考thinkphp官方代码！
:::
## 插件钩子

| 序号 | 钩子 | 类型 | 描述 |
| --- | --- | --- | --- |
| 1 | appInit | plugin | 插件初始化前触发 |
| 2 | user_sidenav_before | plugin | 用户左侧菜单前置 |
| 3 | user_sidenav_after | plugin | 用户左侧菜单后置 |
| 4 | template | 插件 | 插件安装，禁用启用，切换模板触发 |
| 5 | clouduploads | 插件 | 支持腾讯云阿里云上传钩子 |

以上是系统预留的钩子信息！！！你可以自行在代码中增加函数钩子，并将需要的钩子在gitee上提交PR
