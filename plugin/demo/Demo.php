<?php

namespace plugin\demo;

use app\common\library\Menus;
use think\plugin;
/**
 * 演示插件
 */
class Demo extends plugin
{
    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        $menu = [
            [
                'title'    => '测试插件',
                'router'   => '/demo.index/index',
                'icons'    => 'layui-icon-app',
                'auth'    => '1', // 是否鉴权
                'children' => [
                    ['router' => '/demo.index/index', 'title' => '查看'],
                    ['router' => '/demo.index/add', 'title' => '添加'],
                    ['router' => '/demo.index/edit', 'title' => '编辑'],
                    ['router' => '/demo.index/execute', 'title' => '运行'],
                    ['router' => '/demo.index/del', 'title' => '删除'],
                    ['router' => '/demo.index/multi', 'title' => '批量更新'],
                ]
            ],
        ];
        
        // 创建菜单
        Menus::create($menu,'demo');
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        Menus::delete('demo');
        return true;
    }

    /**
     * 插件启用方法
     * @return bool
     */
    public function enable()
    {
        Menus::enable('demo');
        return true;
    }

    /**
     * 插件禁用方法
     * @return bool
     */
    public function disable()
    {
        Menus::disable('demo');
        return true;
    }

    /**
     * 插件初始化
     * @return bool
     */
    public function appInit() {
        
    }

    /**
     * 侧边栏导航
     * @return bool
     */
    public function user_sidenav_after() {
        return $this->fetch('hook/nav');
    }
    
}
