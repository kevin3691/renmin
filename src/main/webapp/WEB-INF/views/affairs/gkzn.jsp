<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/12 0012
  Time: 09:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html><script id="allow-copy_script">(function agent() {
    let unlock = false
    document.addEventListener('allow_copy', (event) => {
        unlock = event.detail.unlock
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
    const rejectOtherHandlers = (e) => {
        if (unlock) {
            e.stopPropagation()
            if (e.stopImmediatePropagation) e.stopImmediatePropagation()
        }
    }
    copyEvents.forEach((evt) => {
        document.documentElement.addEventListener(evt, rejectOtherHandlers, {
            capture: true,
        })
    })
})()</script><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="SiteName" content="邯郸市人民政府">
    <meta name="SiteDomain" content="www.hd.gov.cn">
    <meta name="SiteIDCode" content="1304000009">
    <meta name="ColumnName" content="政府信息公开指南">
    <meta name="ColumnDescription" content="邯郸市人民政府网信息公开平台政府信息公开指南栏目发布邯郸市政府各部门信息公开指南信息">
    <meta name="ColumnKeywords" content="邯郸，信息公开，部门，指南">
    <meta name="ColumnType" content="信息公开指南">
    <title>邯郸市人民政府-政府信息公开指南</title>
    <link href="http://www.gov.cn/govweb/xhtml/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="text/javascript" src="./邯郸市人民政府-政府信息公开指南_files/jquery-1.12.0.min.js.下载"></script>
    <script src="./邯郸市人民政府-政府信息公开指南_files/jquery.superslide.2.1.1.js.下载" type="text/javascript" charset="utf-8"></script>
    <link type="text/css" rel="stylesheet" href="./邯郸市人民政府-政府信息公开指南_files/zwxxgk.css">

</head>
<body>
<div class="zwxxgk_bd">
    <!--top  开始-->
    <div class="zwxxgk_top">
        <div class="zwxxgk_top1"><a href="http://hdzfxxgk.hd.gov.cn/"><img src="./邯郸市人民政府-政府信息公开指南_files/2019_top_img01.png" style="width: 432px; height: 94px;"></a></div>
        <div class="zwxxgk_top2"><a href="http://hdzfxxgk.hd.gov.cn/"><img src="./邯郸市人民政府-政府信息公开指南_files/zwxxgk_bt.png"></a></div>
    </div>
    <!--top  结束-->
    <div class="zwxxgk_box">
        <!--检索  开始-->
        <style>
            .inp1ss{width: 40px;height: 42px;float: right;cursor: pointer;text-align: center;margin-right: 15px; background:url(../images/zwxxgk_ss.png) no-repeat}
        </style>
        <div class="zwxxgk_ss">
            <div class="inputText1">
                <form id="schform" method="post" name="schform" action="http://www.hd.gov.cn/was5/web/search" target="_blank" accept-charset="utf-8" onsubmit="document.charset=&#39;utf-8&#39;">
                    <input class="inp" type="text" placeholder="" id="keyword" name="searchword" border="0">
                    <input type="hidden" name="channelid" value="290962">

                    <!--<div class="inp1"><a href="javascript:void();" onclick="gotosearch()"><img src="../images/zwxxgk_ss.png" /></a></div>-->

                    <button type="submit" class="inp1ss"><img src="./邯郸市人民政府-政府信息公开指南_files/zwxxgk_ss.png"></button>

                </form>
            </div>
        </div>
        <div class="dl_nav">
            <div class="dl_nav01">
                <h3 class="on" style=" margin-top: 0px;"><a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/"><em class="zwxxgk_bnt1"></em>政府信息<br>
                    公开指南</a></h3>
                <h3><a href="http://hdzfxxgk.hd.gov.cn/zfwj/zdwj/"><em class="zwxxgk_bnt2"></em>政府信息<br>
                    公开制度</a></h3>
            </div>
            <div class="dl_nav02">
                <div class="sideMenu">
                    <h3><a href="http://hdzfxxgk.hd.gov.cn/fdgknr/"><em class="zwxxgk_bnt3"></em>
                        <div>法定主动<br>
                            公开内容</div> </a>
                        <span class="zwxxgk_bnt5"></span></h3>
                    <ul style="background:#fff;border:1px solid #e4e4e4;">

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zfwj/jgze/" target="_blank">机构职责</a></li>

                        <li><span>·</span><a href="http://hd.gov.cn/szzc/zwl/" target="_blank">领导分工</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zfwj/ghjh/" target="_blank">规划计划</a></li>

                        <li><span>·</span><a href="http://hd.gov.cn/ztzl/czyjs/" target="_blank">财政财务</a></li>

                        <li><span>·</span><a href="http://www.hbzwfw.gov.cn/hbzw/threesxcx/itemList/xz_index.do?webId=5&amp;deptid=&amp;type=XK" target="_blank">行政许可</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zfwj/sfxm/" target="_blank">收费项目</a></li>

                        <li><span>·</span><a href="http://www.ccgp-hebei.gov.cn/hd/hd/" target="_blank">政府采购</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/zdjsxmxxgk/zdxmsslyxx/" target="_blank">重大建设项目</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/gysyxxgk/jyjgxxgk/" target="_blank">社会公益事业</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/ggzypzxxgk/gcjsxmzbtbly/" target="_blank">公共资源配置</a></li>

                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zfwj/yjgl/" target="_blank">应急管理</a></li>


                        <!--<li class="on"><span>·</span><a href="../zfwj/jgze/" target="_blank">机构职责</a></li>
                        <li><span>·</span><a href="http://hd.gov.cn/szzc/zwl/" target="_blank">领导分工</a></li>
                        <li><span>·</span><a href="../zfwj/ghjh/" target="_blank">规划计划</a></li>
                        <!--<li><span>·</span><a href="http://tj.hd.gov.cn/html/tjsj/" target="_blank">统计数据</a></li>-->
                        <li><span>·</span><a href="http://hd.gov.cn/ztzl/czyjs/" target="_blank">财政财务</a></li>
                        <li><span>·</span><a href="http://www.hbzwfw.gov.cn/hbzw/threesxcx/itemList/xz_index.do?webId=5&amp;deptid=&amp;type=XK" target="_blank">行政许可</a></li>
                        <!--<li><span>·</span><a href="http://smw.hd.gov.cn/fzjd/web/index" target="_blank">行政执法</a></li>-->
                        <li><span>·</span><a href="http://czt.hebei.gov.cn/root17/?from=singlemessage" target="_blank">收费项目</a></li>
                        <li><span>·</span><a href="http://www.ccgp-hebei.gov.cn/hd/hd/" target="_blank">政府采购</a></li>
                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/zdjsxmxxgk/zdxmsslyxx/" target="_blank">重大建设项目</a></li>
                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/gysyxxgk/jyjgxxgk/" target="_blank">社会公益事业</a></li>
                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zdly/ggzypzxxgk/gcjsxmzbtbly/" target="_blank">公共资源配置</a></li>
                        <!--<li><span>·</span><a href="http://rsj.hd.gov.cn/web/list.aspx?tag=ggfw&strtag=ggfw" target="_blank">报考录用</a></li>-->
                        <li><span>·</span><a href="http://hdzfxxgk.hd.gov.cn/zfwj/yjgl/" target="_blank">应急管理</a></li>--&gt;
                    </ul>
                    <h3><a href="http://hdzfxxgk.hd.gov.cn/zfxxgknb/"><em class="zwxxgk_bnt4"></em>政府信息<br>
                        公开年报</a></h3>
                </div>
                <script type="text/javascript">
                    $(".sideMenu ul li").each(function(index) {
                        var strSrc = $(this).find("a:first").attr("href");
                        var IP = "";
                        if (strSrc.indexOf(IP) == -1&&strSrc.indexOf("javascript:") == -1) {
                            $(this).find("a").attr("target", "_blank");
                        }
                    });
                </script>
                <script type="text/javascript">
                    var MenuType=false;
                    $(".sideMenu>h3").click(function(){
                        if($(this).next("ul").is(":hidden")){
                            $(this).addClass("on").siblings("h3").removeClass("on");
                            $(this).next("ul").slideDown().siblings("ul").slideUp();
                        }else{
                            $(this).removeClass("on");
                            $(this).next("ul").slideUp();
                        }

                    })
                </script>
            </div>
            <div class="dl_nav01">
                <h3><a href="http://hdzfxxgk.hd.gov.cn/ysqgk/" style="line-height:60px;"><em class="zwxxgk_bnt2"></em>依申请公开
                </a></h3>
            </div>
        </div>
        <div class="scroll_main" style="height:983px;">
            <div class="scroll_wrap">
                <div class="scroll_cont ScrollStyle" style=" height: 970px;">
                    <!--<div class="scroll_tit"><span>市政府</span></div>
                    <div class="scroll_con">
                        <ul>

                            <li><a href="../gszbm/auto23692/?id=1780/2138" class='c-font1' target="_blank">市政府办公室</a></li>

                        </ul>
                    </div>-->
                    <div class="scroll_tit"><span>市政府部门</span></div>
                    <div class="scroll_con">
                        <ul>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23692/?id=1780/2138" class="c-font1" target="_blank">市政府办公室</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23693/?id=1780/2138" class="c-font1" target="_blank">市发展改革委</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23716/?id=1780/2138" class="c-font1" target="_blank">市教育局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23717/?id=1780/2138" class="c-font1" target="_blank">市科技局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23718/?id=1780/2138" class="c-font1" target="_blank">市民族宗教局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23712/?id=1780/2138" class="c-font1" target="_blank">市公安局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23724/?id=1780/2138" class="c-font1" target="_blank">市民政局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23719/?id=1780/2138" class="c-font1" target="_blank">市司法局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23729/?id=1780/2138" class="c-font1" target="_blank">市财政局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/srsj/?id=1780/2138" class="c-font1" target="_blank">市人力资源和社会保障局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23723/?id=1780/2138" class="c-font1" target="_blank">市建设局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23722/?id=1780/2138" class="c-font1" target="_blank">市自然资源和规划局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23721/?id=1780/2138" class="c-font1" target="_blank">市住房保障房产管理局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23713/?id=1780/2138" class="c-font1" target="_blank">市城管执法局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23730/?id=1780/2138" class="c-font1" target="_blank">市交通运输局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23715/?id=1780/2138" class="c-font1" target="_blank">市水利局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23720/?id=1780/2138" class="c-font1" target="_blank">市农业农村局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23714/?id=1780/2138" class="c-font1" target="_blank">市商务局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23727/?id=1780/2138" class="c-font1" target="_blank">市工业和信息化局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23741/?id=1780/2138" class="c-font1" target="_blank">市卫生健康委员会</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23696/?id=1780/2138" class="c-font1" target="_blank">市审计局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23699/?id=1780/2138" class="c-font1" target="_blank">市国资委</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23746/?id=1780/2138" class="c-font1" target="_blank">国家税务总局邯郸市税务局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23735/?id=1780/2138" class="c-font1" target="_blank">市生态环境局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23695/?id=1780/2138" class="c-font1" target="_blank">市体育局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23694/?id=1780/2138" class="c-font1" target="_blank">市统计局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23702/?id=1780/2138" class="c-font1" target="_blank">市场监督管理局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23708/?id=1780/2138" class="c-font1" target="_blank">市林业局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23736/?id=1780/2138" class="c-font1" target="_blank">市应急管理局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23697/?id=1780/2138" class="c-font1" target="_blank">市人防办</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23761/?id=1780/2138" class="c-font1" target="_blank">市地方金融监督管理局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23698/?id=1780/2138" class="c-font1" target="_blank">市气象局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23705/?id=1780/2138" class="c-font1" target="_blank">邯郸仲裁委</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23726/?id=1780/2138" class="c-font1" target="_blank">市文化广电和旅游局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23770/?id=1780/2138" class="c-font1" target="_blank">市住房公积金管理中心</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23739/?id=1780/2138" class="c-font1" target="_blank">市邮政管理局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23737/?id=1780/2138" class="c-font1" target="_blank">市行政审批局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23759/?id=1780/2138" class="c-font1" target="_blank">市扶贫办</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23700/?id=1780/2138" class="c-font1" target="_blank">市供销社</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23706/?id=1780/2138" class="c-font1" target="_blank">市贸促会</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto28830/?id=1780/2138" class="c-font1" target="_blank">市退役军人事务局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto28831/?id=1780/2138" class="c-font1" target="_blank">市医疗保障局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto28833/?id=1780/2138" class="c-font1" target="_blank">市投资促进局</a></li>

                            <li><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto28832/?id=1780/2138" class="c-font1" target="_blank">市机关事务管理局</a></li>

                        </ul>
                        <!--<ul>
                            <li><a href="../gszbm/auto23693/?id=1780/2138" class="c-font1" target="_blank">市发展改革委</a></li>
                            <li><a href="../gszbm/auto23716/?id=1780/2138" class="c-font1" target="_blank">市教育局</a></li>
                            <li><a href="../gszbm/auto23717/?id=1780/2138" class="c-font1" target="_blank">市科技局</a></li>
                            <li><a href="../gszbm/auto23718/?id=1780/2138" class="c-font1" target="_blank">市民族宗教局</a></li>
                            <li><a href="../gszbm/auto23712/?id=1780/2138" class="c-font1" target="_blank">市公安局</a></li>
                            li><a href="../gszbm/auto23724/?id=1780/2138" class="c-font1" target="_blank">市民政局</a></li>
                            <li><a href="../gszbm/auto23719/?id=1780/2138" class="c-font1" target="_blank">市司法局</a></li>
                            <li><a href="../gszbm/auto23729/?id=1780/2138" class="c-font1" target="_blank">市财政局</a></li>
                            <li><a href="../gszbm/srsj/?id=1780/2138" class="c-font1" target="_blank">市人力资源和社会保障局</a></li>
                            <li><a href="../gszbm/auto23723/?id=1780/2138" class="c-font1" target="_blank">市建设局</a></li>
                            <li><a href="../gszbm/auto23722/?id=1780/2138" class="c-font1" target="_blank">市自然资源和规划局</a></li>
                            <li><a href="../gszbm/auto23721/?id=1780/2138" class="c-font1" target="_blank">市住房保障房产管理局</a></li>
                            <li><a href="../gszbm/auto23713/?id=1780/2138" class="c-font1" target="_blank">市城管执法局</a></li>
                            <li><a href="../gszbm/auto23730/?id=1780/2138" class="c-font1" target="_blank">市交通运输局</a></li>
                            <li><a href="../gszbm/auto23715/?id=1780/2138" class="c-font1" target="_blank">市水利局</a></li>
                            <li><a href="../gszbm/auto23720/?id=1780/2138" class="c-font1" target="_blank">市农业农村局</a></li>
                            <li><a href="../gszbm/auto23714/?id=1780/2138" class="c-font1" target="_blank">市商务局</a></li>
                            <li><a href="../gszbm/auto23727/?id=1780/2138" class="c-font1" target="_blank">市工业和信息化局</a></li>
                            <li><a href="../gszbm/auto23741/?id=1780/2138" class="c-font1" target="_blank">市卫生健康委员会</a></li>
                            <li><a href="../gszbm/auto23696/?id=1780/2138" class="c-font1" target="_blank">市审计局</a></li>
                            <li><a href="../gszbm/auto23699/?id=1780/2138" class="c-font1" target="_blank">市国资委</a></li>
                            <li><a href="../gszbm/auto23746/?id=1780/2138" class="c-font1" target="_blank">国家税务总局邯郸市税务局</a></li>
                            <li><a href="../gszbm/auto23735/?id=1780/2138" class="c-font1" target="_blank">市生态环境局</a></li>
                            <li><a href="../gszbm/auto23695/?id=1780/2138" class="c-font1" target="_blank">市体育局</a></li>
                            <li><a href="../gszbm/auto23694/?id=1780/2138" class="c-font1" target="_blank">市统计局</a></li>
                            <li><a href="../gszbm/auto23702/?id=1780/2138" class="c-font1" target="_blank">市场监督管理局</a></li>
                            <li><a href="../gszbm/auto23708/?id=1780/2138" class="c-font1" target="_blank">市林业局</a></li>
                            <li><a href="../gszbm/auto23736/?id=1780/2138" class="c-font1" target="_blank">市应急管理局</a></li>
                            <li><a href="../gszbm/auto23697/?id=1780/2138" class="c-font1" target="_blank">市人防办</a></li>
                            <li><a href="../gszbm/auto23761/?id=1780/2138" class="c-font1" target="_blank">市地方金融监督管理局</a></li>
                            <li><a href="../gszbm/auto23698/?id=1780/2138" class="c-font1" target="_blank">市气象局</a></li>
                            <li><a href="../gszbm/auto23705/?id=1780/2138" class="c-font1" target="_blank">邯郸仲裁委</a></li>
                            <li><a href="../gszbm/auto23726/?id=1780/2138" class="c-font1" target="_blank">市文化广电和旅游局</a></li>
                            <li><a href="../gszbm/auto23770/?id=1780/2138" class="c-font1" target="_blank">市住房公积金管理中心</a></li>
                            <li><a href="../gszbm/auto23739/?id=1780/2138" class="c-font1" target="_blank">市邮政管理局</a></li>
                            <li><a href="../gszbm/auto23737/?id=1780/2138" class="c-font1" target="_blank">市行政审批局</a></li>
                            <li><a href="../gszbm/auto23759/?id=1780/2138" class="c-font1" target="_blank">市扶贫办</a></li>
                            <li><a href="../gszbm/auto23700/?id=1780/2138" class="c-font1" target="_blank">市供销社</a></li>
                            <li><a href="../gszbm/auto23706/?id=1780/2138" class="c-font1" target="_blank">市贸促会</a></li>
                            <li><a href="../gszbm/auto28830/?id=1780/2138" class="c-font1" target="_blank">市退役军人局</a></li>
                            <li><a href="../gszbm/auto28833/?id=1780/2138" class="c-font1" target="_blank">市投资促进局</a></li>
                        </ul>-->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="dhlm clearfix">
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">网站首页</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zjhd/">走进邯郸</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/szzc/zwl/">市长之窗</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/hdyw/bddt/">邯郸信息</a>
            </li>
            <!--<li>
                <a href="./xxgk/">信息公开</a>
            </li>						<li>
                <a href="javascript:;">政民互动</a>
            </li>
            <li>
                <a href="./wzw/">微政务</a>
            </li>-->
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zt1/">专题专栏</a>
            </li>					</ul>
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">走进邯郸</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zjhd/hdgk/zhgk/" target="_blank">邯郸概况</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zjhd/wwgj/" target="_blank">文物古迹</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zjhd/hdcy/" target="_blank">邯郸成语</a>
            </li>
            <!--<li>
                <a href="./zjhd/hddsj/" target="_blank">邯郸大事记</a>
            </li>
            <li>
                <a href="./zjhd/zsyz/zsxm/" target="_blank">招商引资</a>
            </li>
            <li>
                <a href="http://www.hd.gov.cn/ztlm/hdzt/" target="_blank">邯郸之光</a>
            </li>
            <li>
                <a href="./zjhd/mytc/qggy/" target="_blank">名优特产</a>
            </li>-->
            <!--<li>
                <a href="http://map.tianditu.cn/map/index.html" target="_blank">电子地图</a>
            </li>-->
        </ul>
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">邯郸信息</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/hdyw/hdxw/" target="_blank">邯郸新闻</a>
            </li>
            <!--<li>
                <a href="./hdyw/spxw/" target="_blank">视频新闻</a>
            </li>
            <li>
                <a href="" target="_blank">水电交通</a>
            </li>
-->
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/hdyw/xqdt/" target="_blank">县区动态</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/hdyw/bmdt/" target="_blank">部门动态</a>
            </li>
            <!--<li>
                <a href="./hdyw/kqzl/" target="_blank">空气质量</a>
            </li>-->
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/hdyw/fzyj/" target="_blank">防灾预警</a>
            </li>

            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/hdyw/hygq/" target="_blank">回应关切</a>
            </li>
        </ul>
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">信息公开</a>
            </li>
            <li>
                <a href="http://hd.hbzwfw.gov.cn/" target="_blank">网上政务服务平台</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/" target="_blank">政府信息公开</a>
            </li>


            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/xxgk/gwyw/" target="_blank">国务要闻</a>
            </li>

            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/xxgk/snyw/" target="_blank">省内要闻</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfgb/" target="_blank">政府公报</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/xxgk/zcjd" target="_blank">政策解读</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/xxgk/cbjytagz/dttb" target="_blank">承办建议提案工作</a>
            </li>
        </ul>
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">政民互动</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zmhd/wyly/" target="_blank">我要留言</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zmhd/gdhf/" target="_blank">更多回复</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zmhd/wycx/" target="_blank">我要查询</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zmhd/lytj/" target="_blank">留言统计</a>
            </li>
            <li>
                <a href="http://lt.hd.gov.cn/index.jhtml" target="_blank">邯郸论坛</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/zmhd/yjzj/" target="_blank">意见征集</a>
            </li>
            <li>
                <a href="http://www.hd.gov.cn/qcrx/" target="_blank">清晨热线</a>
            </li>
        </ul>
        <ul>
            <li class="first">
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/#">专题专栏</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/hbdczhd/" target="_blank">省委省政府生态环境保护督察在邯郸</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/czyjs/" target="_blank">财政预决算</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/sn/" target="_blank">三农专栏</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/ndgzbb" target="_blank">政府网站年度工作报表</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/wzjc" target="_blank">政府网站建设管理专栏</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/hbdczl" target="_blank">大气污染综合治理督查信息公开</a>
            </li>
            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/yshbzx/" target="_blank">饮用水水源地环境保护专项行动</a>
            </li>

            <li>
                <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/ztzl/lslm/" target="_blank">历史栏目</a>
            </li>
        </ul>
    </div>
    <div class="footer_bg">
        <div class="footer">
            <ul>
                <li>
                    <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/">返回首页</a>|
                </li>
                <li>
                    <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/wzsm/201709/t20170912_719157.html" target="_blank">网站声明</a>|
                </li>
                <li>
                    <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/lxwm/201709/t20170912_719159.html" target="_blank">联系我们</a>|
                </li>

                <li>
                    <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/wzdt/" target="_blank">网站地图</a>|
                </li>
                <li>
                    <a href="http://hdzfxxgk.hd.gov.cn/zfxxgkzn/bz/" target="_blank">帮助</a>
                </li>
            </ul>
            <p>邯郸市人民政府 <a href="http://www.beian.miit.gov.cn/"><font style="color:#333;">冀ICP备05029117号-1</font></a> </p>
            <p><a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=13042002000523" target="_blank"><font style="color:#333;">冀公网安备 13042002000523号</font> </a></p>
            <p>网站标识码 1304000009 </p>
            <p>主办单位： 邯郸市人民政府办公室 </p>

            <div class="img img1"><script type="text/javascript">document.write(unescape("%3Cspan id='_ideConac' %3E%3C/span%3E%3Cscript src='http://dcs.conac.cn/js/05/107/0000/41468768/CA051070000414687680001.js' type='text/javascript'%3E%3C/script%3E"));</script><span id="_ideConac"><a href="http://bszs.conac.cn/sitename?method=show&amp;id=0A87C46FEE4D331AE053022819ACDC8C" target="_blank"><img id="imgConac" vspace="0" hspace="0" border="0" src="./邯郸市人民政府-政府信息公开指南_files/red.png" data-bd-imgshare-binded="1"></a></span><script src="./邯郸市人民政府-政府信息公开指南_files/CA051070000414687680001.js.下载" type="text/javascript"></script><span id="_ideConac"></span></div>
            <div class="img img2"><script id="_jiucuo_" sitecode="1304000009" src="./邯郸市人民政府-政府信息公开指南_files/jiucuo.js.下载"></script></div>
        </div>
    </div>

</div>

</body></html>