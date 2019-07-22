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
		table {
			margin-top:20px;
			padding: 0px ;
		}
		table tr td{
			margin: 0px ;
		}
	</style>
</head>

<body>
	<div class="container-fluid">
		<div style="width: 50%;margin: auto">

			<table class="table table-bordered"  cellpadding="0" >
				<tr style="">
					<td>ID</td><td>${o.id}</td><td>编号</td><td >${o.sn}</td><td rowspan="3"><div style="width:100px;margin: auto;" id="qrcode"></div></td>
				</tr>
				<tr>
					<td>名称</td><td>${o.name}</td><td>领用人</td><td  >${o.keeper}</td>
				</tr>
				<tr>
					<td>单位</td><td>${o.unit}</td><td>类别</td><td >${o.type}</td>
				</tr>
				<tr>
					<td>规格型号</td><td>${o.spec}</td><td>购买日期</td><td>${o.invoicedt}</td><td></td>
				</tr>
			</table>
		</div>
		<div class="form-group controls" style="text-align:center">
			<button type="button" class="btn btn-info" onclick="DoPrint()">打印</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
		</div>
	</div>
</body>
</html>
<%
	String path = request.getContextPath();
//	String basePath = request.getScheme() + "://"
//			+ request.getServerName() + ":" + request.getServerPort()
//			+ path + "/";
	String basePath = path + "/";


	String bp = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<script>
	jQuery(function(){
		$("#qrcode").qrcode({
			width:100,
			height:100,
			//text:"http://192.168.10.119:8000${pageContext.request.contextPath}/goods/erWeiMa?id=${o.id}"
			text:"http://www.hdswzzb${pageContext.request.contextPath}/goods/erWeiMa?id=${o.id}"
		})
		//encodeURI("
	})
</script>
<SCRIPT LANGUAGE="VBScript">
Sub DoPrint()
 Dim TheForm
 Set TheForm = Document.ValidForm

 'Create b-PAC object
 Dim ObjDoc
 Set ObjDoc = CreateObject("bpac.Document")

 'Open template file created with P-touch Editor
 'Locate fixed asset name.lbx file at any place
 strDir = "Folder containing LBX file"
 bRet = ObjDoc.Open("E:\asset.lbx")

 If (bRet <> False) Then 'normally open?

  'Set input data
  'to text object of "Fixed asset name"
  ObjDoc.GetObject("Name").Text = TheForm.FixedAsset.Value

  'Set input data
  'to text object of "Management section"
  ObjDoc.GetObject("Section").Text = TheForm.SectionName.Value

  'Set input data
  'to text object of "Management No"
  ObjDoc.GetObject("Number").Text = TheForm.SectionNo.Value

  'Set input data
  'to barcode object
  ObjDoc.GetObject("QRCode1").Text = TheForm.SectionNo.Value

  'Execute printing
  ObjDoc.StartPrint "DocumentName", 0
  ObjDoc.PrintOut 1, 0
  ObjDoc.EndPrint
  ObjDoc.Close
 End If

 'Release b-PAC object
 Set ObjDoc = Nothing
End Sub
</SCRIPT>