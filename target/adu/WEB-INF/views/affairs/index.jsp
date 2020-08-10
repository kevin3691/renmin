

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- saved from url=(0026)http://hdzfxxgk.hd.gov.cn/ -->
<html lang="en"><script id="allow-copy_script">(function agent() {
    let isUnlockingCached = false
    const isUnlocking = () => isUnlockingCached
    document.addEventListener('allow_copy', event => {
      const { unlock } = event.detail
      isUnlockingCached = unlock
    })

    const copyEvents = [
      'copy',
      'cut',
      'contextmenu',
      'selectstart',
      'mousedown',
      'mouseup',
      'mousemove',
      'keydown',
      'keypress',
      'keyup',
    ]
    const rejectOtherHandlers = e => {
      if (isUnlocking()) {
        e.stopPropagation()
        if (e.stopImmediatePropagation) e.stopImmediatePropagation()
      }
    }
    copyEvents.forEach(evt => {
      document.documentElement.addEventListener(evt, rejectOtherHandlers, {
        capture: true,
      })
    })
  })()</script><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="SiteName" content="邯郸市人民政府">
<meta name="SiteDomain" content="www.hd.gov.cn">
<meta name="SiteIDCode" content="1304000009">
<meta name="ColumnName" content="邯郸市政府信息公开">
<meta name="ColumnDescription" content="邯郸市人民政府网信息公开栏目发布邯郸市信息公开相关信息">
<meta name="ColumnKeywords" content="邯郸，信息公开">
<meta name="ColumnType" content="信息公开，政策文件">
<title>邯郸市政府信息公开</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<meta name="keywords" content="邯郸市政府信息公开">
<meta name="description" content="邯郸市政府信息公开">
<link href="http://www.gov.cn/govweb/xhtml/favicon.ico" rel="shortcut icon" type="image/x-icon">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="css/new_xxgkindex.css">
</head>
<body>
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/index1.css">
<link href="css/base.css" rel="stylesheet">
<link href="css/index1.css" rel="stylesheet">


<div class="body_l_bg"></div>
<div class="body_r_bg"></div>
<div class="f_w clearfix" style="background: url(http://hd.gov.cn/images/body_bg.jpg) no-repeat;padding-bottom: 20px;">
	<div class="w">
		<div class="header_szf">
			<div class="logo"> <a href="http://www.hd.gov.cn/"> <img src="images/logo1.png"> </a> </div>
			<div class="lj"> <img src="images/icon_sjb.png"> <a href="http://www.gov.cn/" target="_blank">中国政府网站</a>｜ <a href="http://www.hebei.gov.cn/" target="_blank">河北省政府网站</a> </div>
		</div>
	</div>
</div>

<!-- 导航 -->
	<div class="sx-navs">
		<ul class="sx-list">
			<li><a href="affairs/index">首页</a></li>
		</ul>
	</div>
<div class="sx-width">

	<!-- 内容一 -->
	<div class="sx-cot1 clearFix">
		<!-- 左边块 -->
		<div class="sx-c1-left">
			<!-- 搜索 -->
			<div class="sx-sos clearFix">
				<form id="schform" method="post" name="schform" action="http://www.hd.gov.cn/was5/web/search" target="_blank" accept-charset="utf-8" onsubmit="document.charset=&#39;utf-8&#39;">
					<input type="text" alt="本栏检索" title="本栏检索" placeholder="本栏检索" id="keyword" name="searchword" autocomplete="on" class="blinput">
					<input type="hidden" name="channelid" value="258715">
					<button type="submit">搜索</button>
					<a href="http://hdzfxxgk.hd.gov.cn/gjjs/" target="_blank">高级搜索</a>
				</form>
			</div>
			<!-- 栏目 -->
			<ul class="sx-uls">
				<!--<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hd.gov.cn/szzc/zwl/" target="_blank">领导分工</a></div>
				</li>-->
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/" target="_blank">政府信息公开指南</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/zfwj/zdwj/" target="_blank">政府信息公开制度文件</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/fdgknr/" target="_blank">法定主动公开内容</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/zfxxgknb/" target="_blank">政府信息公开年报</a></div>
				</li>

				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/zfgb/" target="_blank">政府公报</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/zfxwfb/" target="_blank">政府新闻发布</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/cycs/" target="_blank">行政机关办公地址/联系方式</a></div>
				</li>
				<li>
					<div class="su-l1">
						<div class="sx-tp"></div>
					</div>
					<div class="su-l2"><a href="http://hdzfxxgk.hd.gov.cn/gszbm/" target="_blank">市政府部门信息公开</a></div>
				</li>
			</ul>
		</div>
		<!-- 右边块 -->
		<div class="sx-c1-right">
			<!-- 标题 -->
			<div class="sx-c1-title clearFix"> <img src="images/sx-blue.jpg" alt=""> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/">
				<h1>近期信息公开</h1>
				</a> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/" class="sx-more1">更多&gt;&gt;</a> </div>
			<ul class="sx-c1-list">

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23716/202008/t20200802_1352104.html" target="_blank">
					<p>邯郸市教育局关于印发《全市教育系统安全专项整治三年行动实施方案》的通知</p>
					</a><span>2020-08-02</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23737/202007/t20200731_1351965.html" target="_blank">
					<p>邯郸市行政审批局关于启用邯郸市行政审批局招投标管理专用章的通告</p>
					</a><span>2020-07-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23716/202007/t20200729_1351303.html" target="_blank">
					<p>邯郸市教育局关于印发《邯郸市中小学生艺术素质测评实施办法（试行）》的通知</p>
					</a><span>2020-07-29</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200731_1351817.html" target="_blank">
					<p>邯郸市人民政府关于岳芝国等同志任职的通知</p>
					</a><span>2020-07-29</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200729_1351123.html" target="_blank">
					<p>邯郸市人民政府办公室关于成立邯郸市农村产权流转交易监督管理委员会的通知</p>
					</a><span>2020-07-27</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200729_1351128.html" target="_blank">
					<p>邯郸市人民政府办公室关于促进建筑业持续健康发展的实施意见</p>
					</a><span>2020-07-27</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zdly/gysyxxgk/jyjgxxgk/202007/t20200725_1350406.html" target="_blank">
					<p>邯郸市教育局关于继续暂停校外培训机构线下培训活动和严禁社会人员无证办学的通知</p>
					</a><span>2020-07-25</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200728_1351064.html" target="_blank">
					<p>邯郸市人民政府关于邯郸市主城区东区部分街路巷命名的通告</p>
					</a><span>2020-07-22</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23737/202007/t20200721_1349486.html" target="_blank">
					<p>邯郸市行政审批局关于将市发展改革委招标投标职能划转至市行政审批局的通告</p>
					</a><span>2020-07-21</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200728_1351065.html" target="_blank">
					<p>邯郸市人民政府办公室关于健全完善促进就业体制机制和操作平台的实施意见</p>
					</a><span>2020-07-21</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23741/202007/t20200731_1351952.html" target="_blank">
					<p>关于进一步加强医疗美容综合监管执法工作的通知</p>
					</a><span>2020-07-18</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200722_1349659.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发邯郸市支持重点行业和重点设施超低排放改造（深度治...</p>
					</a><span>2020-07-16</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23716/202007/t20200715_1348165.html" target="_blank">
					<p>邯郸市教育局关于在全市中小学开展爱国主义教育示范学校创建活动的通知</p>
					</a><span>2020-07-15</span></li>

			</ul>
		</div>
	</div>
	<!-- 内容二 -->
	<div class="sx-cot2 clearFix">
		<!-- 左边块 -->
		<div class="sx-c2-left">
			<!-- 标题 -->
			<div class="sx-c2-title"> <a href="http://hdzfxxgk.hd.gov.cn/ysqgk/" target="_blank">依申请公开</a> </div>
			<ul class="sx-c2-list">

				<a href="http://hd.gov.cn/szzc/zwl/" target="_blank">
				<li>
					<div><img src="images/W020200320523541696409.jpg">
						<p>领导分工</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jgze/" target="_blank">
				<li>
					<div><img src="images/W020200113518107839760.jpg">
						<p>机构职责</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zfwj/szfwj/" target="_blank">
				<li>
					<div><img src="images/W020200113517848565234.jpg">
						<p>政府文件</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zfwj/ghjh/" target="_blank">
				<li>
					<div><img src="images/W020200113518293947059.jpg">
						<p>规划计划</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23694/" target="_blank">
				<li>
					<div><img src="images/W020200113518504234844.jpg">
						<p>统计数据</p>
					</div>
				</li>
				</a>

				<a href="http://hd.gov.cn/ztzl/czyjs/" target="_blank">
				<li>
					<div><img src="images/W020200113518713589950.jpg">
						<p>财政财务</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zfwj/yjgl/" target="_blank">
				<li>
					<div><img src="images/W020200113518935881994.jpg">
						<p>应急管理</p>
					</div>
				</li>
				</a>

				<a href="http://hd.gov.cn/xxgk/zcjd/" target="_blank">
				<li>
					<div><img src="images/W020200113519129794085.jpg">
						<p>政策解读</p>
					</div>
				</li>
				</a>

				<a href="http://222.222.245.73:99/touch/qzqd/Index" target="_blank">
				<li>
					<div><img src="images/W020200113519554581041.jpg">
						<p>权责清单</p>
					</div>
				</li>
				</a>

				<a href="http://hd.gov.cn/xxgk/cbjytagz/jytabljggk/" target="_blank">
				<li>
					<div><img src="images/W020200113519770330156.jpg">
						<p>建议提案</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/cwhy/" target="_blank">
				<li>
					<div><img src="images/W020200113519943650700.jpg">
						<p>常务会议</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zfwj/gggslb/" target="_blank">
				<li>
					<div><img src="images/W020200113520136460153.jpg">
						<p>公告公示</p>
					</div>
				</li>
				</a>

				<a href="http://www.ccgp-hebei.gov.cn/hd/hd/" target="_blank">
				<li>
					<div><img src="images/W020200113522208616517.jpg">
						<p>政府采购</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zdly/zdjsxmxxgk/" target="_blank">
				<li>
					<div><img src="images/W020200113522553066647.jpg">
						<p>重大建设项目</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zdly/gysyxxgk/jyjgxxgk/" target="_blank">
				<li>
					<div><img src="images/W020200113523032148077.jpg">
						<p>社会公益事业</p>
					</div>
				</li>
				</a>

				<a href="http://hdzfxxgk.hd.gov.cn/zdly/ggzypzxxgk/gcjsxmzbtbly/" target="_blank">
				<li>
					<div><img src="images/W020200113523324951850.jpg">
						<p>公共资源配置</p>
					</div>
				</li>
				</a>

			</ul>
		</div>
		<!-- 右边块 -->
		<div class="sx-c2-right">
			<!-- 标题 -->
			<div class="sx-c2r-title clearFix"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/szfwj/" target="_blank" class="s2r-as" style="color: rgb(255, 255, 255); background: rgb(45, 102, 165);">市政府文件</a> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/zhengcejd/" target="_blank" class="s2r-as" style="">市政府办公室文件</a> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/szfl/" target="_blank" class="s2r-as" style="">市政府令</a> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/" target="_blank" class="s2r-as" style="">修订废止</a> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/szfwj/" class="sx-c2-more">更多&gt;&gt;</a> </div>
			<ul class="sx-c1-list list1" style="display: block;">

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200731_1351817.html" target="_blank">
					<p>邯郸市人民政府关于岳芝国等同志任职的通知</p>
					</a><span>2020-07-29</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200728_1351064.html" target="_blank">
					<p>邯郸市人民政府关于邯郸市主城区东区部分街路巷命名的通告</p>
					</a><span>2020-07-22</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348423.html" target="_blank">
					<p>邯郸市人民政府关于王小生等同志职务任免的通知</p>
					</a><span>2020-07-13</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200707_1346409.html" target="_blank">
					<p>邯郸市人民政府关于曹建召等同志职务任免的通知</p>
					</a><span>2020-07-01</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200701_1345119.html" target="_blank">
					<p>邯郸市人民政府关于印发2020年政府规章工作计划的通知</p>
					</a><span>2020-06-30</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200701_1345118.html" target="_blank">
					<p>邯郸市人民政府关于成立邯郸市铁路建设投资有限公司的批复</p>
					</a><span>2020-06-30</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200701_1345122.html" target="_blank">
					<p>邯郸市人民政府关于印发邯郸市文化旅游产业发展规划（2020—2025年）的通知</p>
					</a><span>2020-06-30</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202006/t20200629_1344338.html" target="_blank">
					<p>邯郸市人民政府关于推进超低能耗建筑发展的实施意见</p>
					</a><span>2020-06-26</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200701_1345115.html" target="_blank">
					<p>邯郸市人民政府关于张平等同志任职的通知</p>
					</a><span>2020-06-23</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202006/t20200630_1344871.html" target="_blank">
					<p>邯郸市人民政府关于李鹏丽等同志职务任免的通知</p>
					</a><span>2020-06-12</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202006/t20200617_1342246.html" target="_blank">
					<p>邯郸市人民政府关于印发邯郸市优秀运动员教练员奖励办法的通知</p>
					</a><span>2020-06-12</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202006/t20200617_1342244.html" target="_blank">
					<p>邯郸市人民政府关于印发“邯郸·中国气谷”发展规划的通知</p>
					</a><span>2020-06-12</span></li>

			</ul>
			<ul class="sx-c1-list list1" style="display: none;">

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200729_1351128.html" target="_blank">
					<p>邯郸市人民政府办公室关于促进建筑业持续健康发展的实施意见</p>
					</a><span>2020-07-27</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200729_1351123.html" target="_blank">
					<p>邯郸市人民政府办公室关于成立邯郸市农村产权流转交易监督管理委员会的通知</p>
					</a><span>2020-07-27</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200728_1351065.html" target="_blank">
					<p>邯郸市人民政府办公室关于健全完善促进就业体制机制和操作平台的实施意见</p>
					</a><span>2020-07-21</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200722_1349659.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发邯郸市支持重点行业和重点设施超低排放改造（深度治...</p>
					</a><span>2020-07-16</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348434.html" target="_blank">
					<p>邯郸市人民政府办公室关于更换原邯郸市人民政府外事办公室印章的通知</p>
					</a><span>2020-07-14</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348427.html" target="_blank">
					<p>邯郸市人民政府办公室关于进一步完善经济运行调度机制的通知</p>
					</a><span>2020-07-14</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348429.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发2020年国务院《政府工作报告》部署重点任务分工方案...</p>
					</a><span>2020-07-13</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348428.html" target="_blank">
					<p>邯郸市人民政府办公室关于进一步做好防震减灾工作的通知</p>
					</a><span>2020-07-10</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348425.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发邯郸市突发地质灾害应急预案的通知</p>
					</a><span>2020-07-10</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348426.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发邯郸市“十四五”市级专项规划目录清单的通知</p>
					</a><span>2020-07-10</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200716_1348432.html" target="_blank">
					<p>邯郸市人民政府办公室关于更换原邯郸市防范化解医疗保障基金支付风险工作领导小组...</p>
					</a><span>2020-07-07</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202007/t20200707_1346412.html" target="_blank">
					<p>邯郸市人民政府办公室关于印发邯郸市政务服务“好差评”评价实施办法的通知</p>
					</a><span>2020-07-02</span></li>

			</ul>
			<ul class="sx-c1-list list1" style="display: none;">

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202002/t20200205_1244988.html" target="_blank">
					<p>邯郸市人民政府令第175号</p>
					</a><span>2020-01-23</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201912/t20191227_1229658.html" target="_blank">
					<p>邯郸市人民政府令第173号</p>
					</a><span>2019-12-19</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201909/t20190902_1171966.html" target="_blank">
					<p>邯郸市人民政府令第172号</p>
					</a><span>2019-09-01</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201810/t20181011_879739.html" target="_blank">
					<p>邯郸市人民政府令第171号邯郸市货运车辆超限运输非现场执法规定</p>
					</a><span>2018-10-08</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201810/t20181011_879738.html" target="_blank">
					<p>邯郸市人民政府令第170号关于废止邯郸市行政执法监督检查暂行办法等8件政府规章的决定</p>
					</a><span>2018-10-08</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201809/t20180907_868732.html" target="_blank">
					<p>邯郸市人民政府令第169号《邯郸市城市房屋安全管理办法修正案》</p>
					</a><span>2018-08-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201809/t20180907_868729.html" target="_blank">
					<p>邯郸市人民政府令第168号《邯郸市人民政府制定规章和拟定法规草案规定修正案》</p>
					</a><span>2018-08-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201809/t20180907_868728.html" target="_blank">
					<p>邯郸市人民政府令第167号《关于废止邯郸市城市环境噪声污染防治管理办法等两件政府...</p>
					</a><span>2018-08-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201809/t20180907_868727.html" target="_blank">
					<p>邯郸市人民政府令第166号《邯郸市物业管理办法修正案》</p>
					</a><span>2018-08-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201808/t20180802_800256.html" target="_blank">
					<p>邯郸市人民政府令第160号《邯郸市行政调解办法》</p>
					</a><span>2017-07-01</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201808/t20180802_798076.html" target="_blank">
					<p>邯郸市人民政府令第152号《邯郸市建设工程消防技术审查与行政许可分离实施办法》</p>
					</a><span>2015-03-30</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201808/t20180802_796808.html" target="_blank">
					<p>邯郸市人民政府令第145号邯郸市建设领域农民工工资保障办法</p>
					</a><span>2013-10-30</span></li>

			</ul>
			<ul class="sx-c1-list list1" style="display: none;">

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202004/t20200430_1266530.html" target="_blank">
					<p>邯郸市人民政府关于废止邯郸市军人抚恤优待实施办法等两件政府规章的决定</p>
					</a><span>2020-04-24</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/202002/t20200205_1244988.html" target="_blank">
					<p>邯郸市人民政府令第175号</p>
					</a><span>2020-01-23</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201912/t20191210_1223412.html" target="_blank">
					<p>邯郸市人民政府关于禁限燃放烟花爆竹的通告</p>
					</a><span>2019-12-09</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201906/t20190618_1151247.html" target="_blank">
					<p>邯郸市人民政府办公厅关于印发邯郸市新建商品房预售资金监管办法的通知</p>
					</a><span>2019-06-01</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201905/t20190528_1142013.html" target="_blank">
					<p>邯郸市人民政府关于印发邯郸市国有划拨土地上非住宅房屋办理不动产登记实施办法（...</p>
					</a><span>2019-05-27</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201902/t20190222_1039244.html" target="_blank">
					<p>邯郸市人民政府办公厅关于印发邯郸市违法违规用地行为监察问责暂行办法的通知</p>
					</a><span>2019-02-01</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201902/t20190227_1041597.html" target="_blank">
					<p>邯郸市人民政府关于禁限燃放烟花爆竹的通告</p>
					</a><span>2019-01-17</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/201902/t20190222_1039233.html" target="_blank">
					<p>邯郸市人民政府办公厅关于印发邯郸市城乡建设用地增减挂钩节余指标调剂使用管理暂...</p>
					</a><span>2019-01-04</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201810/t20181011_879750.html" target="_blank">
					<p>邯郸市人民政府关于公布市政府规章和规范性文件清理结果的通知</p>
					</a><span>2018-10-08</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201810/t20181011_879738.html" target="_blank">
					<p>邯郸市人民政府令第170号关于废止邯郸市行政执法监督检查暂行办法等8件政府规章的决定</p>
					</a><span>2018-10-08</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201809/t20180907_868728.html" target="_blank">
					<p>邯郸市人民政府令第167号《关于废止邯郸市城市环境噪声污染防治管理办法等两件政府...</p>
					</a><span>2018-08-31</span></li>

				<li><img src="images/sx-ds.jpg" alt=""><a href="http://hdzfxxgk.hd.gov.cn/zfwj/xdfz/201808/t20180814_847667.html" target="_blank">
					<p>邯郸市人民政府令第163号《关于废止部分政府规章的决定》</p>
					</a><span>2017-11-28</span></li>

			</ul>
		</div>
	</div>
</div>
<div class="yqlj w" style="margin-top:20px;">
	<select onchange="if(this.value!=&quot;国家部委网站链接&quot;)window.open(this.value)">
		<option selected="selected">国家部委网站链接</option>
		<option value="http://www.fmprc.gov.cn/web/"> 外交部 </option>
		<option value="http://www.mod.gov.cn"> 国防部 </option>
		<option value="http://www.ndrc.gov.cn"> 国家发展和改革委员会 </option>
		<option value="http://www.moe.gov.cn"> 教育部 </option>
		<option value="http://www.most.gov.cn"> 科学技术部 </option>
		<option value="http://www.miit.gov.cn"> 工业和信息化部 </option>
		<option value="http://www.seac.gov.cn"> 国家民族事务委员会 </option>
		<option value="http://www.mps.gov.cn"> 公安部 </option>
		<option value="http://www.mca.gov.cn"> 民政部 </option>
		<option value="http://www.moj.gov.cn"> 司法部 </option>
		<option value="http://www.mof.gov.cn"> 财政部 </option>
		<option value="http://www.mohrss.gov.cn"> 人力资源和社会保障部 </option>
		<option value="http://www.mnr.gov.cn/"> 自然资源部 </option>
		<option value="http://www.mee.gov.cn/"> 生态环境部 </option>
		<option value="http://www.mohurd.gov.cn"> 住房和城乡建设部 </option>
		<option value="http://www.mot.gov.cn/"> 交通运输部 </option>
		<option value="http://www.mwr.gov.cn"> 水利部 </option>
		<option value="http://www.moa.gov.cn"> 农业农村部 </option>
		<option value="http://www.mofcom.gov.cn"> 商务部 </option>
		<option value="http://www.mct.gov.cn/"> 文化和旅游部 </option>
		<option value="http://www.nhc.gov.cn/"> 国家卫生健康委员会 </option>
		<option value="http://www.mva.gov.cn/"> 退役军人事务部 </option>
		<option value="http://www.chinasafety.gov.cn/index.shtml"> 应急管理部 </option>
		<option value="http://www.pbc.gov.cn/"> 人民银行 </option>
		<option value="http://www.audit.gov.cn/"> 审计署 </option>
		<option value="http://www.china-language.gov.cn/"> 国家语言文字工作委员会 </option>
		<option value="http://www.safea.gov.cn/"> 国家外国专家局 </option>
		<option value="http://www.cnsa.gov.cn/"> 国家航天局 </option>
		<option value="http://www.caea.gov.cn/"> 国家原子能机构 </option>
		<option value="http://nnsa.mee.gov.cn/"> 国家核安全局 </option>
		<option value="http://www.sasac.gov.cn"> 国务院国有资产监督管理委员会 </option>
		<option value="http://www.customs.gov.cn"> 海关总署 </option>
		<option value="http://www.chinatax.gov.cn"> 国家税务总局 </option>
		<option value="http://www.samr.gov.cn/"> 国家市场监督管理总局 </option>
		<option value="http://www.nrta.gov.cn/"> 国家广播电视总局 </option>
		<option value="http://www.gapp.gov.cn/"> 新闻出版总署 </option>
		<option value="http://www.sport.gov.cn/"> 国家体育总局 </option>
		<option value="http://www.stats.gov.cn"> 国家统计局 </option>
		<option value="http://www.cidca.gov.cn/"> 国家国际发展合作署 </option>
		<option value="http://www.nhsa.gov.cn/"> 国家医疗保障局 </option>
		<option value="http://www.counsellor.gov.cn"> 国务院参事室 </option>
		<option value="http://www.ggj.gov.cn/"> 国家机关事务管理局 </option>
		<option value="http://www.cnca.gov.cn/"> 国家认证认可监督管理委员会 </option>
		<option value="http://www.sac.gov.cn/"> 国家标准化管理委员会 </option>
		<option value="http://www.ncac.gov.cn/"> 国家新闻出版署（国家版权局） </option>
		<option value="http://www.sara.gov.cn/"> 国家宗教事务局 </option>
		<option value="http://www.hmo.gov.cn/"> 国务院港澳事务办公室 </option>
		<option value="http://www.gov.cn/guoqing/2018-06/22/content_5300522.htm"> 国务院研究室 </option>
		<option value="http://www.gqb.gov.cn/"> 国务院侨务办公室 </option>
		<option value="http://www.gwytb.gov.cn/"> 国务院台湾事务办公室 </option>
		<option value="http://www.cac.gov.cn/"> 国家互联网信息办公室 </option>
		<option value="http://www.scio.gov.cn/"> 国务院新闻办公室 </option>
		<option value="http://203.192.6.89/xhs/"> 新华通讯社 </option>
		<option value="http://www.cas.ac.cn/"> 中国科学院 </option>
		<option value="http://cass.cssn.cn/"> 中国社会科学院 </option>
		<option value="http://www.cae.cn/"> 中国工程院 </option>
		<option value="http://www.drc.gov.cn/"> 国务院发展研究中心 </option>
		<option value="http://www.cma.gov.cn/"> 中国气象局 </option>
		<option value="http://www.cbrc.gov.cn/"> 中国银行保险监督管理委员会 </option>
		<option value="http://www.csrc.gov.cn/pub/newsite/"> 中国证券监督管理委员会 </option>
		<option value="http://www.nsa.gov.cn/"> 国家行政学院 </option>
		<option value="http://www.gjxfj.gov.cn/"> 国家信访局 </option>
		<option value="http://www.chinagrain.gov.cn/index.html"> 国家粮食和物资储备局 </option>
		<option value="http://www.nea.gov.cn/"> 国家能源局 </option>
		<option value="http://www.sastind.gov.cn/"> 国家国防科技工业局 </option>
		<option value="http://www.tobacco.gov.cn/html/"> 国家烟草专卖局 </option>
		<option value="http://www.mps.gov.cn/n2254996/"> 国家移民管理局 </option>
		<option value="http://www.forestry.gov.cn/"> 国家林业和草原局 </option>
		<option value="http://www.nra.gov.cn/"> 国家铁路局 </option>
		<option value="http://www.caac.gov.cn/index.html"> 中国民用航空局 </option>
		<option value="http://www.spb.gov.cn/"> 国家邮政局 </option>
		<option value="http://www.sach.gov.cn/"> 国家文物局 </option>
		<option value="http://www.satcm.gov.cn/"> 国家中医药管理局 </option>
		<option value="http://www.chinacoal-safety.gov.cn/"> 国家煤矿安全监察局 </option>
		<option value="http://www.safe.gov.cn/"> 国家外汇管理局 </option>
		<option value="http://www.nmpa.gov.cn/WS04/CL2042/"> 国家药品监督管理局 </option>
		<option value="http://www.cnipa.gov.cn"> 国家知识产权局 </option>
		<option value="http://www.forestry.gov.cn/"> 国家公园管理局 </option>
		<option value="http://www.scs.gov.cn/"> 国家公务员局 </option>
		<option value="http://www.saac.gov.cn/"> 国家档案局 </option>
		<option value="http://www.gjbmj.gov.cn"> 国家保密局 </option>
		<option value="http://www.oscca.gov.cn/"> 国家密码管理局 </option>
	</select>
	<select onchange="if(this.value!=&quot;省内各市政府网站&quot;)window.open(this.value)">
		<option selected="selected">省内各市政府网站</option>
		<option value="http://www.sjz.gov.cn"> 石家庄市 </option>
		<option value="http://www.bd.gov.cn"> 保定市 </option>
		<option value="http://www.tangshan.gov.cn"> 唐山市 </option>
		<option value="http://www.zjk.gov.cn"> 张家口市 </option>
		<option value="http://www.chengde.gov.cn"> 承德市 </option>
		<option value="http://www.xingtai.gov.cn"> 邢台市 </option>
		<option value="http://www.qhd.gov.cn"> 秦皇岛市 </option>
		<option value="http://www.lf.gov.cn"> 廊坊市 </option>
		<option value="http://www.cangzhou.gov.cn"> 沧州市 </option>
		<option value="http://www.hengshui.gov.cn"> 衡水市 </option>
	</select>
	<select onchange="if(this.value!=&quot;中原地区网站链接&quot;)window.open(this.value)">
		<option selected="selected">中原地区网站链接</option>
		<option value="http://www.jconline.cn"> 晋城市 </option>
		<option value="http://www.jiaozuo.gov.cn"> 焦作市 </option>
		<option value="http://www.changzhi.gov.cn"> 长治市 </option>
		<option value="http://www.puyang.gov.cn"> 濮阳市 </option>
		<option value="http://www.heze.gov.cn"> 菏泽市 </option>
		<option value="http://www.anyang.gov.cn"> 安阳市 </option>
		<option value="http://www.hebi.gov.cn"> 鹤壁市 </option>
		<option value="http://www.xinxiang.gov.cn"> 新乡市 </option>
		<option value="http://www.liaocheng.gov.cn"> 聊城市 </option>
		<option value="http://www.linqing.gov.cn"> 临清市 </option>
		<option value="http://www.jiyuan.gov.cn"> 济源市 </option>
	</select>
	<select onchange="if(this.value!=&quot;各县（市、区）网站&quot;)window.open(this.value)">
		<option selected="selected">各县（市、区）网站</option>
		<option value="http://www.chengan.gov.cn"> 成安县人民政府 </option>
		<option value="http://www.cixian.gov.cn"> 磁县人民政府 </option>
		<option value="http://www.hdct.gov.cn/"> 丛台区人民政府 </option>
		<option value="http://www.daming.gov.cn/"> 大名县人民政府 </option>
		<option value="http://www.fxq.gov.cn"> 肥乡区人民政府 </option>
		<option value="http://www.ff.gov.cn"> 峰峰矿区人民政府 </option>
		<option value="http://www.hdfx.gov.cn"> 复兴区人民政府 </option>
		<option value="http://www.guantao.gov.cn"> 馆陶县人民政府 </option>
		<option value="http://www.gpx.gov.cn/"> 广平县人民政府 </option>
		<option value="http://www.hdhs.gov.cn/"> 邯山区人民政府 </option>
		<option value="http://www.jize.gov.cn/"> 鸡泽县人民政府 </option>
		<option value="http://www.linzhang.gov.cn"> 临漳县人民政府 </option>
		<option value="http://www.qiuxian.gov.cn"> 邱县人民政府 </option>
		<option value="http://www.qzx.gov.cn"> 曲周县人民政府 </option>
		<option value="http://www.shexian.gov.cn/"> 涉县人民政府 </option>
		<option value="http://www.wei.gov.cn"> 魏县人民政府 </option>
		<option value="http://www.wuan.gov.cn"> 武安市人民政府 </option>
		<option value="http://www.hdyn.gov.cn"> 永年区人民政府 </option>
		<option value="http://www.jinanxinqu.gov.cn"> 邯郸冀南新区管理委员会 </option>
		<option value="http://www.hdkfq.gov.cn"> 邯郸经济技术开发区管理委员会 </option>
	</select>
	<select onchange="if(this.value!=&quot;市直部门&quot;)window.open(this.value)">
		<option selected="selected">市直部门</option>
		<option value="http://www.hd.gov.cn/fgw/"> 邯郸市发展和改革委员会 </option>
		<option value="http://cgzf.hd.gov.cn"> 邯郸市城市管理和综合行政执法局 </option>
		<option value="http://rsj.hd.gov.cn/web/index.aspx"> 邯郸市人力资源和社会保障局 </option>
		<option value="http://jtj.hd.gov.cn/"> 邯郸市交通运输局 </option>
		<option value="http://jyj.hd.gov.cn"> 邯郸市教育局 </option>
		<option value="http://fgj.hd.gov.cn/"> 邯郸市住房保障和房产管理局 </option>
		<option value="http://wjw.hd.gov.cn"> 邯郸市卫生健康委员会 </option>
		<option value="http://sthj.hd.gov.cn"> 邯郸市生态环境局 </option>
		<option value="http://fpkf.hd.gov.cn"> 邯郸市扶贫开发办公室 </option>
		<option value="http://hdstyj.hd.gov.cn"> 邯郸市体育局 </option>
		<option value="http://housefund.hd.gov.cn"> 邯郸市住房公积金管理中心 </option>
		<option value="http://hdrfb.hd.gov.cn/"> 邯郸市人民防空办公室 </option>
		<option value="http://sfj.hd.gov.cn"> 邯郸市司法局 </option>
		<option value="http://nyncj.hd.gov.cn"> 邯郸市农业农村局 </option>
		<option value="http://hdsyjglj.hd.gov.cn/"> 邯郸市应急管理局 </option>
		<option value="http://hdsswj.hd.gov.cn/"> 邯郸市商务局 </option>
		<option value="http://hdslj.hd.gov.cn"> 邯郸市水利局 </option>
		<option value="http://gaj.hd.gov.cn/"> 邯郸市公安局 </option>
		<option value="http://wgl.hd.gov.cn"> 邯郸市文化广电和旅游局 </option>
		<option value="http://hdskjj.hd.gov.cn"> 邯郸市科学技术局 </option>
		<option value="http://jsj.hd.gov.cn/"> 邯郸市建设局 </option>
		<option value="http://tj.hd.gov.cn"> 邯郸市统计局 </option>
		<option value="http://smw.hd.gov.cn"> 邯郸市民网 </option>
		<option value="http://credit.hd.gov.cn/"> 信用中国（河北邯郸） </option>
		<option value="http://scjg.hd.gov.cn"> 邯郸市市场监督管理局 </option>
	</select>
	<select onchange="if(this.value!=&quot;其他机构&quot;)window.open(this.value)">
		<option selected="selected">其他机构</option>
		<option value="http://www.hebeizhanghe.gov.cn"> 河北漳河经济开发区管理委员会 </option>
		<option value="http://zx.hd.gov.cn/"> 市政协 </option>
	</select>
</div>
<div class="w">
	<div class="dhlm clearfix">
		<ul>
			<li class="first"> <a href="http://www.hd.gov.cn/">网站首页</a> </li>
			<li> <a href="http://hd.gov.cn/zjhd/">走进邯郸</a> </li>
			<li> <a href="http://hd.gov.cn/szzc/zwl/">市长之窗</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/bddt/">邯郸信息</a> </li>
			<li> <a href="http://hd.gov.cn/zt1/">专题专栏</a> </li>
		</ul>
		<ul>
			<li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/#">走进邯郸</a> </li>
			<li> <a href="http://hd.gov.cn/zjhd/hdgk/zhgk/" target="_blank">邯郸概况</a> </li>
			<li> <a href="http://hd.gov.cn/zjhd/wwgj/" target="_blank">文物古迹</a> </li>
			<li> <a href="http://hd.gov.cn/zjhd/hdcy/" target="_blank">邯郸成语</a> </li>
		</ul>
		<ul>
			<li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/#">邯郸信息</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/hdxw/" target="_blank">邯郸新闻</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/xqdt/" target="_blank">县区动态</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/bmdt/" target="_blank">部门动态</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/fzyj/" target="_blank">防灾预警</a> </li>
			<li> <a href="http://hd.gov.cn/hdyw/hygq/" target="_blank">回应关切</a> </li>
		</ul>
		<ul>
			<li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/#">信息公开</a> </li>
			<li> <a href="http://hd.hbzwfw.gov.cn/" target="_blank">网上政务服务平台</a> </li>
			<li> <a href="http://hdzfxxgk.hd.gov.cn/" target="_blank">政府信息公开</a> </li>
			<li> <a href="http://hd.gov.cn/xxgk/gwyw/" target="_blank">国务要闻</a> </li>
			<li> <a href="http://hd.gov.cn/xxgk/snyw/" target="_blank">省内要闻</a> </li>
			<li> <a href="http://hdzfxxgk.hd.gov.cn/zfgb/" target="_blank">政府公报</a> </li>
			<li> <a href="http://hd.gov.cn/xxgk/zcjd" target="_blank">政策解读</a> </li>
			<li> <a href="http://hd.gov.cn/xxgk/cbjytagz/dttb" target="_blank">承办建议提案工作</a> </li>
		</ul>
		<ul>
			<li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/#">政民互动</a> </li>
			<li> <a href="http://hd.gov.cn/zmhd/wyly/" target="_blank">我要留言</a> </li>
			<li> <a href="http://hd.gov.cn/zmhd/gdhf/" target="_blank">更多回复</a> </li>
			<li> <a href="http://hd.gov.cn/zmhd/wycx/" target="_blank">我要查询</a> </li>
			<li> <a href="http://hd.gov.cn/zmhd/lytj/" target="_blank">留言统计</a> </li>
			<li> <a href="http://lt.hd.gov.cn/index.jhtml" target="_blank">邯郸论坛</a> </li>
			<li> <a href="http://hd.gov.cn/zmhd/yjzj/" target="_blank">意见征集</a> </li>
			<li> <a href="http://www.hd.gov.cn/qcrx/" target="_blank">清晨热线</a> </li>
		</ul>
		<ul>
			<li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/#">专题专栏</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/hbdczhd/" target="_blank">省委省政府生态环境保护督察在邯郸</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/czyjs/" target="_blank">财政预决算</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/sn/" target="_blank">三农专栏</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/ndgzbb" target="_blank">政府网站年度工作报表</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/wzjc" target="_blank">政府网站建设管理专栏</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/hbdczl" target="_blank">大气污染综合治理督查信息公开</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/yshbzx/" target="_blank">饮用水水源地环境保护专项行动</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/hbdchtk/" target="_blank">省委省政府环保督察“回头看”</a> </li>
			<li> <a href="http://hd.gov.cn/ztzl/lslm/" target="_blank">历史栏目</a> </li>
		</ul>
	</div>
	<div class="footer_bg">
		<div class="footer">
			<ul>
				<li> <a href="http://hd.gov.cn/">返回首页</a>| </li>
				<li> <a href="http://hd.gov.cn/wzsm/201709/t20170912_719157.html" target="_blank">网站声明</a>| </li>
				<li> <a href="http://hd.gov.cn/lxwm/201709/t20170912_719159.html" target="_blank">联系我们</a>| </li>
				<li> <a href="http://hd.gov.cn/wzdt/" target="_blank">网站地图</a>| </li>
				<li> <a href="http://hd.gov.cn/bz/" target="_blank">帮助</a> </li>
			</ul>
			<p>邯郸市人民政府 <a href="http://www.beian.miit.gov.cn/"><font style="color:#333;">冀ICP备05029117号-1</font></a> </p>
			<p><a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=13042002000523" target="_blank"><font style="color:#333;">冀公网安备 13042002000523号</font> </a></p>
			<p>网站标识码 1304000009 </p>
			<p>主办单位： 邯郸市人民政府办公室 </p>
			<div class="img img1"><script type="text/javascript">document.write(unescape("%3Cspan id='_ideConac' %3E%3C/span%3E%3Cscript src='http://dcs.conac.cn/js/05/107/0000/41468768/CA051070000414687680001.js' type='text/javascript'%3E%3C/script%3E"));</script><span id="_ideConac"><a href="http://bszs.conac.cn/sitename?method=show&amp;id=0A87C46FEE4D331AE053022819ACDC8C" target="_blank"><img id="imgConac" vspace="0" hspace="0" border="0" src="images/red.png" data-bd-imgshare-binded="1"></a></span><script src="images/CA051070000414687680001.js.下载" type="text/javascript"></script><span id="_ideConac"></span></div>
			<div class="img img2"><script id="_jiucuo_" sitecode="1304000009" src="images/jiucuo.js.下载"></script></div>
		</div>
	</div>
</div>
<script src="css/new_xxgkindex.js.下载"></script>

</body></html>