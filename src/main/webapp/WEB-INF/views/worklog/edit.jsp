<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>日志 - 编辑</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<link rel="stylesheet" type="text/css"
		  href="jslib/webuploader/webuploader.min.css">
	<script type="text/javascript"
			src="jslib/webuploader/webuploader.min.js"></script>
	<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
	<script type="text/javascript">
        //保存
        function onSave () {
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }else{
                var para = $("#mainForm").serialize();
                $.post('worklog/save2',para,function (result) {
                    layer.closeAll('loading');
                    onCancel();
                })
            }
        }
        //返回
        function onCancel () {
            window.parent.location.href=window.parent.location.href;
        }
	</script>
</head>
<body>
<div class="container-fluid">
	<div class="breadcrumb content-header form-inline"
		 style="padding:8px;">
		<div class="form-group">
			<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
		</div>
	</div>
	<form id="mainForm" class="form-horizontal">
		<input type="hidden" id="id" name="id" value="${o.id}" />
		<div class="row">
			<div class="col-lg-9 col-sm-8">
				<div class="form-group">
					<label class="col-lg-1 col-sm-2 control-label" for="startdatei">开始日期</label>
					<div class="col-lg-5 col-sm-4">
						<input class="form-control" id="startdatei" name="startdatei" value="${o.startdatei}" type="text" maxlength=60 />
						<script>
                            $('#startdatei').datetimepicker({
                                format: 'yyyy-mm-dd hh:ii'
                            });
						</script>
					</div>
					<label class="col-lg-1 col-sm-2 control-label" for="finishdatei1">结束日期</label>
					<div class="col-lg-5 col-sm-4">
						<input class="form-control" id="finishdatei1" name="finishdatei" value="${o.finishdatei}" type="text" maxlength=60 />
						<script>
                            $('#finishdatei1').datetimepicker({
                                format: 'yyyy-mm-dd hh:ii'
                            });
						</script>
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-1 col-sm-2 control-label" for="titlei">标题</label>
					<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="titlei" name="titlei" value="${o.titlei}" type="text" maxlength=60 />
					</div>
					<label class="col-lg-1 col-sm-2 control-label" for="contenti">内容</label>
					<div class="col-lg-5 col-sm-4">
						<input class="form-control" id="contenti" name="contenti" value="${o.contenti}" type="text" maxlength=60 />

					</div>
				</div>
			</div>
		</div>
    </form>
</div>
</body>
</html>