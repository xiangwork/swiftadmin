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
namespace app\admin\controller;
use app\AdminController;
use think\facade\Db;
use think\cache\driver\Redis;
use think\cache\driver\memcached;

class Index extends AdminController
{
    public function index()
    {   
        return view();
    }

    // 控制台首页
    public function console()
    {
        // 组合系统信息
        $system['app'] = config('app.app_name');
        $system['version'] = config('app.app_version');
        $system['copyright'] = config('app.app_copyright');
        $system['php_version'] = PHP_VERSION;		
        $system['php_sapi'] = PHP_SAPI;
        $system['php_uname'] = php_uname();
        $system['php_server'] = $_SERVER['SERVER_SOFTWARE'];
        $system['ip'] = $_SERVER['SERVER_ADDR'];
        $system['host'] = $_SERVER['HTTP_HOST'];
        $system['gd_info'] = @gd_info();
        $system['post_size'] = get_cfg_var('file_uploads') ? get_cfg_var("post_max_size") : '<font color="red">post_size error</font>';		
        $system['upload_max_filesize'] = get_cfg_var('file_uploads') ? get_cfg_var("upload_max_filesize") : '<font color="red">file upload error</font>';
        $system['memory_limit'] = ini_get('memory_limit');		
        $system['openssl'] = extension_loaded('openssl')? '<font color=green><strong>√</strong></font>':'<font color="red">未开启</font>';
        $system['zip'] = extension_loaded('zip')? '<font color=green><strong>√</strong></font>':'<font color="red">NO（请开启 php.ini 中的php-zip扩展）</font>';
        $system['gzclose'] = function_exists('gzclose')? '<font color=green><strong>√</strong></font>':'<font color="red">NO（请开启 php.ini 中的php-zlib扩展）</font>';
        
        $database = config('database.default');
        if ($database == 'mysql' || $database == 'mysqli') {
            $mysqlver = db::query('select version()');
            if (is_array($mysqlver)) {
                $system['mysql_version'] = $database.' '.$mysqlver[0]['version()'];
            }
        }else {
            $system['mysql_version'] = $database.' 未知版本';
        }

        return view('',['system'=>$system]);
    }

    /**
     * 分析页
     */
    public function analysis() 
    {
        return view();
    }
    
    /**
     * 监控页
     */
    public function monitor() 
    {
        return view();
    }

    /**
     * 获取系统配置
     */
    public function basecfg() 
    {
        $config = config('system');
        $config['fsockopen'] = function_exists('fsockopen');
        $config['stream_socket_client'] = function_exists('stream_socket_client');
		return view('',['config'=>$config]);
    }

    /**
     * 编辑系统配置
     */
    public function baseSet() 
    {
        if (request()->isPost()) {

            $post = input();
            $config = config('system');
            unset($config['variable']);
            $config = array_merge($config, $post);
            if (arr2file('../config/system.php', $config) === false) {
                return $this->error('保存失败，请重试!');
            }

            // 修改入口文件
            $index = public_path().'index.php';
            $files = '../extend/conf/index.tpl';
            if ($config['site']['site_status']) {
                $close = '../extend/conf/close.tpl';
                $content = file_get_contents($close);
                write_file($index,$content);
            }
            else {
                $content = file_get_contents($index);
                if (!strpos($content,'run()')) {
                    $content = file_get_contents($files);
                    write_file($index,$content);
                }
            }

            // 配置文件路径
            $env = root_path().'.env';
            $parse = parse_ini_file($env,true);
            
            // 缓存类型
            $parse['CACHE']['DRIVER'] = $config['cache']['cache_type'];
            $parse['CACHE']['HOSTNAME'] = $config['cache']['cache_host'];
            $parse['CACHE']['HOSTPORT'] = $config['cache']['cache_port'];
            $parse['CACHE']['SELECT']   = $config['cache']['cache_select'] >= 1 ? $config['cache']['cache_select']  : 1;
            $parse['CACHE']['USERNAME'] = $config['cache']['cache_user'];
            $parse['CACHE']['PASSWORD'] = $config['cache']['cache_pass'];
    
            $content = parse_array_ini($parse);
            if (write_file($env,$content)) {
                \think\facade\Cache::set('redis-system',$config);
                return $this->success('保存成功!');
            }
        }
    }

    /**
     * FTP测试上传
     */
    public function testFtp() 
    {
        if (request()->isPost()) {
            if (\app\common\library\Ftp::instance()->ftpTest(input())) {
                return $this->success('上传测试成功！');
            }
        }

        return $this->error('上传测试失败！');
    }

    /**
     * 邮件测试
     */
    public function testEmail() 
    {
        if (request()->isPost()) {
            $info = \app\common\library\Email::instance()->testEMail(input());
            $info === true ? $this->success('测试邮件发送成功！') : $this->error($info);
        }
    }

    /**
     * 缓存测试
     */
	public function testCache() 
    {
        if (request()->isPost()) {

            $param = input();
            if (!isset($param['type']) || empty($param['host']) || empty($param['port'])) {
               return $this->error('参数错误!');
            }
    
            $options = [
               'host' => $param['host'],
               'port' => (int)$param['port'],			
               'username' => $param['user'],
               'password' => $param['pass']
            ];
            
            try {
               if (strtolower($param['type']) == 'redis') {
                   $drive = new Redis($options);
               } else {
                   $drive = new Memcached($options);
               }
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
               
            if ($drive->set('test','cacheOK',1000)) {
                return $this->success('缓存测试成功！');
            }else {
                return $this->error('缓存测试失败！');
            }

        }
    }
}
