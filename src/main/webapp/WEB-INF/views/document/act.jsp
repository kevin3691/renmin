<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
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
	                            label : '文件大小',
	                            name : 'fileSize',
	                            index : 'fileSize',
	                            width : 80,
	                            formatter : function (value, options, row) {
		                            var s = commafy (value / 1024);
		                            s = s != "0" ? s : "<1";
		                            return s + "KB";
	                            }
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 140,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn += '&nbsp;<a href="javascript:onShow(\'' + row.fileUrl + '\',\'' + row.fileExt
		                                    + '\')" title="">查看</a>'
		                            btn += '&nbsp;<a href="comm/attachment/download?filePath=' + row.filePath
		                                    + '" title="">下载</a>'
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
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('document/actdoc', $ ("#mainForm").serialize (), function (result, status) {
		    
		    document.location = 'document/ins'
	    });
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
        	ACTORNAME = node.basePersonName + ","
        	
        })
        
       
        onSubmit();
    }
    function onSubmit(){
    			$.post('document/submit', {"actorId":ACTORID,"actorName":ACTORNAME,"insId":"${ins.id}"}, function(result,
    					status) {
    				document.location = 'document/ins'
    			});
    		}
    function onFinish(){
    	
		$.post('document/finish', {"descr":$("#descr").val(),"insId":"${ins.id}"}, function(result,
				status) {
			document.location = 'document/ins'
		});
	}
    //返回
    function onCancel () {
	    /* var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭    */
	    window.history.back()
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
	    else if (container == "lwfs"){
		    $ ("#lwfs").select2 ("val", "${o.lwfs}");
	    }
	    
    }
    $ (function () {
    	
	    
	    loadGrid();
    })
</script>
</head>

<body>
	<div class="container-fluid">
		
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li class="active"><a href="document/act?id=${o.id}">正文</a></li>
			<li><a href="document/flowInfo?id=${o.id}">流程信息</a></li>
			<li style="float:right;">
				<div>
					
					<c:choose>
	            		<c:when test="${o.recordInfo.createdByUser eq baseUserId && o.isFinish ne 1}">
	            			<button type="button" class="btn btn-info" onclick="onSel()">转交</button>
							&nbsp;&nbsp;
							<button type="button" class="btn btn-info" onclick="onFinish()">办结</button>
	            		</c:when>
	            		<c:otherwise>
	            			<button type="button" class="btn btn-info" onclick="onSave()">回复</button>
							&nbsp;&nbsp;
	            		</c:otherwise>
	            	</c:choose>
					
				</div>
			</li>
		</ul>
		<div>&nbsp;</div>
		<form id="1" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">标题</label>
				<div class="col-sm-10">
					<input class="form-control" readOnly id="title" name="title" value="${o.title}"
						type="text" />
				</div>
				
			</div>
			
			<div class="form-group" style="display:none;">
				
				<label class="col-sm-2 control-label" for="content">内容</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="content" name="content"
							value="${o.content}" type="text" readOnly/>
						<div class="input-group-addon">
							<i class="fa fa-search"
								onclick="onSelOrg()"></i>
						</div>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwdw">来文单位</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="lwdw" name="lwdw"
							value="${o.lwdw}" type="text" readOnly/>
						
					</div>
				</div>
				<label class="col-sm-2 control-label" for="lwlx">来文类型</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="lwlx" name="lwlx"
						value="${o.lwlx}" type="text" />
				
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwbh">来文号</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="lwbh" name="lwbh"
						value="${o.lwbh}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="lwsj">来文时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" readOnly id="lwsj" name="lwsj" value="${o.lwsj}"
							type="text" />
						
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwfs">来文方式</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="lwfs" name="lwfs"
						value="${o.lwfs}" type="text" />
					
				</div>
				<label class="col-sm-2 readOnly control-label" for="cfwz">存放位置</label>
				<div class="col-sm-4">
					<input class="form-control" id="cfwz" readOnly name="cfwz"
						value="${o.cfwz}" type="text" />
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
			</form>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${ins.id}" /> 
			<input
				type="hidden" id="applyTo" name="applyTo" value="${ins.applyTo}" /> 
				<input
				type="hidden" id="refNum" name="refNum" value="${ins.refNum}" /> 
				<input type="hidden" id="nextStepId" name="nextStepId" value="${ins.nextStepId}" />
				<input type="hidden" id="nextStepName" name="nextStepName" value="${ins.nextStepName}" />  
				<input type="hidden" id="category" name="category" value="${ins.category}" /> 
				<input type="hidden" id="stepId"
				name="stepId" value="${ins.stepId}" /> 
				<input type="hidden" id="stepName"
				name="stepName" value="${ins.stepName}" /> 
				<input type="hidden"
				id="actorId" name="actorId" value="${ins.actorId}" />
				<input type="hidden"
				id="actorName" name="actorName" value="${ins.actorName}" /> <input
				type="hidden" id="yesNo" name="yesNo" value="${ins.yesNo}" /> <input
				type="hidden" id="actUrl" name="actUrl" value="${ins.actUrl}" /> <input
				type="hidden" id="listUrl" name="listUrl" value="${ins.listUrl}" /> <input
				type="hidden" id="dtlUrl" name="dtlUrl" value="${ins.dtlUrl}" /> <input
				type="hidden" id="okUrl" name="okUrl" value="${ins.okUrl}" /> <input
				type="hidden" id="title" name="title" value="${ins.title}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">办理意见</label>
				<div class="col-sm-10">
					<textarea class="form-control" required id="descr" name="descr" rows=3>${ins.descr}</textarea>
				</div>
			</div>
			
		</form>
		<div>
			附件列表&nbsp;&nbsp;
		</div>
		<table id="grid" style="height:35px;"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
