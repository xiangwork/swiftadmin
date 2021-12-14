<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.NET High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------
namespace app;

use app\BaseController;
use app\common\library\Auth;

// 前台全局控制器基类
class HomeController extends BaseController 
{
    /**
     * 数据库实例
     * @var object
     */
	public $model = null;

    /**
     * 是否验证
     * @var bool
     */
	public $isValidate = true;

    /**
     * 验证场景
     * @var string
     */
	public $scene = '';

    /**
     * 控制器/类名
     * @var string
     */
    public $controller = null;

    /**
     * 控制器方法
     * @var string
     */
    public $action = null;

    /**
     * 操作状态
     * @var int
     */
	public $status = false;

    /**
     * 错误消息
     * @var string
     */
	public $error = null;

    /**
     * 接口权限
     * @var object
     */
	public $auth = null;

    /**
     * 用户登录ID
     * @var int
     */
    public $userId = null;

    /**
     * 用户数据
     * @var object|array
     */
    public $userInfo = null;

    /**
     * 控制器登录鉴权
     * @var bool
     */
    public $needLogin = false;

    /**
     * 禁止登录重复
     * @var array
     */
	public $repeatLogin = ['login','register'];

    /**
     * 非鉴权方法
     * @var array
     */
	public $noNeedLogin = ['index','home'];

    /**
     * 获取地址类型
     * @var string
     */
	public $Urltype = null;

    /**
     * 跳转URL地址
     * @var string
     */
	public $JumpUrl = '/user/index';

	// 初始化函数
    public function initialize() 
    {
        parent::initialize();

        // 获取权限实例
        $this->auth = Auth::instance();

        // 获取请求控制器
        $this->action = request()->action(true);
        $this->controller = request()->controller(true);

        // 是否验证登录器
        if($this->auth->isLogin()) {
            $this->userId = $this->auth->userInfo['id']; 
            $this->userInfo = $this->auth->userInfo;
 
            if(in_array($this->action,$this->repeatLogin)) {
                $this->redirect($this->JumpUrl);
            }

            $this->app->view->assign('user',$this->auth->userInfo);
        }
        else { // 非鉴权方法
            if ($this->needLogin && !in_array($this->action,$this->noNeedLogin)) {
                return $this->error('请登录后访问','/');
            }
        }

        // 获取站点数据
        foreach (saenv('site') as $key => $value) {
            $this->app->view->assign($key,$value);
        }
    }

    /**
     * 视图过滤
     *
     * @return void
     */
    public function view($template = '', array $argc = [])
    {
        return view($template,$argc)->filter(function($content) {
            if (saenv('compression_page')) {
                $content = preg_replace('/\s+/i',' ',$content);
            }
        	return $content;
        });
    }

    /**
     * 退出登录
     * @access public
     * @return void        
     */
	public function logOut() {
        cookie('uid', NULL);
        cookie('token', NULL);
        cookie('nickname', NULL);
		$this->redirect('/');
	}

	/**
     * 设置注册来源
     */
	public function setHttpRefrer() {
		if (isset($_SERVER["HTTP_REFERER"])) {

			if (strstr($_SERVER["HTTP_REFERER"],'setpwd')) {
				return false;
            }
            
			$referer = parse_url($_SERVER["HTTP_REFERER"]);
            if($referer['host'] == saenv('site_url') ){
				cookie('referer',$_SERVER["HTTP_REFERER"], 604800);
				return true;
			}
		}
		return false;
	}
	
	/**
     * 清空注册来源
     */
	public function refereTonull() {
		cookie('referer',null);
	}



}
