/* 内容管理模块 */
layui.define(function (exports) {

    var admin = layui.admin;
    var jquery = layui.jquery;

    var baseUrl = window.location.href.split("://")[1],
    _begin = baseUrl.indexOf('/'),
    _end   = baseUrl.indexOf('.php')+4,
    _header = baseUrl.substring(_begin,_end),
    uploadUrl = _header + '/upload/upload';

    var content = {
        tinymce: function (elem) {
            elem = elem || 'content';
            tinymce.init({
                selector: '#'+elem,
                language:'zh_CN',
                plugins: 'print preview searchreplace autolink directionality visualblocks visualchars fullscreen image link media template code codesample table charmap hr pagebreak nonbreaking anchor insertdatetime advlist lists wordcount imagetools textpattern help emoticons autosave bdmap indent2em autoresize formatpainter axupimgs',
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
                            url: uploadUrl,                
                            data: formData,                   
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (res) {
                                if (res.code == 200) {
                                    success(res.url);
                                    top.layui.iziToast.success({
                                        message: res.msg,
                                    });
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
                autosave_ask_before_unload: false,
            });
        },
        xmselect: function(elem, data, initvalue, group = true) // 下拉菜单
        {
            if (!elem) {
                layui.iziToast.error({
                    message: 'elem error',
                })

                return false;
            }

            if (group) {
                return xmSelect.render({
                    el: '#'+elem, 
                    name: elem,
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