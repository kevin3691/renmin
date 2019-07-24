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
	        	window.top.OBJ.onQ()
                if(top.onCancel()){
                    top.onCancel();
                }
		    }
		    //document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
		    //document.location.reload();
	    );
    }
	

    //返回
    function onCancel () {

        window.top.onCancel();
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
	    <%--if (container == "lwlx"){--%>
		    <%--$ ("#lwlx").select2 ("val", "${o.lwlx}");--%>
	    <%--}--%>
	    <%--else if (container == "lwfs"){--%>
		    <%--$ ("#lwfs").select2 ("val", "${o.lwfs}");--%>
	    <%--}--%>
	    <%--else if (container == "level"){--%>
		    <%--$ ("#level").select2 ("val", "${o.level}");--%>
	    <%--}--%>
	    <%--else if (container == "miji"){--%>
		    <%--$ ("#miji").select2 ("val", "${o.miji}");--%>
	    <%--}--%>
	    
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
    $ (function () {
    	<%--UPLOADER.formData = {--%>
    		    <%--applyTo : "CASH",--%>
    		    <%--refNum : "${o.id}"--%>
    	    <%--}--%>
    	<%--UPLOADER.init ();--%>
	    //加载select特效
	    //$ (".select2").select2 ();

        //
        // $('#lwsj').datetimebox({
         //    value: '3/4/2010 2:3',
         //    required: true,
         //    showSeconds: false
        // });
        //
        //
	    //loadGrid();

    })
</script>

<body>









<div class="opt-buttons">
	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-list'" onclick="openDialog()">业务日志</a>
	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'">返回</a>
</div>
<div class="easyui-tabs1">
	<div title="基本信息" data-options="closable:true" class="basic-info">
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="sqrId" name="sqrId" value="${o.sqrId}" />
			<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
			<input type="hidden" id="minus" name="minus" value="${o.minus}" />
			<input type="hidden" id="title" name="title" value="${o.title}" />
			<input type="hidden" id="status" name="status" value="${o.status}" />

			<input type="hidden" id="sqr" name="sqr" value="${o.sqr}" />
			<input type="hidden" id="org" name="org" value="${o.org}" />

			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
		<table class="kv-table">
			<tbody>
			<tr>
				<td class="kv-label">部门</td>
				<td class="kv-content">${baseUser.baseOrgName}</td>
				<td class="kv-label">申请人</td>
				<td class="kv-content">${baseUser.basePersonName}</td>
				<td class="kv-label">申请日期</td>
				<td class="kv-content"></td>
			</tr>
			<tr>
				<td class="kv-label">报销用途</td>
				<td class="kv-content">光纤-五金备品</td>
				<td class="kv-label">类型</td>
				<td class="kv-content">3</td>
				<td class="kv-label">支付方式</td>
				<td class="kv-content">不公开</td>
			</tr>
			<tr>
				<td class="kv-label" colspan="6">单据明细：</td>
			</tr>
			<tr>
				<td class="kv-label">发布状态</td>
				<td class="kv-content">已发布</td>
				<td class="kv-label">发布人</td>
				<td class="kv-content">艾荣兵</td>
				<td class="kv-label">发布时间</td>
				<td class="kv-content">2016-04-08 09:43</td>
			</tr>
			<tr>
				<td class="kv-label">报销总金额</td>
				<td class="kv-content">审核通过</td>
				<td class="kv-label">单据总数</td>
				<td class="kv-content">uimaker</td>
				<td class="kv-label">实付金额</td>
				<td class="kv-content"></td>
			</tr>
			<tr>
				<td class="kv-label" colspan="6">备注：</td>
			</tr>
			<tr>
				<td class="kv-label">发布状态</td>
				<td class="kv-content">已发布</td>
				<td class="kv-label">发布人</td>
				<td class="kv-content">艾荣兵</td>
				<td class="kv-label">发布时间</td>
				<td class="kv-content">2016-04-08 09:43</td>
			</tr>
			<tr>
				<td class="kv-label" colspan="6">单据附件：</td>
			</tr>
			<tr>
				<td class="kv-label">单据附件</td>
				<td class="kv-content">已发布</td>
				<td class="kv-label">发布人</td>
				<td class="kv-content">艾荣兵</td>
				<td class="kv-label">发布时间</td>
				<td class="kv-content">2016-04-08 09:43</td>
			</tr>
			</tbody>
		</table>
		</form>
	</div>
	<div title="招标时间" data-options="closable:true">
	</div>
	<div title="项目列表" data-options="closable:true">
	</div>
	<div title="供应商" data-options="closable:true">
	</div>
</div>
<div id="dlg" class="easyui-dialog" title="业务日志查看" data-options="closed:true,modal:true" style="width:720px;height:490px;padding:10px;display:none;">
	<div class="time-line">
		<div class="time-item date">
			<div class="content-left first">
				<span>2016-04-25</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>15:58:34</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item time important">
			<div class="content-left">
				<span>17:00:21</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item date">
			<div class="content-left">
				<span>2016-04-26</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>09:21:14</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item last">
			<div class="content-left">
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
		</div>
	</div>
</div>

</body>
</html>
<script type="text/javascript">
    $('.easyui-tabs1').tabs({
        tabHeight: 36
    });


    $(".edui-body-container").css("width", "98%");

    $(window).resize(function(){
        setTimeout(function(){
            $('.easyui-tabs1').tabs("resize");
            state.setWidth("98%");
            $(".edui-body-container").css("width", "98%");
        },1);
    }).resize();
    function openDialog() {
        var tpWin = getTopWindow();
        try {
            var doc = tpWin.document;
            tpWin.$('#dlg').dialog('open');
        } catch(e) {
            $('#dlg').dialog('open');
        }
    }
    function getTopWindow(){
        var p = window;
        while(p.parent !== p) {
            p = p.parent;
        }
        return p;
    }
</script>
