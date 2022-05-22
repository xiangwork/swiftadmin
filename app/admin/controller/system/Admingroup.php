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
use app\common\model\system\AdminGroup as AdminGroupModel;
class AdminGroup extends AdminController
{
	// 初始化函数
    public function initialize() 
	{
		parent::initialize();
		$this->model = new AdminGroupModel();
		$this->middleware = [\app\admin\middleware\system\AdminGroup::class];
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
	   if (request()->isAjax()) {

			$param = input();
			$param['page'] = input('page/d');
			$param['limit'] = input('limit/d');

			// 查询条件
			$where = array();
			if (!empty($param['title'])) {
				$where[] = ['title','like','%'.$param['title'].'%'];
			}
			if (!empty($param['alias'])) {
				$where[] = ['alias','like','%'.$param['alias'].'%'];
			}
			if (!empty($param['content'])) {
				$where[] = ['content','like','%'.$param['content'].'%'];
			}

			// 查询数据
            $count = $this->model->where($where)->count();
            $limit = is_empty($param['limit']) ? 10 : $param['limit'];
            $page = ($count <= $limit) ? 1 : $param['page'];
			$list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();
			foreach ($list as $key => $value) {
				$list[$key]['title'] = __($value['title']);
			}

			return $this->success('查询成功', null, $list, $count);
		}

		return view('/system/admin/group',['group'=>$this->model->getListGroup()]);
	}
	
	/**
	 * 添加角色
	 */
    public function add()
    {
		if (request()->isPost()) {
			// 接收数据
			$post = input('post.');
			// halt($post);
			$post = safe_field_model($post, get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
			}
			if ($this->model->create($post)) {
				return $this->success('添加角色成功！');
			}else {
				return $this->error('添加角色失败！');
			}
		}
    }	

	/**
	 * 编辑角色
	 */
    public function edit()
    {
		if (request()->isPost()) {
			$post = input('post.');
			$post = safe_field_model($post, get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
			}
			if ($this->model->update($post)) {				
				return $this->success('更新角色成功！');
			}else {
				return $this->error('更新角色失败');
			}
		}			
	}

    /**
     * 权限函数接口
     * @access      public
     * @return      mixed|array
     */
    public function getRuleCateTree()
    {
        if (request()->isAjax()) {
            $type = input('type/s') ?? 'rules';
            return $this->auth->getRuleCatesTree($type, $this->auth->authGroup);
        }
    }

	/**
	 * 更新权限
	 */
	public function editRules() 
	{
		if (request()->isPost()) {

			$id = input('id/d');

			if (!is_empty($id) && is_numeric($id)) {

				$rules = input('rules') ?? [];
				$array = [
					'id'=>$id,
					'rules'=>implode(',',$rules)
				];

				if (!$this->auth->checkRuleOrCateNodes($rules)) {
					return $this->error('没有权限！');
				}

				if ($this->model->update($array)) {
					return $this->success('更新权限成功！');
				}
			}

			return $this->error('更新权限失败！');
		}
	}

	/**
	 * 更新栏目
	 */
	public function editCates() 
	{
		if (request()->isPost()) {

			$id = input('id/d');
			if (!is_empty($id) && is_numeric($id)) {

				$cates = input('cates') ?? [];
				$array = [
					'id'=>$id,
					'cates'=>implode(',',$cates)
				];

				if (!$this->auth->checkRuleOrCateNodes($cates,AUTHCATES)) {
					return $this->error('没有权限！');
				}

				if ($this->model->update($array)) {
					return $this->success('更新栏目权限成功！');
				}
			}

			return $this->error('更新栏目权限失败！');
		}		
	}

	/**
	 * 删除角色/用户组
	 */
	public function del()
	{
		$id = input('id');
		if (!empty($id) && is_numeric($id)) {
			if ($id == 1) {
				return $this->error('系统内置禁止删除！');
			}
			if ($this->model::destroy($id)) {
				return $this->success('删除角色成功！');
			}
		}
		
		return $this->error('删除角色失败，请检查您的参数！');
	}

}
