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

use app\common\library\ResultCode;
use think\App;
use think\Validate;
use think\Response;
use think\exception\ValidateException;
use think\exception\HttpResponseException;

/**
 * 控制器基础类
 */
abstract class BaseController
{
    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 验证错误消息
     * @var bool
     */
    protected $errorMsg = null;

    /**
     * 控制器中间件
     * @var array
     */
    protected $middleware = [];

    /**
     * 构造方法
     * @access public
     * @param  App  $app  应用对象
     */
    public function __construct(App $app)
    {
        $this->app     = $app;
        $this->request = $this->app->request;

        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    protected function initialize()
    {
        // 获取全局站点
        foreach (saenv('site') as $key => $value) {
            $this->app->view->assign($key,$value);
        }
    }

    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate(array $data, $validate, array $message = [], bool $batch = false)
    {
        if (is_array($validate)) {
            $v = new Validate();
            $v->rule($validate);
        } else {
            if (strpos($validate, '.')) {
                // 支持场景
                [$validate, $scene] = explode('.', $validate);
            }
            $class = false !== strpos($validate, '\\') ? $validate : $this->app->parseClass('validate', $validate);
            $v     = new $class();
            if (!empty($scene)) {
                $v->scene($scene);
            }
        }

        $v->message($message);

        // 是否批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        return $v->failException(true)->check($data);
    }

    /**
     * 自动POST校验
     *
     * @param array $post
     * @param string $valiclass
     * @param string $valiscene
     * @return void
     */
    protected function autoPostValidate(array $post, $valiclass = '', $valiscene = '')
    {
        if (empty($post) || !is_array($post)) {
            $this->errorMsg = __('参数不符合预期');
            return true;
        }
        
        // 普通模式
        $post = safe_validate_model($post,$valiclass,$valiscene);
        if (empty($post) || !is_array($post)) {
            $this->errorMsg = $post;
            return true;
        }

        return false;
    }

    /**
     * 操作成功跳转的快捷方法
     * @access protected
     * @param  mixed     $msg 提示信息
     * @param  string    $url 跳转的URL地址
     * @param  mixed     $data 返回的数据
     * @param  integer   $wait 跳转等待时间
     * @param  array     $header 发送的Header信息
     * @return void
     */
    protected function success($msg = '', string $url = null, $data = '', int $count = 0,  int $code = 200, int $wait = 3, array $header = [])
    {
        if (is_null($url) && isset($_SERVER["HTTP_REFERER"])) {
            $url = $_SERVER["HTTP_REFERER"];
        } elseif ($url) {
            $url = (strpos($url, '://') || 0 === strpos($url, '/')) ? $url : app('route')->buildUrl($url);
        }

        // 默认消息
        $msg = !empty($msg) ? __($msg) :  __('操作成功！');

        $result = [
            'code'  => $code,
            'msg'   => $msg,
            'data'  => $data,
            'count' => $count,
            'url'   =>(string)$url,
            'wait'  => $wait,
        ];

        $type = $this->getResponseType();
        if (strtolower($type) == 'html'){
            $response = view(config('app.dispatch_success'), $result);
        } else if ($type == 'json') {
            $response = json($result);
        }
        
        throw new HttpResponseException($response);
    }

    /**
     * 操作错误跳转的快捷方法
     * @access protected
     * @param  mixed     $msg 提示信息
     * @param  string    $url 跳转的URL地址
     * @param  mixed     $data 返回的数据
     * @param  integer   $wait 跳转等待时间
     * @param  array     $header 发送的Header信息
     * @return void
     */
    protected function error($msg = '',  $url = null, $data = '', int $code = 101, int $wait = 3, array $header = [])
    {
        if (is_null($url)) {
            $url = request()->isAjax() ? '' : 'javascript:history.back(-1);';
        } elseif ($url) {
            $url = (strpos($url, '://') || 0 === strpos($url, '/')) ? $url : $this->app->route->buildUrl($url);
        }
        $msg = !empty($msg) ? __($msg) :  __('操作失败！');
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'data' => $data,
            'url'  =>(string)$url,
            'wait' => $wait,
        ];

        $type = $this->getResponseType();
        if ($type == 'html'){
            $response = view(config('app.dispatch_error'), $result);
        } else if ($type == 'json') {
            $response = json($result);
        }
        throw new HttpResponseException($response);
    }


    /**
     * URL重定向
     * @access protected
     * @param  string         $url 跳转的URL表达式
     * @param  array|integer  $params 其它URL参数
     * @param  integer        $code http code
     * @param  array          $with 隐式传参
     * @return void
     */
    protected function redirect($url, $params = [], $code = 302, $with = [])
    {
        $response = Response::create($url, 'redirect');

        if (is_integer($params)) {
            $code   = $params;
            $params = [];
        }
     
        $response->code($code);
        throw new HttpResponseException($response);
    }

    /**
     * 获取当前的response 输出类型
     * @access protected
     * @return string
     */
    protected function getResponseType()
    {
        return request()->isJson() || request()->isAjax() ? 'json' : 'html';
    }

    /**
     * 生成静态HTML
     * @access protected
     * @param  htmlfile         文件名
     * @param  htmlpath         生成路径
     * @param  templateFile     模板地址
     * @param  suffix           文件后缀
     * @return void
     */
    protected function buildHtml(string $htmlfile = null,string $htmlpath = null, string $templateFile = null,$suffix = 'html') 
    {
        $content = $this->app->view->fetch($templateFile);
        if (saenv('compression')) {
            $content = preg_replace('/\s+/i',' ',$content);
        }
        $htmlpath = !empty($htmlpath) ? $htmlpath : './';
        $htmlfile = $htmlpath . $htmlfile . '.' . $suffix; 

        // 写入静态文件
        if(write_file($htmlfile, $content) === false) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 获取模型字段集
     * @access protected
     * @param object|null $model
     * @return void
     */
	protected function getTableFields(object $model = null) 
	{
        $this->model = $model ? $model : $this->model;

        $tableFields = $this->model->getTableFields();

        if (!empty($tableFields) && is_array($tableFields)) {
            foreach ($tableFields as $key => $value) {

                $filter = ['updatetime','createtime','delete_time'];
                if (!in_array($value,$filter)) {
                    $tableFields[$value] = '';
                }
               
                unset($tableFields[$key]);
            }
        }

        return $tableFields;
	}

    /**
     * 抛出404异常
     * @access public
     * @param  msg         消息参数
     * @param  code        错误代码
     * @return void
     */
	public function throwError(string $msg = 'not found!', int $code = 404) 
    {
        if(request()->isAjax()) {
            return json(ResultCode::AUTH_ERROR);
        }
        else {
            abort($code,$msg);
        }
	}

    /**
     * 空方法
     */
    public function __call($method, $args)
    {
        $this->throwError();
    }
}
