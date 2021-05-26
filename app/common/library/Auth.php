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
namespace app\common\library;

use think\facade\Db;
use app\common\library\ResultCode;
use app\common\model\system\AdminAccess;
use app\common\model\system\ApiCondition;
use app\common\model\system\User as UserModel;
use app\common\model\system\Category as CategoryModel;
use app\common\model\system\Admin as AdminModel;
use app\common\model\system\AdminRules as AdminRulesModel;
use app\common\model\system\AdminGroup as AdminGroupModel;

/**
 * 系统全局鉴权类
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
     * 管理员数据
     * @var array
     */
    private $admin = null;

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
     * 用户组id
     * @var array
     */
    public $group_ids = [];


    /**
     * 分组标记
     * @var array
     */
    public $authGroup = '_admin_group_auth';

    /**
     * 用户私有标记
     * @var array
     */
    public $authPrivate = '_admin_private_auth';

    /**
     * 保活时间
     * @var string
     */
    protected $keeptime = 2592000;

    /**
     * 接口访问类型
     * @var array
     */
    protected $method = [
        '0'=>'GET',
        '1'=>'POST'
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
        $this->admin = session('AdminLogin');
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
     * 检查权限
     * @param string|array  $name   	    需要验证的规则列表,支持逗号分隔的权限规则或索引数组
     * @param int           $uid            认证用户的id
     * @param int           $type 			认证类型
     * @param string        $mode 			执行check的模式
     * @param string        $relation 		如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
     * @return bool               	        通过验证返回true;失败返回false
     */
    public function checkauth($name, $uid = 0, $type = 1, $mode = 'url', $relation = 'or') 
    {
        // 转换格式
        if (is_string($name)) {
            $name = strtolower($name);
            if (strpos($name, ',') !== false) {
                $name = explode(',', $name);
            } else {
                $name = [$name];
            }
        }
        
        $authList = [];
        if ('url' == $mode) { // 解析URL参数
            $REQUEST = unserialize(strtolower(serialize($this->request->param())));
        }

        foreach ($this->get_auth_list($uid) as $auth) {

            // 非鉴权接口
            $router = $auth['router'];
            if (in_array($router, $name) && $auth['auth'] == 0) {
                $authList[] = $router;
                continue;
            }

            // 校验正则模式
            if (!empty($auth['condition'])) {
                $rule = $condition = null;
                $user = $this->getUserInfo();
                $command = preg_replace('/\{(\w*?)\}/', '$user[\'\\1\']', $rule);
                
                @(eval('$condition=(' . $command . ');'));
                if ($condition) {
                    $authList[] = $router;
                }
            }

            // URL参数模式
            $query = preg_replace('/^.+\?/U', '', $router);
            if ('url' == $mode && $query != $router) {
                parse_str($query, $param);
                $intersect = array_intersect_assoc($REQUEST, $param);
                $router = preg_replace('/\?.*$/U', '', $router); 
                if (in_array($router, $name) && $intersect == $param) {
                    $authList[] = $router;
                }
            }else {
                if (in_array($router, $name)) { 
                    $authList[] = $router;
                }
            }
        }

        $authList = array_unique($authList);
        if ('or' == $relation && !empty($authList)) {
            return true;
        }

        $authdiff = array_diff($name, $authList);
        if ('and' == $relation && empty($authdiff)) {
            return true;
        }

        return false;
    }

    /**
     * 获取权限节点
     * @param  int      $uid    用户id
     * @param  string   $type   节点类型
     * @return array
     */
    public function _get_auth_nodes($uid = null, string $type = 'rules')
    {
        // 私有节点
        $authGroup = $authPrivate = [];
        $uid = $uid ?? $this->admin['id'];
        $authnodes = AdminAccess::where('uid',$uid)->find();
        if (!empty($authnodes[$type])) {
            $authPrivate = explode(',', $authnodes[$type]);
        }
        
        // 用户组节点
        if (!empty($authnodes['group_id'])) {
            $groupnodes = AdminGroupModel::whereIn('id',$authnodes['group_id'])->select()->toArray();
            foreach ($groupnodes as $value) {
                $nodes = !empty($value[$type]) ? explode(',', $value[$type]) : [];
                $authGroup = array_unique(array_merge($authGroup, $nodes));
                $authPrivate = array_unique(array_merge($authPrivate, $nodes));
            }
        }

        // 返回数据集
        $array[$this->authGroup] = $authGroup ?? [];
        $array[$this->authPrivate] = $authPrivate ?? [];
        return $array;
    }

    /**
     * 获取权限菜单
     * @access  public
     * @return  JSON|Array
     */
    public function _get_auth_menus()
    {
        // 查找节点
        $where[] = ['status','=','normal'];
        $auth_nodes = $this->_get_auth_nodes();
        $list = $this->get_auth_list($this->admin['id'] ,$auth_nodes);

        // 循环处理数据
        foreach ($list as $key => $value) {
            $list[$key]['title'] = __($value['title']);
            $auth_nodes['everycate'] = $value['router'] == 'everycate' ? true : false;
            $auth_nodes['privateauth'] = $value['router'] == 'privateauth' ? true : false;
        }

        if ($this->superAdmin()) {
            $auth_nodes['supersadmin'] = true;
        }

        $auth_nodes['_admin_auth_menus_'] = list_to_tree($list);
        return json_encode($auth_nodes,JSON_UNESCAPED_UNICODE);
    }

    /**
     * 查询权限列表
     * @param  int      $uid        用户id
     * @param  array    $nodes      已获取节点
     * @return mixed
     */
    public function get_auth_list($uid = 0, array $nodes = []) 
    {
        // 查找节点
        $where[] = ['status','=','normal'];
        if (!$this->superAdmin()) {
            $auth_nodes = !empty($nodes) ? $nodes : $this->_get_auth_nodes($uid);
            return AdminRulesModel::where(function ($query) use ($where,$auth_nodes) {
                if (empty($auth_nodes[$this->authPrivate])) {
                    $where[] = ['auth','=','0'];
                    $query->where($where);
                }else {
                    $where[] = ['id','in',$auth_nodes[$this->authPrivate ]];
                    $query->where($where)->whereOr('auth','0');
                }
            })->order('sort asc')->select()->toArray();
        }
        
        return AdminRulesModel::where($where)->order('sort asc')->select()->toArray();
    }

    /**
     * 查询权限节点
     * @access public
     * @param mixed|null $type
     * @param mixed|null $class
     * @return \think\response\Json
     */
    public function get_rulecates_tree($type = null, $class = null, $tree = true)
    {
        
        $list  = [];
        if (is_array($type) && $type) {
            $class = $type['class'] ?? $this->authGroup;
            $type  = $type['type'] ?? 'rules';
        }

        $class = $class != $this->authGroup ? $this->authPrivate : $class;
        $auth_nodes = $this->_get_auth_nodes($this->admin['id'], $type);
        if ($type && $type == 'rules') {

            $where[] = ['status','=','normal'];
            if (!$this->superAdmin()) {
                $list = AdminRulesModel::where(function ($query) use ($where,$auth_nodes,$class) {
                    if (empty($auth_nodes[$class])) {
                        $where[] = ['auth','=','0'];
                        $query->where($where);
                    }else {
                        $where[] = ['id','in',$auth_nodes[$class]];
                        $query->where($where)->whereOr('auth','0');
                    }
                })->order('sort asc')->select()->toArray();
            }
            else {
                $list = AdminRulesModel::where($where)->order('sort asc')->select()->toArray();
            }
        } else {
            if (!$this->superAdmin()) {
                if (!empty($auth_nodes[$class])) {
                    $list = CategoryModel::whereIn('id',$auth_nodes[$class])->where('status',1)->select()->toArray();
                }
            }
            else {
                $list = CategoryModel::where('status',1)->select()->toArray();
            }
        }

        return $tree ? ($list ? json_encode(list_to_tree($list)) : json()) : $list;
    }

    /**
     * 校验节点 避免越权
     * @access public
     * @param mixed|null $rules
     * @param string|null $type
     * @param string|null $class
     * @return bool
     **/
    public function check_rulecates_node($rules = null, string $type = null, string $class = null)
    {
        if (!$this->superAdmin() && !empty($rules)) {
            $type   = !empty($type) ? $type :'rules';
            $class  = !empty($class) ? $class : $this->authGroup;
            $class  = $class != $this->authGroup ? $this->authPrivate : $class;
            $auth_nodes = $this->_get_auth_nodes($this->admin['id'], $type);
            $differ = array_unique(array_merge($rules, $auth_nodes[$class]));
            if (count($differ) > count($auth_nodes[$class])) {
                return false;
            }
        }

        return true;
    }
    
    /**
     * 超级管理员
     * @access      public
     * @return      bool
     */
    public function superAdmin() 
    {
        $group_ids = AdminModel::field('group_id')->find($this->admin['id']);
        $group_ids = explode(',',$group_ids['group_id']);
        $this->group_ids = $group_ids;
        return array_search(1,$group_ids) !== false ? true : false;
    }

    /**
     * 管理组分级鉴权
     * @param array $group_ids 
     * @return bool
     */
    public function check_group_auth(array $group_ids = [])
    {
        if ($this->superAdmin()) {
            return true;
        }

        // 查询数据
        $list = AdminGroupModel::select()->toArray();
        foreach ($list as $value) {
            // 循环处理组PID
            if (in_array($value['id'], $group_ids)) {
                foreach ($this->group_ids as $id) {
                    $self = list_search($list,['id'=>$id]);
                    if (!empty($self) && 
                        ($value['pid'] < $self['id'] || $value['pid'] == $self['pid']) ) {
                        return false;
                    }
                }
            }
        }
        
        return true;
    }

    /**
     * 获取用户信息
     * @param mixed|null $uid
     * @return bool
     */
    public function getUserInfo($uid = null) 
    {

        $uid = $uid ?? $this->admin['id'];
        static $userinfo = [];

        $user = Db::name('admin');
        // 获取用户表主键
        $_pk = is_string($user->getPk()) ? $user->getPk() : 'uid';
        if (!isset($userinfo[$uid])) {
            $userinfo[$uid] = $user->where($_pk, $uid)->find();
        }

        return $userinfo[$uid];
    }

    /**
     * 用户检测登录
     * @param string $name
     * @param string $pwd
     * @return bool
     */
    public function login(string $name, string $pwd) {

        if(filter_var($name, FILTER_VALIDATE_EMAIL)){
            $where[] = ['email','=',htmlspecialchars(trim($name))];
        }else{
            $where[] = ['name','=',htmlspecialchars(trim($name))];
        }

        $where[] = ['pwd','=',hash_pwd($pwd)];
        $this->userInfo = UserModel::where($where)->find();
        if (!empty($this->userInfo)) {
            if($this->userInfo['status'] != 1) { 
                $this->setError('用户异常或未审核，请联系管理员');
                return false;
            }

            // 更新登录数据
            $this->userInfo['logintime'] = time(); 
            $this->userInfo['loginip'] = request()->ip();
            $this->userInfo['logincount'] = $this->userInfo['logincount'] + 1;
            if ($this->userInfo->save()) {
                return true;
            }
        }
        else {
            $this->setError('用户名或密码错误');
            return false;
        }
    }

    /**
     * API权限验证
     * @param string|null $class
     * @return bool
     */
    public function checkapi(string $class = null) {
        
        // 请求参数
        $this->params = input();
        if ((!isset($this->params['app_id']) 
            || !isset($this->params['app_secret'])) 
            && !isset($this->params['token'])) {
            $this->setError(ResultCode::PARAMERROR);
            return false;
        }

        // 优先缓存读取
        $this->classHash = sha1($class);
        $restful = system_cache($this->classHash);
        if (empty($restful)) {
            $restful = Db::name('api')->where('class',$class)->find();
            system_cache($this->classHash, $restful,saenv('cache_time'));
        }

        // 校验请求方式
        if (!$this->checkMethod($restful)) {
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
            
            if (!$this->params['app_id'] 
                || !$this->params['app_secret']) {
                $this->setError(ResultCode::LACKPARAME);
                return false;
            }

            // 默认走普通流程
            $list = $this->getAPIAuthList();
            if (!$nodes = list_search($list,['class'=>$class])) {
                $this->setError(ResultCode::AUTH_ERROR);
                return false;
            }
           
            // 判断余量
            if (!$this->dayCeilingSeconds($nodes)) {
                return false;
            }
        }
        else if ($restful['status'] == DISABLE) {
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
    protected function checkMethod(array $restful = []) 
    {
        if ($restful['method'] !== ALLM 
            && $this->method[$restful['method']] !== request()->method()) {
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
    protected function getAPIAuthList() 
    {
        // 读取节点缓存
        $where['app_id'] = $this->params['app_id'];
        $where['app_secret'] = $this->params['app_secret'];
        $this->nodeHash = sha1(implode('.',$where));
        $list = system_cache($this->nodeHash);

        if (empty($list)) { 
            $list = Db::view('user','id')
                      ->view('api_access','*','api_access.uid=user.id')
                      ->view('api','class','api.id=api_access.api_id')
                      ->where([
                          'user.app_id'=>$this->params['app_id'],
                          'user.app_secret'=>$this->params['app_secret'],
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
    protected function dayCeilingSeconds(array $result = []) 
    {
        // 查询规则
        $access = md5hash($this->params['app_id'].$result['class']);
        if ($result['day'] || $result['ceiling'] || $result['seconds'] ) {
            $condition = ApiCondition::where('hash',$access)->find();
            if (empty($condition)) {
                $condition = [
                    'day'=> 0,
                    'seconds'=> time(),
                    'ceiling'=> 0,
                ];
            }
        }

        // API每日上限
        if ($result['day'] && $condition['day'] >= $result['day']) {
            $this->setError(ResultCode::DAY_INVALID);
            return false;
        }

        // 调用间隔/秒
        if ($result['seconds'] && (time()-$condition['seconds']) <= $result['seconds']) {
            $this->setError(ResultCode::API_SPEED_INVALID);
            return false;
        }

        // 接口调用总数
        if ($result['ceiling'] && $condition['ceiling'] >= $result['ceiling']) {
            $this->setError(ResultCode::CEILING_INVALID);
            return false;
        }

        try {

            if ($result['day'] || $result['ceiling'] || $result['seconds'] ) {

                $condition['day'] += 1;
                $condition['ceiling'] += 1;
                $condition['seconds'] = time();
                if (is_object($condition)) {
                    
                    // 次日初始化
                    $daytime = strtotime($condition['createtime']);
                    if(date('Ymd', $daytime) != date('Ymd')) { 
                        $condition['day'] = 1; 
                    }
                    
                    // 更新数据
                    $condition->save();
                }
                else {

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
     * 验证是否登录
     * @param string 
     * @return bool
     */
    public function isLogin() 
    {
        $token = cookie('token') ?? input('token/s');
        
        if (!$token) {
            return false;
        }

        $array = $this->checkToken($token);
        if (!empty($array)) {
            $this->token = $token; 

            // 只缓存用户uid
            $this->userInfo = $array;
            return true;
        }

        return false;
    }

    /**
     * 设置用户登录状态
     * @param object|array  $array
     * @return bool
     */
    public function setloginState(object|array $array = null, $token = false)
    {
        $this->token = $token ? cookie('token') : $this->buildToken($array);
        cookie('uid',$array['id'],$this->keeptime);
        cookie('token',$this->token,$this->keeptime);
        cookie('nickname',$array['nickname'] ?? $array['name'],$this->keeptime);
        $this->setactiveState(is_object($array) ? $array : $array);
    }

    /**
     * 设置状态
     * @param   array $array
     * @return  bool
     */
    public function setactiveState(object|array $array = []) {
        $tag = md5hash((string)$array['id']);
        \think\facade\Cache::tag($tag)->clear();
        \think\facade\Cache::tag($tag)->set($this->token,$array,$this->keeptime);
    }

    /**
     * 返回一个token
     * @access protected
     * @param  array    $array     用户参数
     * @return string   
     */
    protected function buildToken($array = []) 
    {
        $this->token = md5(create_rand(16));
        return $this->token;
    }

    /**
     * 校验token
     * @access protected
     * @param  string       $token       用户token
     * @return array|string   
     */
    public function checkToken(string $token = null) 
    {
        $token = ($token ?? input('token/s')) ?? '';
        return \think\facade\Cache::get($token) ?? false;
    }

    /**
     * 生成签名
     * @access protected
     * @param  array    $array     用户参数
     * @return string   
     */
    public function buildSign($uid = 0, $time = 0) {

        $sign = [
            'ip' => request()->ip(),
            'auth_key'=> saenv('auth_key'),
            'time'=> $time,
            'uid'=> $uid,
        ];

        return sha1(implode('#',$sign));
    }

    /**
     * 校验签名
     * @access protected
     * @param  string       $token       用户token
     * @return array|string   
     */
    public function checkSign(string $sign = null, $uid = 0, int $time = 0) 
    {
        $check = [
            'ip' => request()->ip(),
            'auth_key'=> saenv('auth_key'),
            'time'=> $time,
        ];

        return sha1(implode('#',$check)) == $sign ? true : false;
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
