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
<title>会议-编辑</title>
<script type="text/javascript">

    function loadGrid () {
        $ ("#grid").jqGrid (
            {
                url : "comm/attachment/list4",
                postData:{
                    refNum: "${o.id}",
                    applyTo:"${o.category}"
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
        var ue = UE.getEditor ('editor');
        $ ("#content").val (ue.getContent ());
	    var para = $ ("#mainForm").serialize ();
	    $.post ('meet/save', $ ("#mainForm").serialize (), function (result, status) {
		    // if (parent.onSaveOk){
			 //    parent.onSaveOk (result.entity)
		    // }

			document.location.href = "meet/edit/?id=" + result.entity.id
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
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
	        content : 'meettype/sel' //iframe的url
	    });
    }
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

    function onSelPerson () {
        var title = '选择申请人'

        _index = layer.open ({
            type : 2,
            title : title,
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
        $("#personId").val(node.id)
        $("#person").val(node.name)
        $("#orgId").val(node.baseOrgId)
        $("#org").val(node.baseOrgName)

        layer.close(_index);
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

        if("${o.id}" == 0)
            alert("先保存再上传附件！")
        return
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



    //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
        $.post(_BasePath + "comm/uploader/saveAs",{url:json.url},function(result,stts){
            //alert(result+"\n\r"+stts)
        })
    }
    $ (function () {
        UPLOADER.formData = {
            applyTo : "${o.category}",
            refNum : "${o.id}"
        }
        UPLOADER.init ();
        var ue = UE.getEditor ('editor');
        $ ("#editor").height (125);
	    //加载select特效
	    $ (".select2").select2 ();
        //为日期设置格式输入
        $ ("#starttime").inputmask ("yyyy-mm-dd", {
            "placeholder" : "yyyy-mm-dd"
        });
        //加载日期控件
        $ ('#starttime').datetimepicker ({
            minView : 3
            //时间，默认为日期时间
        });
        //设置掩码
        $ ('#starttime').inputmask ("yyyy-mm-dd");

        //为日期设置格式输入
        $ ("#finishtime").inputmask ("yyyy-mm-dd", {
            "placeholder" : "yyyy-mm-dd"
        });
        //加载日期控件
        $ ('#finishtime').datetimepicker ({
            minView : 3
            //时间，默认为日期时间
        });
        //设置掩码
        $ ('#finishtime').inputmask ("yyyy-mm-dd");

	    //赋值
	    if ("${o.id}" > 0){
		    $ ("#type").select2 ("val", "${o.type}");
	    }

	    loadGrid()

    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div id="uploader" class="wu-example">
			<!--用来存放文件信息-->
			<div id="thelist" class="uploader-list"></div>
			<div class="btns" style="display:none;">
				<div id="picker">选择文件</div>
				<button id="ctlBtn" class="btn btn-default">开始上传</button>
			</div>
		</div>
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
			<input type="hidden" id="personId" name="personId" value="${o.personId}" />
			<input type="hidden" id="content" name="content" value="${o.content}" />
			<input type="hidden" id="org" name="org" value="${o.org}" />
			<input type="hidden" id="isSms" name="isSms" value="${o.isSms}" />
			<input type="hidden" id="isEmail" name="isEmail" value="${o.isEmail}" />
			<input type="hidden" id="fuzeren" name="fuzeren" value="${o.fuzeren}" />
			<input type="hidden" id="fuzerenId" name="fuzerenId" value="${o.fuzerenId}" />
			<input type="hidden" id="status" name="status" value="${o.status}" />
			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="descr" name="descr" value="${o.descr}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">接待事项</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title" value="${o.title}"
						   type="text" required />
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="location">接待地点</label>
				<div class="col-sm-10">
					<input class="form-control" id="location" name="location" value="${o.location}"
						   type="text" />
				</div>

			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="person">负责人</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="person" name="person"
							   value="${o.person}" readonly type="text" />
						<div class="input-group-addon">
							<i class="fa fa-search"
							   onclick="onSelPerson()"></i>
						</div>
					</div>
				</div>

				<label class="col-sm-2 control-label" for="type">接待类型</label>
				<div class="col-sm-4">
					<select id="type" name="type" class="form-control select2">
						<option value="普通接待">普通接待</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="personNum">接待人数</label>
				<div class="col-sm-4">
					<input class="form-control" id="personNum" name="personNum" value="${o.personNum}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="total">费用预算</label>
				<div class="col-sm-4">
					<input class="form-control" id="total" name="total" value="${o.total}"
						   type="text"  />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="starttime">开始时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="starttime" name="starttime" value="${o.starttime}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#starttime').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="finishtime">结束时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="finishtime" name="finishtime" value="${o.finishtime}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#finishtime').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>


			<div class="form-group">
				<label class="col-sm-2 control-label" for="content">接待内容、安排等:</label>
				<div class="col-sm-10">
					<script id="editor" name="editor" type="text/plain"
							style="width:100%;">${o.content}</script>
                    </div>
                    </div>
                    <div>
                    附件列表&nbsp;&nbsp;
                    <button type="button" class="btn btn-info" onclick="onUpload()">上传附件</button>
                        </div>
                        <table id="grid" style="height:35px;"></table>
                        <div id="pager" style="height:35px;"></div>

			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
