<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	                	refNum: "${o.id}",
                        applyTo:"${o.colSym}"
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

        if($("#sms").prop('checked'))
            $("#isSms").val(1)
        if($("#email").prop('checked'))
            $("#isEamil").val(1)
        var ue = UE.getEditor ('editor');
        $ ("#content").val (ue.getContent ());
	    var para = $ ("#mainForm").serialize ();
	    $.post ('duban/save', $ ("#mainForm").serialize (), function (result, status) {
		    // if (parent.onSaveOk){
			 //    parent.onSaveOk (result.entity)
		    // }
		    document.location = 'duban/edit?id=' + result.entity.id + '&colSym=ZHUANXIANG'
	    });
    }


    //返回
    function onCancel () {

    	parent.layer.closeAll();
    }

var _flag;
var _index;
    function onSelPerson (flag) {
        _flag = flag;
        var title = '选择督办人'
        if(flag == 1)
            title = '选择分管领导'
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
        if(_flag == 1){
            $("#dubanrenId").val(node.id)
            $("#dubanren").val(node.name)
        }

        if(_flag == 2){
            $("#fenguanlingdaoId").val(node.id)
            $("#fenguanlingdao").val(node.name)
        }
        layer.close(_index);
    }

//选择部门
function onSelOrg () {
    layer.open ({
        type : 2,
        title : "选择承办处室",
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
    $ ("#chengbanchushiId").val (node.id)
    $ ("#chengbanchushi").val (node.name)
    layer.closeAll ()
}

//选择部门
function onMultiSelOrg (flag) {
    _flag = flag;
    var title = '选择承办处室'
    if(flag == 1)
        title = '选择协办处室'
    layer.open ({
        type : 2,
        title : title,
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
    var ids = "";
    var names = "";
    $.each(nodes,function(i,v){
        ids += v.id + ","
        names += v.name + ","
    })
    if(_flag == 1){
        $ ("#chengbanchushiId").val (ids)
        $ ("#chengbanchushi").val (names)
    }
    if(_flag == 2){
        $ ("#xiebanchushiId").val (ids)
        $ ("#xiebanchushi").val (names)
    }

    layer.closeAll ()
}


    function initInfo(){
    	$.post ('duban/listDuOrg', {"insId":"${ins.id}"}, function (result, status) {
    		var html = '';
    		for(var i = 0; i < result.length; i++) {
    			var org = result[i].orgInfo;
    			var h = '<div class="box box-default box-solid">'
        		h += '<div class="box-header with-border">'
        		h += '<h3 class="box-title">['+org.listUrl+']'+org.actorName+'('+org.nextStepName+')</h3>'
        		h += '<div class="box-tools pull-right">'
        		h += '<button onclick="addDuInfo('+org.id+')" type="button" class="btn btn-box-tool"><i class="fa fa-plus"></i></button></div></div>'
    			h += '<div class="box-body">'
    			h += '<table id="table_'+org.okUrl+'" class="table table-bordered table-striped">'
        		if(result[i].infoList.length > 0)
    				h += '<thead><tr><th>时间</th><th>内容</th></tr></thead>'
    			h += '<tbody>'

        		for(var j = 0; j < result[i].infoList.length; j++) {
        			var info = result[i].infoList[j];
    				h += '<tr><td width=110>'+jsonDateTimeFormatter(info.actAt)+'</td>'
    				h += '<td>'+info.descr +'</td></tr>'
                }
    			h += '</tbody>'
    			/* if(result[i].infoList.length > 0)
    				h += '<tfoot><tr><th>时间</th><th>内容</th></tr></tfoot>' */
    			h += '</table>'
                h += '</div></div>'

                html += h;
            }

            $("#infoBody").html(html);
		});
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


	function onStart(){

		layer.confirm ('确定启动当前督办事项？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }

            if($("#sms").prop('checked'))
                $("#isSms").val(1)
            if($("#email").prop('checked'))
                $("#isEamil").val(1)
            var para = $ ("#mainForm").serialize ();
            $.post ('duban/save', $ ("#mainForm").serialize (), function (result, status) {
                var url = 'duban/start'
                if ("${o.colSym}" == "YEWU")
                    url = 'duban/startYewu'
                $.post(url, {"id":"${o.id}","insId":0}, function(result,
                                                                 status) {
                    parent.onQ()
                    parent.layer.closeAll ()
                });
            });



	    });

	}

	function addDuInfo(insId){
		var title = "添加督办信息"
    	    top.layer.open ({
    	        type : 2,
    	        title : title,
    	        shadeClose : true,
    	        shade : 0.8,
    	        area : [
    	                '800', '200'
    	        ],
    	        content : "duban/addDuInfo?insId=" + insId + "&docId=${o.id}"
    	    });
	}

	function addInfoOk(){
		top.layer.closeAll();
		initInfo()
	}

    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : "${o.colSym}",
    		    refNum : "${o.id}"
    	    }
    	UPLOADER.init ();
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


        //为日期设置格式输入
        $ ("#lixiangtime").inputmask ("yyyy-mm-dd", {
            "placeholder" : "yyyy-mm-dd"
        });
        //加载日期控件
        $ ('#lixiangtime').datetimepicker ({
            minView : 3
            //时间，默认为日期时间
        });
        //设置掩码
        $ ('#lixiangtime').inputmask ("yyyy-mm-dd");

        if("${o.id}" > 0){
            if("${o.isSms}" == 1)
                $("#sms").prop('checked',true)
            if("${o.isEmail}" == 1)
                $("#email").prop('checked',true)
		}
        UE.getEditor ('editor');

	    loadGrid();
	    //initInfo()
    })
</script>
<style>
html,body{ margin:0; padding:0;}
.tit{ font:18px 微软雅黑; color:#000;}
.tab_text{ width:98%; height:38px; border:0; margin-left:1%; font:14px 宋体;}
.tab_textarea{ width:98%; height:38px;  border:0; margin-left:1%; font:14px/25px 宋体;}
</style>
</head>

<body>
	<div class="container-fluid">

		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li style="float:right;">
				<div>
					<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
					&nbsp;&nbsp;

					<button type="button" class="btn btn-info" onclick="onStart()">开始督办</button>
					&nbsp;&nbsp;

					<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
					&nbsp;&nbsp;
				</div>
			</li>
		</ul>
        <div id="uploader" class="wu-example">
            <!--用来存放文件信息-->
            <div id="thelist" class="uploader-list"></div>
            <div class="btns" style="display:none;">
                <div id="picker">选择文件</div>
                <button id="ctlBtn" class="btn btn-default">开始上传</button>
            </div>
        </div>
		<div>&nbsp;</div>
		<div class="col-md-12 col-sm-12">
			<form id="mainForm" class="form-horizontal">
				<input type="hidden" id="id" name="id" value="${o.id}" />
				<input type="hidden" id="dubanrenId" name="dubanrenId" value="${o.dubanrenId}" />
				<input type="hidden" id="template" name="template" value="${o.template}" />
				<input type="hidden" id="fenguanlingdaoId" name="fenguanlingdaoId" value="${o.fenguanlingdaoId}" />
				<input type="hidden" id="fenguanlingdaoId" name="fenguanlingdaoId" value="${o.fenguanlingdaoId}" />
				<input type="hidden" id="content" name="content" value="${o.content}" />
				<input type="hidden" id="chengbanrenId" name="chengbanrenId" value="${o.chengbanrenId}" />
				<input type="hidden" id="chengbanchushiId" name="chengbanchushiId" value="${o.chengbanchushiId}" />
				<input type="hidden" id="xiebanrenId" name="xiebanrenId" value="${o.xiebanrenId}" />
				<input type="hidden" id="xiebanchushiId" name="xiebanchushiId" value="${o.xiebanchushiId	}" />
				<input type="hidden" id="category" name="category" value="${o.category}" />
				<input type="hidden" id="colSym" name="colSym" value="${o.colSym}" />
				<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
				<input type="hidden" id="descr" name="descr" value="${o.descr}" />
				<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
				<input type="hidden" id="chengbanren" name="chengbanren" value="${o.chengbanren}" />
				<input type="hidden" id="xiebanren" name="xiebanren" value="${o.xiebanren}" />
				<input type="hidden" id="source" name="source" value="${o.source}" />
				<input type="hidden" id="type" name="type" value="${o.type}" />


				<input type="hidden" id="wardfreq" name="wardfreq" value="${o.wardfreq}" />

				<input type="hidden" id="miji" name="miji" value="${o.miji}" />

				<input type="hidden" id="level" name="level" value="${o.level}" />
				<input type="hidden" id="isSms" name="isSms" value="${o.isSms}" />
                <input type="hidden" id="isEmail" name="isEmail" value="${o.isEmail}" />
                <input type="hidden" id="refNum" name="refNum" value="${o.refNum}" />
                <input type="hidden" id="docTypeId" name="docTypeId" value="${o.docTypeId}" />
                <input type="hidden" id="docTypeName" name="docTypeName" value="${o.docTypeName}" />


				<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
				<div class="form-group">
					<label class="col-sm-2 control-label" for="title">任务名称</label>
					<div class="col-sm-10">
						<input class="form-control" id="title" name="title" value="${o.title}"
							   type="text" required/>
					</div>

				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="dubanren">督办人员</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input class="form-control" id="dubanren" name="dubanren"
								   value="${o.dubanren}" type="text" readOnly required/>
							<div class="input-group-addon">
								<i class="fa fa-search"
								   onclick="onSelPerson(1)"></i>
							</div>
						</div>
					</div>
                    <label class="col-sm-2 control-label" for="fenguanlingdao">分管领导</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input class="form-control" id="fenguanlingdao" name="fenguanlingdao"
                                   value="${o.fenguanlingdao}" readonly type="text" required/>
                            <div class="input-group-addon">
                                <i class="fa fa-search"
                                   onclick="onSelPerson(2)"></i>
                            </div>
                        </div>
                    </div>

		</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="sym">督办编号</label>
					<div class="col-sm-4">
                        <input class="form-control" id="sym" name="sym"
                               value="${o.sym}" type="text"/>
					</div>
                    <label class="col-sm-2 control-label" for="lixiangtime">立项时间</label>
                    <div class="col-sm-4">
                        <input class="form-control" id="lixiangtime" name="lixiangtime"
                               value="${o.lixiangtime}" type="text" required/>

                    </div>
				</div>


				<div class="form-group">
					<label class="col-sm-2 control-label" for="chengbanchushi">承办处室</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input class="form-control" id="chengbanchushi" name="chengbanchushi"
								   value="${o.chengbanchushi}" readonly  type="text" required/>
							<div class="input-group-addon">
								<i class="fa fa-search"
								   onclick="onMultiSelOrg(1)"></i>
							</div>
						</div>
					</div>
					<label class="col-sm-2 control-label" for="xiebanchushi">协办处室</label>
					<div class="col-sm-4">
                        <div class="input-group">
                            <input class="form-control" id="xiebanchushi" name="xiebanchushi"
                                         value="${o.xiebanchushi}" readonly type="text" />
                            <div class="input-group-addon">
                                <i class="fa fa-search"
                                   onclick="onMultiSelOrg(2)"></i>
                            </div>
                        </div>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="starttime">开始时间</label>
					<div class="col-sm-4">
						<input class="form-control" id="starttime" name="starttime"
							   value="${o.starttime}" type="text" required/>
					</div>
					<label class="col-sm-2 control-label" for="finishtime">办结时间</label>
					<div class="col-sm-4">
						<input class="form-control" id="finishtime" name="finishtime"
							   value="${o.finishtime}"  type="text" required/>

					</div>
				</div>

				<div class="form-group" style="display: none;">
					<label class="col-sm-2 control-label" for="starttime">预警时间</label>
					<div class="col-sm-4">
						<input class="form-control" id="warnday" name="warnday"
							   value="${o.warnday}" type="text" />
					</div>
					<label class="col-sm-2 control-label" for="finishtime">提醒方式</label>
					<div class="col-sm-4">
						<label>
							<input type="checkbox" class="minimal-red" id="sms">
							短信
						</label>

						<label>
							<input type="checkbox" class="minimal-red" id="email">
							邮件
						</label>

					</div>
				</div>


				<div class="form-group" style="display:none;">

					<label class="col-sm-2 control-label" for="content">内容</label>
					<div class="col-sm-4">
						<script id="editor" type="text/plain" style="width:100%;height: 125px;">${o.content}</script>
                        <%--<textarea class="form-control" id="content" name="content" rows=3>${o.content}</textarea>--%>
					</div>
				</div>


			</form>
			<div>
				附件列表&nbsp;&nbsp;
                <button type="button" class="btn btn-info" onclick="onUpload()">上传附件</button>
			</div>
			<table id="grid" style="height:35px;"></table>
			<div id="pager" style="height:35px;"></div>
		</div>
		<%--<div class="col-md-6 col-sm-6">--%>
			<%--<div class="box box-info">--%>
            <%--<div class="box-header with-border">--%>
              <%--<h3 class="box-title">督办信息</h3>--%>

              <%--<div class="box-tools pull-right">--%>
                <%--<button onclick="onSelPerson()" type="button" class="btn btn-box-tool"><i class="glyphicon glyphicon-plus"></i></button>--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<div class="box-body" id="infoBody">--%>

            <%--</div>--%>
          <%--</div>--%>
		<%--</div>--%>

	</div>
</body>
</html>
