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
use think\facade\Config;
use app\common\model\system\Category as categoryModel;
use app\common\model\system\Channel as channelModel;
use app\common\model\system\Content as contentModel;

class Rewrite extends AdminController 
{
    // 栏目页模式
    public $categoryStyle;

    // 列表页模式
    public $listStyle;

    // 内容页模式
    public $contentStyle;

    // 模板路径
    public $template;

    // 默认跳转页
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
            '/[listdir]/[id]/',
            '/[listdir]/[id].html',
            '/[listdir]/[sublist]/[id].html'
        ];

        $this->template  = root_path('app/index/view');
        $this->jumpIndex = (string)url('/system.rewrite/index');
        if (strpos($this->action,'create') !== false) {
            $this->app->view->config(['view_path' => $this->template]);
        }
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
            if (arr2file('../config/system.php', $config) === false) {
                return $this->error('保存失败，请重试!');
            }
            \think\facade\Cache::set('redis-system',$config);
            return $this->success('保存成功！');
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
        $id = input('id/d');
        $page = input('page/d') ?? 1;
        if (!empty($id)) {
            $where['id'] = $id;
        }
        // 查询到LIST的数据信息
        $where['status'] = 1;
        $list = categoryModel::where($where)->select();
        if ($page <= count($list)) {

            // 重置列表缓存
            if ($page == 1) {
                system_cache('pagesNode', []);
            }

            // 获取数据实例
            $detail = $list[$page-1];
            if (!$detail->jumpurl) {

                // 自定义模板
                if ($detail['skin']) {
                    $htmlFile = $this->template.'category/'.$detail['skin'].'.html';
                } else {
                    $htmlFile = $this->template.$detail->channel->template.'/index.html';
                }

                $htmlFile = str_replace('\\','/',$htmlFile);
                $filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
                $filePath = str_replace(array('\/','\\'),'/',$filePath);

                // 分配当前数据
                Config::set(['page'=>$page],'current');
                Config::set(['detail'=>$detail],'current');
                $this->app->view->assign('page',$page);
                $this->app->view->assign('detail',$detail->toArray());
                $this->buildHtml('index',$filePath,$htmlFile);
                $totalPages = Config::get('current.totalPages');
                if (!empty($totalPages) && $totalPages >= 2) {

                    // 处理列表节点
                    $nextnodes = [];
                    $pagestyle = build_request_url([],'list_style',['page'=>$page,'total'=>$totalPages]);
                    
                    if (preg_match('/href="(.*?)"/i',$pagestyle,$matches)) {
                        // 处理文件名
                        $filePath = substr($matches[1],0,strpos($matches[1],'list'));
                        $filePath = str_replace(saenv('site_http'),public_path(),$filePath);
                        $filePath = str_replace(array('\/','\\'),'/',$filePath);
                    }

                    for ($i = 2; $i <= $totalPages; $i++) {
                        $nextnodes[] = [
                            'id' => $detail['id'],
                            'page' => $i,
                            'filename' => 'list_'.$i,
                            'filePath' => $filePath,
                            'template' => $htmlFile
                        ];
                    }

                    $pagesNode = system_cache('pagesNode');
                    $pagesNode = array_merge($pagesNode,$nextnodes);
                    system_cache('pagesNode', $pagesNode);
                }
            }

            // 创建跳转地址
            $query = array_merge(input(),['page'=>$page + 1]);
            $this->JumpUrl = (string)url('/system.rewrite/createHtml',$query);
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成栏目首页第 '.$page.' 页'.'，共 '.count($list).' 页待生成',$this->JumpUrl);
        }
        else {
            if (system_cache('pagesNode')) {
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
        $pagesNode = system_cache('pagesNode');
        $pagescount = count($pagesNode);

        if ($page <= $pagescount) {
            $current = $page;
            $progress = $page + 30;
            for (;$page <= $progress; $page++) {

                if (!isset($pagesNode[$page-1])) {
                    break;
                }

                // 处理数组信息
                $item = $pagesNode[$page-1];
                $detail = categoryModel::getById($item['id']);
                Config::set(['page'=>$item['page'],'detail'=>$detail],'current');
                $this->app->view->assign('page',$item['page']);
                $this->app->view->assign('detail',$detail->toArray());
                $this->buildHtml($item['filename'],$item['filePath'],$item['template']);
            }

            // 跳转地址
            $query = array_merge(input(),['page'=>$page]);
            $this->JumpUrl = (string)url('/system.rewrite/createHtml',$query);
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成第 '.$current.' - '.($page-1).' 页'.'，共 '.$pagescount.' 页待生成',$this->JumpUrl);
        }
        else {
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
    protected function createContent(int|array $params = [])
    {
        $params = request()->param();
        $listCache = system_cache('content_style');
        if (empty($listCache) || isset($params['id'])) {

            $where = []; 
            if (!empty($params['id'])) {
                $where['id'] = $params['id'];
            }

            $columns = categoryModel::where($where)->select();

            foreach ($columns as $item) {

                $total = contentModel::where([
                    'pid' => $item->id,
                    'status' => 1
                ])->count('id'); 
                
                // 计算分页
                if (!empty($total)) {
                    $pages = ceil((int)$total / 30);
                    $listCache[] = [
                        'id' => $item->id,
                        'count' => $total,
                        'pages' => $pages,
                        'attr' =>  $item->channel->attr,
                    ];
                }
            }

            system_cache('content_style',$listCache);
        }

        $key = input('key/d') ?? 0;
        $page = input('page/d') ?? 1;
        $progress = input('progress/d') ?? 1;
        
        try {
            $totalPages = array_sum(array_column($listCache,'pages'));
        } catch (\Throwable $th) {
            return $this->error('当前栏目无内容生成',$this->jumpIndex);
        }

        $item = $listCache[$key];
        if ($page > $item['pages']) {
            $key = $key + 1;
            if (isset($listCache[$key])) {
                $page = 1;
                $item = $listCache[$key];
            }
        }

        if ($page <= $item['pages']) {

            $withs = ['attr'];
            if ($item['attr'] !== 'none') {
                $withs[] = $item['attr'];
            }

            // 查找数据列表
            $columns = contentModel::with($withs)->where([
                'pid' => $item['id'],
                'status' => 1,
            ])->limit(30)->page($page)->select();

            try {

                // 循环生成静态页面
                foreach ($columns as $detail) {
                    $this->createHtmlByone($detail);
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage(),$this->jumpIndex);
            }

            $this->JumpUrl = (string)url('/system.rewrite/createHtml',[
                'key' => $key,
                'page' => $page+1,
                'type' => 'content',
                'progress' => $progress+1
            ]);
            
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成第 '.$progress.' 页'.'，共 '.$totalPages.' 页待生成',$this->JumpUrl);
        }
        else {

            system_cache('createHtml',null); 
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
        if (!$detail->attr->jumpurl) {

            if ($detail['attr']['skin']) {
                $htmlFile = $this->template.'custom/'.$detail['skin'].'.html';
            } else {
                $htmlFile = $this->template.$detail->channel->template.'/read.html';
            }

            $htmlFile = str_replace('\\','/',$htmlFile);
            $filePath = str_replace(saenv('site_http'),public_path(),$detail->readurl);
            $filePath = str_replace(array('\/','\\'),'/',$filePath);

            // 目录静态页
            $filename = 'index';
            if (strpos($filePath,'.html')) {
                $fileinfo = pathinfo($filePath);
                $filename = $fileinfo['filename'];
                $filePath = $fileinfo['dirname'];
            }
            $this->app->view->assign('detail',$detail);
            $this->app->view->config(['view_path' => $this->template]);
            $this->buildHtml($filename,$filePath.'/',$htmlFile);
        }
    }

    /**
     * 生成网站地图
     *
     * @param string|null $model
     * @param integer $page
     * @return void
     */
    public function createMap(string $model = null, int $page = 1)
    {
        if (!$model) {
            $this->error('请选择模型进行生成');
        }

        // 获取总数
        $model = channelModel::getById($model);
        $count = contentModel::where('cid',$model['id'])->count('id');
        $xmlmax  = (int)saenv('map_xml_max');
        $xmlpath = root_path().'extend/conf/maps/baidu.html';
        $total   = ceil(intval($count)/intval($xmlmax));

        if ($page <= $total) {

            // 查询数据
            $listmap = contentModel::where('status','1')->limit($xmlmax)->page($page)->select()->toArray();

            // 单模型生成
            $filename = $page > 1 ? $model['template'].'_'.$page : $model['template'];
            $this->app->view->assign('listmap',$listmap);
            $this->buildHtml($filename,public_path().saenv('map_xml_path').'/',$xmlpath,'xml');
            $this->JumpUrl = (string)url('/system.rewrite/createMap',array_merge(input(),['page' => $page+1]));
            system_cache('createHtml',$this->JumpUrl);
            $this->success('正在生成第 '.$page.' 页'.'，共 '.$total.' 页待生成',$this->JumpUrl);
        }
        else {
            // 生成完毕
            system_cache('createHtml',null);
            $this->success('生成完毕',$this->jumpIndex);
        }
    }
}   