<?php
declare (strict_types = 1);
namespace app\common\library;

/**
 * 全局工具类
 * @TODO..
 */
class UtilsExec
{

    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    /**
     * @var string  百度推送token
     */
    protected $_BaiduToken = null;

    /**
     * 错误信息
     */
    protected $_error = '';


    /**
     * 类构造函数
     * class constructor.
     */
    public function __construct()
    {
        $this->_BaiduToken = saenv('map_baidu_token');
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return EMAIL
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
     * 百度地图推送函数
     * @param  mixed    $urls       内容网址
     * @return array
     */
    public function pushUrls(array|string $urls = [])
    {
        $api = 'http://data.zz.baidu.com/urls?site='.saenv('site_http').'&token='.saenv('map_baidu_token');
        $ch = curl_init();

        // 是否为数组
        if (!is_array($urls)) {
            $urls = array($urls);
        }

        // 封装参数
        $options =  array(
            CURLOPT_URL => $api,
            CURLOPT_POST => true,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POSTFIELDS => implode("\n", $urls),
            CURLOPT_HTTPHEADER => array('Content-Type: text/plain'),
        );
        
        // 发送请求
        curl_setopt_array($ch, $options);
        $result = json_decode(curl_exec($ch),true);
        $result['remain'] = isset($result['remain']) ? $result['remain'] : 0;
        $result['time'] = time();     
        return $result;   
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