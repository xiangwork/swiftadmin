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
use app\common\model\system\Channel  as ChannelModel;
use app\common\model\system\Category as CategoryModel;
use app\common\model\system\Content  as ContentModel;
use app\common\model\system\UserGroup;
use think\facade\Db;

class Category extends AdminController
{
	// 初始化操作
    public function initialize() 
    {
		parent::initialize();

        $this->model = new CategoryModel();
        
        // 分配前端模板
        $skin = [];
        $skinPath = root_path('app/index/view/category');
        if (is_dir($skinPath)) {
            $skin = glob($skinPath.'*.html');
            $skin = str_replace(array($skinPath,'.html'),'',$skin);
        }

        $this->app->view->assign('skin',$skin);

        // 获取用户权限
        $userGroup = json_encode(UserGroup::select()->toArray());
        $cateGory = $this->auth->getRuleCatesTree(AUTHCATES,$this->auth->authPrivate);
        $this->app->view->assign([
            'cateGory'=>$cateGory,
            'UserGroup'=>$userGroup
        ]);
    }

    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

			// 接收参数
			$title = input('title');
			$model = input('model');
			$status = input('status/d');
            $status = !empty(input('status/d')) ? input('status/d') : 2;

            // 获取数据
            $list = $this->model->getListCate(0,0,['status'=>$status]);
            $channel = ChannelModel::getChannelList();

            if (!is_empty($model)) {
                $model = list_search($channel, ['title'=> '/'.$model.'/']);
                $model = $model ? $model['id'] : '';
            }

            if (!empty($list)) { // 处理数据
                foreach ($list as $key => $value) {

                    $finder = list_search($channel, ['id'=>$value['cid']]);
                    $list[$key]['channel'] = __($finder['title']) ?? '未选择模型';
                    $list[$key]['title'] = __($value['title']);

                    if (!\is_empty($title) && !\is_empty($model)) {
                        
                        if ($value['cid'] !== $model) { 
                            unset($list[$key]);
                        }

                        if (stripos($value['title'],$title) === false) {
                            unset($list[$key]);
                        }
                    }
                    else {
                        if (!\is_empty($title) && (stripos($value['title'],$title) === false)) { 
                            unset($list[$key]);
                        }

                        if (!\is_empty($model) && $value['cid'] !== $model) { 
                            unset($list[$key]);
                        }
                    }
                }
            }
            
            return $this->success('查询成功', null, $list, count($list));
        }

		return view();
    }

    /**
     * 添加栏目
     */
    public function add () 
    {
		if (request()->isPost()) {

			$post = input('post.');
            $post = safe_validate_model($post,get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }
            if ($this->model->create($post)) {
                return $this->success();
            }
			return $this->error(); 
        }

		return view('',['data'=> $this->getTableFields()]);
    }

    /**
     * 编辑栏目
     */
    public function edit() 
    {
        $id = input('id/d');
        $data = $this->model->find($id);
        if (request()->isPost()) {
            
            $post = input('post.'); 
            $post['pid'] = input('post.pid'); 
            $post['cid'] = input('post.cid'); 
            $post = safe_validate_model($post,get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            // 查询栏目统计
            if (!empty($this->model::getListCount(['pid'=>$data['id']]))) {
                $parent = $this->model->getById($post['pid']);
                if (($post['cid'] && $data->cid != $post['cid'])
                    ||($parent && $parent->cid != $data->cid)) {
                    return $this->error('当前分类存在未处理数据！');
                }
            }

            if ($this->model->update($post)){
                return $this->success();
            }

            return $this->error();
        }

		// 渲染模板
		return view('add',['data'=> $data]);
    }

    /**
     * 设置状态
     */
    public function status()
    {
        if (request()->isAjax())
        {
            $array['id'] = input('id/d');	
			$array['status'] = input('status/d');
			Db::startTrans();

			try {
                $data = $this->model->find($array['id']);
                $data->status = $array['status'];
                $data->save();
                ContentModel::where('pid',$data->id)->update(['status'=>$data->status]);
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
            
            $this->status && $this->success();	
		}

		return $this->error();
	}

}
