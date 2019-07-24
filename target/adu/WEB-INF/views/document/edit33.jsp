<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>

	<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<title>公文-编辑</title>
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
    function onSave () {


	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
        if($("#title").val() == ""){
            alert("请输入标题！")
			return false;
        }



        if($("#org").val() == ""){
            alert("请选择来文单位！")
            return false;
        }
        var ue = UE.getEditor ('editor');
        $ ("#content").val (ue.getContent ());

	    var para = $ ("#mainForm").serialize ();
	    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
                if(top.onCancel()){
                    top.onCancel();
                }
		    }
		    //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
		    //document.location.reload();
	    );
    }
	
    function onSel(){
    	if("${o.id}" == 0)
    	{
    		alert("请先保存再提交！");
    		return;
    	}
    	var title = "选择人员"
    	    layer.open ({
    	        type : 2,
    	        title : title,
    	        shadeClose : true,
    	        shade : 0.8,
    	        area : [
    	                '90%', '90%'
    	        ],
    	        content : 'base/user/multiSel'
    	    });
    }
    var ACTORID = ''
    var ACTORNAME = ''
  //选择人员回调方法 
    function onSelOk (nodes) {
    	ACTORID = ""
    	ACTORNAME = ""
    	layer.closeAll ();
       
        $.each (nodes, function (i, node) {
        	ACTORID += node.id + ","
        	ACTORNAME += node.basePersonName + ","
        	
        })
        
       
        onSubmit();
    }
	function onSubmit(){
/* 		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize(); */
		/* if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
	    	$.post('document/submit', {"actorId":ACTORID,"actorName":ACTORNAME,"insId":result.ins.id}, function(result,
					status) {
				document.location = 'document/index'
			});
	    }); */   
	    /* if (!$('#mainForm').validate().form()) {
			return false;
		} */
		if("${o.id}" == 0)
		{
			alert("请先保存再提交！");
			return false;
		}
		var title = "文件批转"
    	    var l = layer.open ({
    	        type : 2,
    	        title : title,
    	        shadeClose : true,
    	        shade : 0.8,
    	        area : [
    	                '90%', '90%'
    	        ],
    	        content : "document/pizhuan?docId=${o.id}&insId=${ins.id}"
    	    });
		layer.full(l);
		
	}
    //返回
    function onCancel () {
	    /* var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭    */
    	//document.location = 'document/index'
    	//window.history.back()
		//parent.parent.layer.closeAll();
        window.top.onCancel();
    }
  //选择部门
    function onSelOrg () {
	    layer.open ({
	        type : 2,
	        title : "选择单位",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '350', '420'
	        ],
	        content : 'base/org/sel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onSelOrgOk (node) {
	    $ ("#orgId").val (node.id)
	    $ ("#org").val (node.name)
	    layer.closeAll ()
    }
    
    
    function onMultiSelOrg () {
    	if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    layer.open ({
	        type : 2,
	        title : "选择处室",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '350', '420'
	        ],
	        content : 'base/org/multiSel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onOrgSelOk (nodes) {
    	ACTORID = ""
        	ACTORNAME = ""
        	layer.closeAll ();
           
            $.each (nodes, function (i, node) {
            	ACTORID += node.id + ","
            	ACTORNAME += node.name + ","
            	
            })
            
    	if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }

	    var para = $ ("#mainForm").serialize ();

	    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
	    	$.post('document/chuanyue', {"actorId":ACTORID,"actorName":ACTORNAME,"insId":result.ins.id}, function(result,
					status) {
				document.location = 'document/index'
			});
	    });
    }
  //选择部门
    function onSelPerson () {
	    layer.open ({
	        type : 2,
	        title : "选择经办人",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '900', '400'
	        ],
	        content : 'base/person/sel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onPersonSelOk (node) {
        $ ("#jbrId").val (node.id)
        $ ("#jbr").val (node.name)

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
        })
	}


    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : "${o.category}",
    		    refNum : "${o.id}"
    	    }
    	UPLOADER.init ();
	    //加载select特效
	    $ (".select2").select2 ();
		getLwdw()
	    //为日期设置格式输入
	    $ ("#lwsj").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#lwsj').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#lwsj').inputmask ("yyyy-mm-dd");
	    //加载数据字典
	    //bindDictSelect ("LWLX", "lwlx");
	    //bindDictSelect ("LWFS", "lwfs");
	    //bindDictSelect ("LEVEL", "level");
	    //bindDictSelect ("MIJI", "miji");
        bindType()

	    //赋值
	    if ("${o.id}" > 0){
            $ ("#isActive").select2 ("val", "${o.isActive}");
            $ ("#isPi").select2 ("val", "${o.isPi}");
            $ ("#type").select2 ("val", "${o.type}");
	    }
	    if("${o.jbrId}" == 0){
	        $("#jbr").val("${baseUser.basePersonName}")
            $("#jbrId").val("${baseUser.basePersonId}")
		}
	    //loadGrid();
	    if ("${o.colTitle}" == "传阅件" || "${o.colTitle}" == "阅办件"){
	    	$ ("#submit").css("display","none")
	    	$ ("#finish").css("display","none")
	    }else{
	    	$ ("#chuanyue").css("display","none")

	    }

        var ue = UE.getEditor ('editor');
        $ ("#editor").height (125);
	    loadGrid();

    })
</script>


</head>

<body>
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
		<input type="hidden" id="id" name="id" value="${o.id}" />
		<input type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
		<input type="hidden" id="category" name="category" value="${o.category}" />
		<input type="hidden" id="isDu" name="isDu" value="${o.isDu}" />
		<input type="hidden" id="isFinish" name="isFinish" value="${o.isFinish}" />
		<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
		<input type="hidden" id="jbrId" name="jbrId" value="${o.jbrId}" />

		<input type="hidden" id="docTypeId" name="docTypeId" value="${o.docTypeId}" />
		<input type="hidden" id="docTypeName" name="docTypeName" value="${o.docTypeName}" />
		<input type="hidden" id="location" name="location" value="${o.location}" />
		<input type="hidden" id="filePath" name="filePath" value="${o.filePath}" />
		<input type="hidden" id="fileUrl" name="fileUrl" value="${o.fileUrl}" />
		<input type="hidden" id="fileExt" name="fileExt" value="${o.fileExt}" />
		<input type="hidden" id="icon" name="icon" value="${o.icon}" />
		<input type="hidden" id="fileName" name="fileName" value="${o.fileName}" />
		<input type="hidden" id="fileSize" name="fileSize" value="${o.fileSize}" />
		<input type="hidden" id="fileId" name="fileId" value="${o.fileId}" />
		<input type="hidden" id="wfWorkflowId" name="wfWorkflowId" value="${o.wfWorkflowId}" />

		<input type="hidden" id="ljrId" name="ljrId" value="${o.ljrId}" />
		<input type="hidden" id="ljr" name="ljr" value="${o.ljr}" />

		<input type="hidden" id="refNum" name="refNum" value="${o.refNum}" />
		<input type="hidden" id="applyTo" name="applyTo" value="${o.applyTo}" />
		<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
		<input type="hidden" id="content" name="content" value="" />
		<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />


		<div class="form-group">
			<label class="col-sm-2 control-label" for="title">标题</label>
			<div class="col-sm-10">
				<input class="form-control" id="title" name="title" value="${o.title}"
					   type="text" required />
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="title">来文时间</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="lwsj" name="lwsj" value="${o.lwsj}"
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#lwsj').datetimepicker('show');"></i>
					</div>
				</div>
			</div>

			<label class="col-sm-2 control-label" for="title">保密</label>
			<div class="col-sm-4">
				<select id="miji" name="miji" style="width: 100px;"
						class="select2">
					<option value='否'>否</option>
					<option value='秘密'>秘密</option>
					<option value='机密'>机密</option>
					<option value='内部保密'>内部保密</option>
				</select>
			</div>

		</div>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="title">来文单位</label>
			<div class="col-sm-4">

				<input class="form-control" id="org" name="org" value="${o.org}"
					   type="text" />
			</div>

			<label class="col-sm-2 control-label" for="jbr">经办人</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="jbr" name="jbr"
						   value="${o.jbr}" type="text" readOnly/>
					<div class="input-group-addon">
						<i class="fa fa-search"
						   onclick="onSelPerson()"></i>
					</div>
				</div>
			</div>

		</div>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="colSym">呈批笺编号</label>
			<div class="col-sm-4">
				<input class="form-control" id="colSym" name="colSym" value="${o.colSym}"
					   type="text"  />
			</div>

			<label class="col-sm-2 control-label" for="jbr">页数</label>
			<div class="col-sm-4">
				<input class="form-control" id="page" name="page" value="${o.page}"
					   type="text"  />
			</div>

		</div>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="lwbh">来文编号</label>
			<div class="col-sm-4">
				<input class="form-control" id="lwbh" name="lwbh" value="${o.lwbh}"
					   type="text"  />
			</div>

			<label class="col-sm-2 control-label" for="phone">电话</label>
			<div class="col-sm-4">
				<input class="form-control" id="phone" name="phone" value="${o.phone}"
					   type="text"  />
			</div>

		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="descr">备注</label>
			<div class="col-sm-10">
				<input class="form-control" id="descr" name="descr" value="${o.descr}"
					   type="text"  />
			</div>
		</div>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="descr">拟办意见</label>
			<div class="col-sm-10">
				<script id="editor" name="editor" type="text/plain" style="width:100%;">${o.content}</script>
			</div>
		</div>

            <div class="form-group" style="display:none">

                <label class="col-sm-2 control-label" for="isActive">状态</label>
                <div class="col-sm-4">
                <select id="isActive" name="isActive" class="form-control select2">
                <option value=1>启用</option>
                <option value=0>停用</option>
                </select>
                </div>
				</div>


	</div>


<div class="col-sm-3">
	<ul class="nav nav-tabs" style="padding-top:10px;">
		<%-- <li class="active"><a href="document/edit?id=${o.id}">正文</a></li>
        <li><a href="document/flowInfo?id=${o.id}">流程信息</a></li> --%>
		<li style="float:right;">
			<div>
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="submit" type="button"
						onclick="onPrint()">打印</button>
			</div>
		</li>
	</ul>

	<div class="form-group">
		<label class="col-sm-3 control-label" for="descr">是否批转</label>
		<div class="col-sm-9">
			<select id="isPi" name="isPi" class="select2" style="width: 180px">
				<option value=0>否</option>
				<option value=1>是</option>

			</select>
		</div>
	</div>

	<div class="form-group">
		<label class="col-sm-3 control-label" for="descr">类型</label>
		<div class="col-sm-9">
			<select id="type" name="type" class="select2" style="width: 180px">
                <option value="">&nbsp;</option>

			</select>
		</div>
	</div>

	附件列表&nbsp;&nbsp;
	<button class="btn btn-info" id="btnUpload" type="button"
			onclick="onSelfUpload()">添加附件</button>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
</div>

	</form>


</body>
</html>
