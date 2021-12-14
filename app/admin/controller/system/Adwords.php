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
use app\common\model\system\Adwords as AdwordsModel;

class Adwords extends AdminController
{

	// 初始化操作
    public function initialize() 
    {
		parent::initialize();
        $this->model = new AdwordsModel();
        $this->path = public_path().'static/adwords/';
    }

    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post = input();
            $status = !empty($post['status']) ? $post['status']-1:1;
            $where = array();
            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }

            // 生成查询数据
            $where[]=['status','=',$status];
            $list = $this->model->where($where)->order("id asc")->select()->toArray();
            return $this->success('查询成功', NULL, $list, count($list));
        }

		return view();
    }

    /**
     * 添加广告
     */
    public function add () 
    {
		if (request()->isPost()) {

			$post = input('post.');
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            // 单独验证场景
            $post = safe_validate_model($post,get_class($this->model));
            if (empty($post) || !is_array($post)) {
                $this->error($post);
            }

            $post['expirestime'] = strtotime($post['expirestime']);
            if ($this->model->create($post)){
                return $this->success();
            }

            return $this->error();
        }
 
        return view('',[
            'data'=> $this->getField()
        ]);
    }

    /**
     * 编辑广告
     */
    public function edit() 
    {
        $id = input('id/d');
        
        if (request()->isPost()) {
            
            $post = input('post.');

            // 单独验证场景
            if ($this->autoPostValidate($post,get_class($this->model))) {
                return $this->error($this->errorMsg);
            }

            $post['expirestime'] = strtotime($post['expirestime']);
            if ($this->model->update($post)){
                $this->after_Data($post);
                return $this->success();
            }
            return $this->error();
        }

        $data = $this->model->find($id);
        $data['expirestime'] = date("Y-m-d H:i:s",$data['expirestime']);
        return view('add',[
            'data'=> $data
        ]);
    }

    /**
     * 写入广告文件
     */
	private function after_Data($array,$mark = false) 
    {
		write_file($this->path.$array['alias'].'.js',strtoJs(stripslashes(trim($array['content']))));
	}


}
