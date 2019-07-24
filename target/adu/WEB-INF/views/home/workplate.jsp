<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>${WorkplateTitle}</title>
	<jsp:include page="/WEB-INF/views/include/ltehead.jsp" />
	<script>
		var OBJ;
        function onModify(){
            var title = "修改密码"
            var url = 'home/modifyPwd?id=${baseUser}'
            window.top.document.getElementById("ifrmDtl").src = url;
            window.top.$('#winDtl').dialog({
                width:300,
                height:300,
                closed: false,
                cache: false,
                modal:true,
                title:title
            });
            window.top.$('#winDtl').dialog("open");
        }

        function closeWin(){
            window.top.$('#winDtl').dialog("close");
		}
			function onCancel(){
                window.top.$('#winDtl').dialog("close");
			}
            $ (function () {
                $ ("#ifrmMain").height ($ (document).height () - 202)
                //设置默认打开菜单 如果为一个则默认打开
                // var m = $ (".sidebar-menu>.treeview")
                // if (m.length == 1){
                //     m.addClass ("active")
                // }
                //菜单选择时高亮显示
                // $ (".treeview-menu li").click (function () {
                //     $ (".treeview-menu li").removeClass ("active");
                //     $ (this).addClass ("active");
                // })
                //initMenu (0);
            })
	</script>
</head>
<body>
<div class="container">
	<div id="pf-hd">
		<div class="pf-logo">
			<img src="images/logo.png" alt="logo">
		</div>

		<div class="pf-nav-wrap">
			<!--<div class="pf-nav-ww">-->
			<div class="pf-nav-ww">

				<ul class="pf-nav">

				</ul>
			</div>
			<!-- </div> -->


			<a href="javascript:;" class="pf-nav-prev disabled iconfont">&#xe606;</a>
			<a href="javascript:;" class="pf-nav-next iconfont">&#xe607;</a>
		</div>



		<div class="pf-user">
			<div class="pf-user-photo">
				<img src="easyui/images/main/user.png" alt="">
			</div>
			<h4 class="pf-user-name ellipsis">${baseUser.basePersonName}</h4>
			<i class="iconfont xiala">&#xe607;</i>
			<div class="pf-user-panel">
				<ul class="pf-user-opt">
					<li class="pf-modify-pwd">
						<a href="javascript:onModify()">
							<i class="iconfont">&#xe634;</i>
							<span class="pf-opt-name">修改密码</span>
						</a>
					</li>
					<li class="pf-logout">
						<a href="javascript:;">
							<i class="iconfont">&#xe60e;</i>
							<span class="pf-opt-name">退出</span>
						</a>
					</li>
				</ul>
			</div>
		</div>

	</div>

	<div id="pf-bd">
		<div class="pf-sider-wrap">

		</div>


		<div id="pf-page">

		</div>
	</div>

	<div id="pf-ft">
		<div class="system-name">
			<i class="iconfont">&#xe6fe;</i>
			<span></span>
		</div>
		<div class="copyright-name">
			<span>CopyRight&nbsp;2018</span>
			<i class="iconfont" >&#xe6ff;</i>
		</div>
	</div>
</div>

<div id="mm" class="easyui-menu tabs-menu" style="width:120px;display:none;">
	<div id="mm-tabclose">关闭</div>
	<div id="mm-tabcloseall">关闭所有</div>
	<div id="mm-tabcloseother">关闭其他</div>
</div>
<div id="dlg" class="easyui-dialog" title="业务日志查看" data-options="closed:true,modal:true" style="width:720px;height:490px;padding:10px;display:none;">
	<link rel="stylesheet" type="text/css" href="static/green/css/process.css">
	<div class="time-line">
		<div class="time-item date">
			<div class="content-left first">
				<span>2016-04-25</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>15:58:34</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item time important">
			<div class="content-left">
				<span>17:00:21</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item date">
			<div class="content-left">
				<span>2016-04-26</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>09:21:14</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item last">
			<div class="content-left">
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="easyui/custom/orange/jquery.min.js"></script>
<script type="text/javascript" src="easyui/custom/orange/jquery.easyui.min.js"></script>

<script type="text/javascript">
	var _Menus = ${baseUser.purMenus};
	var topMenu = []
	var index = 0;
    /*$.each (_Menus, function (i, v) {

        if(v.baseTree.parentId == 0){
            index++
            var obj = new Object()
			obj.title = v.title
			obj.icon = v.img
			if(index == 1)
				obj.isCurrent = true
			var menu = []

			if(v.baseTree.isLeaf == 0){
                var in1 = 0
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        in1++
                        var t = new Object()
						t.title = vv.title
						t.icon = vv.img
						if(in1 == 1){
                            t.isCurrent = true
						}
						var mm = []
						if(vv.baseTree.isLeaf == 0){
                            var in2 = 0
                            $.each (_Menus, function (iii, vvv) {
                                if(vvv.baseTree.parentId == vv.id){
                                    in2++
									var tt = new Object()
									tt.title = vvv.title
									if(in1 == 1 && in2 == 1){
									    tt.isCurrent = true
									}
									if(vvv.baseTree.isLeaf == 0){

									}else{
									    tt.href = vvv.url
									}
									mm.push(tt)
								}
							})
						}else{
							t.href = vv.url
						}
						t.children = mm
                        menu.push(t)
					}
				})

			}else{
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
						t.href = vv.url
                        if(ii == 0){
                            t.isCurrent = true
                        }
                        menu.push(t)
                    }
                })
			}
			obj.menu = menu
			topMenu .push(obj)
        }
    })*/

    $.each (_Menus, function (i, v) {
        if(v.baseTree.parentId == 0){
            index++
            var obj = new Object()
            obj.title = v.title
            obj.icon = v.img
            if(index == 1)
                obj.isCurrent = true
            var menu = []

            if(v.baseTree.isLeaf == 0){
                var in1 = 0
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        in1++
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
                        if(in1 == 1){
                            t.isCurrent = true
                        }
                        var mm = []
                        if(vv.baseTree.isLeaf == 0){
                            var in2 = 0
                            $.each (_Menus, function (iii, vvv) {
                                if(vvv.baseTree.parentId == vv.id){
                                    in2++
                                    var tt = new Object()
                                    tt.title = vvv.title
                                    if(in1 == 1 && in2 == 1){
                                        tt.isCurrent = true
                                    }
                                    if(vvv.baseTree.isLeaf == 0){

                                    }else{
                                        tt.href = vvv.url
                                    }
                                    mm.push(tt)
                                }
                            })
                        }else{
                            t.href = vv.url
                        }
                        t.children = mm
                        menu.push(t)
                    }
                })

            }else{
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
                        t.href = vv.url
                        if(ii == 0){
                            t.isCurrent = true
                        }
                        menu.push(t)
                    }
                })
            }
            obj.menu = menu
            topMenu .push(obj)
        }
    })
	console.log(JSON.stringify(topMenu))
    var SystemMenu = topMenu
</script>






<%--<script type="text/javascript" src="easyui/js/menu.js"></script>--%>
<script type="text/javascript" src="easyui/js/main.js"></script>
<!--[if IE 7]>
<script type="text/javascript">
	$(window).resize(function(){
		$('#pf-bd').height($(window).height()-76);
	}).resize();

</script>
<![endif]-->


<script type="text/javascript">
    // $('.easyui-tabs1').tabs({
    //   tabHeight: 44,
    //   onSelect:function(title,index){
    //     var currentTab = $('.easyui-tabs1').tabs("getSelected");
    //     if(currentTab.find("iframe") && currentTab.find("iframe").size()){
    //         currentTab.find("iframe").attr("src",currentTab.find("iframe").attr("src"));
    //     }
    //   }
    // })
    $(window).resize(function(){
        $('.tabs-panels').height($("#pf-page").height()-46);
        $('.panel-body').not('.messager-body').height($(".easyui-dialog").height)
    }).resize();

    var page = 0,
        pages = ($('.pf-nav').height() / 70) - 1;

    if(pages === 0){
        $('.pf-nav-prev,.pf-nav-next').hide();
    }
    $(document).on('click', '.pf-nav-prev,.pf-nav-next', function(){


        if($(this).hasClass('disabled')) return;
        if($(this).hasClass('pf-nav-next')){
            page++;
            $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
            if(page == pages){
                $(this).addClass('disabled');
                $('.pf-nav-prev').removeClass('disabled');
            }else{
                $('.pf-nav-prev').removeClass('disabled');
            }

        }else{
            page--;
            $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
            if(page == 0){
                $(this).addClass('disabled');
                $('.pf-nav-next').removeClass('disabled');
            }else{
                $('.pf-nav-next').removeClass('disabled');
            }

        }
    })

    // setTimeout(function(){
    //    $('.tabs-panels').height($("#pf-page").height()-46);
    //    $('.panel-body').height($("#pf-page").height()-76)
    // }, 200)
    function replace(doc, style) {


        $('link', doc).each(function(index, one) {

            var path = $(one).attr('href').replace(/(static\/)\w+(\/css)/g, '$1' + style + '$2').replace(/(custom\/)\w+(\/)/g, '$1' + style + '$2'),
                sheet;

            if(doc.createStyleSheet) {

                sheet = doc.createStyleSheet(path);
                setTimeout(function() {

                    $(one).remove();

                }, 500)

            } else {

                sheet = $('<link rel="stylesheet" type="text/css" href="' + path + '" />').appendTo($('head', doc));
                sheet = sheet[0];
                sheet.onload = function() {

                    $(one).remove();

                }

            }

        })

        $('img', doc).each(function(index, one) {

            var path = $(one).attr('src').replace(/(static\/)\w+(\/images)/g, '$1' + style + '$2');

            $(one).attr('src', path);

        })

    }
    $('.skin-item').click(function() {

        var color = $(this).data('color');
        replaceAll(color);

    })
    function replaceAll(style) {

        $('iframe').each(function(index, one) {

            try {

                replace(one.contentWindow.document, style)

            } catch(e) {

                console.warn('origin cross');

            }

        })

        replace(document, style)

    }
</script>
</body>
</html>
<div id="winDtl" data-options="title:'待办信息',closed:true,modal:true" class="easyui-window">
	<iframe id="ifrmDtl" style="width: 100%; height: 100%; border: 0;" frameborder="0" src=""></iframe>
</div>

<div id="winDoc" data-options="title:'待办信息',closed:true,modal:true" class="easyui-window">
	<iframe id="ifrmDoc" style="width: 100%; height: 100%; border: 0;" frameborder="0" src="">

	</iframe>
</div>