<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="scroll2" height="390">
	<tr>
		<td align="center">
			<div id="main">
				<div class="box">
					<#list banners as banner> 
						<#if banner_index==0> 
							<img style="opacity: 1; filter: alpha(opacity=100);" src="/${urlPath}/${banner.img}" /> 
						<#else> 
							<img src="/${urlPath}/${banner.img}" />
						</#if> 
					</#list>
				</div>
				<div class="page">
					<#list banners as banner>
						<a href="javascript:void(0);" class="noactive"></a> 
					</#list>
				</div>
			</div>
		</td>
	</tr>
</table>
