<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>  MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller;


use app\AdminController;


class Tpl extends AdminController
{
    /**
     * 读取模板列表
     */
    public function showtpl() 
    {
        // 读取配置文件
        $list = include (root_path().'extend/conf/tpl/tpl.php');
        foreach ($list as $key => $value) {
            $list[$key]['param'] = str_replace('extend/conf/tpl/','',$value['path']);
        }
        
        return view('',['list'=>$list]);
    }
    
    /**
     * 编辑邮件模板
     */
    public function edittpl() 
    {
        if (request()->isPost()) {
            $post = input();
            $tpl = root_path().'extend/conf/tpl/'.$post['tpl'];
            if (write_file($tpl,$post['content'])) {
                return $this->success('修改邮件模板成功！');
            }
            
            return $this->error('修改邮件模板失败！');
        }

        // 获取模板参数
        $tpl = input('p/s');
        $content = read_file(root_path().'extend/conf/tpl/'.$tpl);
        return view('',['tpl'=>$tpl,'content'=>$content]);
    }

}