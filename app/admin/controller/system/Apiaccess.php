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
use app\common\model\system\Api;
use app\common\model\system\User;
use app\common\model\system\ApiAccess as ApiAccessModel;

class Apiaccess extends AdminController
{
	// 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new ApiAccessModel();
    }

    /**
     * 获取资源
     */
    public function index() 
    {
        if (request()->isAjax()) {

            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            
            // 生成查询条件
            $where = array();
            if (!empty($post['name'])) {
                $name[] = ['nickname','like','%'.$post['nickname'].'%'];
                $uIds = User::where($name)->field('id')->select()->toArray();
                foreach ($uIds as $key => $value) {
                    $ids[] = $value['id'];
                }

                $ids = isset($ids) ? $ids : [];
                $where[] = ['uid','in',$ids];                
            }

            if (!empty($post['title'])) {
                $title[] = ['class','like','%'.$post['title'].'%'];
                $uIds = Api::where($title)->field('id')->select()->toArray();
                foreach ($uIds as $key => $value) {
                    $ids[] = $value['id'];
                }

                $ids = isset($ids) ? $ids : [];
                $where[] = ['api_id','in',$ids];
            }          

            if (!empty($post['contents'])) {
                $where[] = ['contents','like','%'.$post['contents'].'%'];
            }

            // 查询数据
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = $this->model->alias('a')
                                ->field('a.*')
                                ->view('user','nickname','user.id=a.uid')
                                ->view('api','class,hash,title,method','api.id=a.api_id')
                                ->where($where)
                                ->limit($limit)
                                ->page($page)
                                ->order("a.id asc")
                                ->select()->toArray();
            return $this->success('查询成功', "", $list, $count);
        }

        return view();
    }

    /**
     * 添加规则
     */
    public function add() 
    {
        if (request()->isPost()) {
            $post = input();

            if ($this->model->create($post)) {
                return $this->success();
            }

            return $this->error();   
        }

        $data = $this->getField(); 
        return view('',['data'=> $data]);

    }

    /**
     * 编辑规则
     */
    public function edit() 
    {
        if (request()->isPost()) {
            $post = input();

            if ($this->model->update($post)) {
                /**
                 * 勿更新缓存，因为APPID可能为空
                 */
                return $this->success();
            }

            return $this->error();   
        }

        $id = input('id/d');
        $data = $this->model->alias('a')
                            ->field('a.*')
                            ->view('user','nickname','user.id=a.uid')
                            ->view('api','class,hash','api.id=a.api_id')
                            ->where('a.id',$id)
                            ->find()->toArray();
        return view('add',['data'=> $data]);
    }    

}