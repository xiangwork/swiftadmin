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

namespace app\admin\controller\system;

use think\facade\Db;
use think\plugin\Service;
use app\AdminController;
use app\common\library\Auth;

class Plugin extends AdminController
{
    /**
     * Http实例
     * @var Object
     */

    protected $http = null;

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
       
        $list = get_plugin_list();
        if (request()->isAjax()) {

            $localPlugin = [];
            foreach ($list as $key => $value) {
                $localPlugin[$key] = $value;

            }
            $count = count($localPlugin);
            return $this->success('获取成功',null,$localPlugin,$count,0);
        }

        $plugin = $this->localPlugin($list);
        return view('',['plugin'=> json_encode($plugin)]);
    }

    public function localPlugin($list, $array = [])
    {
        foreach ($list as $key => $value) {
            $array[$key]['name'] = $value['name'];
            $array[$key]['status'] = $value['status'];
            $array[$key]['area'] = $value['area'] ?? '600px';
            $array[$key]['auto'] = $value['auto'] ?? 'false';
            $array[$key]['config'] = $value['config'] ?? 0;
            $array[$key]['version'] = $value['version'];
        }

        return $array;
    }

    /**
     * 安装插件
     */
    public function install() {

        if (request()->isPost()) {

            $name = input('name/s');
            $token = input('token/s');
            $force = input('force/d');

            if (!preg_match("/^[a-zA-Z0-9]+$/", $name)) {
                return $this->error('插件信息错误');
            }

            try {

                // 扩展信息
                $extends = [
                    'name' => $name,
                    'token' => $token,
                ];

                $data = Service::install($name,$force,$extends) ?? [];
            } 
            catch (\think\plugin\PluginException $p) {
                return ajaxReturn($p->getMessage(),$p->getData(),$p->getCode());
            }
            catch (\Throwable $th) {
                return ajaxReturn($th->getMessage(),null,$th->getCode());
            }

            return $this->success('插件安装成功',null, $data);
        }
    }

    /**
     * 插件更新
     */
    public function upgrade() {


        if (request()->isPost()) {
            
            $name = input('name/s');
            $token = input('token/s');
            $force = input('force/d');

            if (!preg_match("/^[a-zA-Z0-9]+$/", $name)) {
                return $this->error('插件信息错误');
            }

            try {

                // 扩展信息
                $extends = [
                    'name' => $name,
                    'token' => $token,
                ];

                $data = Service::upgrade($name,$extends) ?? [];
            }
            catch (\think\plugin\PluginException $p) {
                return ajaxReturn($p->getMessage(),$p->getData(),$p->getCode());
            }
            catch (\Throwable $th) {
                return ajaxReturn($th->getMessage(),null,$th->getCode());
            }

            return $this->success('插件更新成功',null, $data);
        }   
    }

    /**
     * 卸载插件
     */
    public function uninstall() {

        if (request()->isAjax()) {
            $name = input('name/s');
            $tables = input('tables');
            $config = get_plugin_infos($name,true);
            if (!$config || !preg_match("/^[a-zA-Z0-9]+$/", $name)) {
                return $this->error('当前插件不存在');
            }

            if ($config['status']) {
                return $this->error('请先禁用插件再卸载');
            }
            
            // 获取插件相关数据表
            if (!empty($tables) && is_array($tables)) {
                $tables = get_plugin_tables($name);
                $tables = array_unique($tables);
            }

            try {

                // 删除插件资源文件
                Service::uninstall($name,true);

                // 执行卸载数据库表
                if ($tables 
                    && is_array($tables) 
                    && Auth::instance()->SuperAdmin()) {

                    // 删除插件关联表
                    $prefix = env('database.prefix');
                    foreach ($tables as $table) {

                        // 忽略非插件标识的表名
                        if (!preg_match("/^{$prefix}{$name}/", $table)) {
                            continue;
                        }

                        Db::execute("DROP TABLE IF EXISTS `{$table}`");
                    }
                       
                }

            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success('插件卸载成功');
        }
    }

    /**
     * 修改插件配置信息
     */
    public function config() {
        
        $name = input('name/s');
        $plugin = get_plugin_instance($name);

        if (!$plugin) {
            return $this->error('插件不存在或已禁用');
        }

        $config = $plugin->getConfig($name);
        if (request()->isPost()) {
            $post['extends'] = input('extends');
            $post['rewrite'] = input('rewrite');
            $config = array_merge($config,$post);
            
            try {
                $plugin->setConfig($name,$config);
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
            return $this->success();
        }

        return view($config['path'].'config.html',['config'=>$config]);
    }

    /**
     * 获取插件数据库表
     */
    public function tables() {

        if (request()->isAjax()) {
            $name = input('name/s');
            if (!$name || !preg_match("/^[a-zA-Z0-9]+$/", $name)) {
                $this->error('当前插件不存在');
            }

            $tables = get_plugin_tables($name);
            $prefix = env('database.prefix');
            foreach ($tables as $index => $table) {

                // 忽略非插件标识的表名
                if (!preg_match("/^{$prefix}{$name}/", $table)) {
                    unset($tables[$index]);
                }
            }

            if ($tables = array_values($tables)) {
                $this->success('查询成功', null, ['tables' => $tables]);
            }

            return $this->error('当前插件无数据表');
            
        }

    }

    /**
     * 修改插件状态
     */
    public function status() {

        if (request()->isAjax()) {

            $name = input('id/s');
            $status = input('status/d');
            $plugin = get_plugin_instance($name);
            if (!empty($plugin)) {
                try {

                    $action = $status == 1 ? 'enable' : 'disable';
                    Service::$action($name, false);
                    $plugin->setConfig($name,['status'=>$status]);
                    
                } catch (\Throwable $th) {
                    return $this->error($th->getMessage());
                }
                return $this->success();
            }
            else {
                return $this->error('插件不存在或其他错误');
            }
        }
    }

    /**
     * 更新插件缓存
     */
    public function cache()
    {
        try {
            $list = get_plugin_list();
            foreach ($list as $key => $value) {
                cache(sha1($key),null);
            }
            $action = true;
        } catch (\Throwable $th) {
            $action = false;
        }

        return $action ? $this->success() : $this->error();
    }
}
