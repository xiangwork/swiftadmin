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
namespace app\common\library;
require_once (root_path().'extend/system/xunsearch/lib/XS.class.php');

/**
 * XS全文索引类
 * @xunsearch 1.4.15 sa-fixed 1.0
 */
class XunSearch 
{
    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    // 全局对象
    protected object $_client;

    // 项目路径
    public  string $_app_path = 'extend/system/xunsearch/app/';

    // 索引字段
    private array $_app_field = [];

    // 高亮字段
    public array $_highlight_field = [];

    // 查询规则
    public array $_where = [];

    /**
     * 必选字段
     *
     * @var array
     */
    public  array $_mustbeFields = ['id', 'title', 'content', 'status'];

    // 搜索匹配数
    private int $_count = 0;

    // 查询毫秒
    protected mixed $_seconds = 0;

    // 查询参数
    protected array $_option = ['page'=>0];

    // 索引状态
    protected mixed $_status = false;

    // 错误信息
    protected $_error = '';

    /**
     * @objectValidate
     */
    public $objectValidate = null;

    /**
     * 类构造函数
     * class constructor.
     */
    public function __construct()
    {
        // 启动索引服务
        $this->_status = saenv('search_status');
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return self
     */
    public static function instance($options = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new static($options);
        }

        // 返回实例
        return self::$instance;
    }

    /**
     * 创建索引
     *
     * @param string|null $name
     * @param mixed $hosts
     * @param array $info
     * @return void
     */
    public function indices(array $data = [])
    {
        try {
            $project = [
                'project.name' => $data['name'],
                'project.default_charset' => 'utf-8',
                'server.index' => $data['index'],
                'server.search' => $data['search'],
            ];

            $project['id']['type'] = 'id';
            $projectIni = parse_array_ini($project);
            $projectPath = root_path().$this->_app_path . $data['name'] .'.ini';
            if (is_file($projectPath)) {
                throw new \Exception('项目配置已经存在');
            }
            
            write_file($projectPath,$projectIni);
        } catch (\Throwable $th) {
            throw new \Exception($th->getMessage());
        }

        return true;
    }

    /**
     * 删除索引
     *
     * @param string|null $name
     * @param mixed $hosts
     * @param array $info
     * @return void
     */
    public function delices(array $data = [])
    {
        $app_path = root_path().$this->_app_path . $data['name'] .'.ini';
        if (is_file($app_path)) {
            $this->index($data['name']);
            $this->_client->index->clean();
            unlink($app_path);
        }

        return true;
    }

    /**
     * 创建Mapping
     *
     * @param array $properties
     * @param mixed $data
     * @return void
     */
    public function putMapping(array $properties = [], mixed $data = [])
    {
        // 初始化项目
        $project = [
            'project.name' => $data['name'],
            'project.default_charset' => 'utf-8',
            'server.index' => $data['index'],
            'server.search' => $data['search'],
        ];

        // 校验数据
        $field_type = array_count_values($properties['field_type']);
        if (!isset($field_type['id']) || $field_type['id'] >= 2) {
            throw new \Exception('主键型非唯一性或为空');
        }

        /**
         * 强选项字段
         */
        $field_name = array_flip($properties['field_name']);

        foreach ($this->_mustbeFields as $key) {
            if (!array_key_exists($key, $field_name)) {
                throw new \Exception('The lack of necessary key values');
            }
        }

        $fields = $this->parXunSearch($properties);

        try {
            // 写入配置
            $projectIni = parse_array_ini(array_merge($project,$fields));
            $projectPath = root_path().$this->_app_path . $data['name'] .'.ini';
            write_file($projectPath,$projectIni);
        } catch (\Throwable $th) {
            throw new \Exception($th->getMessage());
        }

        return $fields;
    }

    /**
     * 解析XS配置
     *
     * @param array $post
     * @return void
     */
    protected function parXunSearch(array $post = [])
    {
        // 循环配置
        foreach ($post['field_name'] as $key => $value) {

            $field[$value]['type'] = $post['field_type'][$key];
            if (!in_array($post['field_type'][$key],['id','title','body'])
                && $post['field_index'][$key] !== 'none') {
                $field[$value]['index'] = $post['field_index'][$key];
            }

            if ($post['field_tokenizer'][$key]
                && $post['field_tokenizer'][$key] !== 'default') {
                $field[$value]['tokenizer'] = $post['field_tokenizer'][$key];
            }

            if ($post['field_weight'][$key] >= 2) {
                $field[$value]['weight'] = $post['field_weight'][$key];
            }
            
            if ($post['field_phrase'][$key]) {
                $field[$value]['phrase'] = 'yes';
            }
        }

        return isset($field) ? $field : [];
    }    

    /**
     * 项目索引
     * @param  string $app  项目名称
     * @return this
     */
    public function index(string $app = null)
    {
        $app = !empty($app) ? $app : 'content';
        $app_path = root_path().$this->_app_path . $app .'.ini';
        if (!is_file($app_path)) {
            throw new \Exception('配置文件不存在');
        }
        
        try {
            $this->_client = new \XS($app);
        } catch (\XSErrorException  $e) {
            $this->setError($e);
        }
        
        $this->_app_field = $this->_client->getConfig();
        foreach ($this->_app_field as $key => $value) {
            if (!is_array($value)) {
                // 保留字段
                unset($this->_app_field[$key]);
                continue;
            }
        }
        
        return $this;
    }

    /**
     * 更新文档
     *
     * @param array $data
     * @param boolean $juetUpdate
     * @return void
     */
    public function save(array $data = [], $juetUpdate = false)
    {
        if (is_array($data) && $this->_status) {

            $document = new \XSDocument();
            if (isset($data['content']) && $data['content']) {
                $data['content'] = msubstr($data['content'], -1);
                $data['content'] = preg_replace('/&[a-z]{1,5};/',"",$data['content']);
            }

            $document->setFields($data);
            $this->_client->index->update($document);
        }
    }

    /**
     * 删除索引
     * @param array|integer|null $id
     * @return void
     */
    public function delete(array|int $id = [])
    {
        if (!empty($id) && $this->_status) {
            $this->_client->index->del($id);
        }
    }

    /**
     * 搜索数据源
     *
     * @param string|null $keyword
     * @param string|array $field
     * @return void
     */
    public function search(string $keyword = null, string|array $field = [])
    {
        // 设置关键字
        $field = !empty($field) ? $field : 'title';
        if (!is_array($field)) {
            $field = explode(',',$field);
        }

        $this->_client->search->setQuery($keyword);

        // 增加字段权重
        $this->_client->search->addWeight($field[key($field)], $keyword);
        if ($this->_option['page'] == 0) {
            $this->_client->search->setLimit($this->_option['length'] ?? 10, 
                                             $this->_option['offset']);
        }
        else {
            $this->_client->search->setLimit($this->_option['length'] ?? 10,
                                             $this->_option['length'] * ($this->_option['page']-1));
        }

        // 限定支持WHERE条件
        foreach ($this->_where as $key => $item) {
            list($field,$symbol,$value) = $item;
            if (array_search($field,['id','pid','cid','status'])) {
                switch ($symbol) {
                    case '<':
                    case '<=':
                        $this->_client->search->addRange($field,null,$value);
                        break;
                    case '>':
                    case '>=':
                        $this->_client->search->addRange($field,$value,null);
                        break;                    
                    default:
                        $this->_client->search->addRange($field,$value,$value);
                        break;
                }
            }
        }

        // 查询时间
        $search_begin = microtime(true);

        // 默认条件
        $this->_client->search->addRange('status',1,1);
        $XSDocuments  = $this->_client->search->search();
        $this->_count = $this->_client->search->getLastCount();
        foreach ($XSDocuments as $key => $doc) {

            if ($this->_highlight_field) {
                foreach ($this->_highlight_field as $word) {
                    if (array_key_exists($word,$this->_app_field)) {
                        $doc->setFields([$word => $this->_client->search->highlight($doc->$word)]);
                    }
                }
            }

            // 遍历数组
            foreach ($doc as $field => $value) {
                $list[$key][$field] = $value;
            }
        }

        $this->_seconds =  sprintf("%.4f",microtime(true) - $search_begin);

        return ['data'=> $list, 'count' => $this->_count, 'seconds'=> $this->_seconds, 'total' => $this->_client->search->dbTotal, 'byte'=> '0'];

    }

    /**
     * 指定查询条件
     * @access public
     * @param mixed $field     查询字段
     * @param mixed $op        查询表达式
     * @param mixed $condition 查询条件
     * @return $this
     */
    public function where($field, $op = null, $condition = null)
    {
        if (is_array($field)) {
            $this->_where = $field;
        }
        else {
            if (empty($condition)) {
                $condition = $op;
                $op = '=';
            }

            $this->_where = [$field,$op,$condition];
        }

       return $this;
    }

    /**
     * 查询字段高亮
     *
     * @param mixed $fields
     * @return void
     */
    public function highlight(mixed $fields)
    {
        if (!is_array($fields)) {
            $fields = str_replace(array('，','|','-'),',',$fields);
            $fields = explode(',',$fields);
        }

        $this->_highlight_field = $fields;
        return $this;
    }

    /**
     * 分页查询
     *
     * @param integer $offset   数据偏移
     * @param integer $length   查询条数
     * @return void
     */
    public function limit(int $offset = 0, int $length = 0)
    {
        if (empty($length)) {
            $this->_option['length'] = $offset;
            $this->_option['offset'] = 0;
        } else {
            $this->_option['length'] = $length;
            $this->_option['offset'] = $offset;
        }

        return $this;
    }

    /**
     * 搜索分页
     *
     * @param integer $page
     * @return void
     */
    public function page(int $page = 1)
    {
        $this->_option['page'] = $page == 0 ? 1 : $page;
        return $this; 
    }

    /**
     * 搜索排序
     * @param string  $field     // 字段
     * @param string    $asc       // 排序方式
     * @return void
     */
    public function order(string $field = 'id', string $asc = 'desc')
    {
        if (!array_key_exists($field,$this->_app_field)) {
            $field = 'id';
        }

        $sort = $asc == 'asc' ? false : true;
        $this->_client->search->setSort($field,$asc);
        return $this;
    }

    /**
     * 模糊搜索
     * @param bool  $status     // 搜索状态
     * @return void
     */
    public function setFuzzy(bool $status = false)
    {
        $this->_client->search->setFuzzy($status);
        return $this;
    }

    /**
     * 获取搜索热词
     * 可做数据分析用
     * @param integer   $limit  限定词数
     * @param string    $type   搜索条件currnum/lastnum/total
     * @return void
     */
    public function getHotKeys(int $limit = 6,string $type = 'total')
    {
        return $this->_client->search->getHotQuery($limit,$type);
    }

    /**
     * 搜索匹配数
     * @return int 
     */
    public function getCount()
    {
        return $this->_count;
    }

    /**
     * 获取搜索耗时
     * 单位/秒
     * @return void
     */
    public function getSecond()
    {
        return $this->_seconds;
    }
    
    /**
     * 获取最后产生的错误
     * @return string
     */
    public function getError()
    {
        return $this->_error;
    }

    /**
     * 设置错误
     * @param string $error 信息信息
     */
    protected function setError($error)
    {
        $this->_error = $error;
    }

}