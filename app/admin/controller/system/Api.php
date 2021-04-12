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
use app\common\model\system\Project;
use app\common\model\system\Api as ApiModel;
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
        if (request()->isAjax()) {

           // 获取数据
           $post = input();
           $page = input('page/d') ?? 1;
           $limit = input('limit/d') ?? 10;
           
           // 生成查询条件
           $where = array();
           if (!empty($post['name'])) {
               $where[] = ['name|class','like','%'.$post['name'].'%'];
           }

           if (!empty($post['status'])) {
               if($post['status'] == 1){
                   $where[]=['status','=','1'];
               }elseif($post['status'] == 2){
                   $where[]=['status','=','0'];
               }		
           }

           // 生成查询数据
           $count = $this->model->where($where)->count();
           $page = ($count <= $limit) ? 1 : $page;
           $list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();
           return $this->success('查询成功', "", $list, $count, 0);

        }

        $project = Project::select()->toArray();
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
                $this->_api_router();
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
                    cache(md5short($post['class']),null); 
                }
                $this->_api_router();
                return $this->success();
            }

            return $this->error();
        }        
    }

    /**
     * 写路由路径
     */
    private function _api_router($router = '') 
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
            return $this->success('查询成功', "", $list, count($list), 0);

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
            return $this->success('查询成功', "", $list, count($list), 0);

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
