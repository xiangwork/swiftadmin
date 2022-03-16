
/**
 * 编辑器通用调用类
 * MIT Licensed 
 */
 
 layui.define(['jquery','layer'], function(exports){
    "use strict";
    
    var $ = layui.$;
    var layer = layui.layer;
    
    exports('editor', function(options){
        var elems = [];
        options = options || {};
        options.elem = $(options.elem);
        options.mode = options.mode ?? 'default';
        
        // 插入预定义的CSS文件
        var html = '<script src="/static/js/wangeditor/index.min.js?v12"><\/script>';
        $('head').prepend(html);

        if (!options.elem.length) {
            console.warn('not find textarea element');
            return false;
        }

        options.elem.hide();
        options.id = options.elem.attr('id');
        if (typeof options.height == 'undefined') {
            options.height = '500px';
        }

        var TOOLBAR = options.id +'-toolbar-container',
            EDITOR = options.id +'-editor-container';
        var html = '<div class="full-screen-container">';
        html += '<div id="'+TOOLBAR+'"></div>';
        html += '<div id="'+EDITOR+'" style="height:'+options.height+';" ></div></div>';
        options.elem.parent().append(html);

        /**
         * 编辑常用配置
         */
        var E = window.wangEditor;

        // 不能用常量，否则无法合并
        let editorConfig = { 
            MENU_CONF: {
            } 
        }

        // 获取一个新的上传地址
        var uploadURL = '/upload/file';
        var upload = options.elem.attr('upload');
        
        if (upload != undefined) {
            console.log(upload);
            uploadURL = upload;
        }

        editorConfig.placeholder = '请输入内容';
        editorConfig.MENU_CONF['uploadImage'] = {
            server: uploadURL,
            fieldName: 'file',
            allowedFileTypes: ['image/*'],
            headers: {
                Accept: 'application/json',
            },
            customInsert: function (res , insertFn) {

                // res 即服务端的返回结果
                if (res.code == 200) {
                    var alt = '';
                    layer.msg(res.msg);
                    return insertFn(res.url, alt, res.url)
                }

                layer.msg(res.msg,'error');
            },
        }
        editorConfig.onChange = (editor) => {
            // 过滤掉空行
            const text = editor.getText().replace(/\s+/,'');
            const html = editor.getHtml().replace(/<p>\s+<br\/>\s+<\/p>/i,'');
            const contentStr = JSON.stringify(editor.children);
            console.log(contentStr);

            $('#'+options.id).text(html);
            if (!text || text == '') {
                $('#'+options.id).text('');
            }
        }

        // 检查并合并数据，是否存在
        if (options.editorConfig != 'undefined') {
            editorConfig = $.extend({},editorConfig,options.editorConfig);
        }

        // 检查model
        var mode = options.elem.attr('mode');
        if (mode != 'undefined' && mode != '') {
            options.mode = mode;
        }

        // 创建编辑器
        const editor = E.createEditor({
            selector: '#'+EDITOR,
            config: editorConfig,
            content: [], 
            mode: options.mode
          })

        // 工具栏，
        var toolbarConfig = {};
        if (options.toolbarConfig != 'undefined') {
            toolbarConfig = $.extend({},toolbarConfig,options.toolbarConfig);
        }

        if (options.mode == 'custom' ) {
            options.mode = 'simple';
            toolbarConfig = {
                excludeKeys: ['header1','header2','header3',"italic","bgColor"]
            }
        }
   
        // 创建工具栏
        const toolbar = E.createToolbar({
            editor,
            selector: '#'+TOOLBAR,
            config: toolbarConfig,
            mode: options.mode
        }) 

        // 返回值
        return [E,editor,toolbar];
    });
  }).addcss('modules/editor.css?v=33s', 'skineditorcss');
  
  