<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<#include "head.ftl" parse=true encoding="utf-8">
</head>
<body>
	<#include "header.ftl" parse=true encoding="utf-8">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="scroll">
		<tr>
			<td align="center" class="scroll_img1"><img
				src="../images/gsjj_03.jpg" width="1012" height="224" /></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		bgcolor="#f4f4f4">
		<tr>
			<td>
				<div class="dqwzbg">
					<div class="dqwz">
						<span class="c_nav_wz">当前位置： <a href="index.html">首页</a> >
							${news.colTitle}
						</span>
					</div>
				</div>
				<div class="content">
					<h1>
						${news.colTitle}<span>Products and Solutions</span>
					</h1>
					<span class="eeq">
						<div class="clear"></div>
					</span>
					<div class="ser_box">
						<h2 class="htitle">${news.title}</h2>
						<div class="a_text">${news.content}</div>
						<div class="clear"></div>
						<div class="white">&nbsp;</div>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td height="120"></td>
		</tr>
	</table>
	<#include "footer.ftl" parse=true encoding="utf-8">
</body>
</html>
