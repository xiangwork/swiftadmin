<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\Friendlink  as FriendlinkModel;

class Friendlink extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
        $this->model = new FriendlinkModel();
    }

    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post  = input();
            $status = !empty($post['status']) ? $post['status']-1:1;

            $where = array();
            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }
            
            $where[]=['status','=',$status];

            // 生成查询数据
            $list = $this->model->where($where)->order("id asc")->select()->toArray();
            return $this->success('查询成功', "", $list, count($list));
        }

		return view();
    }    
    
}