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
<title>会议-编辑</title>
	<style>
		html, body {
			margin: 0;
			padding: 0;
		}
		.table_box {
			width: 794px;
			height: 1090px;
			margin: auto;
		}
		.table_tit {
			font: 22px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit1 {
			font: 22px 仿宋;
			text-align: center;
		}
		.table {
			/*margin-left: 11%;*/
			border: 2px solid #000;
		}
		.table th, .table td {
			border: 1px solid #000;
		}
		.title {
			width: 794px;
			text-align: center;
			text-decoration: underline;
			font: 36px 黑体;
			font-weight: bold;
			margin-top: 12%;
		}
		.mingcheng {
			width: 794px;
			margin-top: 3%;
			margin-bottom: 2%
		}
		.mingcheng div {
			width: 78%;
			margin-left: 11%;
		}
		.mc_left {
			font: 22px 仿宋;
			margin-left: 15px;
			float: left;

		}
		.mc_right {
			font: 20px 仿宋;
			margin-right: 15px;
			float: right;
		}
		.textarea {
			width: 98%;
			height: 99%;
			border: 0;
			margin-left: 1%;
			font: 18px/27px 宋体;
		}
		.input_text {
			width: 98%;
			height: 99%;
			border: 0;
			margin-left: 1%;
			font: 18px 宋体;
		}
	</style>
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
	    $.post ('workPlan/save', $ ("#mainForm").serialize (), function (result, status) {
		    // if (parent.onSaveOk){
			 //    parent.onSaveOk (result.entity)
		    // }
			var id = result.entity.id
            var days = $(".days")
            var dd = new Array()
            $.each(days,function(i,v){
                var entity = new Object()
                entity.content = v.value
                entity.day = v.id
				entity.refNum = id
                dd.push(entity)
            })
			var plans = new Object();
			plans.planList = dd;
			var json = JSON.stringify(plans)
            $.ajax({
                headers : {
                    'Accept' : 'application/json',
                    'Content-Type' : 'application/json'
                },
                type : "POST",
                url : "plan/savePlans",
                data :json,
                success : function(result) {
                    if (parent.onSaveOk){
                        parent.onSaveOk (result.entity)
                    }
                },
                error : function(result) {
                    alert("保存失败！");
                }
            });
            $.post ('plan/savePlans',plans, function (result, status) {

            });
			//document.location.href = "meet/edit/?id=" + result.entity.id
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
        var title = '选择人员'

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

    function getTime() {
        //计算出相差天数
        var date1 = $("#starttime").val();
        var date2 = $("#finishtime").val();
        var date3 = new Date(date2).getTime() - new Date(date1).getTime(); //时间差的毫秒数
        var days = Math.floor(date3 / (24 * 3600 * 1000))
        genData(days)
    }

    function getFormatDate(arg) {
        if (arg == undefined || arg == '') {
            return '';
        }

        var re = arg + '';
        if (re.length < 2) {
            re = '0' + re;
        }

        return re;
    }
    function genData(days) {

        var day = $("#starttime").val();
        var html = ''
        var weekday=new Array(7)
        weekday[0]="星期天"
        weekday[1]="星期一"
        weekday[2]="星期二"
        weekday[3]="星期三"
        weekday[4]="星期四"
        weekday[5]="星期五"
        weekday[6]="星期六"
		for (var i = 0; i<= days; i++){

            html += '<div class="form-group">'
            html += '<label class="col-sm-2 control-label" for="">'+day+'<br/>' + weekday[new Date(day).getDay()] + '</label>'
            html += '<div class="col-sm-10">'
            html += '<textarea class="form-control days" id="'+day+'" name="'+day+'" rows="3">'

			if("${o.id}" > 0){
                html += map[day].content
			}
            html += '</textarea>'
            html += '</div></div>'
			var date = new Date(day)
			date.setDate(date.getDate() + 1)
			var month = date.getMonth() + 1
			var day = date.getDate()
			month =getFormatDate(month)
			day = getFormatDate(day)
            day = date.getFullYear() + "-" + month+ "-" + day

		}
		$("#works").html(html)
    }

    function genWork(){
        var  sd=$("#starttime").val();
        var  fd=$("#finishtime").val();
        if(sd!=''&&fd!=''){
            if(fd < sd){
                alert("开始日期不能小于结束日期！")
            }else{
                getTime()
			}
        }
	}
var map = {}

    $ (function () {


        if("${o.id}" > 0){

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
		<div class="form-group">
			<label class="col-sm-2 control-label" for="person">姓名</label>
			<div class="col-sm-2">
				${o.person}
			</div>
			<label class="col-sm-2 control-label" for="starttime">开始时间</label>
			<div class="col-sm-2">
				${o.starttime}
			</div>
			<label class="col-sm-2 control-label" for="finishtime">结束时间</label>
			<div class="col-sm-2">
				${o.finishtime}
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-12">
				<table width="100%" height="230" border="2" cellspacing="0" class="table">
					<tr>
						<td height="20" width="9%" class="table_tit">时间<br />
							<c:forEach items="${plans}" var="p" varStatus="status">
						<td width="13%" class="table_tit1">${p.key}</td>
						</c:forEach>
					</tr>
					<tr>
						<td height="120" class="table_tit">内容<br />
							<c:forEach items="${plans}" var="p" varStatus="status">
						<td class="table_tit1">${p.value}</td>
						</c:forEach>
					</tr>
				</table>
			</div>
		</div>






			<div class="form-group">
				<label class="col-sm-2 control-label" for="content">备注</label>
				<div class="col-sm-10">
					${o.content}
                    </div>
                    </div>
                    <%--<div>--%>
                    <%--附件列表&nbsp;&nbsp;--%>
                        <%--</div>--%>
                        <%--<table id="grid" style="height:35px;"></table>--%>
                        <%--<div id="pager" style="height:35px;"></div>--%>

	</div>
</body>
</html>
