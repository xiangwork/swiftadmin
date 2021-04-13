<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;

class Rewrite extends AdminController 
{
    // 列表页模式
    protected $list_page;
    // 内容页模式
    protected $content_page;

    // 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->list_page = [
            '{listdir}/list_{page}.html',
            '{listdir}/{sublist}/list_{page}.html'
        ];

        $this->content_page = [
            '{listdir}/{id}/',
            '{listdir}/{id}.html',
            '{listdir}/{sublist}/{id}.html'
        ];
    }

    /**
     * 获取资源 
     */    
    public function index() 
    {

        $total = 0; // 读取配置
        $rewrite = config('system.rewrite');
        $sitemap = config('system.sitemap');
        $map_xml_path = public_path().$sitemap['map_xml_path'];
        $result = glob($map_xml_path.'/*.xml');
        foreach ($result as $key => $value) {
           $xmlfile = simplexml_load_file($value);
           $total += count($xmlfile);
           unset($xmlfile);
        }

        // 数据统计
        $sitemap['total'] = $total;     
        $sitemap['count'] = count($result);
        return view('',[
            'rewrite'=> $rewrite,
            'sitemap'=> $sitemap,
            'listPage' => $this->list_page,
            'contentPage'=> $this->content_page
            ]
        );
    }

    /**
     * 写入配置项
     */
    public function basecfg() 
    {
        if (request()->isPost()) {
            $post = input();
            $config = config('system');
            $config = array_merge($config, $post);
            if (arr2file('../config/system.php', $config) === false) {
                return $this->error('保存失败，请重试!');
            }

            return $this->error('保存成功！');
        }

        // TODO...
    }

}   