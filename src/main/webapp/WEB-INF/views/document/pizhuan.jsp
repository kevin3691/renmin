<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<title>文件批转</title>
<script type="text/javascript">
    function loadGrid () {

        $ ("#grid").jqGrid (
            {
                url : "comm/attachment/list4",
                postData:{
                    refNum: "${doc.id}"
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


    function loadGrid_ljr () {

        $ ("#grid_ljr").jqGrid (
            {
                url : "rp/list",
                postData:{
                    refNum: "${doc.id}"
                },
                height : $ (document).height () - 380,
                rownumbers : true,
                colModel : [

                    {
                        label : '姓名',
                        name : 'personName',
                        index : 'personName',
                        width : 200
                    },{
                        label : '时间',
                        name : 'reciveDate',
                        index : 'reciveDate',
                        width : 180,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (value, 3);
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
                pager : '#pager_ljr',
                sortname : 'id',
                sortorder : "asc",
            });
        jQuery ("#grid_ljr").jqGrid ('bindKeys', {
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

    function onSelPerson () {
        layer.open ({
            type : 2,
            title : "选择经办人",
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'base/person/sel4doc?docId=${doc.id}' //iframe的url
        });
    }

    //选择部门回调方法
    function onPersonSelOk (node) {
        var para = {

        };
        $ ("#grid_ljr").jqGrid ("setGridParam", {
            postData : para
        }).trigger ("reloadGrid");

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
        if("${doc.id}" == 0)
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
    
    function onCancel(){
    	window.top.onCancel();
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

            $ ("#type").select2 ("val", "${doc.type}");
        })
    }

    function onSave(){
    	var wsList=new Array()

    	<c:forEach items="${wsList}" var="ws" varStatus="status">
		var id = ${ws.id}
    	var entity = new Object();
        var content = UE.getEditor ('${ws.id}').getContent ();
    	entity.id = id;
    	entity.content = content
    	entity.actorName = "${ws.actorName}"
    	entity.actorId = ${ws.actorId};
    	entity.status = $("input[name='s_${ws.id}']:checked").val()
		entity.date = $("#date_${ws.id}").val()
    	wsList.push(entity);
    	</c:forEach>
    	var pishiList = new Object();
    	pishiList.pishiList = wsList;

    	$.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			type : "POST",
			url : "document/savePi?docId=${doc.id}&isDu=" + $("#isDu").val(),
			data : JSON.stringify(pishiList),
			success : function(result) {
				//document.location = 'document/index'
				document.location.reload();
			},
			error : function(result) {
				alert("保存失败！");
			}
		});

    }


    $ (function () {
        UPLOADER.formData = {
            applyTo : "${doc.category}",
            refNum : "${doc.id}"
        }
        UPLOADER.init ();
		bindType()
        $ (".select2").select2 ();
        if ("${doc.id}" > 0){
            $ ("#isDu").select2 ("val", "${doc.isDu}");

            $ ("#type").select2 ("val", "${doc.type}");



        }



        loadGrid()
        loadGrid_ljr()
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
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">来文单位</label>
				<div class="col-sm-4">
					<input class="form-control" id="org" name="org" value="${doc.org}" type="text" readonly />

				</div>
				<label class="col-sm-2 control-label" for="title">来文编号</label>
				<div class="col-sm-4">
					<input class="form-control" id="lwbh" name="lwbh" value="${doc.lwbh}" type="text" readonly />

				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">密级</label>
				<div class="col-sm-4">
					<input class="form-control" id="miji" name="miji" value="${doc.miji}" type="text" readonly />

				</div>
				<label class="col-sm-2 control-label" for="title">页数</label>
				<div class="col-sm-4">
					<input class="form-control" id="page" name="page" value="${doc.page}" type="text" readonly />

				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">来文标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title" value="${doc.title}" type="text" readonly />

				</div>
			</div>
			<c:forEach items="${wsList}" var="ws" varStatus="status">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">${ws.title }</label>
				<div class="col-sm-8">
					<script id="${ws.id}" name="${ws.id}" type="text/plain" style="width:100%;height: 125px;">${ws.descr }</script>
                    </div>
                    <div class="col-sm-2">
                        姓名：${ws.actorName}
                        <div class="input-group">
                        <input class="form-control" id="date_${ws.id}" name="date_${ws.id}" value="${ws.recordInfo.createdAt}" type="text" />
                        <div class="input-group-addon">
                        <i class="fa fa-calendar"   onclick="$('#date_${ws.id}').datetimepicker('show');"></i>
                        </div>
                        </div>
                        <input type="radio" name="s_${ws.id}"  value="否" checked>否</input>
                    <input type="radio"  name="s_${ws.id}"   value="在批">在批</input>
                        <input type="radio" name="s_${ws.id}"  value="已批">已批</input>
                        </div>


                        </div>

                        <script type="text/javascript">
                        $("input[name='s_${ws.id}'][value='${ws.okMsg}']").attr("checked",true);
                    //为日期设置格式输入
                    $ ("#date_${ws.id}").inputmask ("yyyy-mm-dd", {
                        "placeholder" : "yyyy-mm-dd"
                    });
                    //加载日期控件
                    $ ('#date_${ws.id}').datetimepicker ({
                        minView : 3
                        //时间，默认为日期时间
                    });
                    //设置掩码
                    $ ('#date_${ws.id}').inputmask ("yyyy-mm-dd");

                    UE.getEditor ('${ws.id}');
					</script>
					</c:forEach>

			<div class="form-group">

				<label class="col-sm-2 control-label" for="jbr">经办人</label>
				<div class="col-sm-4">
					<input class="form-control" id="jbr" name="jbr" value="${doc.jbr}"  type="text" readonly />

				</div>

				<label class="col-sm-2 control-label" for="phone">电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone" value="${doc.phone}"  type="text" readonly />

				</div>

			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="descr" name="descr" value="${doc.descr}"  type="text" readonly />

				</div>
			</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="descr">附件</label>
						<div class="col-sm-10">
							<button class="btn btn-info" id="btnUpload" type="button"
									onclick="onSelfUpload()">添加附件</button>
							<table id="grid"></table>
							<div id="pager" style="height:35px;"></div>

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

                        </div>
                        </li>
                        </ul>

                        <div class="form-group">
                        <label class="col-sm-3 control-label" for="descr">是否督办</label>
                        <div class="col-sm-9">
                        <select id="isDu" name="isDu" class="select2" style="width: 180px">
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

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="descr">领件人</label>
                        <div class="col-sm-9">
							<button type="button" class="btn btn-info" onclick="onSelPerson()">添加领件人</button>
                    </div>
                    </div>
							<div class="form-group">
								<div class="col-sm-12">
									<table id="grid_ljr"></table>
									<div id="pager_ljr" style="height:35px;"></div>

								</div>
							</div>

                        </div>


			</div>




		</div>

	</form>

	</div>
</div>

</body>
</html>
<script type="text/javascript">

    $('.easyui-tabs1').tabs({
        tabHeight: 36,
        onSelect: function() {
            setTimeout(function() {
                resizeTabs();
            },100)
        }
    });
    $(window).resize(function(){
        $('.easyui-tabs1').tabs("resize");
        setTimeout(function() {
            resizeTabs();
        },100)
    }).resize();
    function resizeTabs() {
        var $body = $('body'),
            $window = $(window);

        if($window.height() > $body.height()) {

            $('.panel-body').height($window.height() - 44);

        }
    }
</script>