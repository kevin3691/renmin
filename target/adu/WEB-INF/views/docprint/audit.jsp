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
        var lastFlag ;
        function loadGrid () {
            $ ("#grid").jqGrid (
                {
                    url : "comm/attachment/list4",
                    postData:{
                        refNum: "${o.id}",
                        applyTo:"DOCPRINT"
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
                                if("${o.status}" == 0){
                                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                                }
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



            $ ("#cash").jqGrid (
                {
                    url : "cash/details/list",
                    postData:{
                        refNum:"${o.id}",
                        applyTo:"DOCPRINT"
                    },
                    height : 150,
                    rownumbers : true,
                    colModel : [
                        {
                            label : '名称',
                            name : 'kemu',
                            index : 'kemu',
                            width : 200,
                            editable:true,edittype:'text',editrules:{required:true}
                        },{
                            label : '金额',
                            name : 'jine',
                            index : 'jine',
                            width : 200,
                            editable:true,edittype:'text',editrules:{required:true}
                        },
                        {
                            label : '说明',
                            name : 'descr',
                            index : 'descr',
                            width : 200,
                            editable:true,edittype:'text'
                        },
                        {
                            label : ' ',
                            name : 'id',
                            width : 140,
                            align : 'center',
                            sortable : false,
                            formatter : function (value, options, row) {
                                var btn = "";
                                if("${o.status}" == 0){
                                    btn += '&nbsp;<a href="javascript:delRow(' + value + ',' + row.lineNo + ')" title="">删除</a>'
                                }

                                return btn;
                            }
                        },{
                            name : 'lineNo',
                            hidden:true
                        },{
                            name : 'applyTo',
                            hidden:true
                        },{
                            name : 'refNum',
                            hidden:true
                        }
                    ],


                    sortname : 'id',
                    sortorder : "asc",
                    onSelectRow : function(id){
                        if("${o.status}" == 0){
                            if(id && id!=lastFlag){
                                $('#cash').jqGrid('saveRow',lastFlag);
                                lastFlag=id;
                            }
                            $('#cash').jqGrid('editRow',id,true);
                        }


                    }
                });

        }

        function addRow()
        {
            $('#cash').jqGrid('saveRow',lastFlag);
            var selectedId = $("#cash").jqGrid("getGridParam", "selrow");
            var dataRow = {
                id: 0,
                kemu: "",
                jine:"",
                descr:"",
                lineNo:0,
                applyTo:"",
                refNum:0
            };
            var ids = jQuery("#cash").jqGrid('getDataIDs');
            //获得当前最大行号（数据编号）
            var rowid = Math.max.apply(Math,ids);
            rowid =rowid + 1;
            if (selectedId) {
                $("#cash").jqGrid("addRowData", rowid, dataRow, "after", selectedId);
            } else {
                $("#cash").jqGrid("addRowData", rowid, dataRow, "last");
            }

        }

        function delRow(id,lineNo) {
            $('#cash').jqGrid('saveRow',lastFlag);
            var selectedId = $("#cash").jqGrid("getGridParam","selrow");
            if(!selectedId){
                alert("请选择要删除的行");
                return;
            }else{
                $("#cash").jqGrid("delRowData", selectedId);
                if(id > 0){
                    $.post ("cash/details/del", {
                        id : lineNo
                    }, function () {

                    });
                }
            }
        }


        //保存
        function onSave () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }

            var para = $ ("#mainForm").serialize ();
            $.post ('docprint/save', $ ("#mainForm").serialize (), function (result, status) {
                parent.onQ()
                document.location.href = "docprint/audit/?id=" + result.entity.id
            });
        }

        function onSubmit (flag) {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }

            var para = $ ("#mainForm").serialize ();
            $("#status").val(flag)
            $.post ('docprint/audit', $ ("#mainForm").serialize (), function (result, status) {
                parent.onQ()
                document.location.href = "docprint/audit/?id=" + result.entity.id
            });

        }

        //返回
        function onCancel () {
            var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
            parent.layer.close (index); //再执行关闭
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
                applyTo : "DOCPRINT",
                refNum : "${o.id}"
            }
            UPLOADER.init ();

            //加载select特效
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#sqrq").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#sqrq').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#sqrq').inputmask ("yyyy-mm-dd");


            //赋值
            if ("${o.id}" > 0){
            }else{
                $("#person").val("${baseUser.basePersonName}")
                $("#personId").val("${baseUser.basePersonId}")
                $("#org").val("${baseUser.baseOrgName}")
                $("#orgId").val("${baseUser.baseOrgId}")
            }
            if ("${o.status}" > 0){

                $ ("#btnDate").css("display","none");
                $ ("#sqrq").attr("readonly","readonly");
                $ ("#sqyy").attr("readonly","readonly");

                $ ("#ss").css("display","block");
                $ ("#btnAdd").css("display","none");
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
		<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
		<input type="hidden" id="personId" name="personId" value="${o.personId}" />
		<input type="hidden" id="org" name="org" value="${o.org}" />
		<input type="hidden" id="sprId" name="sprId" value="${o.sprId}" />
		<input type="hidden" id="spr" name="spr" value="${o.spr}" />
		<input type="hidden" id="actAt" name="actAt" value="${o.actAt}" />
		<input type="hidden" id="status" name="status" value="${o.status}" />
		<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
		<input type="hidden" id="descr" name="descr" value="${o.descr}" />
		<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

		<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
		<div class="form-group">
			<label class="col-sm-2 control-label" for="person">申请人</label>
			<div class="col-sm-4">
						<span class="input-group"> <input class="form-control"
														  id="person" name="person"
														  value="${o.person}" type="text" readonly required /><span
								class="input-group-btn">
							<button class="btn btn-info btn-flat" type="button" id="btnSel"
									onclick="onSelPerson()">选择</button>
					</span>
					</span>
			</div>

		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="sqrq">申请日期</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="sqrq" name="sqrq" value="${o.sqrq}"
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar" id="btnDate"
						   onclick="$('#sqrq').datetimepicker('show');"></i>
					</div>
				</div>
			</div>

		</div>


		<div class="form-group">
			<div class="container-fluid">
				<div class="box box-default box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">明细</h3>

						<div class="box-tools pull-right">
							<button type="button" onclick="addRow()" class="btn btn-box-tool"><i id="btnAdd" class="fa fa-plus"></i>
							</button>
						</div>
						<!-- /.box-tools -->
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="cash"></table>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
		</div>

		<div class="form-group" style="display: none;">
			<label class="col-sm-2 control-label" for="sqyy">用章事由</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="sqyy" name="sqyy" rows=3>${o.sqyy}</textarea>
			</div>

		</div>
		<div class="form-group" id="ss" style="display: none;">
			<label class="col-sm-2 control-label" for="content">审批意见</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="content" name="content" rows=3>${o.content}</textarea>
			</div>

		</div>

		<div>
			附件列表&nbsp;&nbsp;
			<button type="button" class="btn btn-info" id="btnUp" onclick="onSelfUpload()">上传附件</button>
		</div>
		<table id="grid" style="height:35px;"></table>
		<div id="pager" style="height:35px;"></div>

		<div class="form-group controls" style="text-align:center">
			<button type="button" id="btnSave" class="btn btn-info" onclick="onSave()">保存</button>
			&nbsp;&nbsp;
			<button type="button" id="btnSubmit" class="btn btn-info" onclick="onSubmit(3)">同意申请</button>
			&nbsp;&nbsp;
			<button type="button" id="btnSubmit2" class="btn btn-info" onclick="onSubmit(2)">驳回申请</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
		</div>
	</form>
</div>
</body>
</html>
