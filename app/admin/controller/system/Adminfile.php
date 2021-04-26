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

class AdminFile extends AdminController
{
    // 上传文件夹地址
    protected $upload;

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
        $this->upload = saenv('upload_path');
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isPost()) {

            $dir = input('path/s');
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 20;

            $files = [];
            $path = public_path() . $this->upload . $dir;
            $list = traverse_opendir($path,false); // 非递归模式！
            $count = count($list);

            // 排序
            foreach ($list as $key => $value) {
                $file = $path.'/'.$value;
                if (is_dir($file)) {
                    unset($list[$key]);
                    $files[$key] = $value;
                }
            } 

            if (!empty($list)) {
                $files = array_merge($files,$list);
                $files = array_chunk($files,$limit);
                $files = $files[$page - 1];
            }

            $result = [];
            foreach ($files as $key => $value) {
                $file = $path.'/'.$value;
                $result[$key]['name'] = $value;
                $result[$key]['size'] = format_bytes(filesize($file));
                $result[$key]['time'] = date("Y-m-d H:i:s",filemtime($file));

                if (is_dir($file)) {
                   
                    $result[$key]['type'] = 'dir';
                    $result[$key]['path'] = $dir.'/'.$value; // 参数地址很重要。
                }else {
                    $result[$key]['type'] = substr($value, strrpos($value, '.')+1);
                    $result[$key]['path'] = '/'.$this->upload.$dir.'/'.$value;
                }
            }
           
            return $this->success('ok','',$result,$count,0);
        }

        return view();
    }

    /**
     * 覆盖添加方法
     */
    public function add() {

    }

    public function edit() {

    }

    public function del() {
        
    }
}
