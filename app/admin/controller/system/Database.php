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
namespace app\admin\controller\system;


use app\AdminController;
use think\facade\Db;
use app\common\library\Database as DatabaseInterface;

class Database extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
    }
    
    /**
     * 获取数据库资源
     */
    public function index() 
    {
        if (request()->isAjax()) {

            $list = [];
            $table = input('table/s') ?? env('database.PREFIX').'admin';
            if ($table == 'admin') {

                // 返回所有的表
                $tables = Db::query("SHOW TABLE STATUS");
                foreach ($tables as $key => $value) {
                    $list[$key]['id'] = $value['Name'];
                    $list[$key]['name'] = $value['Name'];
                    $list[$key]['comment'] = $value['Comment'];
                    $list[$key]['data_length'] = format_bytes($value['Data_length']);
                }
            } else {
                // 查询字段。
                $schema = Db::query('SHOW FULL COLUMNS FROM `'.$table.'`');
                if (!empty($schema)) {
                    foreach ($schema as $key => $value) {
                        $list[$key]['field'] = $value['Field'];
                        $list[$key]['default'] = $value['Default'];
                        $list[$key]['type'] = $value['Type'];
                        $list[$key]['collation'] = $value['Collation'];
                        $list[$key]['null'] = $value['Null'];
                        $list[$key]['comment'] = $value['Comment'];
                    }
                }
            }

            return $this->success('获取成功', null, $list, count($list));            


        }


        return view();
    }

    /**
     * 优化数据库表
     */
    public function optimize($id = null) 
    {

        if (request()->isAjax()) {        
            if (empty($id)) {
                return $this->error('请选择需要优化的数据库表！');
            }

            if (!is_array($id)) {
                $id = array($id);
            }

            // 开始优化
            $tables = implode('`,`', $id);
            if (Db::query("OPTIMIZE TABLE `{$tables}`")) {
                return $this->success('数据表优化完成！');
            }
        }
        return $this->error('数据表优化失败！');
    }

    /**
     * 修复数据库表
     */
    public function repair($id = null) 
    {

        if (request()->isAjax()) {

            if (empty($id)) {
                return $this->error('请选择需要修复的数据库表！');
            }
    
            if (!is_array($id)) {
                $id = array($id);
            }
    
            // 开始修复
            $tables = implode('`,`', $id);
            if (Db::query("REPAIR TABLE `{$tables}`")) {
                return $this->success('数据表修复完成！');
            }
        }

        return $this->error('数据表修复失败！');
    }

    /**
     * 数据库导出配置
     */
    public function config() 
    {

        if (request()->isPost()) {

            $post = input();
            $config = config('system');
            $config = array_merge($config,$post);
            if (arr2file('../config/system.php', $config) === false) {
                return $this->error('配置失败，请重试!');
            }
            
            \think\facade\Cache::set('redis-system',$config);
            return $this->success('配置成功!');

        }

        $data = saenv('database');
        return view('',['data'=>$data]);
    }

    /**
     * 备份数据库
    */
    public function export($id = null, $start = 0) 
    {

        if (request()->isPost() && !empty($id) && is_array($id)) {
            
            $config = saenv('database');
            $config['path'] = public_path().$config['path'].DIRECTORY_SEPARATOR;

            // 创建备份文件夹
            if (!is_dir($config['path'])) {
                mkdir($config['path'], 0755, true);
            }

            // 检查是否有正在执行的任务
            $lock = "{$config['path']}backup.lock";
            if(is_file($lock)){
                $this->error('检测到有一个备份任务正在执行，请稍后再试！');
            } else {
                // 创建锁文件
                file_put_contents($lock, request()->time());
            }

            // 检测目录权限
            if (!is_writable($config['path'])) {
                $this->error('备份目录不存在或不可写，请检查后重试！');
            }

            // 生成备份文件信息
            $file = array(
                'name' => date('Ymd-His', request()->time()),
                'part' => 1,
            );

            // 创建备份文件
            $Database = new DatabaseInterface($file, $config);
            if($Database->create() !== false){
                // 备份指定表
                foreach ($id as $table) {
                    $start = $Database->backup($table, $start);
                    while (0 !== $start) {
                        if (false === $start) {
                            return $this->error('备份出错');
                        }
                        $start = $Database->backup($table, $start[0]);
                    }
                }
                // 备份完成，删除锁定文件
                unlink($lock);
                return $this->success('备份数据库成功！');
            } else {
                return $this->error('初始化失败，备份文件创建失败！');
            }
        }

    }
}
