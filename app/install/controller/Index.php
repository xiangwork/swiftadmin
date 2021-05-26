<?php
declare (strict_types = 1);

namespace app\install\controller;
use think\facade\Cache;

use app\BaseController;

class Index extends BaseController
{   
    /**
     * 使用协议
     */
    public function index()
    {
        Cache::clear();
        return view();
    }

    /**
     * 检测安装环境
     */
    public function step1() {

        if (request()->isPost()) {

            // 检测生产环境
            foreach (checkenv() as $key => $value) {
                
                if ($key == 'php' && (float)$value < 8) {
                    return $this->error('PHP版本过低！');
                }

                if ($value == false && $value != 'redis') {
                    return $this->error($key.'扩展未安装！');
                }
            }

            // 检测目录权限
            foreach (check_dirfile() as $value) {
                if ($value[1] == ERROR 
                    || $value[2] == ERROR) {
                    return $this->error($value[3].' 权限读写错误！');
                }
            }

            Cache::set('checkenv','success',3600);
            return json(['code'=>200,'url'=>'/install.php/index/step2']);
        }

        return view('',[
            'checkenv' => checkenv(),
            'checkdirfile' => check_dirfile(),
        ]);
    }

    /**
     * 检查环境变量
     */
    public function step2() {

        if (!Cache::get('checkenv')) {
            return redirect('/install.php/index/step1');
        }
 
        if (request()->isPost()) {

            // 链接数据库
            $post = input();
            $connect = @mysqli_connect($post['hostname'] . ':' . $post['hostport'], $post['username'], $post['password']);
            if (!$connect) {
                return $this->error('数据库链接失败');
            }
    
            // 检测MySQL版本
            $mysqlInfo = mysqli_get_server_info($connect);
            if ((float)$mysqlInfo < 5.5) {
                return $this->error('MySQL版本过低');
            }
    
            // 查询数据库名
            $database = mysqli_select_db($connect, $post['database']);
            if (!$database) {
                $query = "CREATE DATABASE IF NOT EXISTS `".$post['database']."` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;";
                if (!mysqli_query($connect, $query)) {
                    return $this->error('数据库创建失败或已存在，请手动修改');
                }
            }
            else {
                $mysql_table = mysqli_query($connect, 'SHOW TABLES FROM'.' '.$post['database']);
                $mysql_table = mysqli_fetch_array($mysql_table);
                if (!empty($mysql_table) && is_array($mysql_table)) {
                    return $this->error('数据表已存在，请勿重复安装');
                }
            }
            
            Cache::set('mysql',$post,3600);
            return json(['code'=>200,'url'=>'/install.php/index/step3']);
        }

        return view();
    }

    /**
     * 初始化数据库
     */
    public function step3() 
    {
        $mysql = Cache::get('mysql');
        if (!$mysql) {
            return redirect('/install.php/index/step2');
        }

        // 修改加密KEY
        $config = config('system');
        $config['auth']['auth_key'] = create_rand(16);
        arr2file('../config/system.php',$config);

        return view();
    }

    /**
     * 启动安装
     */
    public function install() 
    {
        if (request()->isAjax()) {

            $mysql = Cache::get('mysql');
            if (is_file('../extend/conf/install.lock') || !$mysql) {
                return $this->error('请勿重复安装本系统');
            }
    
            // 获取变量文件
            $env = app_path().'install.env';
            $parse = parse_ini_file($env,true);
            $parse['DATABASE']['HOSTNAME'] = $mysql['hostname'];
            $parse['DATABASE']['HOSTPORT'] = $mysql['hostport'];
            $parse['DATABASE']['DATABASE'] = $mysql['database'];
            $parse['DATABASE']['USERNAME'] = $mysql['username'];
            $parse['DATABASE']['PASSWORD'] = $mysql['password'];
            $parse['DATABASE']['PREFIX'] = $mysql['prefix'];
            $content = parse_array_ini($parse);
            write_file(root_path().'.env',$content);
    
            // 读取MySQL数据
            $path = app_path().'install.sql';
            $sql = file_get_contents($path);
            $sql = str_replace("\r", "\n", $sql);
    
            // 替换数据库表前缀
            $sql = explode(";\n", $sql);
            $sql = str_replace(" `sa_", " `{$mysql['prefix']}", $sql);
            
            // 缓存任务总数
            $count = count($sql);
			
            if ($count >= 1 && is_numeric($count)) {
                Cache::set('total',$count,3600);
            } else {
                unlink(root_path().'.env');
                Cache::set('error','读取install.sql出错',7200);
                return false;
            }
			
            // 链接数据库
            $connect = @mysqli_connect($mysql['hostname'].':'.$mysql['hostport'], $mysql['username'], $mysql['password']);
            mysqli_select_db($connect, $mysql['database']);
            mysqli_query($connect, "set names utf8mb4");
    
            $logs = [];
            $nums = 0;
            try {

                // 写入数据库
                foreach ($sql as $key => $value) {

                    Cache::set('progress',($key+1),3600);
                    $value = trim($value);
                    if (empty($value)) {
                        continue;
                    }
                    
                    // 创建表数据
                    if (substr($value, 0, 12) == 'CREATE TABLE') {
                        $name = preg_replace("/^CREATE TABLE `(\w+)` .*/s", "\\1", $value);
                        $msg  = "创建数据表 {$name}...";
						
                        if (false !== mysqli_query($connect,$value)) {

                            $msg .= '成功！';
                            $logs[$nums] = [
                                'id'=> $nums,
                                'msg'=> $msg,
                            ];

                            $nums++;
							Cache::set('tasks',$logs,3600);
                        }
                    } else {
                        mysqli_query($connect,$value);
                    }
                }
    
            } catch (\Throwable $th) { // 异常信息
                Cache::set('error',$th->getMessage() ?? '任务执行失败！',7200);
            }
    
            // 修改初始化密码
            $pwd = hash_pwd($mysql['pwd']);
            mysqli_query($connect,"UPDATE {$mysql['prefix']}admin SET pwd='{$pwd}' where id = 1");
			write_file(root_path().'extend/conf/install.lock',true);
        }
    }

    /**
     * 获取安装进度
     */
    public function progress() 
    {
        if (request()->isAjax()) {

            // 查询错误
            $error = Cache::get('error');
            if (!empty($error)) {
                return json(['code'=>101,'msg'=>$error]);
            }
            
            // 获取任务信息
			$code  = 200;
			$total = Cache::get('total');
            $tasks = Cache::get('tasks') ?? [
                'id' => 0,
                'msg' => '等待任务...'
            ];
            $progress = round((Cache::get('progress')/$total) * 100 ).'%';
            $result = [
                'code'=> $code,
                'msg'=> $tasks,  
                'progress'=> $progress,
            ];

            return json($result);
        }
    }

    /**
     * 清理安装文件包
     */
    public function clear() 
    {
        if (request()->isAjax() 
            && is_file('../extend/conf/install.lock')) {
            try {
                
                // 复制入口文件
                $admin = input('admin/s') ?? 'admin';
                $index   = '../extend/conf/index.tpl';
                copy($index,public_path().'index.php');
				$index   = '../extend/conf/admin.tpl';
                copy($index,public_path().$admin.'.php');

                // 清理安装包
                Cache::clear();
                recursiveDelete(app_path());
                unlink(public_path().'install.php');
            }
            catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
        }
    }
}
