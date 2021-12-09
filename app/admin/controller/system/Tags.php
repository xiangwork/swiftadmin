<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\Tags as TagsModel;

class Tags extends AdminController
{

	// 初始化操作
    public function initialize() 
    {
		parent::initialize();
        $this->model = new TagsModel();
    }

    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post  = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            $type  = !empty($post['type']) ? $post['type']-1:1;
            $status = !empty($post['status']) ? $post['status']-1:1;

            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['name','like','%'.$post['name'].'%'];
            }
            
            $where[]=['type','=',$type];
            $where[]=['status','=',$status];
            
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;            

            // 生成查询数据
            $list = $this->model->where($where)->order("id desc")->limit($limit)->page($page)->select()->toArray();
            return $this->success('查询成功', "", $list, $count);
        }

		return view();
    }

}
