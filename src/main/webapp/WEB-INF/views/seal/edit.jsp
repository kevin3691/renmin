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
	<script src="jslib/jsjs/modernizr.js"></script>
	<!--[if lt IE 9]>
	<script type="text/javascript" src="jslib/jsjs/flashcanvas.js"></script>
	<![endif]-->

	<link rel="stylesheet" href="css/viewimg.css">

	<script src="jslib/jsjs/jSignature.min.noconflict.js"></script>
<title>会议-编辑</title>
<script type="text/javascript">

    function loadGrid () {
        $ ("#grid").jqGrid (
            {
                url : "comm/attachment/list4",
                postData:{
                    refNum: "${o.id}",
                    applyTo:"SEAL"
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
    }

	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
		var imgSrc = "";
		$('#photoos').find("img").each(function(i,v){
			imgSrc+=v.src+"|";
		});
		$("#photo").val(imgSrc);
		$("#sealTypeName").val($("#sealTypeId").select2('data').text)
	    var para = $ ("#mainForm").serialize ();
	    $.post ('seal/save', $ ("#mainForm").serialize (), function (result, status) {
			//parent.onQ()
			document.location.href = "seal/index";
			// document.location.href = "seal/edit/?id=" + result.entity.id
	    });
    }

    function onSubmit () {
        //表单验证
        if (!$ ('#mainForm').validate ().form ()){
            return false;
        }

        var para = $ ("#mainForm").serialize ();

        $.post ('seal/submit', $ ("#mainForm").serialize (), function (result, status) {
            parent.onQ()
            document.location.href = "seal/edit/?id=" + result.entity.id
        });

    }

    //返回
    function onCancel () {
	    // var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    // parent.layer.close (index); //再执行关闭
		document.location.href = 'seal/index'
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
		{
			alert("先保存再上传附件！")
			return
		}

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

	function onSelfUpload() {
		if ("${o.id}" == 0) {
			alert("请先保存再上传附件！");
			return;
		}
		$("input[name='file']").click();
	}

	//拍照
	function photograph() {
		/*if ("${o.id}" == 0) {
			alert("先保存再上传附件！")
			return
		}*/
		var index = layer.open({
			type: 2,
			// shadeClose: true,
			// shade: 0.8,
			area: ['100%', '100%'],
			// maxmin: true,
			content: 'seal/photo?id=' + ${o.id}, //iframe的url
			offset: ['0px', '0px'],
			scrollbar: false
		});

		// layer.full(index);

		//document.location.href = "seal/photo"


	}

	function DeleteImage(imgdiv) {
		var imgtitle = $("img", $(imgdiv).parent().parent())[0].title;
		var mess = confirm("是否删除图片?");
		if (mess == true) {//开始删除图片
			$(imgdiv).parent().parent().parent().remove();
		}

	}

	function genImgList(src) {
		 var str = '';
         str += '<li style="cursor: hand"><div class="imgbox">';
         str += '<img width="1920px";height="1080px"; src="' + src + '" title="" />';
         str += '<div class="text"><div class="imgtext" onclick="DeleteImage(this)"> 删  除</div></div></div></li>';
		return str;
	}


	function onTakePhotoOk(photo) {


		if(photo!=""){

			var photoo = $('#photoos')
			var str = genImgList(photo)
			photoo.append(str + "<br/>")
		}
		layer.closeAll();


		/*if(photo!=""){
			$("#photo").val(photo);


			var data=photo.split("|");
			// console.log("photo1111111"+data[1])
			var photoo = $('#photoos')
			photoo.empty();
			for (var t=0;t<data.length-1;t++){
				var i = new Image()
				<%--i.src = 'data:${o.photo}'--%>
				i.src = 'data:' + data[t]
				$(i).appendTo(photoo)
				photoo.append("<br/>")
			}
		}
		layer.closeAll();*/
	}

	//签字
	function sign() {
		/*if ("${o.id}" == 0) {
			alert("先保存再上传附件！")
			return
		}*/
		var index=layer.open ({
			type : 2,
			shadeClose : true,
			shade : 0.8,
			area : [
				'60%', '60%'
			],
			content : 'seal/autograph?id=' + ${o.id}, //iframe的url
			/*content : 'seal/autograph?id=' + ${o.id}, //iframe的url
			cancel: function(){
				// 右上角关闭事件的逻辑
				document.location.href = 'seal/edit?id='+${o.id}
			}*/

		});
		layer.full(index);
	}

	function onSignOk(img) {
		$("#img").val(img);

		if($("#img").val() != ""){

			var $sigdiv = $("#signature").jSignature({'UndoButton': true})

					// All the code below is just code driving the demo.
					, $tools = $('#tools')
					, $extraarea = $('#displayarea')
					, pubsubprefix = 'jSignature.demo.'
			var i = new Image()
			i.src = 'data:' + $("#img").val();

			$extraarea.empty()
			$(i).appendTo($extraarea)
		}
		layer.closeAll();
		//document.location.reload();
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

    function bindType(){
        $.post ("sealtype/list", {
            isActive : 1
        }, function (rslt) {
            if (rslt.rows == null)
                return;
            var rows = rslt.rows;
            var html = ""
            for (var i = 0; i < rows.length; i++){
                html += '<option value='+ rows[i].id +'>'+ rows[i].name +'</option>'
            }
            $("#sealTypeId").append(html)
            $ ("#sealTypeId").select2 ("val", "${o.sealTypeId}");
            if( "${o.sealTypeId}" == 0){
                $ ("#sealTypeId").select2 ("val",rows[0].id );
            }

        })
    }

    //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
        $.post(_BasePath + "comm/uploader/saveAs",{url:json.url},function(result,stts){
            //alert(result+"\n\r"+stts)
        })
    }
    $ (function () {
        UPLOADER.formData = {
            applyTo : "SEAL",
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
		    $ ("#sealTypeId").select2 ("val", "${o.sealTypeId}");
		}else{
            $("#person").val("${baseUser.basePersonName}")
            $("#personId").val("${baseUser.basePersonId}")
            $("#org").val("${baseUser.baseOrgName}")
            $("#orgId").val("${baseUser.baseOrgId}")
		}
        if ("${o.status}" > 0){
            $ ("#sealTypeId").attr("readonly","readonly");
            $ ("#btnSel").css("display","none");
            $ ("#btnDate").css("display","none");
            $ ("#btnUp").css("display","none");
            $ ("#sqrq").attr("readonly","readonly");
            $ ("#sqyy").attr("readonly","readonly");

            $ ("#btnSave").css("display","none");
            $ ("#btnSubmit").css("display","none");
            $ ("#ss").css("display","block");
        }
		bindType()
	    loadGrid()

		if("${o.img}" != ""){

			var $sigdiv = $("#signature").jSignature({'UndoButton': true})

					// All the code below is just code driving the demo.
					, $tools = $('#tools')
					, $extraarea = $('#displayarea')
					, pubsubprefix = 'jSignature.demo.'
			var i = new Image()
			i.src = 'data:${o.img}'


			$(i).appendTo($extraarea)
		}
        if("${o.photo}"!=""){
        	var data="${o.photo}".split("|");

			var photoo = $('#photoos')

			for (var t=0;t<data.length-1;t++){

				/*var i = new Image()
				<%--i.src = 'data:${o.photo}'--%>
				i.src = 'data:' + data[t]
				$(i).appendTo(photoo)*/
				var str = genImgList(data[t])
				photoo.append(str + "<br/>")
			}







		}

    })
</script>
</head>

<body oncontextmenu=self.event.returnValue=false>
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
			<input type="hidden" id="org" name="org" value="${o.org}"/>
			<input type="hidden" id="sprId" name="sprId" value="${o.sprId}"/>
			<input type="hidden" id="spr" name="spr" value="${o.spr}"/>
			<input type="hidden" id="actAt" name="actAt" value="${o.actAt}"/>
			<input type="hidden" id="status" name="status" value="${o.status}"/>
			<input type="hidden" id="sealTypeName" name="sealTypeName" value="${o.sealTypeName}"/>
			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}"/>
			<input type="hidden" id="descr" name="descr" value="${o.descr}"/>
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}"/>
			<input type="hidden" id="img" name="img" value="${o.img}"/>
			<input type="hidden" id="photo" name="photo" value="${o.photo}"/>


			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp"/>


			<div class="row">
				<div class="col-lg-6 col-sm-6">
					<div class="form-group">

						<label class="col-lg-2  col-sm-4 control-label" for="person">申请人</label>
						<div class="col-lg-10 col-sm-8">
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

						<label class="col-lg-2 col-sm-4 control-label" for="sealTypeId">公章类型</label>
						<div class="col-lg-4 col-sm-2">
							<select id="sealTypeId" name="sealTypeId" class="select2" style="width: 180px">
								<option value="">&nbsp;</option>

							</select>
						</div>


						<label class="col-lg-2 col-sm-4 control-label" for="sqrq"
							   style="white-space:nowrap; ">申请日期</label>
						<div class="col-lg-4 col-sm-2">
							<div class="input-group">
								<input class="form-control" id="sqrq" name="sqrq"
									   value="${o.sqrq}" type="text" />
								<div class="input-group-addon">
									<i class="fa fa-calendar" id="btnDate"
									   onclick="$('#sqrq').datetimepicker('show');"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 col-sm-4 control-label" for="sqyy">用章事由</label>
						<div class="col-lg-10 col-sm-8">
							<textarea class="form-control" id="sqyy" name="sqyy" rows=3>${o.sqyy}</textarea>
						</div>

					</div>
				</div>
				<div class="col-lg-6 col-sm-6">
					<button type="button" class="btn btn-info"  onclick="sign()">签字</button>

					<div id="displayarea"></div>
				</div>
			</div>


			<div class="form-group" id="ss" style="display: none;">
				<label class="col-sm-2 control-label" for="content">审批意见</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="content" name="content" rows=3>${o.content}</textarea>
				</div>
			</div>

	<div>
<%--                    附件列表&nbsp;&nbsp;--%>
<%--                    <button type="button" class="btn btn-info" id="btnUp" onclick="onSelfUpload()">上传附件</button>--%>
                    <button type="button" class="btn btn-info"  onclick="photograph()">拍照</button>
                        </div>
                        <table id="gFrid" style="height:35px;"></table>

			<style>
				#photoos img{
                              display: block;
				}
			</style>
			<div id="photoos"></div>
<%--			附件--%>
<%--            <table id="grid" style="height:35px;"></table>--%>

            <div id="pager" style="height:35px;"></div>

			<div class="form-group controls" style="text-align:center">
				<button type="button" id="btnSave" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<%--<button type="button" id="btnSubmit" class="btn btn-info" onclick="onSubmit()">提交申请</button>
				&nbsp;&nbsp;--%>
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
