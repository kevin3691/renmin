<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>用户编辑</title>
<script type="text/javascript">

    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    function query(sendToId,sendDoId,sendTime,content){
		$.post ("chat/list", {sendToId:sendToId,sendDoId:sendDoId,sendTime:sendTime,content:content}, function (rslt) {
			$("#list ul").empty();
			var rows = rslt.rows;

			$.each(rows,function (i,t) {
				var time = jsonDateTimeFormatter (t.sendTime, 2);
				if(t.sendDoId == sendToId){
					var ele = "<li>"+t.sendDoName+"&nbsp;"+time+":<br/><p class=\"mesInfo\">"+t.content+"</p></li>";
					$("#list ul").append(ele);
				}
				if(t.sendDoId == sendDoId ) {
					var eleMy = "<li style='text-align: right'>"+time+"&nbsp;我:<br/><p class=\"mesInfo\">"+t.content+"</p></li>";
					$("#list ul").append(eleMy);
				}
			})
			var box=document.getElementsByClassName("mes")[0];
			box.scrollTop=box.scrollHeight;
		})
	}
	//查询
	function onQ () {
		var sendTime = $("#sendTime").val();
		var content = $("#content").val();
		query(${sendToId},${sendDoId},sendTime,content);
	}
	//查询
	function onQAll () {
		$("#sendTime").val("");
		$("#content").val("");
		onQ();
	}
    //页面加载完成执行
    $ (function () {
	    //初始化select
	    $ (".select2").select2 ();
	    //初始化角色选择项
		query(${sendToId},${sendDoId},"");
		//为日期设置格式输入
		$ ("#sendTime").inputmask ("yyyy-mm-dd", {
			"placeholder" : "yyyy-mm-dd"
		});
		//加载日期控件
		$ ('#sendTime').datetimepicker ({
			minView : 3
			//时间，默认为日期时间
		});
		//设置掩码
		$ ('#sendTime').inputmask ("yyyy-mm-dd");
    })
</script>
	<style>
		.mes{
			width: 55%;
			box-sizing: border-box;
			padding: 10px 10px;
			list-style: none;
			height: 84%;
			min-height:420px;
			max-height:420px;
			overflow-y: scroll;
			margin: auto;
		}
		.mes li{
			width: 100%;
			border-top: 1px solid #E9E9E9;
			margin-bottom: 5px;
			padding-top: 10px;
		}
		.mes li:first-child{
			border: none;
		}
		.mesInfo{
			word-break: break-all;
			white-space: pre-wrap;
			line-height: 30px;
			margin-top: 5px;
			text-indent: 2em;
		}
	</style>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<div class="breadcrumb content-header form-inline"
			 style="padding:8px;">
			<div class="form-group">
				<label for="content">关键字</label> <input
					class="form-control input-sm" id="content" name="content" value=""
					type="text" />
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="sendTime">购买日期</label>
				<div class="col-sm-9">
					<div class="input-group">
						<input class="form-control" id="sendTime" name="sendTime" value=""
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#sendTime').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
						onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
						onclick="onQAll()">显示全部</button>
			</div>
		</div>
		<form id="mainForm" class="form-horizontal">

			<div id="list" class="form-group">
				<ul class="mes">

				</ul>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
