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
use app\common\model\system\Channel;
use app\common\model\system\Category;
use app\common\model\system\Content as ContentModel;
use app\common\model\system\TagsMapping;
use app\common\model\system\UserGroup;

class Content extends AdminController 
{
    /**
     * 初始化函数
     *
     * @return void
     */
    public function initialize() {

        parent::initialize();

        try {

            $ModelId = request()->param('cid');
            if (!empty($ModelId) && !is_array($ModelId)) {
                $this->channel = Channel::getChannelList($ModelId);
                $this->table = $this->channel['table'];
                $this->template = $this->channel['template'];
            }

        } catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }

        $userGroup = json_encode(UserGroup::select()->toArray());
        $cateGory = $this->auth->getrulecatestree('cates','private');
        $this->app->view->assign([
            'cateGory'=>$cateGory,
            'UserGroup'=>$userGroup
        ]);

        $this->model = new ContentModel();
		$this->middleware = [\app\admin\middleware\system\Content::class];
    }

	/**
	 * 获取资源
	 */
	public function index() 
    {
        if (request()->isAjax()) {
           
            // 获取数据
            $post = input();
            $pid   = request()->param('pid');
            $page = request()->param('page/d') ?? 1;
            $limit = request()->param('limit/d') ?? 18;
            $status = !empty($post['status']) ? $post['status']-1 : 1;

            // 生成查询条件
            $where = array();

            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }
            
            $where[] = ['status','=',$status];
            if (!empty($pid)) {
                $where[] = ['pid','=',$pid];
            } else {
                if (!$this->auth->SuperAdmin()) {
                    $where[] = ['pid','in',$this->getCateNodes()];
                }
            }
 
            try {
                
                if (saenv('search_status') && !empty($post['title'])) {
                    $result = search_model()::instance()->index('content')->where($where)->order('id','desc')->limit($limit)->page($page)->search($post['title']);
                    $count = search_model()::instance()->getCount();
                    $subQuery = empty($result) ? '(0)' : '('.implode(',',array_column($result,'id')).')';
                } else {
                    $count = $this->model->where($where)->count('id');
                    $page = ($count <= $limit) ? 1 : $page;
                    $subQuery = $this->model->field('id')->where($where)->order('id','desc')->limit($limit)->page($page)->buildSql();
                    $subQuery = '( SELECT content.id FROM '.$subQuery.' AS content )';
                }
                
                $lists = $this->model->with('category')->where('id in'.$subQuery)->select();
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success('查询成功', null, $lists, $count);
        }

        return view();
    }

    /**
     * 添加数据项
     * 
     * @return void
     */
    public function add() 
    {

        if (request()->isPost()) {

            try {

                $post = request()->post();
                $post['admin_id'] = $this->admin['id'];
                $post['author'] = $this->admin['name'];

                if ($this->autoPostValidate($post,get_class($this->model))) {
                    return $this->error($this->errorMsg);
                }
                
                $data = $this->model->together([$this->table=>$post])->save($post);
                TagsMapping::writeMapID((int)$data['id'],$post['seo_keywords']);
                
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
           
            return $this->success();
        }

        // 渲染页面
        $data = $this->getField();
        $data[$this->table] = $this->getField('content'.$this->table);
        $data = array_merge($data,request()->param());
        return view($this->template,['data' => $data]);
    }

    /**
     * 编辑数据项
     * 
     * @return void
     */
    public function edit()
    {
        // 查找数据
        $id = request()->param('id');
        $pid = request()->param('pid');

        $data = $this->model
                    ->with($this->table)
                    ->where(['id'=>$id,'pid'=>$pid])
                    ->find();
        
        if (request()->isPost()) {
            
            try {
                
                $post = request()->post();
                $post['attribute'] = input('attribute') ?? [];

                if ($this->autoPostValidate($post,get_class($this->model))) {
                    return $this->error($this->errorMsg);
                }

                $this->model->update($post)->together([$this->table=>$post])->save();
                if ($data[$this->table]['seo_keywords'] != $post['seo_keywords']) {
                    TagsMapping::writeMapID((int)$data['id'],$post['seo_keywords']);
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
           
            return $this->success();
        }

        return view($this->template,['data' => $data]);
    }

    /**
     * 移动内容
     * 
     * @return void
     */
    public function move()
    {

        if (request()->isPost()) {
            
            $ids = request()->param('id');
            $destpid = request()->param('destpid');

            // 查找栏目
            $category = Category::getByid($destpid);
            if (empty($category)) {
                return $this->error();
            }

            foreach ($ids as $id) {
                $data = $this->model->find($id);
                if (!empty($data) 
                    && $data['cid'] == $category['cid']) {
                    $data->pid = $destpid;
                    $data->save();
                } else {
                    return $this->error('数据模型不匹配');
                }
            }

            return $this->success();
        }
    }

    /**
     * 获取栏目权限节点
     *
     * @return void
     */
    public function getCateNodes()
    {
        $rulecates = $this->auth->getRuleCatesTree('cates',$this->auth->authPrivate,false);
        $rulecates = array_column($rulecates,'id');
        return implode(',',$rulecates);
    }
}   
