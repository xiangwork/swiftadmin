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

namespace app\admin\controller\system;

use app\AdminController;
use app\common\model\system\Pluginhook as PluginhookModel;

class Pluginhook extends AdminController
{

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
        $this->model = new PluginhookModel();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post = input();
            $where = array();
            $status = !empty($post['status'])?$post['status']-1:1;
            
            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }

            // 生成查询数据
            $where[]=['status','=',$status];
            $list = $this->model->where($where)->order("id asc")->select()->toArray();
            return $this->success('查询成功', "", $list, count($list));
          
        }

        return view();
    }

}
