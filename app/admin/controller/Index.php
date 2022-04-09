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
namespace app\admin\controller;

use app\AdminController;
use app\common\library\Email;
use app\common\library\Ftp;
use app\common\model\system\Config;
use think\facade\Cache;
use think\cache\driver\Redis;
use think\cache\driver\memcached;
use Throwable;

class Index extends AdminController
{
    public function index()
    {
        return view();
    }

    // 控制台首页
    public function console()
    {

        return view();
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
        $config = Config::all();
        $config['fsockopen'] = function_exists('fsockopen');
        $config['stream_socket_client'] = function_exists('stream_socket_client');
        return view('', ['config' => $config]);
    }

    /**
     * 编辑系统配置
     *
     * @param array $config
     * @return void
     */
    public function baseSet(array $config = [])
    {
        if (request()->isPost()) {

            $post = input();
            $list = Config::select()->toArray();
            foreach ($list as $key => $value) {

                $name = $value['name'];

                // 字段必须存在
                if (isset($post[$name])) {
                    $option['id'] = $value['id'];
                    if ('array' == trim($value['type'])) {
                        $option['value'] = json_encode($post[$name], JSON_UNESCAPED_UNICODE);
                    } else {
                        $option['value'] = $post[$name];
                    }

                    $config[$key] = $option;
                }
            }
    
            try {

                (new Config())->saveAll($config);
                $index = public_path() . 'index.php';
                $files = '../extend/conf/index.tpl';
              
                if ($post['site_status']) {
                    $close = '../extend/conf/close.tpl';
                    $content = file_get_contents($close);
                    write_file($index, $content);
                } else {
                    $content = file_get_contents($index);
                    if (!strpos($content, 'run()')) {
                        $content = file_get_contents($files);
                        write_file($index, $content);
                    }
                }

                // 配置文件路径
                $env = root_path() . '.env';
                $parse = parse_ini_file($env, true);
                $parse['CACHE']['DRIVER'] = $post['cache_type'];
                $parse['CACHE']['HOSTNAME'] = $post['cache_host'];
                $parse['CACHE']['HOSTPORT'] = $post['cache_port'];
                $parse['CACHE']['SELECT']   = max($post['cache_select'], 1);
                $parse['CACHE']['USERNAME'] = $post['cache_user'];
                $parse['CACHE']['PASSWORD'] = $post['cache_pass'];

                $content = parse_array_ini($parse);
                if (write_file($env, $content)) {
                    Cache::set('redis-sys_', $post,config('cookie.expire'));
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success('保存成功!');
        }
    }

    /**
     * FTP测试上传
     */
    public function testFtp()
    {
        if (request()->isPost()) {
            if (Ftp::instance()->ftpTest(input())) {
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
            $info = Email::instance()->testEMail(input());
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
            } catch (Throwable $th) {
                return $this->error($th->getMessage());
            }

            if ($drive->set('test', 'cacheOK', 1000)) {
                return $this->success('缓存测试成功！');
            } else {
                return $this->error('缓存测试失败！');
            }
        }

        return false;
    }
}
