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
namespace app\common\library;

use think\facade\Db;
use app\common\library\ResultCode;
use app\common\model\system\ApiCondition;
use app\common\model\system\User as UserModel;

/**
 * 会员鉴权常量
 */
const AUTH     = 1;
const ALLM     = 2;
const DISABLE  = 2;

class Auth
{
    /**
     * 数据库实例
     * @var object
     */
    protected $model = null;

    /**
     * token令牌
     * @var string
     */
    public $token = null;

    /**
     * 用户数据
     * @var object|array
     */
    public $userInfo = null;

    /**
     * API类接口
     * @var string
     */
    public $classHash = null;

    /**
     * API节点
     * @var string
     */
    public $nodeHash = null;

    /**
     * API参数接口
     * @var string
     */
    public $params = [];

    /**
     * 保活时间
     * @var string
     */
    protected $keepTime = 2592000;

    /**
     * 接口访问类型
     * @var array
     */
    protected $method = [
        '0' => 'GET',
        '1' => 'POST'
    ];

    /**
     * 错误信息
     * @var string
     */
    protected $_error = '';

    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    /**
     * 类构造函数
     * class constructor.
     */
    public function __construct($config = [])
    {
        $this->request = \think\facade\Request::instance();
    }

    /**
     * 初始化
     * @access public
     * @param  array $options 参数
     * @return object
     */

    public static function instance($options = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new static($options);
        }

        // 返回实例
        return self::$instance;
    }

    /**
     * API权限验证
     * @param string|null $class
     * @return bool
     */
    public function checkApi(string $class = null)
    {

        // 请求参数
        $this->params = input();
        if ((!isset($this->params['app_id'])
                || !isset($this->params['app_secret']))
            && !isset($this->params['token'])
        ) {
            $this->setError(ResultCode::PARAMERROR);
            return false;
        }

        // 优先缓存读取
        $this->classHash = sha1($class);
        $restful = system_cache($this->classHash);
        if (empty($restful)) {
            $restful = Db::name('api')->where('class', $class)->find();
            system_cache($this->classHash, $restful, saenv('cache_time'));
        }

        // 校验请求方式
        if (!$this->checkMothod($restful)) {
            return false;
        }

        // 接口是否鉴权
        if ($restful['status'] == AUTH) {

            // 是否token鉴权
            if ($restful['access'] == ALLM) {
                $this->token = $this->params['token'] ?? '';
                $data = $this->checkToken($this->token);
                if ($data === false) {
                    $this->setError(ResultCode::TOKEN_INVALID);
                    return false;
                }
                $this->params = $data;
            }

            if (
                !$this->params['app_id']
                || !$this->params['app_secret']
            ) {
                $this->setError(ResultCode::LACKPARAME);
                return false;
            }

            // 默认走普通流程
            $list = $this->getApiRuleList();
            if (!$nodes = list_search($list, ['class' => $class])) {
                $this->setError(ResultCode::AUTH_ERROR);
                return false;
            }

            // 判断余量
            if (!$this->checkCallLimit($nodes)) {
                return false;
            }
        } else if ($restful['status'] == DISABLE) {
            $this->setError(ResultCode::API_DISABLE);
            return false;
        }

        return true;
    }

    /**
     * 访问方式
     * @access protected
     * @param  array    $restful     当前接口数据
     * @return bool
     */
    protected function checkMothod(array $restful = [])
    {
        if (
            $restful['method'] !== ALLM
            && $this->method[$restful['method']] !== request()->method()
        ) {
            $this->setError(ResultCode::METHOD_INVALID);
            return false;
        }

        return true;
    }

    /**
     * 获取权限列表
     * @access protected
     * @return array
     */
    protected function getApiRuleList()
    {
        // 读取节点缓存
        $where['app_id'] = $this->params['app_id'];
        $where['app_secret'] = $this->params['app_secret'];
        $this->nodeHash = sha1(implode('.', $where));
        $list = system_cache($this->nodeHash);

        if (empty($list)) {
            $list = Db::view('user', 'id')
                ->view('api_access', '*', 'api_access.user_id=user.id')
                ->view('api', 'class', 'api.id=api_access.api_id')
                ->where([
                    'user.app_id' => $this->params['app_id'],
                    'user.app_secret' => $this->params['app_secret'],
                ])->select()->toArray();
            // 修改后请清理缓存
            if ($list) {
                system_cache($this->nodeHash, $list, saenv('cache_time'));
            }
        }

        return $list ?? [1];
    }

    /**
     * 接口其他限制
     * @access protected 
     * @param  array    $result     当前接口规则
     * @return bool
     */
    protected function checkCallLimit(array $result = [])
    {
        // 查询规则
        $access = md5($this->params['app_id'] . $result['class']);
        if ($result['day'] || $result['ceiling'] || $result['seconds']) {
            $condition = ApiCondition::where('hash', $access)->find();
            if (empty($condition)) {
                $condition = [
                    'day' => 0,
                    'seconds' => time(),
                    'ceiling' => 0,
                ];
            }
        }

        // API每日上限
        if ($result['day'] && $condition['day'] >= $result['day']) {
            $this->setError(ResultCode::DAY_INVALID);
            return false;
        }

        // 调用间隔/秒
        if ($result['seconds'] && (time() - $condition['seconds']) <= $result['seconds']) {
            $this->setError(ResultCode::API_SPEED_INVALID);
            return false;
        }

        // 接口调用总数
        if ($result['ceiling'] && $condition['ceiling'] >= $result['ceiling']) {
            $this->setError(ResultCode::CEILING_INVALID);
            return false;
        }

        try {

            if ($result['day'] || $result['ceiling'] || $result['seconds']) {

                $condition['day'] += 1;
                $condition['ceiling'] += 1;
                $condition['seconds'] = time();
                if (is_object($condition)) {

                    // 次日初始化
                    $daytime = strtotime($condition['createtime']);
                    if (date('Ymd', $daytime) != date('Ymd')) {
                        $condition['day'] = 1;
                    }

                    // 更新数据
                    $condition->save();
                } else {

                    // 创建新规则
                    $condition['hash'] = $access;
                    ApiCondition::create($condition);
                }
            }
        } catch (\Throwable $th) {
            $this->setError($th->getMessage());
            return false;
        }

        return true;
    }

    /**
     * 用户注册
     *
     * @param array $post
     * @return void
     */
    public function register(array $post)
    {

        if (!saenv('user_status')) {
            $this->setError('暂未开放注册！');
            return false;
        }

        // 禁止批量注册
        $where[] = ['createip', '=', ip2long(request()->ip())];
        $where[] = ['createtime', '>', linux_extime(1)];
        $totalMax = UserModel::where($where)->count();

        if ($totalMax >= saenv('user_register_second')) {
            $this->setError('当日注册量已达到上限');
            return false;
        }

        // 过滤用户信息
        if (isset($post['nickname']) && UserModel::getByNickname($post['nickname'])) {
            $this->setError('当前用户名已被占用！');
            return false;
        }

        if (isset($post['email']) && UserModel::getByEmail($post['email'])) {
            $this->setError('当前邮箱已被占用！');
            return false;
        }

        if (isset($post['mobile']) && UserModel::getByMobile($post['mobile'])) {
            $this->setError('当前手机号已被占用！');
            return false;
        }

        try {

           $this->userInfo = UserModel::create($post);
           $this->returnToken($this->userInfo);

        } catch (\Throwable $th) {
            $this->setError($th->getMessage());
            return false;
        }

        return true;
    }

    /**
     * 用户检测登录
     * @param string $name
     * @param string $pwd
     * @return bool
     */
    public function login(string $nickname = '', string $pwd = '')
    {
        // 支持邮箱或手机登录
        if (filter_var($nickname, FILTER_VALIDATE_EMAIL)) {
            $where[] = ['email', '=', htmlspecialchars(trim($nickname))];
        } else {
            $where[] = ['mobile', '=', htmlspecialchars(trim($nickname))];
        }

        $this->userInfo = UserModel::where($where)->find();

        if (!empty($this->userInfo)) {

            if ($this->userInfo->pwd != member_encrypt($pwd, $this->userInfo->salt)) {
                $this->setError('用户名或密码错误');
            }

            if (!$this->userInfo['status']) {
                $this->setError('用户异常或未审核，请联系管理员');
                return false;
            }

            // 更新登录数据
            $this->userInfo->logintime = time();
            $this->userInfo->loginip = request()->ip();
            $this->userInfo->logincount++;

            if ($this->userInfo->save()) {
                $this->returnToken($this->userInfo, false);
                return true;
            }

        } else {
            $this->setError('您登录的用户不存在');
            return false;
        }
    }

    /**
     * 验证是否登录
     * @param string 
     * @return bool
     */
    public function isLogin()
    {
        $token = $this->getToken();

        if (!$token) {
            return false;
        }

        $uid = $this->checkToken($token);

        if (!empty($uid)) {

            $this->token = $token;
            $this->userInfo = UserModel::find($uid);

            return true;
        }

        return false;
    }

    /**
     * 退出登录
     *
     * @return void
     */
    public function logout()
    {
        cookie('uid', null);
        cookie('token', null);
        cookie('nickname', null);
    }

    /**
     * 
     * 返回前端令牌
     * @param object  $array
     * @return bool
     */
    public function returnToken(object $user = null, $token = false)
    {
        $this->token = $token ? $this->getToken() : $this->buildToken($user->id);
        cookie('uid', $user->id, $this->keepTime);
        cookie('token', $this->token, $this->keepTime);
        cookie('nickname',$user->nickname, $this->keepTime);
        \think\facade\Cache::set($this->token, $user->id, $this->keepTime);
    }

    /**
     * 生成token
     * @access protected
     * @return mixed   
     */
    protected function buildToken(mixed $id)
    {
        return md5(create_rand(16) . $id);
    }

    /**
     * 获取token
     *
     * @return string
     */
    public function getToken()
    {
       return request()->header('token', input('token', cookie('token')));
    }

    /**
     * 校验token
     * @access protected
     * @param  string       $token       用户token
     * @return bool
     */
    public function checkToken(string $token = null)
    {
        $userId = \think\facade\Cache::get($token);
        return $userId ?? false;
    }

    /**
     * 获取最后产生的错误
     * @return string
     */
    public function getError()
    {
        return $this->_error;
    }

    /**
     * 设置错误
     * @param string $error 信息信息
     */
    protected function setError($error)
    {
        $this->_error = $error;
    }
}
