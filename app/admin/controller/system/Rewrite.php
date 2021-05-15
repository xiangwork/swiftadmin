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
use think\facade\Cache;
use think\facade\Config;
use app\common\model\system\Category;

class Rewrite extends AdminController 
{
    // 栏目页模式
    protected $category_page;

    // 列表页模式
    protected $list_page;

    // 内容页模式
    protected $content_page;

    // 模板路径
    protected $template;

    // 默认跳转页
    protected $jumpIndex;

    // 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->category_page = [
            '/listdir/',
            '/listdir/sublist/'
        ];

        $this->list_page = [
            '/listdir/list_page.html',
            '/listdir/sublist/list_page.html'
        ];

        $this->content_page = [
            '/listdir/id/',
            '/listdir/id.html',
            '/listdir/sublist/id.html',
            '/listdir/pinyin/',
            '/listdir/pinyin.html',
            '/listdir/sublist/pinyin.html',
            '/listdir/hash/',
            '/listdir/hash.html',
            '/listdir/sublist/hash.html',
        ];

        if (saenv('url_model') != STATICS 
            && !in_array($this->action,['index','basecfg','createmap'])) {
                return $this->error('请开启静态生成再操作');
        }

        $this->template  = root_path('app/index/view');
        $this->jumpIndex = (string)url('/system.rewrite/index');
        if (strpos($this->action,'create') !== false) {
            $this->app->view->config(['view_path' => $this->template]);
        }
    }

    /**
     * 获取资源 
     */    
    public function index() 
    {
        // 读取配置
        $total = 0; 
        $rewrite = saenv('rewrite');
        $sitemap = saenv('sitemap');
        $map_xml_path = public_path().$sitemap['map_xml_path'];
        $result = glob($map_xml_path.'/*.xml');
        foreach ($result as $key => $value) {
           $xmlfile = simplexml_load_file($value);
           $total += count($xmlfile);
           unset($xmlfile);
        }

        // 数据统计
        $sitemap['total'] = $total;     
        $sitemap['count'] = count($result);

        return view('',[
            'rewrite'=> $rewrite,
            'sitemap'=> $sitemap,
            'catePage' => $this->category_page,
            'listPage' => $this->list_page,
            'contentPage'=> $this->content_page
            ]
        );
    }

    /**
     * 写入配置项
     */
    public function basecfg() 
    {
        if (request()->isPost()) {
            $post = input();
            $config = config('system');
            $config = array_merge($config, $post);
            if (arr2file('../config/system.php', $config) === false) {
                return $this->error('保存失败，请重试!');
            }

            return $this->success('保存成功！');
        }
    }

    /**
     * 生成静态首页
     */
    public function createindex()
    {
        if (!$this->buildHtml('index',public_path(),'index/index')) {
            $this->error('生成首页失败',$this->jumpIndex);
        }
        $this->success('生成首页成功',$this->jumpIndex);
    }

    /**
     * 生成静态页面
     */
    public function createhtml()
    {
        ob_start();
        $type = input('type');
        switch ($type) {
            case 'category':
                $this->createcate();
                break;
            case 'list':
                $this->createlist();
                break;   
            case 'content':
                $this->createcontent();
                break;          
            default:
                // TODO..
                break;
        }
        ob_end_flush();
    }

    /**
     * 生成栏目页
     */
    protected function createcate()
    {
        $id = input('id/d');
        $page = input('page/d') ?? 1;
        $where = [];
        if (!empty($id)) {
            $where['id'] = $id;
        }

        $where['status'] = 1;
        $list = Category::where($where)->select();
        if ($page <= count($list)) {

            // 重置列表缓存
            if ($page == 1) {
                Cache::set('pagesNode', []);
            }

            // 获取数据实例
            $detail = $list[$page-1];
            if (!$detail->jumpurl) {

                // 自定义模板
                if ($detail['skin']) {
                    $htmlFile = $this->template.'category/'.$detail['skin'].'.html';
                } else {
                    $htmlFile = $this->template.$detail->channel->table.'/index.html';
                }

                $htmlFile = str_replace('\\','/',$htmlFile);
                $filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
                $filePath = str_replace(array('\/','\\'),'/',$filePath);

                // 分配当前数据
                Config::set(['detail'=>$detail],'current');
                $this->app->view->assign('detail',$detail->toArray());
                $this->buildHtml('index',$filePath,$htmlFile);

                $totalpages = Config::get('current.totalpages');
                if (!empty($totalpages) && $totalpages >= 2) {

                    // 处理列表节点
                    $nextnodes = [];
                    $pagestyle = build_request_url([],'list_page',['page'=>$page,'total'=>$totalpages]);

                    if (preg_match('/href="(.*?)"/i',$pagestyle,$matches)) {

                        // 处理文件名
                        $filePath = substr($matches[1],0,strpos($matches[1],'list'));
                        $filePath = str_replace(saenv('site_http'),public_path(),$filePath);
                        $filePath = str_replace(array('\/','\\'),'/',$filePath);
                    }

                    for ($i = 2; $i <= $totalpages; $i++) {
                        $nextnodes[] = [
                            'id' => $detail['id'],
                            'page' => $i,
                            'filename' => 'list_'.$i,
                            'filePath' => $filePath,
                            'template' => $htmlFile
                        ];
                    }

                    $pagesNode = Cache::get('pagesNode');
                    $pagesNode = array_merge($pagesNode,$nextnodes);
                    Cache::set('pagesNode', $pagesNode);
                }
            }

            // 创建跳转地址
            $query = array_merge(input(),['page'=>$page+1]);
            $this->JumpUrl = (string)url('/system.rewrite/createhtml',$query);
            Cache::set('createhtml',$this->JumpUrl);
            $this->success('正在生成第 '.$page.' 页'.'，共 '.count($list).' 页待生成',$this->JumpUrl);
        }
        else {

            if (Cache::get('pagesNode')) {
                $this->JumpUrl = (string)url('/system.rewrite/createhtml',['type'=>'list']);
                return $this->success('正在生成列表页',$this->JumpUrl);
            }

            Cache::delete('createhtml');
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成栏目列表页
     */
    protected function createlist()
    {
        $page = input('page/d') ?? 1;
        $pagesNode = Cache::get('pagesNode');
        $pagescount = count($pagesNode);

        if ($page <= $pagescount) {
            $current = $page;
            $progress = $page + 30; // 每次生成30页
            for (;$page <= $progress; $page++) {

                if (!isset($pagesNode[$page-1])) {
                    break;
                }

                // 处理数组信息
                $item = $pagesNode[$page-1];
                $detail = Category::getById($item['id']);
                Config::set([
                    'page'=>$item['page'],
                    'detail'=>$detail
                ],'current');
                $this->app->view->assign('page',$item['page']);
                $this->app->view->assign('detail',$detail->toArray());
                $this->buildHtml($item['filename'],$item['filePath'],$item['template']);
            }

            // 跳转地址
            $query = array_merge(input(),['page'=>$page]);
            $this->JumpUrl = (string)url('/system.rewrite/createhtml',$query);
            Cache::set('createhtml',$this->JumpUrl);
            $this->success('正在生成第 '.$current.' - '.($page-1).' 页'.'，共 '.$pagescount.' 页待生成',$this->JumpUrl);
        }
        else {
            Cache::delete('createhtml'); 
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成内容页
     */
    protected function createcontent()
    {
        $where = [];
        $where['status'] = 1;
        $list = Cache::get('content_page');
        if (empty($list) || !is_array($list)) {

            $id = input('id/d');
            if (!empty($id)) {
                $where['id'] = $id;
            }

            $result = Category::where($where)->select();
            
            foreach ($result as $value) {
                $where = [
                    'status'=>1,
                    'pid' => $value->id,
                ];
                // 查询数据
                $table = $value->channel->table;
                $count = Category::getlistcount($table,$where);

               
                if (!empty($count)) {
                    $pages = ceil((int)$count/30);
                    $list[] = [
                        'id' => $value->id,
                        'count' => $count,
                        'pages' => $pages,
                        'table' => $table,
                    ];
                }
            }

            Cache::set('content_page',$list);
        }

        $key = input('key/d') ?? 0;
        $page = input('page/d') ?? 1;
        $progress = input('progress/d') ?? 1;
        try {
            $totalpages = array_sum(array_column($list,'pages'));
        } catch (\Throwable $th) {
            return $this->error('当前栏目无内容生成',$this->jumpIndex);
        }

        $item = $list[$key];
        if ($page > $item['pages']) {
            $key = $key + 1;
            if (isset($list[$key])) {
                $page = 1;
                $item = $list[$key];
            }
        }

        if ($page <= $item['pages']) {

            $model = NAMESPACEMODELSYSTEM.ucfirst($item['table']);
            $result = $model::where([
                'pid'=>$item['id'],
                'status'=> 1,
            ])->limit(30)->page($page)->select();

            foreach ($result as $detail) {
                $this->createhtmlByone($detail);
            }

            $this->JumpUrl = (string)url('/system.rewrite/createhtml',[
                'key'=>$key,
                'page'=>$page+1,
                'type'=>'content',
                'progress'=>$progress+1,
            ]);
            
            Cache::set('createhtml',$this->JumpUrl);
            $this->success('正在生成第 '.$progress.' 页'.'，共 '.$totalpages.' 页待生成',$this->JumpUrl);
        }
        else {
            
            Cache::delete('createhtml'); 
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成静态页面
     */
    public function createhtmlByone(object $detail = null)
    {
        if (!$detail->jumpurl) {

            if ($detail['skin']) {
                $htmlFile = $this->template.'custom/'.$detail['skin'].'.html';
            } else {
                $htmlFile = $this->template.$detail->channel->table.'/read.html';
            }

            $htmlFile = str_replace('\\','/',$htmlFile);
            $filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
            $filePath = str_replace(array('\/','\\'),'/',$filePath);

            // 目录静态页
            $filename = 'index';
            if (strpos($filePath,'.html')) {

                // 提取文件名
                $fileinfo = pathinfo($filePath);
                $filename = $fileinfo['filename'];
                $filePath = $fileinfo['dirname'];
            }

            // 分配页面数据
            $this->app->view->assign('detail',$detail);
            $this->app->view->config(['view_path' => $this->template]);
            $this->buildHtml($filename,$filePath,$htmlFile);
        }
    }

    /**
     * 生成网站地图
     */
    public function createmap(string $model = null, int $page = 1)
    {
        try {
            $Db = NAMESPACEMODELSYSTEM.ucfirst($model);
            $Db = new $Db;
            $count = $Db->count();
        } catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }

        // 获取总数
        $xmlmax  = (int)saenv('map_xml_max');
        $xmlpath = root_path().'extend/conf/maps/baidu.html';
        $total   = ceil(intval($count)/intval($xmlmax));

        if ($page <= $total) {

            // 组合元素
            $query = array_merge(input(),['page'=>$page+1]);
            $listmap = $Db->where('status','1')->withoutField('content')->limit($xmlmax)->page($page)->select()->toArray();

            // 单模型生成
            $filename = $page > 1 ? $model.'_'.$page : $model;
            $this->app->view->assign('listmap',$listmap);
            $this->buildHtml($filename,public_path().saenv('map_xml_path').'/',$xmlpath,'xml');
            $this->JumpUrl = (string)url('/system.rewrite/createmap',$query);
            Cache::set('createhtml',$this->JumpUrl);
            $this->success('正在生成第 '.$page.' 页'.'，共 '.$total.' 页待生成',$this->JumpUrl);
        }
        else {
            // 生成完毕
            Cache::set('createhtml',null);
            $this->success('生成完毕',$this->jumpIndex);  
        }
    }
}   