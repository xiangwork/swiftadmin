<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>  MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use think\facade\Db;
use app\common\model\system\Channel;
use app\common\model\system\Category;
use app\common\validate\system\Content as Contvalidate;

class Content extends AdminController 
{

   /**
    * 模型数据表
    * @access   protected
    * @var      string
    */
    protected   $parent = null;

    // 初始化函数
    public function initialize() {
        
        parent::initialize();
        try {

            // 查找当前模型
            $cid = request()->param('cid');
            if (!is_array($cid)) {
                $channel = Channel::get_channel_list($cid);
            }
            
            // 是否存在数据库表
            if (isset($channel['table'])) {
                $namespace = NAMESPACEMODELSYSTEM.ucfirst($channel['table']);
                if (class_exists($namespace)) {
                    $this->parent = $channel['table'];
                    $this->model = new $namespace;
                }
            }
        }
        catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }

		$this->middleware = [
			\app\admin\middleware\system\Content::class,
	    ];        
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
            $limit = request()->param('limit/d') ?? 2;
            $status = !empty($post['status']) ? $post['status']-1:1;

            // 生成查询条件
            $where = array();
            
            $where[] = ['pid','=',$pid];
            $where[] = ['status','=',$status];
            
            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }

            $lists = [];
            $count = 0;
            try {

                if (empty($pid) && !$this->parent) {
                    
                    // 获取权限节点
                    $category = $this->auth->get_rulecates_tree('cates',$this->auth->authPrivate,false);
                    $tables = [];
                    foreach ($category as $value) {
                        $channel = Channel::get_channel_list($value['cid']);
                        if (isset($channel['table'])) {
                            $table = $channel['table'];
                            $tables[$table][] = $value['id'];
                        }
                    }
                    
                    // 组合UNION查询
                    $unionSql = [];
                    $where[] = ['delete_time','=',null];
                    $field = "id,cid,pid,title,status,hits,author,attribute,createtime";
                    foreach ($tables as $table => $elems) {

                        // 筛选条件
                        foreach ($where as $key => $value) {
                            $fixed[$key] = $where[$key];
                            if ($fixed[$key][0] == 'pid') {
                                $fixed[$key][1] = 'in';
                                $fixed[$key][2] = implode(',',$elems);
                            }
                            $fixed[$key][0] = $table.'.'.$fixed[$key][0];
                        }

                        $unionSql[] = Db::view($table, $field)
                                        ->view('category', ['title'=>'category'], "category.id=$table.pid")
                                        ->where($fixed)->buildSql();
                        if (count($tables) == 1) {
                            $unionSql = current($unionSql);
                            break;
                        }

                        if ($elems == end($tables)) {
                            $unionSql = Db::view($table, $field)
                                        ->view('category', ['title'=>'category'], "category.id=$table.pid")
                                        ->where($fixed)->union($unionSql)->buildSql();
                        }
                    }

                    if (!empty($unionSql)) {

                        // 闭包循环处理数据
                        $lists  = Db::table($unionSql . ' alias')->order('id','desc')
                            ->paginate($limit)->each(function($item){
                                    $item['readurl'] = '/123'; // 配置内容页访问地址。
                                    $item['createtime'] = date('Y-m-d H:i:s',$item['createtime']);
                                    return $item;
                            })->toArray();
                        $count  = $lists['total'];
                        $lists  = $lists['data'] ?? [];
                        
                    }
                }
                else {
                    $count = $this->model->where($where)->count();
                    $page = ($count <= $limit) ? 1 : $page;
                    $lists = $this->model->with('category')->where($where)
                                                            ->order('id','desc')
                                                            ->withoutField('content')
                                                            ->limit($limit)
                                                            ->page($page)->select();
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success('查询成功', null, $lists, $count, 0);
        }

        return view();
    }

    /**
     * 添加数据项
     */
    public function add() 
    {

        if (request()->isPost()) {

            try {
                
                $post = request()->post();
                $post['admin_id'] = $this->admin['id'];
                $post['author'] = $this->admin['name'];
                $post = safe_validate_model($post,Contvalidate::class);
                if (!is_array($post)) {
                    throw new \Exception($post);
                }

                $this->model->create($post);

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
           
            return $this->success();
        }
        
        // 渲染页面
        $data = $this->getField($this->parent);
        $data = array_merge($data,request()->param());
        return view($this->parent,['data' => $data]);
    }

    /**
     * 编辑数据项
     */
    public function edit()
    {

        // 查找数据
        $id = request()->param('id');
        $pid = request()->param('pid');
        $data = $this->model->where(['id'=>$id,'pid'=>$pid])->find();

        if (request()->isPost()) {
            
            try {

                $post = request()->post();
                $post['attribute'] = input('attribute') ?? [];
                $post = safe_validate_model($post,Contvalidate::class);

                // 验证出错
                if (!is_array($post)) {
                    throw new \Exception($post);
                }
                
                $this->model->update($post);

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
           
            return $this->success();
        }

        return view($this->parent,['data' => $data]);
    }

    /**
     * 移动内容
     */
    public function move()
    {

        if (request()->isPost()) {
            
            $ids = request()->param('id');
            $cid = request()->param('cid');
            $destpid = request()->param('destpid');

            // 查找模型
            $category = Category::getByid($destpid);
            if (empty($category)) {
                return $this->error();
            }

            // 对比数据模型
            foreach ($ids as $key => $value) {

                // 获取数据表
                $channel = Channel::get_channel_list($cid[$key]);
                $table = $channel['table'];

                $data = Db::name($table)->find($value);
                if ($data['cid'] == $category['cid']) {
                    $data['pid'] = $destpid;
                    Db::name($table)->save($data);
                }
            }

            return $this->success();
        }
    }
}   