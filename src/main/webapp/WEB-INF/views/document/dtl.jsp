<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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
	    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
		    document.location = 'document/yueban?id=' + result.entity.id
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
    	
	    //加载select特效
	    $ (".select2").select2 ();
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
	    bindDictSelect ("LWLX", "lwlx");
	    bindDictSelect ("LWFS", "lwfs");
	    
	    //赋值
	    if ("${o.id}" > 0){
		    $ ("#isActive").select2 ("val", "${o.isActive}");
	    }
	    loadGrid();
    })
</script>
</head>

<body>
	<div class="container-fluid">
		
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li class="active"><a href="document/dtl?id=${o.id}">正文</a></li>
			<li><a href="document/flow?id=${o.id}">流程信息</a></li>
			<li style="float:right;">
				<div>
					
				</div>
			</li>
		</ul>
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="type" name="type" value="${o.type}" />
			<input type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="isFinish" name="isFinish" value="${o.isFinish}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
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
				<label class="col-sm-2 control-label" for="lwdw">处室</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="org" name="org"
							value="${o.org}" type="text" readOnly/>
						
					</div>
				</div>
				<label class="col-sm-2 control-label" for="lwlx">经办人</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="jbr" name="jbr"
						value="${o.jbr}" type="text" />
				
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="wbh">来文号</label>
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
				<label class="col-sm-2 control-label" for="level">等级</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="level" name="level" value="${o.level}"
							type="text" />
				</div>
				<label class="col-sm-2 control-label" for="miji">密级</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="miji" name="miji" value="${o.miji}"
							type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwfs">来文方式</label>
				<div class="col-sm-4">
					<input class="form-control" readOnly id="lwfs" name="lwfs" value="${o.lwfs}"
							type="text" />
				</div>
				<label class="col-sm-2 control-label" for="lwlx">来文类型</label>
					<div class="col-sm-4">
						<input class="form-control" readOnly id="lwlx" name="lwlx" value="${o.lwlx}"
							type="text" />
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
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" readOnly id="descr" name="descr" rows=3>${o.descr}</textarea>
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
