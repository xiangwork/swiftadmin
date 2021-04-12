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
use app\common\model\system\Department as DepartmentModel;

class Department extends AdminController
{
	// 初始化函数
    public function initialize() {
		parent::initialize();
        $this->model = new DepartmentModel();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
		if (request()->isAjax()) {
			
			// 查询参数
			$where = array();
			$post['head'] = input('head');
			$post['status'] = input('status') ?? 1;
			if (!empty($post['head'])) {
				$where[] = ['head','like','%'.$post['head'].'%'];
			}

			$where[] = ['status','=',$post['status']];

			// 获取总数
			$total = $this->model->count();
			$list = $this->model->where($where)->order('sort asc')->select()->toArray();
			foreach ($list as $key => $value) {
				$list[$key]['title'] = __($value['title']);
			}

			// 自定义查询
			if (count($list) < $total) {

				$parentNode = []; // 查找父节点
				foreach ($list as $key => $value) {
					if ($value['pid'] !== 0 && !list_search($list,['id'=>$value['pid']])) {
						$parentNode[] = $this->parentNode($value['pid']);
					}
				}

				foreach ($parentNode as $key => $value) {
					$list = array_merge($list,$value);
				}

				return $this->success('查询成功', '', $list, count($list), 0);
			}

			return $this->success('获取成功', '', $list, count($list), 0);
		}

		return view();
	}

	/**
	 * 添加部门数据
	 */
	public function add() 
	{

		if (request()->isPost()) {
			$post = input('post.');
			$post = safe_field_model($post, $this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
			}
			if ($this->model->create($post)) {
				return $this->success('添加部门成功！');
			}else {
				return $this->error('添加部门失败！');
			}		
		}			
	}

	/**
	 * 编辑部门数据
	 */
	public function edit() 
	{
		if (request()->isPost()) {
			$post = input('post.');
			$post = safe_field_model($post, $this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
			}
			if ($this->model->update($post)) {				
				return $this->success('更新部门成功！');
			}else {
				return $this->error('更新部门失败');
			}
		}	
	}

	/**
	 * 删除部门数据
	 */
	public function del() 
	{
		$id = input('id');
		if (!empty($id) && is_numeric($id)) {
			// 查询子部门
			if ($this->model->where('pid',$id)->count()) {
				return $this->error('当前部门存在子部门！');
			}

			// 删除单个
			if ($this->model::destroy($id)) {
				return $this->success('删除部门成功！');
			}
		}
		
		return $this->error('删除失败，请检查您的参数！');
	}


	/**
	 * 获取部门数据
	 */
	public function getListTree() 
	{
		if (request()->isAjax()) {
			$nodes = $this->model->getListTree();
			return json($nodes);
		}
	}
}