"use strict";

/*
	*SwiftAdmin 前端模块
    由于前端样式有些地方可能并不符合你已有的模板样式，
    所以此style和js文件仅供参考调用使用。
    在你实际的项目中，请参考一下示例重写模板文件。
*/
layui.use(['jquery','layer','element','form'],function(){

	var $ = layui.jquery;
	var layer = layui.layer;
	var form = layui.form;
	var element = layui.element;

	var _cookie = {},
		_system = {},
		_website = {
			default : function() {
				var uid = this.Cookie.Get('uid') ||"undefined";
				if (uid !== "undefined" || !uid) {
     //                uid = uid.split('.')[1];
     //                uid = uid.replace(/-/g,'+').replace(/_/g,'/');
					// _system.users = JSON.parse(window.atob(uid));

					// // 判断是否过期
					// var timestamp = Math.round(new Date().getTime() / 1000);
					// if (timestamp >= _system.users.exp) {
					// 	_website.Cookie.Set('uid',"undefined");
					// 	return false;
					// }
					
					// var html = '<li class="layui-nav-item"><a class="" href="/user/index" >会员中心</a></li>';
					// $('#login').html(html);
				}

                // 非登录状态下使用默认的头像 
                if (typeof(_system.users) !== "undefined") {
                    _cookie = _system.users.sub;
                }
                else {
                    _cookie = {
                        name: '游客',
                        avatar: '/static/images/user_def.jpg',
                    }
                }

                // 数据用来修改元素使用
                console.log(_cookie);

			}
			,listen: function() {


			}
			,Cookie : { // 获取cookies
				'Set': function(name,value,days){
					var exp = new Date();
					exp.setTime(exp.getTime() + days*24*60*60*1000);
					var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
					document.cookie = name + "=" + escape(value) + ";path=/;expires=" + exp.toUTCString();
				},
				'Get': function(name){
					var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
					if(arr != null){
						return unescape(arr[2]);
						return null;
					}
				},
				'Del': function(name){
					var exp = new Date();
					exp.setTime(exp.getTime()-1);
					var cval = this.Get(name);
					if(cval != null){
						document.cookie = name + "=" + escape(cval)+";path=/;expires="+exp.toUTCString();
					}
				}
            }
            ,'ajax' : function(cid,sid){
                    // 获取变量还有页码
                    var page = $('.load_comment').attr('page');
                    page++;
                    var more = $('.load_comment').prop("outerHTML");
                    var ment = $('.load_comment').remove();
                    var time = '';
                    if (_system.comment_time) {
                        var time = _system.comment_time;
                    }

                    $.get('/index.php/comment/ajax',{cid:cid,sid:sid,time:time,p:page},function(res){

                        if (res.code == 200) {
  
                            var tpl = '';
                            for(let i in res.data) {
                                
                                tpl += '<li class="material_comment clear">';
                                tpl += '<img src="'+ res.data[i].avatar +'" class="u_avatar">'; // cookie face
                                tpl += '<div class="comment-main">';
                                tpl += '<p class="comment-content-name">'+ res.data[i].name +'<span>'+res.data[i].createtime+'</span></p>';
                                tpl += '<div class="comment-main-content"><p>'+res.data[i].content+'</p></div>';
                                tpl += '<div class="comment-btn-container clear">';
                                tpl += '<a href="javascript:;" class="up" id="'+res.data[i].id+'">赞<span class="agree-num">0</span></a>';
                                tpl += '<a href="javascript:;" class="down" id="'+res.data[i].id+'">踩<span class="agree-num">0</span></a>';
                                tpl += '<a href="javascript:;" pid="'+res.data[i].id+'" rid="'+res.data[i].id+'" class="reply-btn" name="'+(res.data[i].name == null ? _system.name : res.data[i].name)+'">回复</a>'; 
                                tpl += '</div>';
                                // 判断子元素
                                if (res.data[i]._child.length) { // 插入父节点
                                    tpl += '<ul class="comment_t_list">';
                                    for (let n in res.data[i]._child) {
                                        tpl += '<li class="material_rep_li">';
                                        tpl += '<div class="clearfix"><span class="r_n fl">'+ res.data[i]._child[n].name;
                                        if (res.data[i]._child[n].rid !== res.data[i]._child[n].pid) {
                                            tpl += '回复：'+res.data[i]._child[n].replyname; 
                                        }
                                        tpl += '</span>';
                                        tpl += '<span pid="'+res.data[i]._child[n].pid+'" rid="'+res.data[i]._child[n].id+'" name="'+res.data[i]._child[n].name+'" class="reply-btn r_t fr" >回复</span>';
                                        tpl += '<span class="r_t fr">'+res.data[i]._child[n].createtime+'</span>';
                                        tpl += '</div><p class="r_c">'+res.data[i]._child[n].content+'</p></li>';
                                    }
                                    tpl += '</ul>';
                                }
                                // 闭合标签
                                tpl += '</li>';
                            }

                            // 插入元素
                            $(".material_comment_lst").append(tpl);

                            // 改变页码
                            $(".material_comment_lst").append(more);
                            $(".load_comment").attr('page',page);
                        }else {
                            layer.msg(res.msg);
                        }

                    },'json');

                    return false;
            }
            
	};

	// 全局事件调用
	_website.event = {
		closeDialog: function(that) { // 关闭窗体
			that = that || this;
			var _type = $(that).parents(".layui-layer").attr("type");
			if (typeof _type === "undefined") {
			    parent.layer.close(parent.layer.getFrameIndex(window.name));
			}else {
			    var layerId = $(that).parents(".layui-layer").attr("id").substring(11);
			    layer.close(layerId);
			    top.layer.close(layerId);
			}
		}
	}

	_website.default();
	_website.listen();


	// 默认监听的操作开始
	$(window).scroll(function () {
	    var a = $(window).scrollTop();
	    if (a >= 50) {
	        $("#header").addClass("layui-nav-scroll")
	    } else {
	        $("#header").removeClass("layui-nav-scroll")
	    }
	});

	// 监听全局事件
    $(document).on("click", "*[sa-event]", function () {
        var name = $(this).attr("sa-event");
        var obj = _website.event[name];
        obj && obj.call(this, $(this));
    });  	

    // 监听其他事件
    $(document).ready(function() {

		// 监听form表单
		form.on('submit(submitIframe)', function(data){
	        var that = $(this), _form = that.parents('form'),
	            _url = _form.attr("action") || false;
	        $.post(_url,
	            data.field,function(res){
	           	if(res.code == 200){ // 存在URL属性则跳转
					top.layer.msg(res.msg, function(){
						if(res.url != "") {
							top.location.href = res.url;
						}
						 _website.event.closeDialog(that);
					});
				}
				else{
					top.layer.msg(res.msg);
				}
	        }, 'json');
	        return false;
		});    	
    })

	// 监听打开窗口
    $(document).on('click',"*[lay-open]",function(){
       var clickthis = $(this),
       		config = {
            url: clickthis.attr('lay-url') || undefined,
            type: clickthis.attr('lay-type') || 2,
            area: clickthis.attr('lay-area') || "auto",
            offset: clickthis.attr('lay-offset') || "25%",
            title: clickthis.attr('lay-title') || false,
            maxmin: clickthis.attr('lay-maxmin') || false,
            auto: clickthis.attr('lay-auto') || "undefined",
        }

        if (config.url.indexOf('#') !== -1 || config.url.indexOf('.') !== -1) {
            if (config.url.indexOf('http://') === -1 && config.url.indexOf('.php') === -1) {
                config.type = 1;
                config.url = $(config.url).html(); 
            }
        }

        // 配置窗口大小
        if (config.area !== "auto") {
        	config.area = config.area.split(',');
        }

        // 打开窗口
        layer.open({
            type: config.type,
            area: config.area,
            title: config.title,
            offset: config.offset,
            maxmin: config.maxmin, 
            shadeClose: true,
            scrollbar: false,
            content:  config.url,
            success:function(layero,index){

            	if (config.type === 1) {
            		form.render();
					form.on("submit(submitPage)",function(post){
                        var that = $(this), 
                        	_pageUrl = that.parents('form').attr('action');
                        
                        // 开始POST提交数据
                        $.post(_pageUrl, 
                            post.field, function(res){

                                if (res.code == 200) {
                                    _website.event.closeDialog(that);
                                }

                                top.layer.msg(res.msg);
                        }, 'json');

                        return false;                        
                	})
            	}
            }
        })
    })

    // 监听ajax操作
	$(document).on("click","*[lay-ajax]",function(obj) {

        var clickthis = $(this),config = {
            url : clickthis.attr('lay-url')|| "undefined",
            type :  clickthis.attr('lay-type') || 'post',
            dataType :  clickthis.attr('lay-dataType') || 'json',
            timeout :  clickthis.attr('lay-timeout') || '6000',
            tableId :  clickthis.attr('lay-table') || clickthis.attr('lay-batch'),
            reload :  clickthis.attr('lay-reload') || false,
        }, defer = $.Deferred();
        
        // 定义初始化对象
        var data = {}

        // 获取拼接参数
        ,packet =  clickthis.attr("lay-data") || null
        ,object =  clickthis.attr("lay-object") || undefined;

        // 传递类数据
        if (typeof object !== "undefined") {
            object = object.split(',');
            for (var i = 0; i < object.length; i++) {
                let ele = object[i].split(":");
                var val = $('.'+ele[1]).val();
                data[ele[0]] = val;
            }
        }

        // 传递对象数据
        if (packet !== 'null') {
            packet = new Function("return "+packet)();
            data = $.extend({},data,packet);
        }

        // 传递input表单数据
        var input = clickthis.attr('lay-input') || undefined;
        if (typeof input !== undefined) {
            var attribute = top.layui.jquery('.'+input).val();
            console.log(attribute);
        }

        // 执行AJAX操作
        $.ajax({
            url: config.url,
            type: config.type,
            dataType: config.dataType,
            timeout: config.timeout,
            data: data, 
            success: function(res) {
            
                if (res.code == 200) { 
                	if (config.reload) {
                		location.reload();
                	}
                } 

                top.layer.msg(res.msg);
            },
            error: function(res) {
            	top.layer.msg('Access methods failure');
            }
        })
         
    })


    // 点击QQ登录 关闭自身
    $('.login-link a,.layui-bind-third').click(function(){
        var type = $(this).attr('data-url');
        parent.layer.open({
            type: 2,
            area: ['600px','600px'],
            title: false,
            scrollbar: true,
            shadeClose: true,
            closeBtn: 0,
            content: [type,'no'],
            success:function(layero,index){
                // TODO...
                var index = layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }
        });
    })


    // 提交评论
    $('.comment-post').on('submit',function(){

        if ($('.comm_content_text').val() == '') {
            layer.msg('评论内容不允许为空！');
            return false;
        }

        var that = $(this);
        $.post(that.attr('action'),that.serialize(),function(res) {
            if (res.code == 200) {
                layer.msg(res.msg);
                var tpl = '<li class="material_comment clear">';
                tpl += '<img src="'+res.data.user.avatar+'" class="u_avatar">';
                tpl += '<div class="comment-main">';
                tpl += '<p class="comment-content-name">'+res.data.user.name+'<span>'+res.data.createtime+'</span></p>';
                tpl += '<div class="comment-main-content"><p>'+res.data.content+'</p></div>';
                tpl += '<div class="comment-btn-container clear">';
                tpl += '<a href="javascript:;" class="up" id="'+res.data.id+'">赞<span class="agree-num">0</span></a>';
                tpl += '<a href="javascript:;" class="down" id="'+res.data.id+'">踩<span class="agree-num">0</span></a>';
                tpl += '<a href="javascript:;" pid="'+res.data.id+'" rid="'+res.data.id+'" class="reply-btn" name="'+res.data.user.name+'">回复</a>';  
                tpl += '</div>';
                tpl += '</li>';
                $(".material_comment_lst").prepend(tpl);
                $('.comm_content_text').val('');
                /**
                  * 设置时间戳, 避免回显再次ajax出现问题
                */
                _system.comment_time = res.data.createtime;
            }else {
                // 评论失败
                $('.comm_content_text').val('');
                layer.msg(res.msg);
            }

        },'json');

        return false;
    });

    // 二级评论框
    $('body').on('click','.reply-btn',function(){
        $("#replyHtml").remove();
        var cid = $('#cid').val();
        var sid = $('#sid').val();                      
        var pid = $(this).attr('pid');
        var rid = $(this).attr('rid');
        _cookie.replyname = $(this).attr('name');
        var replyHtml = '<form id="replyHtml" action="/index.php/comment/insert">';
            replyHtml += '<input type="hidden" name="cid" value="'+cid+'">';
            replyHtml += '<input type="hidden" name="sid" value="'+sid+'">';
            replyHtml += '<input type="hidden" name="pid" value="'+pid+'">';
            replyHtml += '<input type="hidden" name="rid" value="'+rid+'">';
            replyHtml += '<textarea id="comm_content_text" class="comm_content_text" name="content" placeholder="@';
            replyHtml += $(this).attr('name') + '" style="height: 80px;width:98%;"></textarea>';
            replyHtml += '<div class="clear"><input type="submit" class="reply-post" value="回复" ></div></form>';
        $(this).parent().parent().append(replyHtml);
    });

    // 二级评论提交
    $('body').on('submit','#replyHtml',function(){

        if ($('#comm_content_text').val() == '') {
            layer.msg('回复内容不允许为空！');
            return false;
        }


        var $this = $(this); // 查找父节点
        $.post($this.attr('action'),$this.serialize(),function(res){

            if (res.code == 200) { // 评论成功
                layer.msg(res.msg);
                if (!$this.parents('.comment-main').children('.comment_t_list').length) {
                    $this.parents('.comment-main').append('<ul class="comment_t_list"></ul>');
                }                           
                var tpl = '<li class="material_rep_li">';
                tpl += '<div class="clearfix"><span class="r_n fl">'+ res.data.user.name;     
                if (res.data.rid !== res.data.pid) {
                    tpl += '回复：'+_cookie.replyname; // 这里可自行去解决，反正你也得重写JS代码，毕竟这个不适合你的站点。
                }
                tpl += '</span>';
                tpl += '<span pid="'+res.data.pid+'" rid="'+res.data.id+'" name="'+res.data.user.name+'" class="reply-btn r_t fr" >回复</span>';
                tpl += '<span class="r_t fr">'+res.data.createtime+'</span>';
                tpl += '</div><p class="r_c">'+res.data.content+'</p></li>';
                $('.comment_t_list').append(tpl);
                $("#replyHtml").remove();
            }else {
                // 评论失败
                $("#replyHtml").remove();
                layer.msg(res.msg);
            }
            
        },'json');

        return false;
    }); 


    // 请求表情包
    $('.face i').on('click',function(obj){

        // 判断窗体是否开启
        if ($('.face-util').css('display') == 'block') {
            $(".face-util").css("display", "none");
            return false;
        }

        var left = $('.face').offset().left;
        var top = $('.face').offset().top + 33;

        /*
            表情包渲染数据后保存在本地！~
        */
        if (!$('.face-util').length) {

            // 表情包为本地存储，
            // 你可以自行增加时间检测，防止一直缓存
            var html = layui.data('facePacket').face || undefined;
            if (html == undefined) {
                $.get('/index.php/comment/getfacepacket','',function(res){
                    if (res.code == 200) {

                        html = '<div class="face-util" style="display:block;position:absolute;"><ul class="layui-clear">';
                        for(let i in res.data) { // 创建表情
                            html += '<li title="' + res.data[i].v +'"><img src="/static/images/face/'+res.data[i].k+'.gif" alt="'+res.data[i].v+'"></li>';
                        }

                        html += '</ul></div>';

                        // 本地存储
                        layui.data('facePacket',{
                            key: 'face',
                            value: html
                        });
                    }

                },  'json');
            }

            // 注意插入的元素位置会导致位置错误
            $('#content').append(html);
            $(".face-util").css({left: left,top: top,display: "block",position:"absolute"});
        }

        // 调整位置
        $(".face-util").css({
            left: left,
            top: top,
            display: "block",
            position:"absolute"
        });
    });

    // 点击表情
    $('body').on('click','.face-util ul li',function(){
        $(".face-util").css("display", "none");
        $(".comm_content_text").val($(".comm_content_text").val() + $(this).attr('title'));
    });

    // 刷新加载
    $('body').on('click','.load_comment',function(){
        _website.ajax($('#cid').val(),$('#sid').val());
    });

    // 监听顶踩
    $('body').on('click','.comment-btn-container .up,.comment-btn-container .down',function(){
        var $this = $(this);
        var id    = $this.attr('id');
        var type  = $this.attr('class');
        
        $.get('/index.php/upDown/show',{id:id,model:'system.comment',type: type},function(res){
            if (res.code == 200) {
                var total = $this.children('span').text();
                total++;
                $this.children('span').text(total);
            }
            layer.msg(res.msg);
            
        },'json');
        return false;                           
    });

})

function openWindow(obj) {
    window.open(layui.$(obj).attr("data-url"), "_blank", "width=600,height=600,top=100px,resizable=no")
}
