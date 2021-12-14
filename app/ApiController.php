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
use app\common\library\ResultCode;

// Api全局控制器基类
class ApiController extends BaseController 
{
    /**
     * 数据库实例
     * @var object
     */
	public $model = null;

    /**
     * API验证流程
     * @var bool
     */
	public $authWorkflow = true;

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
     * 操作状态
     * @var int
     */
	public $status = false;

    /**
     * 接口权限
     * @var object
     */
	public $auth = '';

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
     * 控制器方法
     * @var string
     */
    public $action = null;

    /**
     * 禁止登录重复
     * @var array
     */
	public $repeatLogin = [];

    /**
     * 非鉴权方法
     * @var array
     */
	public $noNeedLogin = ['index','login','logout'];

	// 初始化函数
    public function initialize() 
    { 
        parent::initialize();
       
        // 检查跨域请求
        check_referer_origin();
        $this->auth = Auth::instance();
        if ($this->authWorkflow) {
           
            // 验证API控制器
            $this->controller = request()->controller(true);
            $this->action = request()->action(true);
            $this->class = $this->controller.'/'.$this->action;
            if (!$this->auth->checkAPI($this->class)) {
                return ajax_return($this->auth->getError());
            }
        }
        else {
            
            // 普通验证流程
            // 是否验证登录器
            if ($this->needLogin) {
                $this->action = request()->action(true);
                if($this->auth->isLogin()) {
                    $this->userId = $this->auth->userInfo['id']; 
                    $this->userInfo = $this->auth->userInfo; 
                    if(in_array($this->action,$this->repeatLogin)) {
                        return $this->error(ResultCode::INVALID['msg']);
                    }
                }
                else { // 非鉴权方法
                    if (!in_array($this->action,$this->noNeedLogin)) {
                        return $this->error(ResultCode::ACCESS_TOKEN_TIMEOUT['msg'],null,null,-101);
                    }
                }
            }
        }
    }
}
