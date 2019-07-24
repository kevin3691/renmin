<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<#include "head.ftl" parse=true encoding="utf-8">
<script type="text/javascript" src="/${urlPath}/${webStaticPath}/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/${urlPath}/${webStaticPath}/js/scroll.min.js"></script>
<script type="text/javascript" src="/${urlPath}/${webStaticPath}/js/index.min.js"></script>
</head>

<body>
	<#include "header.ftl" parse=true encoding="utf-8">
	<#include "indexBanner.ftl" parse=true encoding="utf-8">
	<div class="hdiv">
		<table width="1400" border="0" cellspacing="0" cellpadding="0"
			height="395">
			<tr>
				<td>
					<table width="1041" border="0" cellspacing="0" cellpadding="0"
						class="section_frame" height="325">
						<tr>
							<td>
								<div id="divScroll">
									<#include "indexCpjfa.ftl" parse=true encoding="utf-8">
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<#include "footer.ftl" parse=true encoding="utf-8">
</body>
</html>
