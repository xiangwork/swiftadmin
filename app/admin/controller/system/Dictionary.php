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


use app\AdminController;

use think\facade\Db;


class Dictionary extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
    }
    
    public function index() 
    {

        if (request()->isAjax()) {

            $table = input('table/s') ?? 'sa_admin';

            if (empty($table)) {
                return $this->error();
            }
    
            $list = [];
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

            return $this->success('查询成功', "", $list, count($list), 0);

        }

        // 渲染字典列表
        $tables = Db::query("SHOW TABLE STATUS");
        $list = [];
        foreach ($tables as $key => $value) {
            $list[$key]['name'] = $value['Name'];
            $list[$key]['comment'] = $value['Comment'];
            $list[$key]['length'] = format_bytes($value['Data_length']);
        }

        return view('',['list'=>$list]);
    }

}