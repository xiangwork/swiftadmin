<?php
declare(strict_types=1);

namespace app\admin\controller\generate;

use app\AdminController;
use app\common\model\Generate;
use think\facade\Db;


/**
 * 代码生成器
 */
class Index extends AdminController
{

    /**
     * 数据表前缀
     *
     * @var string
     */
    public string $prefix = 'sa_';

    // 初始化操作
    public function initialize()
    {
        parent::initialize();
        $this->model = new Generate();
        $this->prefix = env('DATABASE.PREFIX');
    }

    /**
     * 显示列表
     *
     * @return void
     */
    public function index()
    {
        if (request()->isAjax()) {

            $param = input();
            $param['page'] = input('page/d');
            $param['limit'] = input('limit/d');
            // 查询条件
            $where = array();
            if (!empty($param['title'])) {
                $where[] = ['title', 'like', '%' . $param['title'] . '%'];
            }

            // 查询数据
            $count = $this->model->where($where)->count();
            $limit = is_empty($param['limit']) ? 10 : $param['limit'];
            $page = ($count <= $limit) ? 1 : $param['page'];
            $list = $this->model->where($where)->order("id desc")->limit($limit)->page($page)->select()->toArray();
            return $this->success('查询成功', null, $list, $count);
        }

        return view();
    }

    /**
     * 添加生成数据
     *
     * @return void
     */
    public function add()
    {
        if (request()->isPost()) {

            $post = $this->insert_before(input('post.'));

            if ($this->model->create($post)) {
                return $this->success();
            }

            return $this->error();
        }

        return view('', ['data' => $this->getTableFields()]);
    }

    /**
     * 编辑生成数据
     *
     * @param integer $id
     * @return void
     */
    public function edit(int $id = 0)
    {

        if (request()->isPost()) {

            $post = $this->insert_before(input('post.'));

    
            $post = safe_field_model($post,get_class($this->model));
     
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            $variable = ['force', 'create', 'auth', 'global','delete'];
            foreach ($variable as $value) {
                if (!isset($post[$value])) {
                    $post[$value] = 0;
                }
            }

            if ($this->model->update($post)) {
                return $this->success();
            }

            return $this->error();
        }

        $id = input('id/d');
        $data = $this->model->find($id);
        if (!$data) {
            return $this->error('not found');
        }

        // 查询当前表
        $table = str_replace($this->prefix,'', $data['table']);
        $data['localfields'] = $this->queryfields($table);

        if ($data['listField']) {
            $data['listField'] = json_encode(explode(',', $data['listField']));
        }

        if ($data['relation']) {
            $data['relation'] = unserialize($data['relation']);
        }
        if ($data['menus']) {
            $data['menus'] = unserialize($data['menus']);
        }

        // 渲染模板
        return view('', ['data' => $data]);
    }

    /**
     * 数据预处理
     *
     * @param array $post
     * @return void
     */
    public function insert_before(array $post = [])
    {
        // 是否存在关联表
        if (isset($post['relation_table'])) {

            foreach ($post['relation_table'] as $key => $value) {
                if (empty($value)) {
                    continue;
                }
                $post['relation'][$key]['table'] = $value;
                $post['relation'][$key]['style'] = $post['relation_style'][$key];
                $post['relation'][$key]['foreignKey'] = $post['foreignKey'][$key];
                $post['relation'][$key]['localKey'] = $post['localKey'][$key];
                $post['relation'][$key]['relationField'] = $post['relationField'][$key];
            }

            if (!empty($post['relation'])) {
                $post['relation'] = serialize($post['relation']);
            }
        } else {
            $post['relation'] = '';
        }

        // 处理菜单项
        $menuParams = [];
        foreach ($post['menus']['title'] as $key => $value) {
            $menuParams[$key]['title'] = $value;
            $menuParams[$key]['route'] = $post['menus']['route'][$key];
            $menuParams[$key]['router'] = $post['menus']['router'][$key];
            $menuParams[$key]['template'] = $post['menus']['template'][$key];
            $menuParams[$key]['auth'] = $post['menus']['auth'][$key];
            $menuParams[$key]['type'] = $post['menus']['type'][$key];
        }

        $post['menus'] = $menuParams ? serialize($menuParams) : '';
        return $post ? $post : [];
    }

    /**
     * 表单设计器
     *
     * @param integer $id
     * @return void
     */
    public function formDesign(int $curdId = 0)
    {
        if (request()->isPost()) {

            $post['id'] = $curdId;
            
            $post['formName'] = input('formName');
            $post['width'] = input('width');
            $post['height'] = input('height');
            $post['formType'] = input('formType');
            $post['formDesign'] = input('formDesign');
            
            if ($this->model->update($post)) {
                return $this->success();
            }

            return $this->error();
        }

        $data = $this->model->find($curdId);
        if (!$data) {
            return $this->error('not found');
        }

        // 渲染模板
        return view('', ['data' => $data]);
    }

    /**
     * 查询表字段
     *
     * @param string|null $table
     * @return void
     */
    public function queryfields(string $table = null)
    {

        if (/*request()->isAjax() && */ $table) {
            $field = Db::name($table)->getTableFields();
            foreach ($field as $key => $value) {
                $list[$key]['value'] = $value;
                $list[$key]['name'] = $value;
            }
        }

        return json_encode($list ?? []);
    }
}
