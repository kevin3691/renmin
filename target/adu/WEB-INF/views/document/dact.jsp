<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<link href="easyui/css/process.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>

	<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<title>公文-编辑</title>
	<style>
		html, body {
			margin: 0;
			padding: 0;
		}
		.table_box {
			width: 794px;
			height: 1000px;
			margin: auto;
		}
		.table_tit {
			font: 20px/24px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit2 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit3 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit4 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit5 span {
			display: block;
			width: 20px;
			margin-left: 24px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}

		.table_tit1 {
			font: 19px 仿宋;
			text-align: center;
			border-collapse:collapse;
		}
		.dtable {
			margin-left: 105px;
			border: 2px solid #000;
			border-bottom:1px solid #000;
		}
		.dtable1 {
			margin-left: 105px;
			border: 2px solid #000;
			border-top:1px solid #000; margin-top:-1px;
		}
		.dtable th, .dtable td { border-bottom: 1px solid #000;border-right: 1px solid #000;
		}
		.dtable1 th, .dtable1 td {border-right: 1px solid #000;
		}
		.title {
			width: 794px;
			text-align: center;
			text-decoration: underline;
			font: 33px 黑体;
			font-weight: bold;
			margin-top: 106px;
		}
		.title span{font: 33px 宋体;
			font-weight: bold;}
		.mingcheng {
			width: 794px;
			height: 18px;
			margin-top: 30px;
			margin-bottom: 10px
		}
		.mingcheng div {
			width: 627px;
			margin-left: 105px;
		}
		.mc_left {
			font: 19px 仿宋;
			margin-left: 12px;
			float: left;
		}
		.mc_right {
			font: 19px 仿宋;
			margin-right: 35px;
			float: right;
		}
		.textarea {
			width: 98%;
			height: 99%;
			border: 0;
			margin-left: 1%;
			font: 18px/27px 宋体;
		}
		.input_text {
			width: 98%;
			height: 99%;
			border: 0;
			margin-left: 1%;
			font: 18px 宋体;
		}
	</style>
<script type="text/javascript">
    function loadGrid () {
        $ ("#grid").jqGrid (
            {
                url : "comm/attachment/list4",
                postData:{
                    refNum: "${o.id}"
                },
                height : $ (document).height () - 380,
                rownumbers : true,
                colModel : [

                    {
                        label : '标题',
                        name : 'title',
                        index : 'title',
                        width : 200
                    },
                    {
                        label : ' ',
                        name : 'id',
                        width : 140,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, options, row) {
                            var btn = "";

                            btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\')" title="">查看</a>'
                            if(value != "${o.fileId}")
                                btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                            return btn;
                        }
                    }
                ],
                rowNum : 3,
                rowList : [
                    3
                ],
                pager : '#pager',
                sortname : 'id',
                sortorder : "asc",
            });
        jQuery ("#grid").jqGrid ('bindKeys', {
            "onEnter" : function (rowid) {
                //alert ("你enter了一行， id为:" + rowid)
            },
            "onRightKey" : function (rowid) {
                onDown (rowid)
            },
            "onLeftKey" : function (rowid) {
                onDel (rowid)
            },
            "onSpace" : function (rowid) {
                onShow (rowid)
            }
        });
    }
function onPrint() {

    if($("#title").val() == ""){
        alert("请输入标题！")
    }



    if($("#org").val() == ""){
        alert("请选择来文单位！")
    }
    //表单验证
    if (!$ ('#mainForm').validate ().form ()){
        return false;
    }
    var ue = UE.getEditor ('editor');
    $ ("#content").val (ue.getContent ());

    var para = $ ("#mainForm").serialize ();
    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
            var _URL = "document/print?id=${o.id}"
            window.open(_URL)
        }
        //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
        //document.location.reload();
    );


}

	//保存
    function onSave (person) {

        // //表单验证
        // if (!$ ('#mainForm').validate ().form ()){
        //    return false;
        // }
        // if($("#title").val() == ""){
        //    alert("请输入标题！")
        // return false;
        // }
        //
        //
        //
        // if($("#org").val() == ""){
        //    alert("请选择来文单位！")
        //    return false;
        // }
        // var ue = UE.getEditor ('editor');
        // $ ("#content").val (ue.getContent ());
        //
        // var para = $ ("#mainForm").serialize ();
        var content = UE.getEditor ('u${ins.stepId}').getContent ();
        $.post ('document/act_ins',{"docId":${o.id},"content":content,"insId":${ins.id}}, function (result, status) {
                document.location = 'document/dindex'
            }
            //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
            //document.location.reload();
        );
    }


    function onGui () {

        $.post ('document/finish_ins',{"docId":${o.id},"insId":${ins.id}}, function (result, status) {
                document.location = 'document/dindex'
            }
            //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
            //document.location.reload();
        );
    }

    function onDu () {

        $.post ('document/du_ins',{"docId":${o.id},"insId":${ins.id}}, function (result, status) {
                document.location.reload();
            }
            //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
            //document.location.reload();
        );
    }
	
    function onSel(){
        var title = "选择经办人"
        var l = layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'base/user/sel'
        });
        layer.full(l)
    }


    //返回
    function onCancel () {
	    /* var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭    */
    	//document.location = 'document/index'
    	window.history.back()
		//parent.parent.layer.closeAll();
        //window.top.onCancel();
    }

    //选择部门回调方法 
    function onPersonSelOk (node) {
        // $ ("#jbrId").val (node.id)
        // $ ("#jbr").val (node.name)
		onSave(node)
	    layer.closeAll ()
    }
    function onDel (id) {
	    layer.confirm ('确定要删除该附件？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/attachment/del", {
			    id : id
		    }, function () {
			    $ ("#grid").datagrid ("reload");
		    });
		    layer.closeAll ();
	    });
    }
  //查看
    function onShow (url, fileExt) {
	    url = _BasePath + "/" + url;
	    if (".jpg;.gif;.bmp;.png".indexOf (fileExt) >= 0){
		    showPhoto (url)
	    }
	    else{
		    window.open (url, "att", "")
	    }
    }
    function showPhoto (url) {
	    layer.photos ({
		    photos : {
		        "title" : "", //相册标题
		        "id" : 0, //相册id
		        "start" : 0, //初始显示的图片序号，默认0
		        "data" : [ //相册包含的图片，数组格式
			        {
			            "alt" : "图片名",
			            "pid" : 0, //图片id
			            "src" : url, //原图地址
			            "thumb" : "" //缩略图地址
			        }
		        ]
		    }
	    });
    }
    function onUpload (flag) {
	    flag = flag || "";
	    var title = "上传附件";
	    var url = 'comm/attachment/upload';
	    if (flag == "preview"){
		    url = 'comm/attachment/preUpload';
	    }
	    else if (flag == "corpper"){
		    url = 'comm/attachment/cropUpload';
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '450'
	        ],
	        content : url
	    //iframe的url
	    });
    }
    function onSelfUpload () {
    	if("${o.id}" == 0)
    	{
    		alert("请先保存再上传附件！");
    		return;
    	}
	    $ ("input[name='file']").click ();
    }
    //上传完附件后执行
    function onUploadSucess () {
	    onQ ();
    }
    //查询
    function onQ () {
        var para = {

        };
        $ ("#grid").jqGrid ("setGridParam", {
            postData : para
        }).trigger ("reloadGrid");
    }
    
    
    //数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    if (container == "lwlx"){
		    $ ("#lwlx").select2 ("val", "${o.lwlx}");
	    }
	    <%--else if (container == "lwfs"){--%>
		    <%--$ ("#lwfs").select2 ("val", "${o.lwfs}");--%>
	    <%--}--%>
	    <%--else if (container == "level"){--%>
		    <%--$ ("#level").select2 ("val", "${o.level}");--%>
	    <%--}--%>
	    else if (container == "miji"){
		    $ ("#miji").select2 ("val", "${o.miji}");
	    }
	    
    }
	function onFinish(){
		/* if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    } */
	    if("${o.id}" == 0)
		{
			alert("请先保存再提交！");
			return false;
		}
		layer.confirm ('确定不批转？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
	    	$.post('document/finish', {"descr":$("#descr").val(),"insId":"${ins.id}"}, function(result,
    				status) {
    			document.location = 'document/ins'
    		});
		    layer.closeAll ();
	    });
		
	}

//ueditor 上传完成后回调
function ueSimpleUploadCallback(json){
    $.post(_BasePath + "comm/uploader/saveAs",{url:json.url},function(result,stts){
        //alert(result+"\n\r"+stts)
    })
}
    var lwdw  = []
	function getLwdw(){
        $.post ("base/dict/listBySym", {
            parentSym : "lwdw"
        }, function (rslt) {
            if (rslt.rows == null)
                return;
            var rows = rslt.rows;
            for (var i = 0; i < rows.length; i++){
                var entity = new Object()
				entity.title = rows[i].title
				entity.id = rows[i].id
				entity.value = rows[i].title
				lwdw.push(entity)
            }
            $( "#org" ).autocomplete({
                minLength: 1,
                source: lwdw,
                focus: function( event, ui ) {
                    $( "#org" ).val( ui.item.title );
                    return false;
                },
                select: function( event, ui ) {
                    $( "#org" ).val( ui.item.title );
                    $( "#orgId" ).val( ui.item.id );
                    return false;
                }
            })
                .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
                return $( "<li>" )
                    .append( "<a>" + item.title + "</a>" )
                    .appendTo( ul );
            };

        })
	}

	function bindType(){
        $.post ("workflow/workflow/list", {
            parentSym : "lwdw"
        }, function (rslt) {
            if (rslt.rows == null)
                return;
            var rows = rslt.rows;
            var html = ""
            for (var i = 0; i < rows.length; i++){
                html += '<option value='+ rows[i].id +'>'+ rows[i].title +'</option>'
            }
            $("#type").append(html)
            $ ("#type").select2 ("val", "${o.type}");
            initIns()
        })
	}
    function initIns(){
        $.post ("workflow/step/list", {
            wfWorkflowId : $ ("#type").select2("val")
        }, function (rslt) {
            if (rslt.rows == null)
                return;
            var rows = rslt.rows;
            var html = ""

            var width = 100/(rows.length + 2)
            var wcc = "width: "+width+"%"
			var ccc = 'passed'

			var hh = '';
            for (var i = 0; i < rows.length; i++){

                var cc = "laters"
                var cl = "last"
                var index = i +1
                if(i == rows.length-1){
                    cc = "laters"

                }
                if(rows[i].id < ${ins.stepId}){
                    cc = "passed"

				}

                if(rows[i].id == ${ins.stepId - 1}){
                    cc = "curr-pre"
                }
                if(rows[i].id == ${ins.stepId}){
                    cc = "current"
					if(i == 0){
                        ccc = 'curr-pre'
					}
                }
                if(99 == ${ins.stepId}){
                    if(i == rows.length -1)
					{
                        cc = "curr-pre"
                        cl = "current"
					}
                }

                hh += '<li style="'+wcc+'">'
                hh += '<div class="item '+ cc +'"><div class="step">'
                hh += '<i>'+index+'</i><label>'+rows[i].title+'</label>'
                hh += '</div><span></span></div></li>'
            }

            html += '<li style="'+wcc+'">'
            html += '<div class="item '+ ccc +'"><div class="step">'
            html += '<i>1</i><label>新建公文</label>'
            html += '</div><span></span></div></li>'

			html += hh

            html += '<li style="'+wcc+'">'
            html += '<div class="item '+cl+'"><div class="step">'
            html += '<i>'+ (rows.length + 1)+'</i><label>归档</label>'
            html += '</div><span></span></div></li>'

            $("#ins").html(html)

        })
    }


    function iniflowinfo(){
        $.post ("workflow/instance/list", {
            refNum: ${o.id},
			isActive:5
        }, function (rslt) {
            if (rslt.rows == null)
                return;
            var rows = rslt.rows;
            var html = ""


            for (var i = 0; i < rows.length; i++){
				var index = i + 1
                html += '<li class="item"><div class="product-info">'
				html += '<a href="javascript:void(0)" class="product-title">'
				html += "第<span style='color:darkred'>" + index + "</span>步：" +rows[i].stepName
				html += '<span class="label label-warning pull-right">'+rows[i].actorName+'</span></a>'
				html += '<span class="product-description">'
				html += '开始于：'+jsonDateTimeFormatter(rows[i].recordInfo.createdAt,2)+'<br>'
                if(rows[i].actAt != "null" && rows[i].actAt != null){
                    html += '结束于：'+jsonDateTimeFormatter(rows[i].actAt,2)
                }

				html += '</span></div></li>'

            }


            $("#flowInfo").html(html)

        })
    }

    function initText(){
	   //var html = '<textarea class="form-control" required id="content" name="content" rows=3></textarea>'
        UE.getEditor ('u${ins.stepId}');
        <%--$("#${ins.stepId}").html(html)--%>
        <c:forEach items="${list}" var="in">
        if(  '${in.descr}' != null &&  '${in.descr}' != "" && '${ins.id}' != '${in.id}'){
            html = '<br>'
            html += '${in.descr}'
            <%--html += '<div style="text-align: right"><span style="text-align: right">'--%>
            <%--html += '<br><br>'--%>
            <%--html +='姓名：${in.actorName}'--%>
            <%--html += '&nbsp;&nbsp;&nbsp;&nbsp;'--%>
            <%--html +='时间：${in.actAt}'.replace(".0","")--%>
            <%--html += '<span></div>'--%>
            $("#${in.stepId}").html(html);
        }




        </c:forEach>

    }

    $ (function () {
    	<%--UPLOADER.formData = {--%>
    		    <%--applyTo : "${o.category}",--%>
    		    <%--refNum : "${o.id}"--%>
    	    <%--}--%>
    	<%--UPLOADER.init ();--%>
	    //加载select特效
	    $ (".select2").select2 ();

        bindType()

	    //赋值

        $("#type").on("select2:select",function(){
            $('.table_box').css("display","none")
            var data = $(this).val();

            $("#type" +data).css("display","block")
            initIns()
        });
	    loadGrid();
	    if("${o.id}" > 0){

		}
        iniflowinfo()
        initText()
        $("#type${o.type}").css("display","block")

        if("${ins.stepId}" == 99){
            $("#btnSave").hide()
            if("${ins.isDu}"  > 0)
                $("#btnDu").hide()
            if("${ins.isGui}"  > 0)
                $("#btnGui").hide()
        }else{
            $("#btnDu").hide()
            $("#btnGui").hide()
        }
    })
</script>


</head>

<body>

<div id="form">
	<ul class="process clearfix" id="ins">

	</ul>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<div id="uploader" class="wu-example">
			<!--用来存放文件信息-->
			<div id="thelist" class="uploader-list"></div>
			<div class="btns" style="display:none;">
				<div id="picker">选择文件</div>
				<button id="ctlBtn" class="btn btn-default">开始上传</button>
			</div>
		</div>
		<form id="mainForm" class="form-horizontal">

			<div class="col-sm-9">
				<div class="table_box" id="type2"  style="display:none">
				<div class="title">文件呈批笺${o.colSym}（号）</div>
				<div class="mingcheng">
					<div> <span class="mc_left">中共邯郸市委组织部办公室</span>  <span class="mc_right">
			<fmt:formatDate pattern="yyyy年MM月dd日"
							value="${o.lwsj}" />
		</span></div>
				</div>
				<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
					<tr>
						<td width="72" height="55" class="table_tit">来&nbsp;文<br />
							单&nbsp;位</td>
						<td width="152" class="table_tit1">${o.org}</td>
						<td width="60" class="table_tit" >来&nbsp;文
							编&nbsp;号</td>
						<td width="155" class="table_tit1" >${o.lwbh}</td>
						<td width="47" class="table_tit" >密<br />级</td>
						<td width="50" class="table_tit1">${o.miji}</td>
						<td width="34" class="table_tit" >页数</td>
						<td width="56" class="table_tit1" >${o.page}</td>
					</tr>
					<tr>
						<td width="72" height="55" class="table_tit">来&nbsp;文
							标&nbsp;题</td>
						<td height="15" colspan="7" class="table_tit1">${o.title}</td>
					</tr>
					<tr>
						<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>意<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        见</span></td>
						<td  colspan="7" id="8" valign="top">
							<script id="u8" type="text/plain" style="width:100%;height: 125px;"></script>
                            </td>
                            </tr>
                            <tr>
                            <td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
                                <br />
                                <br />
                                <br />
                                见</span></td>
                            <td colspan="7" id="7" valign="top"><script id="u7" type="text/plain" style="width:100%;height: 125px;"></script></td>
					</tr>
					<tr style="border-bottom:none;">
						<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
						<td colspan="7"  style="border-bottom:none;" id="6" valign="top"><script id="u6" type="text/plain" style="width:100%;height: 125px;"></script></td>
					</tr>
				</table>
				<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
					<tr>
						<td width="71" class="table_tit1">经办人</td>
						<td width="90">${o.jbr}</td>
						<td width="94" class="table_tit1">联系电话</td>
						<td width="136">${o.phone}</td>
						<td width="222" class="table_tit1">${o.descr}</td>
					</tr>
				</table>
			</div>


				<div class="table_box" id="type3" style="display:none">
					<div class="title" style="text-decoration:none">情&nbsp;况&nbsp;报&nbsp;告</div>
					<div class="mingcheng">
						<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																														  value="${o.lwsj}" /></span> </div>
					</div>
					<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
						<tr>
							<td width="72" height="55" class="table_tit">处室</td>
							<td width="152" class="table_tit1">${o.org}</td>
							<td width="60" class="table_tit" >内部保密</td>
							<td width="155" class="table_tit1" >${o.miji}</td>
							<td width="47" class="table_tit" >页<br />数</td>
							<td width="50" class="table_tit1">${o.page}</td>
							<td width="34" class="table_tit" >编号</td>
							<td width="56" class="table_tit1" >${o.lwbh}</td>
						</tr>
						<tr>
							<td width="72" height="55" class="table_tit">报&nbsp;告
								主&nbsp;题</td>
							<td height="15" colspan="7" class="table_tit1">${o.title}</td>
						</tr>
						<tr>
							<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>批<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        示</span></td>
							<td  colspan="7" id="11" valign="top"><script id="u11" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
						<tr>
							<td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
							<td colspan="7" id="10" valign="top"><script id="u10" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
						<tr style="border-bottom:none;">
							<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>处<br />
        <br />室</span><span>意<br />

        <br />
        见</span></td>
							<td colspan="7"  style="border-bottom:none;" id="9" valign="top"><script id="u9" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
					</table>
					<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
						<tr>
							<td width="73" class="table_tit1">经办人</td>
							<td width="93">${o.jbr}</td>
							<td width="96" class="table_tit1">联系电话</td>
							<td width="141">${o.phone}</td>
							<td width="227" class="table_tit1">${o.descr}</td>
						</tr>
					</table>
				</div>



				<div class="table_box" id="type4" style="display:none">
					<div class="title">明传电报呈批笺（<span>${o.colSym}</span>号）</div>
					<div class="mingcheng">
						<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																														  value="${o.lwsj}" /></span> </div>
					</div>
					<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
						<tr>
							<td width="72" height="55" class="table_tit">来&nbsp;文<br />
								单&nbsp;位</td>
							<td width="152" class="table_tit1">${o.org}</td>
							<td width="60" class="table_tit" >来&nbsp;文
								编&nbsp;号</td>
							<td width="155" class="table_tit1" >${o.lwbh}</td>
							<td width="47" class="table_tit" >密<br />级</td>
							<td width="50" class="table_tit1">${o.miji}</td>
							<td width="34" class="table_tit" >页数</td>
							<td width="56" class="table_tit1" >${o.page}</td>
						</tr>
						<tr>
							<td width="72" height="55" class="table_tit">来&nbsp;文
								标&nbsp;题</td>
							<td height="15" colspan="7" class="table_tit1">${o.title}</td>
						</tr>
						<tr>
							<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>意<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        见</span></td>
							<td  colspan="7" id="14" valign="top"><script id="u14" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
						<tr>
							<td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
							<td colspan="7" id="13" valign="top"><script id="u13" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
						<tr style="border-bottom:none;">
							<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
							<td colspan="7"  style="border-bottom:none;" id="12" valign="top"><script id="u12" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
					</table>
					<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
						<tr>
							<td width="71" class="table_tit1">经办人</td>
							<td width="90">${o.jbr}</td>
							<td width="94" class="table_tit1">联系电话</td>
							<td width="136">${o.phone}</td>
							<td width="222" class="table_tit1">${o.descr}</td>
						</tr>
					</table>
				</div>


				<div class="table_box" id="type5" style="display:none">
					<div class="title">文&nbsp;件&nbsp;呈&nbsp;批&nbsp;笺（${o.colSym}号）</div>
					<div class="mingcheng">
						<div> <span class="mc_left">中共邯郸市委组织部办公室</span><span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																											  value="${o.lwsj}" /></span>   </div>
					</div>
					<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
						<tr>
							<td width="72" height="55" class="table_tit">来&nbsp;文<br />
								单&nbsp;位</td>
							<td width="152" class="table_tit1">${o.org}</td>
							<td width="60" class="table_tit" >来&nbsp;文
								编&nbsp;号</td>
							<td width="155" class="table_tit1" >${o.lwbh}</td>
							<td width="47" class="table_tit" >密<br />级</td>
							<td width="50" class="table_tit1">${o.miji}</td>
							<td width="34" class="table_tit" >页数</td>
							<td width="56" class="table_tit1" >${o.page}</td>
						</tr>
						<tr>
							<td width="72" height="55" class="table_tit">来&nbsp;文
								标&nbsp;题</td>
							<td height="15" colspan="7" class="table_tit1">${o.title}</td>
						</tr>
						<tr>
							<td width="72" height="104" class="table_tit2"><span>部务会成员</span><span>圈<br />
        <br />
        <br />
        <br />
        阅</span></td>
							<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
								<tr>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none; border-right:none;"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td width="72" height="87" class="table_tit">签&nbsp;名</td>
							<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
								<tr>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none; border-right:none;"></td>
								</tr>
							</table></td>
						</tr>
						<tr>
							<td width="72" height="55" class="table_tit">时&nbsp;间</td>
							<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
								<tr>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none;"></td>
									<td style=" border-bottom:none; border-right:none;"></td>
								</tr>
							</table></td>
						</tr>
						<tr>
							<td width="72" height="220" class="table_tit5"><span>领<br /><br />导<br /><br />批<br /><br />示</span></td>
							<td colspan="7" id="17" valign="top"><script id="u17" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
						<tr style="border-bottom:none;">
							<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
							<td colspan="7"  style="border-bottom:none;" id="16" valign="top"><script id="u16" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
					</table>
					<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
						<tr>
							<td width="71" class="table_tit1">经办人</td>
							<td width="90">${o.jbr}</td>
							<td width="94" class="table_tit1">联系电话</td>
							<td width="136">${o.phone}</td>
							<td width="222" class="table_tit1">${o.descr}</td>
						</tr>
					</table>
				</div>



				<div class="table_box" id="type6" style="display:none">
					<div class="title">密码电报呈批笺（<span>2018</span>）${o.colSym}号</div>
					<div class="mingcheng">
						<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																														  value="${o.lwsj}" /></span> </div>
					</div>
					<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
						<tr>
							<td width="72" height="55" class="table_tit">来&nbsp;文<br />
								单&nbsp;位</td>
							<td width="217" class="table_tit1">${o.org}</td>
							<td width="64" class="table_tit" >来&nbsp;文
								编&nbsp;号</td>
							<td width="190" class="table_tit1" >${o.lwbh}</td>
							<td width="40" class="table_tit" >密<br />级</td>
							<td width="44" class="table_tit1">${o.miji}</td>
						</tr>
						<tr>
							<td width="64" height="55" class="table_tit">来&nbsp;文
								标&nbsp;题</td>
							<td height="15" colspan="5" class="table_tit1">${o.title}</td>
						</tr>
						<tr>
							<td width="64" height="400" class="table_tit5"><span>领<br />
        <br />
        导<br />
        <br />
        批<br />
        <br />
        示</span></td>
							<td  colspan="5" id="19" valign="top"><script id="u19" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>

						<tr style="border-bottom:none;">
							<td width="64" height="170" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
							<td colspan="5"  style="border-bottom:none;" id="18" valign="top"><script id="u18" type="text/plain" style="width:100%;height: 125px;"></script></td>
						</tr>
					</table>
					<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
						<tr>
							<td width="72" class="table_tit1">经办人</td>
							<td width="90">${o.jbr}</td>
							<td width="94" class="table_tit1">联系电话</td>
							<td width="136">${o.phone}</td>
							<td width="222" class="table_tit1">${o.descr}</td>
						</tr>
					</table>
				</div>








			</div>


                            <div class="col-sm-3">
                            <ul class="nav nav-tabs" style="padding-top:10px;">
                            <%-- <li class="active"><a href="document/edit?id=${o.id}">正文</a></li>
                            <li><a href="document/flowInfo?id=${o.id}">流程信息</a></li> --%>
                            <li style="float:right;">
                            <div>
                                <button type="button" class="btn btn-info" id="btnDu"  onclick="onDu()">督办</button>
                                &nbsp;&nbsp;
                                <button type="button" class="btn btn-info" id="btnGui"  onclick="onGui()">归档</button>
                                &nbsp;&nbsp;
                            <button type="button" class="btn btn-info" id="btnSave" onclick="onSave()">保存</button>
                            &nbsp;&nbsp;
                        <button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
                            &nbsp;&nbsp;

                        </div>
                        </li>
                        </ul>

                        <div class="form-group" style="display:none">
                            <label class="col-sm-3 control-label" for="descr">是否批转</label>
                            <div class="col-sm-9">
                            <select id="isPi" name="isPi" class="select2" style="width: 180px">
                            <option value=1>是</option>
                            <option value=0>否</option>


                            </select>
                            </div>
                            </div>

                            <div class="form-group" style="display: none;">
                            <label class="col-sm-3 control-label" for="descr">公文类型</label>
                            <div class="col-sm-9">
                            <select id="type" name="type" class="select2" style="width: 180px">
                            <option value="">&nbsp;</option>

                        </select>
                        </div>
                        </div>

                        附件&nbsp;&nbsp;

                        <table id="grid"></table>
                            <div id="pager" style="height:35px;"></div>


                                <div class="box box-default box-solid">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">流程信息</h3>

                                        <div class="box-tools pull-right">
                                            <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <ul class="products-list product-list-in-box"  id="flowInfo">
                                        </ul>
                                    </div>
                                </div>

                            </div>

                            </form>
</div>



</body>
</html>
