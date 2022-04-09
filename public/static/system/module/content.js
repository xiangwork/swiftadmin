/* 内容管理模块 */
layui.define(['jquery','layer'],function (exports) {

    var jquery = layui.jquery;
    var layer = layui.layer;
    var content = {
        tinymce: function (elem) {
            elem = elem || 'content';
            var obj = tinymce.init({
                selector: '#'+elem,
                language:'zh_CN',
                plugins: 'code print preview searchreplace paste autolink directionality visualblocks visualchars fullscreen image link media template code codesample table charmap hr pagebreak nonbreaking anchor quickbars insertdatetime advlist lists wordcount imagetools textpattern emoticons autosave bdmap indent2em autoresize formatpainter axupimgs',
                toolbar: 'code undo redo restoredraft | cut copy paste pastetext table | image axupimgs media print preview bdmap forecolor backcolor formatpainter bold italic underline strikethrough link anchor fullscreen | alignleft aligncenter alignright alignjustify outdent indent  | \
                styleselect formatselect fontselect fontsizeselect | bullist numlist | blockquote subscript superscript removeformat | \
                charmap emoticons hr pagebreak insertdatetime|  indent2em lineheight ',
                height: 650, //编辑器高度
                min_height: 400,
                max_width: 1200,
                importcss_append: true,
                images_upload_handler: function(block, success, failure) {
                    var file = block.blob();
                    var reader = new FileReader();
                    reader.readAsDataURL(file); 
                    reader.onload = function(e) {
                        var formData = new FormData();
                        formData.append('file',file);
                        jquery.ajax({
                            type:'post',
                            url:  _fr4mework.app + '/upload/file',
                            data: formData,                   
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (res) {
                                if (res.code == 200) {
                                    success(res.url);
                                    layer.msg(res.msg);
                                }
                                else {
                                    failure(res.msg);
                                    return;
                                }
                            },// 请求失败触发的方法
                            error:function(XMLHttpRequest, textStatus, errorThrown){
                                failure(textStatus);
                                return;	
                            }
                        });
                    };
                },
                init_instance_callback: function (editor) {
                },
                setup: function(editor){ 
                    editor.on('change',function(){ editor.save(); });
                },
                toolbar_sticky: true,
                relative_urls: false,
                branding: false,
                autosave_ask_before_unload: false,
            });
            return obj;
        },
        xmselect: function(elem, data, initvalue, group = true) // 下拉菜单
        {
            if (!elem) {
                layer.msg('elem error','error');
                return false;
            }

            if (group) {
                return xmSelect.render({
                    el: '#'+elem, 
                    name: elem,
                    tips: '请选择',
                    size: 'small',
                    theme: {
                        color: '#0081ff', 
                    },
                    prop: {
                        name : 'title',
                        value : 'id',
                    },
                    data: data,
                    initValue: initvalue,
                }) 
            }

            else {
                return xmSelect.render({
                    el: '#'+elem, 
                    name: elem,
                    tips: '请选择',
                    height: 'auto',
                    data: data,
                    radio: true,
                    clickClose: true,
                    initValue: initvalue,
                    prop: {
                        value: 'id',
                        name:'title'
                    },
                    tree: {
                        show: true,
                        strict: false,
                        showLine: false,
                        clickExpand: false,
                    },
                    model: { 
                        icon: 'hidden',
                        label: { 
                            type: 'text' 
                        } 
                    },
                    theme: {
                        color: '#1890FF'
                    }
                })
            }
        }
    };

	
	exports('content', content);
});