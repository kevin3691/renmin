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
    	document.location = 'document/yuebanindex'
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
	    $ ("#lwdwId").val (node.id)
	    $ ("#lwdw").val (node.name)
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
			    $ ("#grid").trigger ("reloadGrid");
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
	    else if (container == "lwfs"){
		    $ ("#lwfs").select2 ("val", "${o.lwfs}");
	    }
	    
    }
    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : "${o.category}",
    		    refNum : "${o.id}"
    	    }
    	UPLOADER.init ();
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
			<li class="active"><a href="document/yueban?id={o.id}">正文</a></li>
			<li><a href="document/flowInfo?id={o.id}">流程信息</a></li>
			<li style="float:right;">
				<div>
					<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
					&nbsp;&nbsp;
					<button class="btn btn-info" id="submit" type="button"
						onclick="onSubmit()">转交</button>
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
					<input class="form-control" id="title" name="title" value="${o.title}"
						type="text" required />
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
						<div class="input-group-addon">
							<i class="fa fa-search"
								onclick="onSelOrg()"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="lwlx">来文类型</label>
				<div class="col-sm-4">
					<select id="lwlx" name="lwlx"
						class="form-control select2">
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwbh">来文号</label>
				<div class="col-sm-4">
					<input class="form-control" id="lwbh" name="lwbh"
						value="${o.lwbh}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="lwsj">来文时间</label>
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
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lwfs">来文方式</label>
				<div class="col-sm-4">
					<select id="lwfs" name="lwfs"
						class="form-control select2">
					</select>
				</div>
				<label class="col-sm-2 control-label" for="cfwz">存放位置</label>
				<div class="col-sm-4">
					<input class="form-control" id="cfwz" name="cfwz"
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
			
			<div class="form-group" style="display:none">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
			</div>
			
		</form>
		<div>
			附件列表&nbsp;&nbsp;
			<button class="btn btn-info" id="btnUpload" type="button"
						onclick="onSelfUpload()">添加附件</button>
		</div>
		<table id="grid" style="height:35px;"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
