<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <jsp:include page="/WEB-INF/views/include/head4.jsp" />
    <title>固定资产-编辑</title>
    <script type="text/javascript">
        //保存
        function onSave () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }
            var para = $ ("#mainForm").serialize ();
            $.post ('goods/save', $ ("#mainForm").serialize (), function (result, status) {
                if (parent.onSaveOk){
                    parent.onSaveOk (result.entity)
                }
            });
        }
        //返回
        function onCancel () {
            var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
            parent.layer.close (index); //再执行关闭
        }/*
    //选择部门
    function onSelOrg () {
	    layer.open ({
	        type : 2,
	        title : "选择类别",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '350', '420'
	        ],
	        content : 'goodstype/sel' //iframe的url
	    });
    }*/
        //选择部门回调方法
        function onSelOrgOk (node) {
            $ ("#typeId").val (node.id)
            $ ("#type").val (node.name)
            layer.closeAll ()
        }
        //数据字典回调函数,初始化后为其赋值
        function dictCallBack (container) {
            <%--if (container == "title"){--%>
            <%--$ ("#title").select2 ("val", "${o.title}");--%>
            <%--}--%>
            <%--else if (container == "education"){--%>
            <%--$ ("#education").select2 ("val", "${o.education}");--%>
            <%--}--%>
            <%--else if (container == "gender"){--%>
            <%--$ ("#gender").select2 ("val", "${o.gender}");--%>
            <%--}--%>
        }




        $ (function () {
            //加载select特效
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#startdt").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#startdt').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#startdt').inputmask ("yyyy-mm-dd");


            //为日期设置格式输入
            $ ("#invoicedt").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#invoicedt').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#invoicedt').inputmask ("yyyy-mm-dd");


            $("#authorId").val("${baseUser.id}")
            $("#author").val("${baseUser.basePersonName}")
        })
    </script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
        }
        ul, li {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .box {
            width: 300px;
            height: 180px;
            border: 2px solid #000000;
            padding:8px;
            margin: auto;
            position: relative;
        }
        .top{ width:280px; height:56px; border-bottom:1px solid #000;}
        .logo{ width:246px; float:left; height:56px; font:16px/24px 微软雅黑; color:#330; margin-left: 4px}
        .img_box{ float:right; width:40px; height:40px; margin-top:4px;}
        .img_box img{ width:100%; height:100%;}
        .test_box{ width:288px; height:104px; margin-top:3px;}
        .test_box ul li{ float:left; height:26px;}
        .test_box_tit{ width:57px; font:12px/26px 黑体; color:#000;}
        .test_box_text{ width:87px; font:11px/26px 宋体; color:#000;}
    </style>
</head>

<body>
<div style="height: 30px"></div>
<div class="box">
    <div class="top">
        <div class="logo">中共邯郸市委组织部<br />固定资产标签</div>
        <div class="img_box" id="qrcode" style="position: absolute;right: 18px;"></div>
    </div>
    <div class="test_box">
        <ul>
            <li class="test_box_tit">ID</li>
            <li class="test_box_text">${o.id}</li>
            <li class="test_box_tit">设备名称</li>
            <li class="test_box_text">${o.name}</li>
            <li class="test_box_tit">设备编号</li>
            <li class="test_box_text">${o.sn}</li>
            <li class="test_box_tit">领用人</li>
            <li class="test_box_text">${o.keeper}</li>
            <li class="test_box_tit">单位</li>
            <li class="test_box_text">${o.unit}</li>
            <li class="test_box_tit">类别</li>
            <li class="test_box_text">${o.type}</li>
            <li class="test_box_tit">规格型号</li>
            <li class="test_box_text">${o.spec}</li>
            <li class="test_box_tit">购买日期</li>
            <li class="test_box_text" id="date">服务器</li>
        </ul>
    </div>
</div>
<script>
    var date ="${o.invoicedt}";
    $("#date").html(date.substring(0,10));
    //购买日期
</script>
</body>
</html>

<script>
    $("#qrcode").qrcode({
        width:50,
        height:50,
        //text:"http://192.168.10.119:8000${pageContext.request.contextPath}/goods/erWeiMa?id=${o.id}"
        text:"http://www.hdswzzb.com/hd/goods/erWeiMa?id=${o.id}"
    })
</script>