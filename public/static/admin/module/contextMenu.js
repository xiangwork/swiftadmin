/* 右键菜单模块 */
layui.define(function (exports) {

    var jquery = layui.jquery;
    var rightMenu = "layui-layout-rightMenu";

	var contextMenu = {
		render: function(obj,x,y,z) { 
			if (!obj || typeof obj !== "object") {
                return layer.msg('render参数错误');
            } 

            var css = "left:" + x + "px;top:" + y + "px;";
            var html = "<div class="+rightMenu+" style= "+ css +" >";
            html += this.getHtml(obj,"");
            html += "</div>";
            contextMenu.delete();
            jquery("body").append(html);
            this.setEvent(obj,z);

            var i = jquery(".layui-layout-rightMenu");
            if (x + i.outerWidth() > this.getPageWidth()) { // 用来修复位置
                x -= i.outerWidth()
            }
            if (y + i.outerHeight() > this.getPageHeight()) {
                y = y - i.outerHeight();
                if (y < 0) {
                    y = 0
                }
            }
            // 修改css
            i.css({
                "top": y,
                "left": x
            });

            // 存在子菜单的时候，鼠标移动在上面显示
            jquery(".layui-layout-rightMenu-item.haveMore").on("mouseenter", function () {
                var e = jquery(this).find("li");
                var l = jquery(this).find(".layui-layout-rightMenu-sub");
                var n = e.offset().top;
                var m = e.offset().left + e.outerWidth();
                if (m + l.outerWidth() > contextMenu.getPageWidth()) {
                    m = e.offset().left - l.outerWidth()
                }
                if (n + l.outerHeight() > contextMenu.getPageHeight()) {
                    n = n - l.outerHeight() + e.outerHeight();
                    if (n < 0) {
                        n = 0
                    }
                }
                // 动态显示位置
                jquery(this).find(".layui-layout-rightMenu-sub").css({
                    "top": n,
                    "left": m,
                    "display": "block"
                })
            }).on("mouseleave", function () {
                jquery(this).find(">.layui-layout-rightMenu-sub").css("display", "none")
            })             

        },
        getHtml: function(obj,child){ 

            var html = "";
            for (var i = 0; i < obj.length; i++) {
                var main = obj[i];
                main.menuId = "sa-menu-id-" +  child + i ;

                if (main.subject) {
                    html += '<div class="layui-layout-rightMenu-item haveMore" lay-id="' + main.menuId + '">';
                    html += "<li>";
                    if (main.icon) {
                        html += '<i class="' + main.icon + ' icon"></i>'
                    }
                    html += main.name;     
                    html += '<i class="layui-icon layui-icon-right more"></i>';
                    html += "</li>";
                    html += '<div class="layui-layout-rightMenu-sub" style="display: none;">';
                    html += this.getHtml(main.subject,  child + i);
                    html += "</div>"
                }else {
                    html += '<div class="layui-layout-rightMenu-item" lay-id="' + main.menuId + '">';
                    html += "<li>";
                    if (main.icon) {
                        html += '<i class="' + main.icon + ' icon"></i>'
                    }
                    html += main.name;
                    html += "</li>"
                }

                html += "</div>"; 
                if (main.hr == true) {
                    html += "<hr/>"
                }  
            }
            
            return html
        },
        setEvent:function(obj,z){

            jquery("."+rightMenu).off("click").on("click", "[lay-id]", function (res) {
                res.stopPropagation(); 
                res.preventDefault(); 
                var id = jquery(this).attr("lay-id");
                var main = recursive(id,obj); 
                main.click && main.click(res, z);
                contextMenu.delete();
            })

            function recursive(menuId,obj) {
            
                for (var i in obj) {
                    if (menuId == obj[i].menuId) {
                        return obj[i];
                    }
                    if (obj[i].subject) { 
                      var event = recursive(menuId,obj[i].subject);
                      if (event) {
                        return event;
                      }
                    }
                }
            }
        },
        delete: function() {
            var array = parent.window.frames;
            for (var i = 0; i < array.length; i++) {
                var iframe = array[i];
                try {
                    iframe.layui.jquery('.'+rightMenu).remove()
                } catch (e) {}
            }
            try {
                parent.layui.jquery('.'+rightMenu).remove()
            } catch (e) {}
        },
        getPageHeight: function () { // 获取页面的宽高。
            return document.documentElement.clientHeight || document.body.clientHeight
        },
        getPageWidth: function () {
            return document.documentElement.clientWidth || document.body.clientWidth
        }
    };

    // 点击右键菜单元素后 关闭菜单
    jquery(document).off("click.layui-layout-rightMenu").on("click.layui-layout-rightMenu", function () {
        contextMenu.delete();
    })
	
	exports('contextMenu', contextMenu);
});