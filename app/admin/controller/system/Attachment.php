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

namespace app\admin\controller\system;

use app\AdminController;

use app\common\model\system\Attachment as AttachmentModel;

/**
 * 附件管理
 */

class Attachment extends AdminController
{
    // 上传文件夹地址
    protected $upload;

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
        $this->model = new AttachmentModel();
        $this->upload = saenv('upload_path');
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        if (request()->isAjax()) {

            // 生成查询条件
            $post  = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;

            $where = [];
            if (!empty($post['filename'])) {
                $where[] = ['filename','like','%'.$post['filename'].'%'];
            }
            
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;            

            // 生成查询数据
            $list = $this->model->where($where)->order("id desc")->limit($limit)->page($page)->select()->toArray();
            return $this->success('查询成功', "", $list, $count);
        }

		return view(input('type') ?? 'index');
    }
}
