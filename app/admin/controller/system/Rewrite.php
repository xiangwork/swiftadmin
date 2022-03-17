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
use think\facade\Config;
use think\facade\Cache;
use app\common\model\system\Category as categoryModel;
use app\common\model\system\Channel as channelModel;
use app\common\model\system\Content as contentModel;

class Rewrite extends AdminController 
{
    /**
     * 栏目页模式
     *
     * @var [type]
     */
    public $categoryStyle;

    /**
     * 列表页模式
     *
     * @var [type]
     */
    public $listStyle;

    /**
     * 内容页模式
     *
     * @var [type]
     */
    public $contentStyle;

    /**
     * 模板路径
     *
     * @var [type]
     */
    public $template;

    /**
     * 默认跳转页
     *
     * @var [type]
     */
    public $jumpIndex;

    /**
     * 初始化函数
     *
     * @return void
     */
    public function initialize() 
    {
        parent::initialize();

        $this->categoryStyle = [
            '/[listdir]/',
            '/[listdir]/[sublist]/'
        ];

        $this->listStyle = [
            '/[listdir]/list_page.html',
            '/[listdir]/[sublist]/list_page.html'
        ];

        $this->contentStyle = [
            '/[model]/[id].html',
            '/[listdir]/[id].html',
            '/[listdir]/[sublist]/[id].html'
        ];

        $this->template  = root_path('app/index/view');
        $this->jumpIndex = (string)url('/system.rewrite/index');
        if (strpos($this->action,'create') !== false) {
            $this->app->view->config(['view_path' => $this->template]);
        }

        // 获取用户权限
        $cateGory = $this->auth->getRuleCatesTree(AUTHCATES);
        $this->app->view->assign(['cateGory'=>$cateGory]);
    }

    /**
     * 获取资源
     *
     * @return void
     */   
    public function index() 
    {
        // 读取配置
        $total = 0; 
        $rewrite = saenv('rewrite');
        $sitemap = saenv('sitemap');
        $map_file_path = public_path($sitemap['map_file_path']);
        $result = glob($map_file_path.'/*.xml');
        foreach ($result as $value) {
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
            'catePage' => $this->categoryStyle,
            'list_style' => $this->listStyle,
            'content_style'=> $this->contentStyle
            ]
        );
    }

    /**
     * 写入配置项
     *
     * @return void
     */
    public function baseCfg() 
    {
        if (request()->isPost()) {
            $post = input();
            $config = config('system');
            $config = array_merge($config, $post);
            if (arr2file('../config/system.php', $config) == false) {
                return $this->error('保存失败，请重试!');
            }

            $this->writeRouterRules();
            Cache::set('redis-system',$config);
            return $this->success('保存成功！');
        }
    }

    /**
     * 伪静态规则
     *
     * @return void
     */
    public function writeRouterRules()
    {
        try {

            $routers = null;
            $config = saenv('rewrite');
            $listItems = categoryModel::getListCache(true);
            foreach ($listItems as $item) {

                $style = $config['content_style'];
                if (strstr($style,'[model]')) {
                    $route = $item->channel->table.'/';
                }
                else {
                    $route = $item['pinyin'] . '/';
                    if ($item['pid'] !== 0 && strstr($style,'[sublist]')) {
                        $parent = list_search($listItems,['id'=>$item['pid']]);
                        if (!empty($parent)) {
                            $route = $parent['pinyin'] .'/'. $route;
                        }
                    }
                }
    
                $route .= '<id>';
                if ($item->single) {
                    $routers .= "Route::rule('".$item['pinyin']."$','category/index')";
                    $routers .= "->append(['dir'=>'".$item['pinyin']."'])->ext('html');".PHP_EOL;
                }
                
                $routers .= "Route::rule('".$route."$','content/read')->ext('html');".PHP_EOL;
            }

            $routers = array_unique(explode(PHP_EOL,$routers));
            $routers = implode(PHP_EOL,$routers);
            arr2router(root_path('app/index/route').'cms.php',$routers);

        } catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }
    }

    /**
     * 生成静态首页
     *
     * @return void
     */
    public function createIndex()
    {
        try {
            $this->buildHtml('index',public_path(),'index/index');
        } catch (\Throwable $th) {
            $this->error($th->getMessage(),$this->jumpIndex);
        }

        $this->success('生成首页成功',$this->jumpIndex);
    }

    /**
     * 生成静态页面
     *
     * @return void
     */
    public function createHtml()
    {
        ob_start();
        $type = input('type');
        switch ($type) {
            case 'category':
                $this->createCate();
                break;
            case 'list':
                $this->createList();
                break;   
            case 'content':
                $this->createContent();
                break;          
            default:
                // TODO..
                break;
        }
        ob_end_flush();
    }

    /**
     * 生成栏目页
     *
     * @return void
     */
    protected function createCate()
    {
        $id = request()->param('id/d');
        $subject = request()->param('subject/d') ?? 1;

        if (!empty($id)) {
            $where['id'] = $id;
        }
        
        $where['status'] = 1;
        $list = categoryModel::where($where)->select();
        $count = count($list);
    
        if ($subject <= $count) {

            $detail = $list[$subject-1];
            
            if (!$detail->jumpurl) {

                // 判断模板信息
                if ($detail['skin']) {
                    $this->template = $this->template.'category/'.$detail['skin'].'.html';
                } else {
                    $this->template = $this->template.$detail->channel->template.'/index.html';
                }
                
                // 清理模板转义
                $this->template = str_replace('\\','/',$this->template);

                if ($detail->single) {
                    $this->filePath = public_path();
                } else {
                    $this->filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
                    $this->filePath = str_replace(array('\/','\\'),'/',$this->filePath);
                }

                $this->app->view->assign('detail',$detail->toArray());
                $this->buildHtml($detail->single ? $detail->pinyin :'index',$this->filePath,$this->template);

                $totalPages = Config::get('total.Pages');
                if (!empty($totalPages) && $totalPages >= 1) {

                    $this->filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
                    $this->filePath = str_replace(array('\/','\\'),'/',$this->filePath);

                    for ($i=1; $i < $totalPages+1; $i++) { 
                        $listNodes[] = [
                            'id' => $detail['id'],
                            'page' => $i,
                            'fileName' => 'list_'.$i,
                            'filePath' => $this->filePath,
                            'template' => $this->template
                        ];
                    }

                    $temporary = system_cache('listNodes') ?? [];
                    system_cache('listNodes',array_merge($temporary,$listNodes));
                }

                // 创建跳转地址
                $queryParams = array_merge(input(),['subject' => $subject + 1]);
                $this->JumpUrl = (string)url('/system.rewrite/createHtml',$queryParams);
                system_cache('createHtml',$this->JumpUrl);
                $this->success('正在生成栏目第 '.$subject.' 项'.'，共 '.count($list).' 项待生成',$this->JumpUrl);
            }
        }
        else {

            if (system_cache('listNodes')) {
                $this->JumpUrl = (string)url('/system.rewrite/createHtml',['type'=>'list']);
                return $this->success('正在生成列表页',$this->JumpUrl);
            }

            system_cache('createHtml',null);
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成栏目列表页
     *
     * @return void
     */
    protected function createList()
    {
        $page = input('page/d') ?? 1;
        $listNodes = system_cache('listNodes');
        if ($page <= count($listNodes)) {
            $current = $page;
            $progress = ($page + 3) - 1;

            // 循环处理节点
            for (;$page <= $progress; $page++) {

                if (!isset($listNodes[$page-1])) {
                    break;
                }

                $item = $listNodes[$page-1];
                $detail = categoryModel::queryCategory($item['id']);
                Config::set(['page'=>$item['page']],'param');
                $this->app->view->assign('page',$item['page']);
                $this->app->view->assign('detail',$detail);
                $this->buildHtml($item['fileName'],$item['filePath'],$item['template']);
            }

            // 跳转地址
            $query = array_merge(input(),['page'=>$page]);
            $this->JumpUrl = (string)url('/system.rewrite/createHtml',$query);
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成列表页第 '.$current.' - '.($page-1).' 页'.'，共 '.count($listNodes).' 页待生成',$this->JumpUrl);
        }
        else {
            system_cache('listNodes',null);
            system_cache('createHtml',null); 
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成内容页
     *
     * @param array $params
     * @return void
     */
    protected function createContent($params = [])
    {
        $params = request()->param();
        $contentNodes = system_cache('contentNodes');
        if (empty($contentNodes) || isset($params['id'])) {

            $where = []; 
            if (!empty($params['id'])) {
                $where['id'] = $params['id'];
            }

            $listItems = categoryModel::where($where)->select();

            foreach ($listItems as $item) {

                $total = contentModel::where([
                    'pid' => $item->id,
                    'status' => 1
                ])->count('id'); 
                
                // 计算分页
                if (!empty($total)) {
                    $pages = ceil((int)$total / 10);
                    $contentNodes[] = [
                        'id' => $item->id,
                        'count' => $total,
                        'pages' => $pages,
                        'table' =>  $item->channel->table,
                    ];
                }
            }

            system_cache('contentNodes',$contentNodes);
        }

        // 缓存查询参数
        $key = input('key/d') ?? 0;
        $page = input('page/d') ?? 1;
        $progress = input('progress/d') ?? 1;
        
        try {
            $totalPages = array_sum(array_column($contentNodes,'pages'));
        } catch (\Throwable $th) {
            return $this->error('当前栏目无内容生成',$this->jumpIndex);
        }

        $item = $contentNodes[$key];
        if ($page > $item['pages']) {
            $key = $key + 1;
            if (isset($contentNodes[$key])) {
                $page = 1;
                $item = $contentNodes[$key];
            }
        }

        if ($page <= $item['pages']) {

            // 查找数据列表
            $listItems = contentModel::with($item['table'])->where([
                'pid' => $item['id'],
                'status' => 1,
            ])->limit(10)->page($page)->select();

            try {

                // 循环生成静态页面
                foreach ($listItems as $detail) {
                    $this->createHtmlByone($detail);
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage(),$this->jumpIndex);
            }

            $this->JumpUrl = (string)url('/system.rewrite/createHtml',[
                'key' => $key,
                'page' => $page + 1,
                'type' => 'content',
                'progress' => $progress + 1
            ]);
            
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成第 '.$progress.' 页'.'，共 '.$totalPages.' 页待生成',$this->JumpUrl);
        }
        else {

            system_cache('createHtml',null); 
            system_cache('contentNodes',null); 
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }

    /**
     * 生成静态页面
     *
     * @param object|null $detail
     * @return void
     */
    public function createHtmlByone(object $detail = null)
    {
        if (!$detail->jumpurl) {

            if ($detail['skin']) {
                $this->htmlFile = $this->template.'custom/'.$detail['skin'].'.html';
            } else {
                $this->htmlFile = $this->template.$detail->channel->table.'/read.html';
            }

            $this->htmlFile = str_replace('\\','/',$this->htmlFile);
            $this->filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
            $this->filePath = str_replace(array('\/','\\'),'/',$this->filePath);

            // 目录静态页
            $filename = 'index';
            if (strpos($this->filePath,'.html')) {
                $fileinfo = pathinfo($this->filePath);
                $filename = $fileinfo['filename'];
                $this->filePath = $fileinfo['dirname'];
            }

            $this->app->view->assign('detail',$detail);
            $this->app->view->config(['view_path' => $this->template]);
            $this->buildHtml($filename,$this->filePath.'/',$this->htmlFile);
        }
    }

    /**
     * 生成网站地图
     *
     * @param string|null $model
     * @param integer $page
     * @return void
     */
    public function createMap(string $key = null, int $page = 1)
    {
        
        $createListMap = system_cache('createListMap');
        if (empty($createListMap)) {

            $id = input('id/d');
            $where = [];

            // 是否为单模型
            if (!empty($id) && $id >= 1) {
                $where['id'] = $id;
            }

            $createList = channelModel::where($where)->select();
            if (!empty($createList)) {

                $limit  = (int)saenv('map_max_limit');
                foreach ($createList as $key => $value) {

                    $count = contentModel::where('cid',$value->id)->count('id');
                    $pages   = ceil(intval($count) / intval($limit));
                    if ($pages == null && $pages == 0) {
                        continue;
                    }

                    // 封装查询参数
                    $createListMap[$key] = [
                        'cid'   => $value->id,
                        'file'  => $value->template,
                        'limit' => $limit,
                        'pages' => $pages,
                        'count' => $count
                    ];
                }
            }

            // 判断是否存在数据
            if (empty($createListMap)) {
                return $this->error('当前没有内容可生成',$this->jumpIndex);
            }

            system_cache('createListMap',$createListMap);
        }

        $key = input('key/d') ?? 0;
        $page = input('page/d') ?? 1;
        $mapItem = $createListMap[$key];
        if ($page > $mapItem['pages']) {
            $key = $key + 1;
            if (isset($createListMap[$key])) {
                $page = 1;
                $mapItem = $createListMap[$key];
            }
        }

        // 生成百度地图
        if ($page <= $mapItem['pages']) {

            $fileName = $page > 1 ? $mapItem['file'].'_'.$page : $mapItem['file'];
            $filePath = public_path(saenv('map_file_path')).$fileName;
            if (!is_file($filePath)) {
                $listMapUrl = contentModel::where([
                    'cid'=>$mapItem['cid'],
                    'status'=>1
                ])->limit($mapItem['limit'])->page($page)->select()->toArray();

                $this->app->view->assign('listmap',$listMapUrl);
                $readMaps = root_path().'extend/conf/maps/baidu.html';
                $this->buildHtml($fileName,public_path(saenv('map_file_path')),$readMaps,'xml');
            }

            $this->JumpUrl = (string)url('/system.rewrite/createMap',[
                'key' => $key,
                'page' => $page + 1,
            ]);
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成第 '.$page.' 页'.'，共 '.$mapItem['pages'].' 页待生成',$this->JumpUrl);
        }
        else {
            system_cache('createHtml',null); 
            return $this->success('全部生成完毕',$this->jumpIndex);
        }
    }
}
