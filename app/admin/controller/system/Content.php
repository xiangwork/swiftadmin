<?php

declare(strict_types=1);
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
use app\common\model\system\Channel;
use app\common\model\system\Category;
use app\common\model\system\UserGroup;
use app\common\model\system\TagsMapping;
use app\common\model\system\Content as ContentModel;
use app\admin\middleware\system\Content as ContentMiddleware;
use app\common\library\ResultCode;

class Content extends AdminController
{
    /**
     * 模型 ID
     *
     * @var integer
     */
    private $modelId = 0;

    /**
     * 栏目 ID
     *
     * @var integer
     */
    private $parentId = 0;

    /**
     * 模型实体
     *
     * @var [type]
     */
    private $channel = null;

    /**
     * 初始化函数
     *
     * @return void
     */
    public function initialize()
    {

        parent::initialize();

        // 实例化模型
        $this->model = new ContentModel();

        // 获取栏目权限
        $this->categoryList = $this->auth->getRuleCatesTree(AUTHCATES, 'pri', false);

        // 获取模型参数
        $this->parentId = input('pid/d') ?? $this->categoryList[0]['id'];
        $this->modelId  = input('cid/d') ?? $this->categoryList[0]['cid'];

        if (request()->isPost()) {

            foreach ($this->categoryList as $value) {
                if ($value['id'] == $this->parentId) {
                    $this->parentId = $value;
                    break;
                }
            }

            // 无操作权限
            if (!$this->parentId || !is_array($this->parentId)) {
                if (request()->isAjax()) {
                    return json(ResultCode::AUTH_ERROR);
                } else {
                    return abort(401);
                }
            }
        }

        // 获取模型表属性
        $this->channel = Channel::find($this->modelId);
        if (!empty($this->channel)) {
            $this->table = $this->channel->table;
            $this->template = $this->channel->template;
        } else {
            return $this->error('获取内容模板异常');
        }

        $this->app->view->assign([
            'UserGroup' => json_encode(UserGroup::select()->toArray(), JSON_UNESCAPED_UNICODE),
            'categoryList' => json_encode($this->categoryList, JSON_UNESCAPED_UNICODE),
        ]);
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
            $status = !empty($post['status']) ? $post['status'] - 1 : 1;

            // 生成查询条件
            $where = array();

            if (!empty($post['title'])) {
                $where[] = ['title', 'like', '%' . $post['title'] . '%'];
            }

            $where[] = ['status', '=', $status];
            if (!empty($pid)) {
                $where[] = ['pid', '=', $pid];
            } else {
                if (!$this->auth->SuperAdmin()) {
                    $where[] = ['pid', 'in', $this->getCateNodes()];
                }
            }

            try {
                if (saenv('search_status') && !empty($post['title'])) {
                    $result = search_model()::instance()->index('content')->where($where)->order('id', 'desc')->limit($limit)->page($page)->search($post['title']);
                    $count = search_model()::instance()->getCount();
                    $subQuery = empty($result) ? '(0)' : '(' . implode(',', array_column($result, 'id')) . ')';
                } else {
                    $count = $this->model->where($where)->count('id');
                    $page = ($count <= $limit) ? 1 : $page;
                    $subQuery = $this->model->field('id')->where($where)->order('id', 'desc')->limit($limit)->page($page)->buildSql();
                    $subQuery = '( SELECT content.id FROM ' . $subQuery . ' AS content )';
                }

                $lists = $this->model->with('category')->where('id in' . $subQuery)->select();
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

            // try {

                $post = request()->post();

                $post['admin_id'] = $this->admin['id'];
                $post['author'] = $this->admin['name'];

                if ($this->autoPostValidate($post, get_class($this->model))) {
                    return $this->error($this->errorMsg);
                }

                // halt($post);

                $data = $this->model->create($post);
            // } catch (\Throwable $th) {
            //     return $this->error($th->getMessage());
            // }



            return $this->success();
        }

        $data  = $this->getTableFields();
        $table = $this->table;
        $data['cid'] = $this->modelId;
        $data['pid'] = $this->parentId;
        $data[$table] = $this->getTableFields($this->model->$table());
        return view($this->template, [
            'data' => $data
        ]);
    }

    /**
     * 编辑数据项
     * 
     * @return void
     */
    public function edit()
    {
  
        $id = input('id/d');
        $pid = $this->parentId;
        $data = $this->model->with($this->table)->where(['id' => $id, 'pid' => $pid])->find();

        if (request()->isPost()) {

            try {

                $post = request()->post();
                if ($this->autoPostValidate($post, get_class($this->model))) {
                    return $this->error($this->errorMsg);
                }
                //修复属性为空时候
                if(empty($post['attribute'])){
                    $post['attribute']='';
                }
                $this->model->update($post);
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success();
        }

        return view($this->template, [
            'data' => $data
        ]);
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
                if (
                    !empty($data)
                    && $data['cid'] == $category['cid']
                ) {
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
        $rulecates = $this->auth->getRuleCatesTree(AUTHCATES, $this->auth->authPrivate, false);
        $rulecates = array_column($rulecates, 'id');
        return implode(',', $rulecates);
    }
}
