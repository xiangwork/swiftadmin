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
use think\facade\Db;
use app\common\model\system\Fulltext as FulltextModel;

class Fulltext extends AdminController
{
    public function initialize() 
    {
		parent::initialize();
        $this->model = new FulltextModel();
    }
    
    /**
     * 获取数据库资源
     */
    public function index() 
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post  = input();
            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['name','like','%'.$post['name'].'%'];
            }

            // 生成查询数据
            $list = $this->model->where($where)->order("id asc")->select()->toArray();
            return $this->success('查询成功', "", $list, count($list));
        }

        return view();
    }

    /**
     * 添加项目
     *
     * @return void
     */
    public function add()
    {
        if (request()->isPost()) {
            
            $post = input();
			$validate = $this->isValidate ? get_class($this->model) : $this->isValidate;
            $post = safe_field_model($post,$validate,$this->scene);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            Db::startTrans();
			try {
                search_model($post['type'])::instance()->indices($post);
                $this->status = $this->model->create($post);
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
			
			return $this->status ? $this->success() : $this->error();
        }
    }

    /**
     * 删除索引
     *
     * @return void
     */
    public function del(int $id = 0)
    {
        // 删除数据
        $data = $this->model->find($id);
        if (!empty($data)) {

            try {
                search_model($data['type'])::instance()->delices($data->toArray());
                $data->delete();
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success();
        }
    }

    /**
     * 更新字段集
     *
     * @param integer $id
     * @param string $type
     * @return void
     */
    public function field(int $id = 0, string $type = 'XunSearch')
    {   
        if (!$id) {
            return $this->error('未找到索引项目');
        }

        $data = $this->model->find($id);

        if (request()->isPost()) {
            
            $post = input('post.');
            
            try {
                $field = search_model($data['type'])::instance()->index($data['name'])->putMapping($post,$data->toArray());
                $data['field'] = serialize($field);
                $data->save();
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success('操作成功');
        }

        // 反序列化字段集
        if ($data['field']) {
            $data['field'] = unserialize($data['field']);
        }
        
        return view($type,['data'=>$data]);
    }
}