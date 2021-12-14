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
use app\common\model\system\Project;
use app\common\model\system\Api as ApiModel;
use app\common\model\system\ApiGroup as ApiGroupModel;
use app\common\model\system\ApiParams as ApiParamsModel;
use app\common\model\system\ApiRestful as ApiRestfulModel;

class Api extends AdminController
{

	// 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new ApiModel();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        $project = Project::select()->toArray();
        if (request()->isAjax()) {

           // 获取数据
           $post = input();
           $page = input('page/d') ?? 1;
           $app_id = input('app/d') ?? 1;
           $limit = input('limit/d') ?? 10;
           $status = !empty($post['status']) ? $post['status']-1:1;

           // 生成查询条件
           $where = array();
           if (!empty($post['title'])) {
                $where[] = ['title|class','like','%'.$post['title'].'%'];
           }

           // 生成查询数据
           $where[] = ['status','=',$status];
           $where[] = ['app_id','=',$app_id];
           $count = $this->model->where($where)->count();
           $page = ($count <= $limit) ? 1 : $page;
           $list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();

            // 获取项目分组
            $group = [];
            foreach ($project as $value) {
                $group[$value['id']] = ApiGroupModel::getListTree(['app_id'=>$value['id']]) ?? [];
            }

           return $this->success('查询成功', "", [
               'item' => $list,
               'group' => $group,
           ], $count);
        }


        return view('',[
            'apps' => $project,
            'project' => json_encode($project, JSON_UNESCAPED_UNICODE)
        ]);
    }

    /**
     * 添加接口
     */
    public function add() 
    {
        if (request()->isPost()) {

            $post = input();

            if (is_empty($post['hash'])) {
                $post['hash'] = strtolower(create_rand(10));
            }

            if ($this->model->create($post)) {
                $this->api_Router();
                return $this->success();
            }

            return $this->error();
        }
    }

    /**
     * 编辑接口
     */
    public function edit() 
    {
        if (request()->isPost()) {

            $post = input();
            if ($this->model->update($post)) {
                if (isset($post['class'])) { // 清理接口缓存
                    system_cache(md5($post['class']),null); 
                }
                $this->api_Router();
                return $this->success();
            }

            return $this->error();
        }        
    }

    /**
     * 写路由路径
     */
    private function api_Router($router = '') 
    {
        $path = root_path().'app\api\route\api.php';
        $list = $this->model->where('model','1')->select();
        foreach ($list as $value) {
            $router .= "Route::rule('";
            $router .=  $value['hash']."','".$value['class']."');";
            $router .=  PHP_EOL;
        }

        arr2router($path,$router);
    }

    /**
     * API分组
     */
    public function group()
    {
        $app_id = input('app_id');
        if (request()->isAjax()) {
            $where[] = ['app_id','=',$app_id];
            $list = ApiGroupModel::where($where)->select()->toArray();
            $group = ApiGroupModel::getListTree($where) ?? [];
			return $this->success('获取成功', '',[
				'item'=> $list,
				'group'=> $group 
			], 
			count($list),0);
        }
        return view('',['app_id'=>$app_id]);
    }   

    /**
     * 添加分组
     */
    public function groupAdd() 
    {
        if (request()->isPost()) {
            $post = input();

            if (ApiGroupModel::create($post)) {
                return $this->success();
            }

            return $this->error();
        }
    }
    
    /**
     * 编辑分组
     */
    public function groupEdit() 
    {
        if (request()->isPost()) {
            $post = input();
            if (ApiGroupModel::update($post)) {
                return $this->success();
            }
            return $this->error();
        }        
    }

    /**
     *  删除分组
     */
    public function groupDel() 
    {
        $id = input('id/d');
        $app_id = input('app_id/d');

        if (!empty($id) && is_numeric($id)) {
            if ($this->model->where([
                'app_id' => $app_id,
                'group_id' => $id,
            ])->find()) {
                return $this->error('当前分组存在API数据');
            }
            if (ApiGroupModel::destroy($id)) {
                return $this->success();
            }

            return $this->error();
        }
    }

    /**
     * 请求参数
     */
    public function params() 
    {
        if (request()->isAjax()) {
  
            $pid = input('id');
            $name = input('name');

            $where = []; // 查询条件
            if (!empty($pid)) {
                $where[] = ['pid','=',$pid];
            }
            if (!empty($name)) {
                $where[] = ['name','like','%'.$name.'%'];
            }

            $list = ApiParamsModel::where($where)->select()->toArray();
            return $this->success('查询成功', "", $list, count($list));

        }

        $id = input('id/d');
        $data = $this->model->find($id);
        return view('',[
            'data'=>$data
        ]);
    }

    /**
     * 添加参数
     */
    public function paramsAdd() 
    {
        if (request()->isPost()) {
            $post = input();

            if (ApiParamsModel::create($post)) {
                return $this->success();
            }

            return $this->error();
        }
    }
    
    /**
     * 编辑参数
     */
    public function paramsEdit() 
    {
        if (request()->isPost()) {
            $post = input();
            if (ApiParamsModel::update($post)) {
                return $this->success();
            }
            return $this->error();
        }        
    }

    /**
     *  删除参数
     */
    public function paramsDel() 
    {
        $id = input('id/d');
        if (!empty($id) && is_numeric($id)) {

            if (ApiParamsModel::destroy($id)) {
                return $this->success();
            }

            return $this->error();
        }
    }

    /**
     * 返回参数
     */
    public function restful() 
    {
        if (request()->isAjax()) {
  
            $pid = input('id');
            $name = input('name');
            $where = []; // 查询条件

            if (!empty($pid)) {
                $where[] = ['pid','=',$pid];
            }

            if (!empty($name)) {
                $where[] = ['name','like','%'.$name.'%'];
            }

            $list = ApiRestfulModel::where($where)->select()->toArray();
            return $this->success('查询成功', "", $list, count($list));

        }

        $id = input('id/d');
        $data = $this->model->find($id);
        return view('',[
            'data'=>$data
        ]);
    }

    /**
     * 添加返回参数
     */
    public function restfulAdd() 
    {
        if (request()->isPost()) {
            $post = input();

            if (ApiRestfulModel::create($post)) {
                return $this->success();
            }

            return $this->error();
        }
    }
    
    /**
     * 编辑返回参数
     */
    public function restfulEdit() 
    {
        if (request()->isPost()) {
            $post = input();
            if (ApiRestfulModel::update($post)) {
                return $this->success();
            }
            return $this->error();
        }                
    }

    /**
     * 删除返回参数
     */
    public function restfulDel() 
    {
        $id = input('id/d');
        if (!empty($id) && is_numeric($id)) {

            if (ApiRestfulModel::destroy($id)) {
                return $this->success();
            }

            return $this->error();
        }        
    }

}
