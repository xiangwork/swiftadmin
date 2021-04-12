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
namespace app\common\library;
use think\facade\Db;
use think\facade\Cache;
use think\facade\request;



use app\common\library\ResultCode;
use app\common\model\system\ApiCondition;
use app\common\model\system\User as UserModel;
use app\common\model\system\UserThird as UserThirdModel;
use app\common\model\system\Category as CategoryModel;
use app\common\model\system\AdminRules as AdminRulesModel;

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
    private  $Admin = null;

    /**
     * token令牌
     * @var string
     */
    public $token = null;

    /**
     * 用户数据
     * @var array
     */
    public $userData = null;

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
     * 分组权限
     * @var array
     */
    protected $authGroup = [];   

    /**
     * 用户私有权限
     * @var array
     */
    protected $authPrivate = [];  

    /**
     * 返回权限数据
     * @var array
     */
    protected $authListArray = [];

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
        $this->Admin = session('AdminLogin');
        $this->request = \think\facade\Request::instance();
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return auth
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
     * @param $name string|array  	需要验证的规则列表,支持逗号分隔的权限规则或索引数组
     * @param $uid   int           	认证用户的id
     * @param int    $type 			认证类型
     * @param string $mode 			执行check的模式
     * @param string $relation 		如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
     * @return bool               	通过验证返回true;失败返回false
     */
    public function checkauth($name, $uid, $type = 1, $mode = 'url', $relation = 'or') 
    {
        $this->authListArray = $this->getAuthList();
        
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

        foreach ($this->authListArray as $key => $auth) {

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
     */
    public function getauthNode($pk, $type = 'rules') 
    {

        // 获取角色数据
        $id = (int)$pk ?? session('AdminLogin.id');
        $authRules = Db::name('admin_access')->where('uid',$id)->find();
        
        // 用户私有权限
        if (!empty($authRules[$type])) {
            $this->authPrivate = explode(',', $authRules[$type]);
        }

        // 用户分组权限
        if (!empty($authRules['group_id'])) {
            $authGroup = Db::name('admin_group')->whereIn('id',$authRules['group_id'])->select()->toArray();
            foreach ($authGroup as $key => $value) {
                $groupRules = !empty($value[$type]) ? explode(',', $value[$type]) : [];
                if ($type == 'rules') {
                    $this->authListArray['GroupAuthList'][$value['alias']] = $groupRules;
                }
                $this->authGroup = array_unique(array_merge($this->authGroup, $groupRules));
                $this->authPrivate = array_unique(array_merge($this->authPrivate, $groupRules));
            }
        }

        // 拼装数据
        $this->authListArray['GroupRules'] = $this->authGroup ?? [];
        $this->authListArray['UserRules'] = $this->authPrivate ?? [];
        return $this->authListArray;
    }

    /**
     * 管理组权限节点
     */
    public function getGroupRules($id = null) 
    {
        return $this->getGroupOrPrivateAuth('GroupRules',$id);
    }
    /**
     * 私有权限节点
     */
    public function getPrivateRules($id = null) 
    {   
        return $this->getGroupOrPrivateAuth('UserRules',$id);   
    }

    /**
     * 获取权限节点
     */
    public function getGroupOrPrivateAuth($GorPrivate,$id = null) 
    {

        if (!$this->SuperAdmin()) {
            $id = $id ?? $this->Admin['id'];
            $authNode = $this->getauthNode($id);
            // 默认获取
            if (!empty($authNode[$GorPrivate])) { 
                $where[] = ['id','in',$authNode[$GorPrivate]];
            }else {
                $where[] = ['auth','=','0']; 
            }

            // 返回节点
            $list = AdminRulesModel::where($where)->select()->toArray();
            foreach ($list as $key => $value) {
                $list[$key]['title'] = __($value['title']);
            }

            return $list ? json(list_to_tree($list)) : json();
        }

        return json(AdminRulesModel::getListTree());
    }

    /**
     * 管理组栏目节点
     */
    public function getGroupCateIds($id = null) 
    {
        return $this->getGroupOrPrivateCateIds('GroupRules',$id);
    }

    /**
     * 私有栏目节点
     */
    public function getPrivateCateIds($id = null) 
    {
        return $this->getGroupOrPrivateCateIds('UserRules',$id);       
    }

    /**
     * 获取栏目节点
     */
    public function getGroupOrPrivateCateIds($GorPrivate,$id = null) 
    {
        if (!$this->SuperAdmin()) {
            $id = $id ?? $this->Admin['id'];
            $authNode = $this->getauthNode($id,'cateids');
            if (!empty($authNode[$GorPrivate])) { 
                $where[] = ['id','in',$authNode[$GorPrivate]];
            }else {
                $where[] = ['id','=','error']; 
            }

            // 返回节点
            $list = CategoryModel::where($where)->select()->toArray();
            foreach ($list as $key => $value) {
                $list[$key]['title'] = __($value['title']);
            }

            return $list ? json(list_to_tree($list)) : json();
        }
        
        return json(CategoryModel::getListTree());
    }


    /**
     * 管理组规则鉴权
     */
    public function checkGroupRules($rules) 
    {
        return $this->checkRulesORCateIds($rules,'GroupRules');
    }

    /**
     * 管理组栏目鉴权
     */
    public function checkGroupCateIds($cateIds) 
    {
        return $this->checkRulesORCateIds($cateIds,'GroupRules','cateids');
    }

    /**
     * 个人节点鉴权
     */
    public function checkPrivateRules($rules) 
    {
        return $this->checkRulesORCateIds($rules,'UserRules');
    }

    /**
     * 个人栏目鉴权
     */
    public function checkPrivateCateIds($cateIds) 
    { 
        return $this->checkRulesORCateIds($cateIds,'UserRules','cateids');     
    }

    /**
     * 节点元素鉴权
     */
    public function checkRulesORCateIds($rules, $GorPrivate ,$type = 'rules') 
    {
        if (!$this->SuperAdmin() && !empty($rules)) {
            $id = $id ?? $this->Admin['id'];
            $nodes = $this->getauthNode($id,$type); // 获取节点权限
            $differ = array_unique(array_merge($rules,$nodes[$GorPrivate]));
            if (count($differ) > count($nodes[$GorPrivate])) {
                return false;
            }
        }

        return true;
    }

    /**
     * 查询权限列表
     */
    public function getAuthList() 
    {

        $where = [];
        $id = $this->Admin['id'];
        $authNode = $this->getauthNode($id);
        if (!$this->SuperAdmin()) {

            if (!empty($authNode['UserRules'])) {
                $where[] = ['id','in',$authNode['UserRules']];
            }

            // 过滤不需要鉴权节点
            return AdminRulesModel::where($where)->whereOr('auth','0')->order('sort asc')->select()->toArray();
        }

        return AdminRulesModel::where($where)->order('sort asc')->select()->toArray();
    }
    
    /**
     * 检测管理员 改为数据库查询
     */
    public function SuperAdmin() 
    {
        $groupIds = Db::name('admin')->field('group_id')->find($this->Admin['id']);
        $groupIds = explode(',',$groupIds['group_id']);
        return array_search(1,$groupIds) !== false ? true : false;
    }

    /**
     * 管理组分级鉴权
     */
    public function checkGroupDiffer($groupId = []) 
    {

        if ($this->SuperAdmin()) {
            return true;
        }

        // 操作的用户组
        if (!is_array($groupId)) {
            $groupId = array($groupId);
        }

        $ids = Db::name('admin')->field('group_id')->find($this->Admin['id']);
        $LoginGroup = Db::name('admin_group')->whereIn('id',$ids['group_id'])->select()->toArray();

        foreach ($groupId as $value) {

            // 查询用户组信息
            $data = Db::name('admin_group')->where('id',$value)->find();
            if (empty($data)) {
                return false;
            }

            foreach ($LoginGroup as $values) {
                if ($data['pid'] < $values['id']|| $data['pid'] == $values['pid']) {
                    return false;
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

        $uid = $uid ?? $this->Admin['id'];
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

        $where[] = ['pwd','=',hasha($pwd)];
        $this->userData = UserModel::where($where)->find();
        if (!empty($this->userData)) {
            if($this->userData['status'] != 1) { 
                $this->setError('用户异常或未审核，请联系管理员');
                return false;
            }

            // 更新登录数据
            $this->userData['logintime'] = time(); 
            $this->userData['loginip'] = ip2long(request()->ip());
            $this->userData['logincount'] = $this->userData['logincount'] + 1;

            if ($this->userData->save()) {
                $this->userData = $this->userData->toArray();
                $this->loginState($this->userData);
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
        $restful = Cache::get($this->classHash);
        if (empty($restful)) {
            $restful = Db::name('api')->where('class',$class)->find();
            Cache::set($this->classHash, $restful,config(CACHETIME));
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

                $this->params = unserialize((string)$data);
            }
            
            // 默认走普通流程
            $list = $this->getAPIAuthList();
            // halt($list);
            if (!$nodes = list_search($list,['class'=>$class])) {
                $this->setError(ResultCode::AUTH_ERROR);
                return false;
            }
           
            // 判断余量
            if (!$this->dayCeilingSeconds($nodes)) {
                return false;
            }
        }
        else if ($restful['status'] = DISABLE) {
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
        $list = Cache::get($this->nodeHash);

        if (empty($list)) { 
            $list = Db::view('user','id')
                      ->view('api_access','*','api_access.uid=user.id')
                      ->view('api','class','api.id=api_access.api_id')
                      ->where([
                          'user.app_id'=>$this->params['app_id'],
                          'user.app_secret'=>$this->params['app_secret'],
                        ])->select()->toArray();

            Cache::set($this->nodeHash, $list, config(CACHETIME));
        }

        return $list ?? [];
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
        $access = md5short($this->params['app_id'].$result['class']);
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
            $this->userData = unserialize($array);
            return true;
        }

        return false;
    }

    /**
     * 设置用户登录状态
     * @param array $array
     * @return bool
     */
    public function loginState(array $array = [], $token = false)
    {
        $this->token = $token ? cookie('token') : $this->buildToken($array);
        cookie('uid',$array['id'],$this->keeptime);
        cookie('token',$this->token,$this->keeptime);
        cookie('nickname',$array['nickname'] ?? $array['name'],$this->keeptime);
        $this->cache($array);
    }

    /**
     * 缓存数据
     * @param array $array
     * @return bool
     */
    public function cache(array $array = []) {
        $tag = md5short((string)$array['id']);
        Cache::tag($tag)->clear();
        Cache::tag($tag)->set($this->token,serialize($array),$this->keeptime);
    }

    /**
     * 返回一个token
     * @access protected
     * @param  array    $array     用户参数
     * @return string   
     */
    protected function buildToken(array $array = []) 
    {
        $this->token = md5(create_rand(16));
        return $this->token;
    }

    /**
     * 获取token
     * @access protected
     * @param  int          $id          用户app_id
     * @return string   
     */
    protected function getToken(int $id = null) 
    {
        $this->token = Cache::getTagItems(md5short($id))[0];
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
        return Cache::get($token) ?? false;
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
            'auth_key'=> config('system.auth.auth_key'),
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
            'auth_key'=> config('system.auth.auth_key'),
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