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
namespace app\admin\controller\generate;


use app\AdminController;
use app\common\model\Generate;
use app\common\library\Menus;
use think\facade\Db;
use think\helper\Str;
use system\Form;

/**
 * 一键CURD
 * 版本 beta - V1
 * 欢迎提交Fork PR
 */
class Curd extends AdminController
{
    /**
     * 数据表前缀
     *
     * @var string
     */
    public $prefix = 'sa_';

    /**
     * 获取菜单
     *
     * @var array
     */
    public  $menus = [];

    /**
     * 关联表信息
     *
     * @var array
     */
    public  $relation = [];

    /**
     * 函数体
     *
     * @var array
     */
    public  $methods = [];

    /**
     * 模板路径
     *
     * @var string
     */
    public $templatePath = '';

    /**
     * 模板文件
     *
     * @var array
     */
    public  $templateFiles = [];

    /**
     * 添加时间字段
     * @var string
     */
    protected $createTimeField = 'createtime';

    /**
     * 更新时间字段
     * @var string
     */
    protected $updateTimeField = 'updatetime';

    /**
     * 软删除时间字段
     * @var string
     */
    protected $deleteTimeField = 'delete_time';

    /**
     * 过滤默认模板
     *
     * @var array
     */
    public $filterMethod = ['index', 'add', 'edit', 'del', 'status'];

    /**
     * 限定特定组件
     *
     * @var array
     */
    public $mustbeComponent = ['set', 'text', 'json'];

    /**
     * 修改器字段
     * 
     * @var array
     */
    public $modifyFieldAttr = ['set', 'text', 'json'];

    /**
     * 保留字段
     *
     * @var string
     */
    public $keepFeild = 'status';

    /**
     * 查询字段[SELECT]
     *
     * @var array
     */
    public $dropdown = ['radio', 'checkbox', 'select'];

    /**
     * COLS换行符
     *
     * @var string
     */
    public $commaEol = ',' . PHP_EOL;

    /**
     * 受保护的表
     * 禁止CURD操作
     * @var array
     */
    protected array $protectTable = [
        "admin",
        "admin_access",
        "admin_group",
        "admin_rules",
        "adwords",
        "api",
        "api_access",
        "api_condition",
        "api_group",
        "api_params",
        "api_restful",
        "category",
        "channel",
        "comment",
        "company",
        "content",
        "content_articl",
        "content_images",
        "content_produc",
        "content_soft",
        "content_video",
        "department",
        "dictionary",
        "friendlink",
        "fulltext",
        "generate",
        "guestbook",
        "jobs",
        "navmenu",
        "project",
        "systemlog",
        "tags",
        "tags_mapping",
        "user",
        "user_group",
        "user_invitecod",
        "user_third",
        "user_validate"
    ];

    /**
     * 类保留关键字
     *
     * @var array
     */
    protected $internalKeywords = [
        'abstract',
        'and',
        'array',
        'as',
        'break',
        'callable',
        'case',
        'catch',
        'class',
        'clone',
        'const',
        'continue',
        'declare',
        'default',
        'die',
        'do',
        'echo',
        'else',
        'elseif',
        'empty',
        'enddeclare',
        'endfor',
        'endforeach',
        'endif',
        'endswitch',
        'endwhile',
        'eval',
        'exit',
        'extends',
        'final',
        'for',
        'foreach',
        'function',
        'global',
        'goto',
        'if',
        'implements',
        'include',
        'include_once',
        'instanceof',
        'insteadof',
        'interface',
        'isset',
        'list',
        'namespace',
        'new',
        'or',
        'print',
        'private',
        'protected',
        'public',
        'require',
        'require_once',
        'return',
        'static',
        'switch',
        'throw',
        'trait',
        'try',
        'unset',
        'use',
        'var',
        'while',
        'xor'
    ];

    // 初始化操作
    public function initialize()
    {
        parent::initialize();
        $this->model = new Generate();
        $this->templatePath = app_path('view');
        $this->prefix = env('DATABASE.PREFIX');
    }

    /**
     * 生成代码
     *
     * @param integer $id
     * @return void
     */
    public function index(int $id = 0)
    {

        if (request()->isAjax()) {

            $data = $this->model->find($id);

            if ($data['status'] && !$data['force']) {
                return $this->error('已经生成非覆盖选项');
            }

            if (!$this->prefix) {
                return $this->error('To get the data table prefix error');
            }

            // 过滤数据表
            $table = str_replace($this->prefix, '', $data['table']);
            if (in_array($table, $this->protectTable)) {
                return $this->error("system table cant be crud");
            }

            // 需存在表单项
            if (!$data['formDesign']) {
                return $this->error("the form cannot be empty");
            }

            try {
                $formDesign = json_decode($data['formDesign'], true);
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            // 定义命名空间
            $formItems   = [];
            $formType    = $data['formType'];
            $controller  = $data['controller'];
            $globalspace = $data['global'] ? 'common' : 'admin';

            // 获取控制器
            list($controllerName, $controllerNamespace, $controllerFile) = $this->getControllerData($controller, null);
            // 获取数据模型
            list($modelName, $modelNamespace, $modelFile) = $this->getModelData($globalspace, $controller, $table);
            // 获取验证器规则
            list($validateName, $validateNamespace, $validateFile) = $this->getvalidateData($globalspace, $controller, $table);
            // 获取菜单函数模板
            list($this->menus, $this->methods, $this->templateFiles) = $this->getMenuMethods($data->toArray());

            // 是否为删除模式
            if ($data['delete']) {
 
                try {
                    $readyFiles = [$controllerFile, $modelFile, $validateFile];
                    foreach ($readyFiles as $key => $value) {
                        if (is_file($value)) {
                            unlink($value);
                        }
    
                        $this->removeEmptyFolder(dirname($value));
                    }
    
                    recursive_delete($this->templatePath);

                    Menus::delete($table);

                    // 更新状态
                    $data->status = 0;
                    $data->save();

                } catch (\Throwable $th) {
                    
                    return $this->error($th->getMessage());
                }

                return $this->success('删除成功');
            }

            // 获取字段
            $adviceField = [];
            $adviceSearch = [];
            $everySearch  = [];

            // 字段属性值
            $colsFields = [];
            $fieldAttrArr = [];
            $this->tableFields = Db::name($table)->getFields();
            $listFields  = explode(',', $data['listField']);

            foreach ($this->tableFields as $key => $value) {

                if (
                    strtolower($key) != 'id'
                    && current($this->tableFields) == $value
                ) {
                    $this->error('The first field must be an id');
                }

                $field = $value['name'];
                $comment = str_replace(':', ';', $value['comment']);

                if (empty($comment)) {
                    return $this->error($field . " comment Can't be empty");
                }

                $this->tableFields[$key]['title'] = explode(';', $comment)[0];

                // 是否存在状态字段
                if ($field == $this->keepFeild) {
                    $adviceSearch[] = $field;
                }

                // 获取字段类型
                $everySearch[] = $field;
                $type = explode('(', $value['type'])[0];

                // 限定组件类型
                if (in_array($type, $this->mustbeComponent)) {
                    $this->validComponent($field, $type, $formDesign);
                }

                // 获取修改器
                if (in_array($type, $this->modifyFieldAttr)) {
                    $fieldAttrArr[] = $this->getFieldAttrArr($field, $type);
                }

                if (
                    empty($adviceField)
                    || ($adviceField['type'] != 'varchar' && $type == 'varchar')
                ) {
                    $adviceField = [
                        'field' => $field,
                        'type' => $type,
                    ];
                }

                // 列表展示的字段
                if (in_array($field, $listFields)) {
                    $colsFields[] = [
                        'field' => $field,
                        'title' => '{:__("' . $this->tableFields[$key]['title'] . '")}',
                    ];
                }
            }

            $fieldAttrArr = implode(PHP_EOL . PHP_EOL, $fieldAttrArr);

            // 推荐搜索片段
            $adviceSearch[] = $adviceField['field'];
            $advceSearchHtml = $this->getadviceSearch($adviceSearch, $formDesign);

            // 获取全部搜索字段
            $everySearch = array_diff($everySearch, $adviceSearch);
            $everySearchHtml =  $this->getadviceSearch($everySearch, $formDesign);
            $controller = substr($controller, 0, (strrpos($controller, '/') + 1));
            $colsListArr = $this->getColsListFields($colsFields, $formDesign);

            $replace = [
                'table'                 => $table,
                'title'                 => $data['title'],
                'controller'            => $controller, # 在这里还是需要判断内置外置表单的
                'controllerName'        => $controllerName,
                'controllerNamespace'   => $controllerNamespace,
                'tplsharing'            => $formType ? 'public $tplsharing = \'add\';' : '',
                'controllerDiy'         => $this->getMethodString($this->methods),
                'modelName'             => $modelName,
                'modelNamespace'        => $modelNamespace,
                'softDelete'            => array_key_exists($this->deleteTimeField, $this->tableFields) ? "use SoftDelete;" : '',
                'softDeleteClassPath'   => array_key_exists($this->deleteTimeField, $this->tableFields) ? "use think\model\concern\SoftDelete;" : '',
                'createTime'            => array_key_exists($this->createTimeField, $this->tableFields) ? "'$this->createTimeField'" : 'false',
                'updateTime'            => array_key_exists($this->updateTimeField, $this->tableFields) ? "'$this->updateTimeField'" : 'false',
                'deleteTime'            => array_key_exists($this->deleteTimeField, $this->tableFields) ? "'$this->deleteTimeField'" : 'false',
                'relationMethodList'    => $this->getrelationMethodList($data['relation']),
                'fieldAttrArr'          => $fieldAttrArr,
                'validateName'          => $validateName,
                'validateNamespace'     => $validateNamespace,
                'advceSearchHtml'       => $advceSearchHtml,
                'everySearchHtml'       => $everySearchHtml,
                'colsListArr'           => $colsListArr,
                'FormArea'              => $data['width'] . ',' . $data['height'],
            ];

            try {

                $writeArr = [
                    'controller' => $controllerFile,
                    'model'      => $modelFile,
                    'validate'   => $validateFile,
                ];

                foreach ($writeArr as $type => $file) {

                    $master = read_file($this->getStubTpl($type));
                    foreach ($replace as $key => $value) {
                        $master = str_replace("{%$key%}", $value, $master);
                    }

                    write_file($file, $master);
                }

                // 表单元素
                $addTpl = $formType ? 'add' : 'inside';
                $addHtml = read_file($this->getStubTpl($addTpl));

                foreach ($formDesign as $key => $value) {
                    $formItems[$key] = Form::itemElem($value, $formType);
                }

                $formItems = implode(PHP_EOL, $formItems);
                $addHtml = str_replace('{formItems}', $formItems, $addHtml);
                
                if (!empty($formType)) {
                    $index = read_file($this->getStubTpl('index'));
                    write_file($this->templatePath . 'add.html', $addHtml);
                } else {
                    $index = read_file($this->getStubTpl('index_inside'));
                }

                // 首页模板
                $replace['editforms'] = $formType ? '' : $addHtml;
                foreach ($replace as $key => $value) {
                    $index = str_replace("{%$key%}", $value, $index);
                }

                write_file($this->templatePath . 'index.html', $index);

                // 自定义函数
                $methodHtml = read_file($this->getStubTpl('extend'));
                foreach ($this->methods as $key => $method) {
                    write_file($this->templatePath . $method . '.html', $methodHtml);
                }

                // 是否写入菜单
                $data['create'] && Menus::create([$this->menus], $table);

                // 状态更改为已完成
                $data->save(['status' => 1]);
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }

            return $this->success();
        }
    }


    /**
     * 获取列表字段
     *
     * @param array $colsFields
     * @param array $formDesign
     * @return void
     */
    public function getColsListFields(array $colsFields = [], array $formDesign = [])
    {
        $colsListArr = [];
        foreach ($colsFields as $key => $value) {

            // 过滤删除字段
            $colsLine = [];
            $colsField = $value['field'];
            $colsTitle = $value['title'];
            if ($colsField == $this->deleteTimeField) {
                continue;
            }

            // 获取每一列参数合集
            $colsLine[] = "field:'$colsField'";
            if ($colsField == $this->keepFeild) {
                $colsLine[] = "templet: '#columnStatus'";
            }

            $item = $this->recursiveComponent($colsField, $formDesign);

            if (!empty($item) && is_array($item)) {

                $colsTpl = '';
                $colsArr = '';
                $colsTag = $item['tag'];

                if (in_array($colsTag, $this->dropdown)) {

                    $colsArr = $item['options'];
                    foreach ($colsArr as $index => $elem) {
                        $colsArr[$index]['title'] = "{:__('" . $elem['title'] . "')}";
                    }

                    $colsArr = json_encode($colsArr, JSON_UNESCAPED_UNICODE);
                    $colsTpl = read_file($this->getStubTpl('list/' . $colsTag));
                } else if ($colsTag == 'upload') {
                    $colsTpl = read_file($this->getStubTpl('list/' . $item['uploadtype']));
                } else {
                    $colsTpl = read_file($this->getStubTpl('list/' . $colsTag));
                }
                if (!empty($colsTpl)) {
                    $colsLine[] = str_replace(['{colsArr}', '{field}'], [$colsArr, $colsField], $colsTpl);
                }
            }

            $colsLine[] = "width: 160";
            $colsLine[] = "title:'$colsTitle'";
            $colsListArr[$key] = '{' . implode(',', $colsLine) . '}';
        }

        $colsListArr = implode($this->commaEol, $colsListArr);
        return $colsListArr ? $colsListArr .= ',' : $colsListArr;
    }

    /**
     * 获取修改器
     *
     * @param string|null $field
     * @param string|null $type
     * @param string $subTpl
     * @return void
     */
    public function getFieldAttrArr(string $field = null, string $type = null, string $subTpl = 'change')
    {
        $tplPath =  $subTpl . '/' . $type;
        $methods = read_file($this->getStubTpl($tplPath));

        if (!empty($methods)) {
            $methods = str_replace('{%field%}', ucfirst($field), $methods);
        }

        return $methods;
    }

    /**
     * 验证组件
     *
     * @param string|null $field
     * @param string|null $type
     * @param array $data
     * @return void
     */
    public function validComponent(string $field = null, string $type = null, array $data = [])
    {
        if (!$field || !$data) {
            return false;
        }

        $result = $this->recursiveComponent($field, $data);

        if (!empty($result)) {

            $tag = strtolower($result['tag']);
            switch ($type) {
                case 'set':
                    if ($tag != 'checkbox') {
                        return $this->error($field . ' components should be checkbox');
                    }
                    break;
                case 'json':
                    if ($tag != 'json') {
                        return $this->error($field . ' components should be json');
                    }
                    break;
                case 'text': // 限定TEXT字段类型必须为多文件上传
                    if ($tag != 'upload' || $result['uploadtype'] != 'multiple') {
                        return $this->error($field . ' components should be multiple upload');
                    }
                    break;
                default:
                    break;
            }
        }

        return false;
    }

    /**
     * 查找组件
     *
     * @param string $field
     * @param array $data
     * @return void
     */
    public function recursiveComponent(string $field = '', array $data = [])
    {
        foreach ($data as $value) {

            if ($field == $value['name']) {
                return $value;
            }

            if (isset($value['children']) && $value['children']) {
                $subElem = $value['children'];
                foreach ($subElem as $child) {
                    $item = $this->recursiveComponent($field, $child['children']);
                    if (!empty($item)) {
                        return $item;
                    }
                }
            }
        }
    }

    /**
     * 搜索模板
     *
     * @param array $searchArr
     * @param array $formArr
     * @return void
     */
    public function getadviceSearch(array $searchArr = [], array $formArr = [])
    {
        if (!$searchArr) {
            return false;
        }

        $varhtml = '';
        $varData = '';
        $searchHtml = [];
        foreach ($searchArr as $searchField) {

            if ($searchField == $this->deleteTimeField) {
                continue;
            }

            if ($searchField == $this->keepFeild) {
                $varhtml = read_file($this->getStubTpl('search/status'));
            } else if (in_array($searchField, [$this->createTimeField, $this->updateTimeField])) {
                $varhtml = read_file($this->getStubTpl('search/datetime'));
            } else {

                $result = $this->recursiveComponent($searchField, $formArr);
                if ($result && in_array($result['tag'], $this->dropdown)) {
                    $varData = Form::validOptions($result['options']);
                    $varhtml = read_file($this->getStubTpl('search/select'));
                } else if ($result && in_array($result['tag'], ['slider'])) {
                    $varhtml = read_file($this->getStubTpl('search/slider'));
                    $varhtml = str_replace(
                        ['{default}', '{theme}', '{step}', '{max}', '{min}'],
                        [$result['data_default'], $result['data_theme'], $result['data_step'], $result['data_max'], $result['data_min']],
                        $varhtml
                    );
                } else if ($result && in_array($result['tag'], ['cascader'])) {
                    $varhtml = read_file($this->getStubTpl('search/cascader'));
                } else if ($result && in_array($result['tag'], ['date'])) {
                    $varhtml = read_file($this->getStubTpl('search/datetime'));
                } else if ($result && in_array($result['tag'], ['rate'])) {
                    $varhtml = read_file($this->getStubTpl('search/rate'));
                    $varhtml = str_replace(['{theme}', '{length}'], [$result['data_theme'], $result['data_length']], $varhtml);
                } else {
                    $varhtml = read_file($this->getStubTpl('search/input'));
                }
            }

            $replace = [
                'field' => $searchField,
                'title' => $this->tableFields[$searchField]['title'],
                'varlist' => ucfirst($searchField) . '_list',
                'vardata' => $varData,
            ];

            foreach ($replace as $key => $value) {
                $varhtml = str_replace("{%$key%}", $value, $varhtml);
            }

            $searchHtml[] = $varhtml;
        }

        return implode(PHP_EOL . PHP_EOL, $searchHtml);
    }


    /**
     * 获取菜单函数
     * 
     * @param array $data
     * @return void
     */
    protected function getMenuMethods(array $data = [])
    {
        if (empty($data) || !is_array($data)) {
            throw new \Exception("Error Params Request", 1);
        }

        if (!is_array($data['menus'])) {
            $data['menus'] = unserialize($data['menus']);
        }

        $writeRules = [
            'title' => $data['title'],
            'router'   => $data['controller'],
            'icons'    => $data['icon'] ?? '',
            'pid'      => $data['pid'],
            'auth'     => $data['auth'],
        ];


        // 菜单项
        foreach ($data['menus'] as $key => $value) {

            $writeRules['children'][$key] = [
                'title' => $value['title'],
                'router' => $value['router'],
                'auth' => $value['auth'],
                'type' => $value['type'],
            ];

            $parse = explode(':', $value['route']);
            $parse = Str::lower(end($parse));
            if (!in_array($parse, $this->filterMethod)) {
                $this->methods[$key] = $parse;
                $this->templateFiles[$key] = Str::snake($parse);
            }
        }

        return [$writeRules, $this->methods, $this->templateFiles];
    }

    /**
     * 获取其他函数
     *
     * @param array $method
     * @return void
     */
    protected function getMethodString(array $methods = [])
    {
        $outsMethod = PHP_EOL;

        foreach ($methods as $method) {

            if (!in_array($method, $this->filterMethod)) {
                $outsMethod .= <<<Eof
                    
                    public function $method()
                    {
                        return view();
                    }
                    
                Eof;
            }
        }

        return $outsMethod;
    }

    /**
     * 获取关联表信息
     * id style KEY
     * @param mixed $relation
     * @return void
     */
    protected function getrelationMethodList(mixed $relation = [])
    {
        $relationString = PHP_EOL;
        if (!empty($relation) && !is_array($relation)) {

            $relation = unserialize($relation);

            foreach ($relation as $value) {

                $table = $value['table'];
                $schema = Db::query("SHOW TABLE STATUS LIKE '$table'");
                $studly = Str::studly(str_replace($this->prefix, '', $table));

                // 拼接关联语句
                $localKey   = $value['localKey'];
                $foreignKey = $value['foreignKey'];
                $strRlation  = '$this->' . $value['style'] . '(' . $studly . '::Class,' . "'$foreignKey','$localKey')";

                if ($value['relationField']) {
                    $bindfield = explode(',', $value['relationField']);
                    $bindfield = array_unique(array_filter($bindfield));
                    $strRlation .= '->bind(' . str_replace('"', '\'', json_encode($bindfield)) . ')';
                }

                try {

                    $Comment = $schema[0]['Comment'] ?? $table;
                    $table = str_replace([$this->prefix, '_'], '', $table);
                    $relationString .= <<<Eof

                        // 定义{$Comment}关联
                        public function {$table}()
                        {
                            return {$strRlation};
                        }
                        
                    Eof;
                } catch (\Throwable $th) {
                    throw new \Exception($th->getMessage());
                }
            }
        }

        return $relationString;
    }

    /**
     * 获取模板文件
     *
     * @param [type] $name
     * @return void
     */
    protected function getStubTpl($name)
    {
        return __DIR__ . DIRECTORY_SEPARATOR . 'stubs' . DIRECTORY_SEPARATOR . $name . '.stub';
    }

    /**
     * 获取控制器
     *
     * @param [type] $app
     * @param [type] $name
     * @param [type] $table
     * @return void
     */
    protected function getControllerData($name, $table)
    {
        return $this->getParseNameData('admin', $name, $table, 'controller');
    }

    /**
     * 获取数据库模型
     *
     * @param [type] $module
     * @param [type] $name
     * @param [type] $table
     * @return void
     */
    protected function getModelData($module, $name, $table)
    {
        return $this->getParseNameData($module, $name, $table, 'model');
    }

    /**
     * 获取验证器
     *
     * @param [type] $module
     * @param [type] $name
     * @param [type] $table
     * @return void
     */
    protected function getvalidateData($module, $name, $table)
    {
        return $this->getParseNameData($module, $name, $table, 'validate');
    }


    /**
     * 获取已解析相关信息
     * @param string $module 模块名称
     * @param string $name   自定义名称
     * @param string $table  数据表名
     * @param string $type   解析类型，本例中为controller、model、validate
     * @return array
     */
    protected function getParseNameData($module, $name, $table, $type)
    {
        $array = str_replace(['.', '/', '\\'], '/', strtolower($name));
        $array = array_filter(explode('/', $array));

        // 判断是否为默认函数
        if (substr($name, 0 - strlen('/')) != '/') {
            array_pop($array);
        }

        // 获取文件名
        if (!empty($table)) {
            $parseName = Str::studly($table);
        } else {
            $parseName = ucfirst(end($array));
        }

        // 类名不能为内部关键字
        if (in_array(strtolower($parseName), $this->internalKeywords)) {
            throw new \Exception('Unable to use internal variable:' . $parseName);
        }

        array_pop($array);
        $type == 'controller' && $this->getTemplatePath($name);
        $appNamespace = "app\\{$module}\\$type" . ($array ? "\\" . implode("\\", $array) : "");
        $parseFile = root_path() . $appNamespace . DIRECTORY_SEPARATOR . $parseName . '.php';

        // dump($parseName);
        // dump($appNamespace);
        // dump($parseFile);

        return [$parseName, $appNamespace, $parseFile];
    }

    /**
     * 获取代码模板
     *
     * @param [type] $name
     * @return void
     */
    protected function getTemplatePath($name)
    {
        $array = str_replace(['.', '/', '\\'], '/', strtolower($name));
        $array = array_filter(explode('/', strtolower($array)));
        if (substr($name, 0 - strlen('/')) != '/') {
            array_pop($array);
        }

        foreach ($array as $value) {
            $this->templatePath .= $value . DIRECTORY_SEPARATOR;
        }

        return $this->templatePath;
    }

    /**
     * 移除空文件夹
     * https://www.php.net/manual/zh/class.filesystemiterator.php
     * @param mixed $parseDirs
     * @return void
     */
    protected function removeEmptyFolder(mixed $parseDirs)
    {

        if (!is_array($parseDirs)) {
            $parseDirs = str_replace(['_', '-'], ',', $parseDirs);
            $parseDirs = explode(',', $parseDirs);
        }

        foreach ($parseDirs as $dir) {
            try {
                $iterator = new \FilesystemIterator($dir . '\\ss');
                if (!$iterator->valid()) {
                    // rmdir($dir);
                } else {
                    return true;
                }
            } catch (\Throwable $th) {
                return false;
            }
        }
        return true;
    }
}
