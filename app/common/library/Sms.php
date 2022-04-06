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
namespace app\common\library;

use think\facade\Event;

use system\sms\Alisms;
use system\sms\Tensms;
use app\common\model\system\UserValidate;
use system\Random;

/**
 * 短信息类
 *
 */
class Sms 
{

    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    // 默认配置
    protected $config = [];

    // 错误信息
    protected $_error = '';

    // 事件名称
    protected $event = "default";

    // 短信参数
    protected $params = null;

    // 手机号码
    protected $phone = [];

    // 自动设置参数
    protected $autoPrarms = false;

    /**
     * @objectValidate
     */
    public $objectValidate = null;

    // 运行商号段
    protected $numberHeader = [
        'cmcc'=> '134,135,136,137,138,139,147,150,151,152,157,158,159,172,178,182,183,184,187,188,198',
        'cdma'=> '130,131,132,155,156,166,175,176,185,186,166',
        'ccom'=> '133,153,173,177,180,181,189,191,193,199',
    ];

    /**
     * 类构造函数
     * class constructor.
     */
    public function __construct()
    {
        // 此配置项为数组。
        if ($snsface = saenv('smsface')) {
            $this->config = array_merge($this->config, $snsface);
        }

        // 验证类回调操作 1、单手机号 2、自动获取验证码
        Event::listen("sendsms_success",function($params) {
            $array['event'] = $this->event;
            $array['code'] = $params['code'];
            $array['mobile'] = $params['mobile'];
            UserValidate::create($array);
        });
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return self
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
     * 获取变量类型
     */
    public function __call($method, $arg_array) 
    {
        
        try {
            
            if (!empty($arg_array[0])) {        // 手机号码
                $this->phone = $arg_array[0];
            }
           
            if (!empty($arg_array[1])) {        // 事件类型
                $this->event = $arg_array[1];
            }

            if (!empty($arg_array[2])) {        // 短信参数
                $this->params = $arg_array[2];
            }

            // 读取短信模板
            $type = $this->config['type'];
            $config = include(root_path()."extend/conf/sms/sms.php");
            if ($config[$type][$method]['template']) {
                $template = $config[$type][$method]['template'];
            }

            // 是否自动设置参数
            if ($config[$type][$method]['auto']) {
                $this->autoPrarms = true;
                $this->params = array(Random::number(4));
            }

            // 判断类型并设置时间限制
            if ($this->autoPrarms) {
                if (is_array($this->phone)) {
                    $phone = implode(',',$this->phone);
                }
                else {
                    $phone = $this->phone;
                }

                $phone = str_replace("+86","",$phone);
                $result = UserValidate::where("mobile",$phone)->order('id desc')->find();
                if (!empty($result)) {
                    $difftime = time() - strtotime($result['createtime']);
                    if (($difftime / 60) <= saenv('user_valitime')) {
                        $this->setError("请求的频率过快，请稍后再试！");
                        return false;
                    }
                }
            }

            if (!$this->valiParam($this->phone, $this->params)) {
                $this->setError("暂时只支持大陆手机号！");
                return false;
            }

        } catch (\Throwable $th) {
            $this->setError($th->getMessage());
            return false;
        }

        // 消息类型和事件应该区分开来
        return call_user_func(array(__NAMESPACE__.'\Sms',$type),$template, $method);
    }

    /**
     * 腾讯云SMS短信
     */
    public function tensms($template,$event = null) 
    {

        try {
    
            // 读取配置信息
            $config = $this->config['tensms'];
            $result = Tensms::instance()
                ->action('SendSms')
                ->method('POST')
                ->options([
                    "PhoneNumberSet" => $this->phone,            # 手机号
                    "TemplateParamSet" =>  $this->params,        # 变量
                    "TemplateID" => $template,                   # 模板ID
                    "SmsSdkAppid" => $config['app_id'],          # APPID    
                    "Sign" =>  $config['app_sign']               # 公司签名   
            ])->request();
            
            $result = $result['Response'];
            if (isset($result['SendStatusSet']) &&  strtolower($result['SendStatusSet'][0]['Code']) == "ok") {
                if ($this->autoPrarms && (count($this->phone) == 1)) {
                    $this->phone = str_replace("+86","",implode(",",$this->phone));
                    $this->params = implode(",",$this->params);
                    Event::trigger("sendsms_success",['code'=>$this->params,'mobile'=>$this->phone]);
                }

                return true;
            }

            // 设置错误信息
            if (isset($result['Error'])) {
                $this->setError($result['Error']['Message']);
            }
            else {
                $this->setError($result['SendStatusSet'][0]['Message']);
            }

        } catch(\Throwable $th) {
            $this->setError($th->getMessage());
            return false;
        }

        return false;
    }

    /**
     * 阿里云短信
     */
    public function alisms($template,$event = null) 
    {
        $config = $this->config['alisms'];
        try {
            $result = Alisms::instance()
                ->action('SendSms')
                ->method('GET')
                ->options([
                    'RegionId' => $config['app_id'],        # 地区ID
                    'PhoneNumbers' => $this->phone,         # 手机号码 阿里云短信不支持数组格式
                    'SignName' => $config['app_sign'],      # 公司签名
                    'TemplateCode' => $template,            # 短信模板
                    'TemplateParam' => $this->params,       # 短信参数 JSON格式
                ])->request();
                    
            if (strtolower($result['Code']) === "ok") {
                if ($this->autoPrarms) { 
                    $this->phone = str_replace("+86","",$this->phone);
                    $this->params = json_decode($this->params,true)['code'];
                    Event::trigger("sendsms_success",['code'=>$this->params,'mobile'=>$this->phone]);
                }
                return true;
            }

            // 设置错误信息
            $this->setError($result['Message']);              
        } catch (\Throwable $th) {
            $this->setError($th->getMessage());
            return false;
        }

        return false;
    }

    /**
     * 验证手机号参数
     */
    public function valiParam($phone, $params) 
    {

        if (empty($phone)) {
            return false;
        }

        // 转换数组
        if (!is_array($phone)) {
            $this->phone = explode(",",$phone);
        }

        // 校验手机号码
        foreach ($this->phone as $key => $value) {
    
            $first = substr($value,0,3);

            foreach ($this->numberHeader as $index => $elem) {
                if (stripos($elem,$first)) {
                    $find = $elem;
                }
            }
            
            // 正则匹配
            $match = preg_match('/^[0-9]{11}$/',$value);
            if (!empty($find) && !empty($match)) {
               $this->phone[$key] = "+86".$value;
            }
            else {  // TODO..
                return false;
            }
        }

        /**
         * 参数类型
         * 阿里云JSON - 腾讯云Array
         */
        if ($this->config['type'] === "alisms") {
 
            $this->phone = implode(",",$this->phone);
            
            // 是否自动获取
            if (!$this->autoPrarms && $params ) {
                $params = json_encode($params);
            }
            else if ($params){
                $params = json_encode(['code'=>$params[0]]);
            }
        }

        $this->params = $params;

        return true;
    }

    /**
     * 检查验证码
     *
     * @param string $mobile
     * @param string $event
     * @return void
     */
    public function check(string $mobile, string $event = "default") 
    {
        $where['event'] = $event;
        $where['mobile'] = $mobile;
        $this->objectValidate = UserValidate::where($where)->order("id","desc")->find();

        if (!empty($this->objectValidate)) {
            $difftime = time() - strtotime($this->objectValidate['createtime']);
            if (($difftime / 60) <= saenv('user_valitime')) {
                return true;
            }

            // 删除验证码
            $this->objectValidate->delete();
            $this->setError("当前验证码已过期！");
        } else {
            $this->setError("当前手机号不存在");
        }

        return false;
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