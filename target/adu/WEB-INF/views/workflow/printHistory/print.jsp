<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<script src="jslib/jquery-1.4.4.min.js"></script>
<script src="jslib/lodop/LodopFuncs4.js"></script>
<script src='http://localhost:8000/CLodopfuncs.js'></script>
<title>打印模板 - 编辑</title>
<script type="text/javascript">
	//取消
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}

	var LODOP; //声明为全局变量
	var blPreviewOpen = false;
	function myAction1() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_ZOOM_HIGHT", 0);
	};

	//正常显示
	function myAction2() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_ZOOM_NORMAL", 0);
	};

	//适宽显示
	function myAction3() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_ZOOM_WIDTH", 0);
	};

	//拉近显示+
	function myAction4() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_ZOOM_IN", 0);
	};

	//推远显示-
	function myAction5() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_ZOOM_OUT", 0);
	};

	function myAction6() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_PERCENT",
				document.getElementById('percent').value);
	};

	//首页
	function myAction7() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_GOFIRST", 0);
	};

	//上一页
	function myAction8() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_GOPRIOR", 0);
	};

	//下一页
	function myAction9() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_GONEXT", 0);
	};

	//尾页
	function myAction10() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_GOLAST", 0);
	};

	function myAction11() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_GOTO",
				document.getElementById('inputpage').value);//PREVIEW_GOSKIP
	};

	//打印设置
	function myAction12() {
		if (!blPreviewOpen)
			initPreview();
		LODOP.DO_ACTION("PREVIEW_SETUP", 0);
	};

	//打印全部
	function myAction13() {
		if (!blPreviewOpen)
			initPreview();
		var iPageCount = LODOP.GET_VALUE("PREVIEW_PAGE_COUNT", 0);//获得页数
		LODOP.SET_PRINT_MODE("PRINT_START_PAGE", 1);
		LODOP.SET_PRINT_MODE("PRINT_END_PAGE", iPageCount);
		LODOP.DO_ACTION("PREVIEW_PRINT", 0);
		addPrintHistory();
	};

	//打印本页
	function myAction14() {
		if (!blPreviewOpen)
			initPreview();
		var iThisNumber = LODOP.GET_VALUE("PREVIEW_PAGE_NUMBER", 0);//获得当前页号
		LODOP.SET_PRINT_MODE("PRINT_START_PAGE", iThisNumber);
		LODOP.SET_PRINT_MODE("PRINT_END_PAGE", iThisNumber);
		LODOP.DO_ACTION("PREVIEW_PRINT", 0);
	};

	//实例化lodOp
	function initPreview() {
		LODOP = getLodop(document.getElementById('LODOP_X'), document
				.getElementById('LODOP_EM'));
		LODOP.SET_PRINT_STYLE("FontSize", 18);
		LODOP.SET_PRINT_STYLE("Bold", 1);
		LODOP.ADD_PRINT_HTM("0mm", "0mm", "RightMargin:0mm",
				"BottomMargin:9mm", $("#content").val());
		LODOP.SET_SHOW_MODE("HIDE_PAPER_BOARD", true);//隐藏走纸板
		LODOP.SET_PREVIEW_WINDOW(0, 3, 0, 0, 0, ""); //隐藏工具条，设置适高显示
		LODOP.SET_SHOW_MODE("PREVIEW_IN_BROWSE", 1); //预览界面内嵌到页面内
		LODOP.PREVIEW();
		LODOP.DO_ACTION("PREVIEW_ZOOM_NORMAL", 0);
		blPreviewOpen = true;
	}

	//添加打印历史纪录
	function addPrintHistory() {
		$.ajax({
			type : "POST",
			url : "workflow/printHistory/genHistory",
			data : {
				category : "${category}",
				applyTo : "${applyTo}",
				refNum : "${refNum}",
				title : "${title}",
				html : $("#content").val()
			},
			async : false,
			success : function(rslt) {

			},
			error : function(x, e) {
				layer.msg(e)
			}
		});
	}

	//编辑模式
	function onEditor() {
		$("#editorDiv").show();
		$("#lodopDiv").hide();
	}

	//打印模式
	function onPrint() {
		$("#content").val(UE.getEditor('editor').getContent());
		$("#editorDiv").hide();
		$("#lodopDiv").show();
		initPreview();
	}

	//初始化
	$(function() {
		if (parent.genPrintHtml) {
			$("#content").val(parent.genPrintHtml());
		}
		initPreview();
		$("#LODOP_X").height(document.body.clientHeight - 60);
		new UE.ui.Editor({
			initialFrameWidth : $(document.body).width() - 50,
			initialFrameHeight : document.body.clientHeight - 190,
			autoHeightEnabled : false,
			initialContent : $("#content").val()
		}).render('editor');
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="content" name="content" value="" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group" id="lodopDiv">
				<div class="col-md-12 col-sm-12" style="text-align:right;">
					<!-- <button type="button" class="btn btn-info" onclick="myAction1()">适高显示</button> -->
					<button type="button" class="btn btn-info" onclick="myAction2()">正常显示</button>
					<button type="button" class="btn btn-info" onclick="myAction3()">适宽显示</button>
					<button type="button" class="btn btn-info" onclick="myAction4()">拉近显示+</button>
					<button type="button" class="btn btn-info" onclick="myAction5()">推远显示-</button>
					<button type="button" class="btn btn-info" onclick="myAction7()">首页</button>
					<button type="button" class="btn btn-info" onclick="myAction8()">上一页</button>
					<button type="button" class="btn btn-info" onclick="myAction9()">下一页</button>
					<button type="button" class="btn btn-info" onclick="myAction10()">尾页</button>
					<button type="button" class="btn btn-info" onclick="myAction12()">打印设置</button>
					<button type="button" class="btn btn-info" onclick="myAction13()">打印全部</button>
					<button type="button" class="btn btn-info" onclick="myAction14()">打印本页</button>
					<button type="button" class="btn btn-info" onclick="onEditor()">编辑模式</button>
				</div>
				<div class="col-md-12 col-sm-12">
					<object id="LODOP_X"
						classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="100%"
						height="0">
						<embed id="LODOP_EM" type="application/x-print-lodop" width="100%"
							height="500" color="#ADD8E6"
							pluginspage="driver/install_lodop32.exe"></embed>
					</object>
				</div>
			</div>
			<div class="form-group" id="editorDiv" style="display:none;">
				<div class="col-md-12 col-sm-12" style="text-align:right;">
					<button type="button" class="btn btn-info" onclick="onPrint()">打印模式</button>
				</div>
				<div class="col-md-12 col-sm-12">
					<script type="text/plain" id="editor" style="width: 100%;"></script>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
