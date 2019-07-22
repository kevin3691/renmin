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
<title>打印</title>
	<style>
		html, body {
			margin: 0;
			padding: 0;
		}
		.table_box {
			width: 794px;
			height: 1000px;
			margin: auto;
		}
		.table_tit {
			font: 20px/24px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit2 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit3 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit4 span {
			display: block;
			width: 20px;
			margin-left: 8px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}
		.table_tit5 span {
			display: block;
			width: 20px;
			margin-left: 24px;
			float: left;
			font: 20px 宋体;
			text-align: center;
			font-weight: 600;
		}

		.table_tit1 {
			font: 19px 仿宋;
			text-align: center;
			border-collapse:collapse;
		}
		.dtable {
			margin-left: 105px;
			border: 2px solid #000;
			border-bottom:1px solid #000;
		}
		.dtable1 {
			margin-left: 105px;
			border: 2px solid #000;
			border-top:1px solid #000; margin-top:-1px;
		}
		.dtable th, .dtable td { border-bottom: 1px solid #000;border-right: 1px solid #000;
		}
		.dtable1 th, .dtable1 td {border-right: 1px solid #000;
		}
		.title {
			width: 794px;
			text-align: center;
			text-decoration: underline;
			font: 33px 黑体;
			font-weight: bold;
			margin-top: 106px;
		}
		.title span{font: 33px 宋体;
			font-weight: bold;}
		.mingcheng {
			width: 794px;
			height: 18px;
			margin-top: 30px;
			margin-bottom: 10px
		}
		.mingcheng div {
			width: 627px;
			margin-left: 105px;
		}
		.mc_left {
			font: 19px 仿宋;
			margin-left: 12px;
			float: left;
		}
		.mc_right {
			font: 19px 仿宋;
			margin-right: 35px;
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



function onprint(){
    document.getElementById("btnPrint").style.display = "none";
    window.print();
    document.getElementById("btnPrint").style.display = "block";
}
function initText(){
    <c:forEach items="${list}" var="in">
    if(  '${in.descr}' != null &&  '${in.descr}' != "" && '${ins.id}' != '${in.id}'){
        html = '<br>'
        html += '${in.descr}'
        <%--html += '<div style="text-align: right"><span style="text-align: right">'--%>
        <%--html += '<br><br>'--%>
        <%--html +='姓名：${in.actorName}'--%>
        <%--html += '&nbsp;&nbsp;&nbsp;&nbsp;'--%>
        <%--html +='时间：${in.actAt}'.replace(".0","")--%>
        <%--html += '<span></div>'--%>
        $("#${in.stepId}").html(html);
    }




    </c:forEach>

}

    $ (function () {
		$("#type${o.type}").css("display","block")
        initText()
    })
</script>

</head>

<body>
<div style="text-align: center">
	<a href="javascript:;" id="btnPrint" onclick="onprint()" class="easyui-linkbutton" data-options="selected:true" >打印</a>
</div>
<div class="table_box" id="type2"  style="display:none">
	<div class="title">文件呈批笺${o.colSym}（号）</div>
	<div class="mingcheng">
		<div> <span class="mc_left">中共邯郸市委组织部办公室</span>  <span class="mc_right">
			<fmt:formatDate pattern="yyyy年MM月dd日"
							value="${o.lwsj}" />
		</span></div>
	</div>
	<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文<br />
				单&nbsp;位</td>
			<td width="152" class="table_tit1">${o.org}</td>
			<td width="60" class="table_tit" >来&nbsp;文
				编&nbsp;号</td>
			<td width="155" class="table_tit1" >${o.lwbh}</td>
			<td width="47" class="table_tit" >密<br />级</td>
			<td width="50" class="table_tit1">${o.miji}</td>
			<td width="34" class="table_tit" >页数</td>
			<td width="56" class="table_tit1" >${o.page}</td>
		</tr>
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文
				标&nbsp;题</td>
			<td height="15" colspan="7" class="table_tit1">${o.title}</td>
		</tr>
		<tr>
			<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>意<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        见</span></td>
			<td  colspan="7" id="8" valign="top">
                </td>
                </tr>
                <tr>
                <td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
                    <br />
                    <br />
                    <br />
                    见</span></td>
                <td colspan="7" id="7" valign="top"></td>
		</tr>
		<tr style="border-bottom:none;">
			<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="7"  style="border-bottom:none;" id="6" valign="top"></td>
		</tr>
	</table>
	<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
		<tr>
			<td width="71" class="table_tit1">经办人</td>
			<td width="90">${o.jbr}</td>
			<td width="94" class="table_tit1">联系电话</td>
			<td width="136">${o.phone}</td>
			<td width="222" class="table_tit1">${o.descr}</td>
		</tr>
	</table>
</div>


<div class="table_box" id="type3" style="display:none">
	<div class="title" style="text-decoration:none">情&nbsp;况&nbsp;报&nbsp;告</div>
	<div class="mingcheng">
		<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																										  value="${o.lwsj}" /></span> </div>
	</div>
	<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
		<tr>
			<td width="72" height="55" class="table_tit">处室</td>
			<td width="152" class="table_tit1">${o.org}</td>
			<td width="60" class="table_tit" >内部保密</td>
			<td width="155" class="table_tit1" >${o.miji}</td>
			<td width="47" class="table_tit" >页<br />数</td>
			<td width="50" class="table_tit1">${o.page}</td>
			<td width="34" class="table_tit" >编号</td>
			<td width="56" class="table_tit1" >${o.lwbh}</td>
		</tr>
		<tr>
			<td width="72" height="55" class="table_tit">报&nbsp;告
				主&nbsp;题</td>
			<td height="15" colspan="7" class="table_tit1">${o.title}</td>
		</tr>
		<tr>
			<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>批<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        示</span></td>
			<td  colspan="7" id="11" valign="top"></td>
		</tr>
		<tr>
			<td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="7" id="10" valign="top"></td>
		</tr>
		<tr style="border-bottom:none;">
			<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>处<br />
        <br />室</span><span>意<br />

        <br />
        见</span></td>
			<td colspan="7"  style="border-bottom:none;" id="9" valign="top"></td>
		</tr>
	</table>
	<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
		<tr>
			<td width="73" class="table_tit1">经办人</td>
			<td width="93">${o.jbr}</td>
			<td width="96" class="table_tit1">联系电话</td>
			<td width="141">${o.phone}</td>
			<td width="227" class="table_tit1">${o.descr}</td>
		</tr>
	</table>
</div>



<div class="table_box" id="type4" style="display:none">
	<div class="title">明传电报呈批笺（<span>${o.colSym}</span>号）</div>
	<div class="mingcheng">
		<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																										  value="${o.lwsj}" /></span> </div>
	</div>
	<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文<br />
				单&nbsp;位</td>
			<td width="152" class="table_tit1">${o.org}</td>
			<td width="60" class="table_tit" >来&nbsp;文
				编&nbsp;号</td>
			<td width="155" class="table_tit1" >${o.lwbh}</td>
			<td width="47" class="table_tit" >密<br />级</td>
			<td width="50" class="table_tit1">${o.miji}</td>
			<td width="34" class="table_tit" >页数</td>
			<td width="56" class="table_tit1" >${o.page}</td>
		</tr>
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文
				标&nbsp;题</td>
			<td height="15" colspan="7" class="table_tit1">${o.title}</td>
		</tr>
		<tr>
			<td width="72" height="275" class="table_tit2"><span>市<br />
        <br />
        委<br />
        <br />
        领<br />
        <br />
        导</span><span>意<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        见</span></td>
			<td  colspan="7" id="14" valign="top"></td>
		</tr>
		<tr>
			<td width="72" height="191" class="table_tit3"><span>常务副部长</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="7" id="13" valign="top"></td>
		</tr>
		<tr style="border-bottom:none;">
			<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="7"  style="border-bottom:none;" id="12" valign="top"></td>
		</tr>
	</table>
	<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
		<tr>
			<td width="71" class="table_tit1">经办人</td>
			<td width="90">${o.jbr}</td>
			<td width="94" class="table_tit1">联系电话</td>
			<td width="136">${o.phone}</td>
			<td width="222" class="table_tit1">${o.descr}</td>
		</tr>
	</table>
</div>


<div class="table_box" id="type5" style="display:none">
	<div class="title">文&nbsp;件&nbsp;呈&nbsp;批&nbsp;笺（${o.colSym}号）</div>
	<div class="mingcheng">
		<div> <span class="mc_left">中共邯郸市委组织部办公室</span><span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																							  value="${o.lwsj}" /></span>   </div>
	</div>
	<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文<br />
				单&nbsp;位</td>
			<td width="152" class="table_tit1">${o.org}</td>
			<td width="60" class="table_tit" >来&nbsp;文
				编&nbsp;号</td>
			<td width="155" class="table_tit1" >${o.lwbh}</td>
			<td width="47" class="table_tit" >密<br />级</td>
			<td width="50" class="table_tit1">${o.miji}</td>
			<td width="34" class="table_tit" >页数</td>
			<td width="56" class="table_tit1" >${o.page}</td>
		</tr>
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文
				标&nbsp;题</td>
			<td height="15" colspan="7" class="table_tit1">${o.title}</td>
		</tr>
		<tr>
			<td width="72" height="104" class="table_tit2"><span>部务会成员</span><span>圈<br />
        <br />
        <br />
        <br />
        阅</span></td>
			<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
				<tr>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none; border-right:none;"></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td width="72" height="87" class="table_tit">签&nbsp;名</td>
			<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
				<tr>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none; border-right:none;"></td>
				</tr>
			</table></td>
		</tr>
		<tr>
			<td width="72" height="55" class="table_tit">时&nbsp;间</td>
			<td  colspan="7"><table width="100%%" border="0" height="100%%" cellspacing="0">
				<tr>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none;"></td>
					<td style=" border-bottom:none; border-right:none;"></td>
				</tr>
			</table></td>
		</tr>
		<tr>
			<td width="72" height="220" class="table_tit5"><span>领<br /><br />导<br /><br />批<br /><br />示</span></td>
			<td colspan="7" id="17" valign="top"></td>
		</tr>
		<tr style="border-bottom:none;">
			<td width="72" height="104" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="7"  style="border-bottom:none;" id="16" valign="top"></td>
		</tr>
	</table>
	<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
		<tr>
			<td width="71" class="table_tit1">经办人</td>
			<td width="90">${o.jbr}</td>
			<td width="94" class="table_tit1">联系电话</td>
			<td width="136">${o.phone}</td>
			<td width="222" class="table_tit1">${o.descr}</td>
		</tr>
	</table>
</div>



<div class="table_box" id="type6" style="display:none">
	<div class="title">密码电报呈批笺（<span>2018</span>）${o.colSym}号</div>
	<div class="mingcheng">
		<div> <span class="mc_left">${baseUser.baseOrgName}</span> <span class="mc_right"><fmt:formatDate pattern="yyyy年MM月dd日"
																										  value="${o.lwsj}" /></span> </div>
	</div>
	<table width="627" height="701" border="0" bordercolor="#000000" cellspacing="0" class="dtable">
		<tr>
			<td width="72" height="55" class="table_tit">来&nbsp;文<br />
				单&nbsp;位</td>
			<td width="217" class="table_tit1">${o.org}</td>
			<td width="64" class="table_tit" >来&nbsp;文
				编&nbsp;号</td>
			<td width="190" class="table_tit1" >${o.lwbh}</td>
			<td width="40" class="table_tit" >密<br />级</td>
			<td width="44" class="table_tit1">${o.miji}</td>
		</tr>
		<tr>
			<td width="64" height="55" class="table_tit">来&nbsp;文
				标&nbsp;题</td>
			<td height="15" colspan="5" class="table_tit1">${o.title}</td>
		</tr>
		<tr>
			<td width="64" height="400" class="table_tit5"><span>领<br />
        <br />
        导<br />
        <br />
        批<br />
        <br />
        示</span></td>
			<td  colspan="5" id="19" valign="top"></td>
		</tr>

		<tr style="border-bottom:none;">
			<td width="64" height="170" class="table_tit4"  style="border-bottom:none;" ><span>办公室拟办</span><span>意<br />
        <br />
        <br />
        <br />
        见</span></td>
			<td colspan="5"  style="border-bottom:none;" id="18" valign="top"></td>
		</tr>
	</table>
	<table width="627" height="44" border="0" bordercolor="#000000" cellspacing="0" class="dtable1">
		<tr>
			<td width="72" class="table_tit1">经办人</td>
			<td width="90">${o.jbr}</td>
			<td width="94" class="table_tit1">联系电话</td>
			<td width="136">${o.phone}</td>
			<td width="222" class="table_tit1">${o.descr}</td>
		</tr>
	</table>
</div>

</body>
</html>
