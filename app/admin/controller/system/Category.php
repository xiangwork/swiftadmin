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
use app\common\model\system\Channel  as ChannelModel;
use app\common\model\system\Category as CategoryModel;

class Category extends AdminController
{

    public $tableName = '管理员';

	// 初始化操作
    public function initialize() 
    {
		parent::initialize();
        $this->model = new CategoryModel();
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

            // 获取数据
            $list = $this->model->getListCate();
            $channel = ChannelModel::getListChannel();

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

                return $this->success('查询成功', "", $list, count($list), 0);
            }
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
            $post = safe_field_model($post,$this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            if (empty($post['pinyin'])) {
                $post['pinyin'] = preg_replace('/\s*/','',pinyin($post['title']));
            }

            if ($this->model->create($post)) {
                return $this->success();
            }
            
			return $this->error(); 
        }

		return view('',[
            'data'=> $this->getField(),
            'category'=> json_encode($this->model->getListTree()),
            'channel'=> ChannelModel::getListChannel()
		]);
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
            $post = safe_field_model($post,$this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            // 查询模型
            $channel = ChannelModel::getListChannel($data['cid']);
            $cateCount = $this->model->getListCount($channel['table'],array('cid' => $data['id']));
            if (!empty($cateCount)) {
                $check = false;
                if ($post['pid'] != 0) {
                    $channelPid = ChannelModel::getListChannel($post['pid']);
                    if ($channelPid['cid'] !== $post['cid']) {
                        $check = true;
                    }
                }

                if ($post['cid'] != $data['cid'] || $check){
                    return $this->error('当前分类存在未处理数据！');
                }
            }
            
            if ($this->model->update($post)){
                return $this->success();
            }

            return $this->error();
        }

		// 渲染模板
		return view('add',[
            'data'=> $data,
            'category'=> json_encode($this->model->getListTree()),
            'channel'=> ChannelModel::getListChannel()
		]);
    }

}