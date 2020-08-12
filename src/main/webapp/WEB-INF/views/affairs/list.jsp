<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/10 0010
  Time: 09:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



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
    <meta name="keywords" content="邯郸市政府信息公开">
    <meta name="description" content="邯郸市政府信息公开">
    <link href="http://www.gov.cn/govweb/xhtml/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./邯郸市政府信息公开1_files/new_xxgkindex.css">
    <link rel="stylesheet" type="text/css" href="./邯郸市政府信息公开1_files/szbmtclb.css">
    <style type="text/css">
        .CurrChnlCls{ color:#666; font-size:14px;}

        .dangqianweizhi{ margin: 0 auto; width: 1200px; text-align: left; height:60px; line-height: 60px; position: relative; overflow: hidden; color: #333333; font-size:14px;}
        .dangqianweizhi a{ color: #333333;}
        .szbmtclb table {
            margin-top: 0;
        }
        .shxxgkheader_box {
            background: #29aee6;
            height: 78px;
        }

        .shxxgkheader_box .logo {
            width: 230px;
            height: 78px;
            float: left;
        }

        .shxxgkheader_box .nav {
            height: 78px;
            float: left;
            margin-left: 200px;
        }

        .shxxgkheader_box .nav ul {
            overflow: hidden;
        }

        .shxxgkheader_box .nav ul li {
            float: left;
        }

        .shxxgkheader_box .nav ul li+li {
            margin-left: 50px;
        }

        .shxxgkheader_box .nav ul li a {
            display: inline-block;
            width: 130px;
            height: 74px;
            font: 300 18px/74px "microsoft yahei";
            color: #fff;
            text-align: center;
        }

        .shxxgkheader_box .nav ul li a:hover {
            border-bottom: 4px solid #f7d238;
            font-weight: 600;
        }
        .sosuo {
            width: 99%;
            height: 59px;
            margin: 18px 0;
            background-color: rgba(255, 255, 255, .3);
        }

        .sosuo>img {
            padding: 13px 14px 0 26px;
            float: left;
        }

        .sosuo .lbnr {
            float: left;
            font: 300 14px/59px "Microsoft Yahei";
            color: #0b6eca;
            position: relative;
        }

        .sosuo .lbnr iframe {
            position: absolute;
            top: 18px;
            right: -190px;
        }

        .ss {
            float: right;
            width: 308px;
            height: 41px;
            margin: 9px 0 0 0;
            border: 1px solid #c3c3c3;
        }

        .wbk {
            width: 230px;
            height: 41px;
            padding-left: 16px;
            color: #b2b2b2;
            font: 300 14px/41px "Microsoft Yahei";
            float: left;
        }

        .ssan {
            display: block;
            width: 49px;
            height: 41px;
            background: url(../images/icon_fdj.png) no-repeat center center #1978D2;
            float: right;
            cursor: pointer;
        }
        .szbmtclb table td{
            padding: 5px 10px;
        }
        .news-list {
            text-align: center;
        }
        #searchBtn {
            width: 40px;
            height: 30px;
            cursor: pointer;
            background: #037EDB;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
<link rel="stylesheet" type="text/css" href="./邯郸市政府信息公开1_files/base.css">
<link rel="stylesheet" type="text/css" href="./邯郸市政府信息公开1_files/index1.css">

<div class="body_l_bg"></div>
<div class="body_r_bg"></div>
<div class="f_w clearfix" style="background: url(http://hd.gov.cn/images/body_bg.jpg) no-repeat;padding-bottom: 20px;">
    <div class="w">
        <div class="header_szf">
            <div class="logo"> <a href="http://www.hd.gov.cn/"> <img src="./邯郸市政府信息公开1_files/logo1.png"> </a> </div>
            <div class="lj"> <img src="./邯郸市政府信息公开1_files/icon_sjb.png"> <a href="http://www.gov.cn/" target="_blank">中国政府网站</a>｜ <a href="http://www.hebei.gov.cn/" target="_blank">河北省政府网站</a> </div>
        </div>
    </div>
</div>

<!-- 导航 -->
<div class="sx-navs">
    <ul class="sx-list">
        <li><a href="http://www.hd.gov.cn/" target="_blank">首页</a></li>
        <li><a href="http://hdzfxxgk.hd.gov.cn/">信息公开</a></li>
    </ul>
</div>
<div class="sx-width">
    <!-- 内容一 -->
    <div class="sx-cot1 clearFix">
        <!-- 左边块 -->
        <!-- 左边块 -->
        <div class="sx-c1-left1">
            <!-- 搜索 -->




            <div class="ss1">
                <form method="post" name="trssearchform" id="trssearchform" target="DataList" action="http://www.hd.gov.cn/govsearch/simp_gov_list.jsp">
                    <div class="rowOfSearchNew">

                        <input type="text" name="sword" id="sword" placeholder="请输入搜索内容..." style="border:1px #ccc solid; height:30px;width: 50%;font-size: 14px;">
                        <input type="hidden" name="channelid" value="258715">
                        <select name="searchColumn" id="select" style="height:31px;width: 15%;text-align: center;margin: 15px 0;">
                            <option value="all">全部</option>
                            <option value="zhengwen">正文</option>
                            <option value="biaoti">名称</option>
                            <option value="indexid">索引号</option>
                            <option value="fwdw">发布机构</option>
                        </select>
                        <input type="hidden" name="searchYear" value="all">
                        <input type="hidden" name="pubURL" id="pubURL" value="http://hdzfxxgk.hd.gov.cn/">
                        <input type="hidden" name="SType" value="1">
                        <span id="searchBtn" onclick="return executeSearch();" tabindex="2" style="width: 15%;height: 32px;display: inline-block;text-align: center;line-height: 32px;margin-bottom: 15px; border-radius:5px;">搜索</span>
                        &nbsp;&nbsp;<a class="advanceSearch1" href="http://hdzfxxgk.hd.gov.cn/gjjs/" id="advanceSearch1" target="_blank" style="color: #b94a48;margin-left: 20px;">高级搜索</a>
                    </div>
                </form>
            </div>






        </div>

        <!-- 右边块 -->
        <div class="sx-c2-right1">
            <!-- 标题 -->
            <div class="sx-c1-title clearFix"> <img src="./邯郸市政府信息公开1_files/sx-blue.jpg" alt="">
                <h1>近期信息公开</h1>
                <!--<a href="./" class="sx-more1">更多>></a>-->

                <div class="sx-more1"><a href="http://hdzfxxgk.hd.gov.cn/" title="首页" class="CurrChnlCls">首页</a>-&gt;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/" title="政府文件" class="CurrChnlCls">政府文件</a>-&gt;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/" title="近期信息公开" class="CurrChnlCls">近期信息公开</a></div>

            </div>
            <ul class="sx-c1-list list1" style="display:block;">
                <div class="szbmtclb fl clearfix" style="width:100%;">
                    <table>
                        <tbody><tr>
                            <th width="47%" height="35">名称</th>
                            <th width="21%" height="35">索引号</th>
                            <th width="19%" height="35">发布机构</th>
                            <th width="12%" height="35">发布日期</th>
                        </tr>

                        <tr>
                            <td height="35"><a href="http://hdzfxxgk.hd.gov.cn/gszbm/auto23716/202008/t20200805_1353179.html" title="邯郸市教育局关于印发《邯郸市学校安全工作目标管理考核办法》的通知">
                                邯郸市教育局关于印发《邯郸市学校安全工作目标管理考核办法》的通知
                            </a></td>
                            <td height="35">000014348/2020-35428</td>
                            <td height="35">邯郸市教育局</td>
                            <td height="35">2020-08-05</td>
                        </tr>

                        </tbody></table>
                    <div class="news-list">
                        <style type="text/css">
                            .page_box{width:100%;margin:auto auto;color:#000000;}
                            .lefttotal{ float:left;text-align:left;color:#000;}
                            .leftnum{color:#ff0000;}

                            .now{padding-left:5px;padding-right:5px;}
                            a.pnum{padding-left:5px;padding-right:5px;}

                            .news-list .page {
                                height: 24px;
                                line-height: 24px;
                                margin-top: 30px;
                                margin-bottom: 30px;
                                font-size: 14px;
                            }
                            .news-list .page a, .news-list .page span  {
                                display: inline-block;
                                width: 50px;
                                text-align: center;
                                height: 24px;
                                line-height: 24px;
                                color: #fff;
                                background-color: #29aee6;
                            }
                            .news-list .page .now {
                                background-color: #cccccc;
                                width: 28px;
                            }
                            .news-list .page .pnum {
                                width: 28px;
                            }
                        </style>

                        <div class="clear"></div>
                        <div class="page_box">
                            <!--<div class="lefttotal" style="color:#000000;">共有<span class="leftnum">0</span>条信息</div>-->
                            <div class="page">
                                <script language="javascript">
                                    var countnum= 6348;
                                    var currentPage=0;
                                    var prevPage=currentPage-1
                                    var nextPage=currentPage+1
                                    var countPage=56
                                    var endPage=countPage-1
                                    document.write("<a href=\"index.html\" target=\"_self\" >首页</a>&nbsp;&nbsp;");
                                    if(countPage>1&&currentPage!=0&&currentPage!=1)
                                        document.write("<a  href=\"index"+"_"+prevPage+"."+"html\" target=\"_self\">上一页</a>&nbsp;&nbsp;");
                                    else if(countPage>1&&currentPage!=0&&currentPage==1)
                                        document.write("<a  href=\"index.html\" target=\"_self\">上一页</a>&nbsp;&nbsp;");
                                    else
                                        document.write("<span class='bg'>上一页</span>&nbsp;&nbsp;");
                                    var num=6;
                                    var startPage=currentPage-2;
                                    if(startPage<0)startPage=0;
                                    var endpage=startPage+num;
                                    if(endpage>countPage)
                                        endpage=countPage;
                                    startPage=endpage-6;
                                    if(startPage<0)startPage=0;
                                    for(var i=startPage;i<endpage;i++){
                                        if(currentPage==i)
                                            document.write("<span class='now'>"+(i+1)+"</span>&nbsp;&nbsp;");
                                        else if(i==0){
                                            document.write("<a  href=\"index.html\" target=\"_self\" class='pnum'>"+1+"</a>&nbsp;&nbsp;");
                                        }else
                                            document.write("<a href=\"index"+"_"+i+"."+"html\" target=\"_self\" class='pnum'>"+(i+1)+"</a>&nbsp;&nbsp;");}
                                    if(countPage>1&&currentPage!=(countPage-1))
                                        document.write("<a href=\"index"+"_"+nextPage+"."+"html\" target=\"_self\">下一页</a>&nbsp;&nbsp;");
                                    else
                                        document.write("<span class='bg'>下一页</span>&nbsp;&nbsp;");
                                    if(countPage==1)
                                        document.write("<a  href=\"index.html\" target=\"_self\">尾页</a>");
                                    else if(countPage>1)
                                        document.write("<a  href=\"index_"+endPage+".html\" target=\"_self\">尾页</a>");

                                </script><a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index.html" target="_self">首页</a>&nbsp;&nbsp;<span class="bg">上一页</span>&nbsp;&nbsp;<span class="now">1</span>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_1.html" target="_self" class="pnum">2</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_2.html" target="_self" class="pnum">3</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_3.html" target="_self" class="pnum">4</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_4.html" target="_self" class="pnum">5</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_5.html" target="_self" class="pnum">6</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_1.html" target="_self">下一页</a>&nbsp;&nbsp;<a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/index_55.html" target="_self">尾页</a>                    </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>

            </ul>

        </div>
    </div>
</div>

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
<div class="dhlm clearfix">
    <ul>
        <li class="first"> <a href="http://www.hd.gov.cn/">网站首页</a> </li>
        <li> <a href="http://hd.gov.cn/zjhd/">走进邯郸</a> </li>
        <li> <a href="http://hd.gov.cn/szzc/zwl/">市长之窗</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/bddt/">邯郸信息</a> </li>
        <li> <a href="http://hd.gov.cn/zt1/">专题专栏</a> </li>
    </ul>
    <ul>
        <li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/#">走进邯郸</a> </li>
        <li> <a href="http://hd.gov.cn/zjhd/hdgk/zhgk/" target="_blank">邯郸概况</a> </li>
        <li> <a href="http://hd.gov.cn/zjhd/wwgj/" target="_blank">文物古迹</a> </li>
        <li> <a href="http://hd.gov.cn/zjhd/hdcy/" target="_blank">邯郸成语</a> </li>
    </ul>
    <ul>
        <li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/#">邯郸信息</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/hdxw/" target="_blank">邯郸新闻</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/xqdt/" target="_blank">县区动态</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/bmdt/" target="_blank">部门动态</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/fzyj/" target="_blank">防灾预警</a> </li>
        <li> <a href="http://hd.gov.cn/hdyw/hygq/" target="_blank">回应关切</a> </li>
    </ul>
    <ul>
        <li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/#">信息公开</a> </li>
        <li> <a href="http://hd.hbzwfw.gov.cn/" target="_blank">网上政务服务平台</a> </li>
        <li> <a href="http://hdzfxxgk.hd.gov.cn/" target="_blank">政府信息公开</a> </li>
        <li> <a href="http://hd.gov.cn/xxgk/gwyw/" target="_blank">国务要闻</a> </li>
        <li> <a href="http://hd.gov.cn/xxgk/snyw/" target="_blank">省内要闻</a> </li>
        <li> <a href="http://hdzfxxgk.hd.gov.cn/zfgb/" target="_blank">政府公报</a> </li>
        <li> <a href="http://hd.gov.cn/xxgk/zcjd" target="_blank">政策解读</a> </li>
        <li> <a href="http://hd.gov.cn/xxgk/cbjytagz/dttb" target="_blank">承办建议提案工作</a> </li>
    </ul>
    <ul>
        <li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/#">政民互动</a> </li>
        <li> <a href="http://hd.gov.cn/zmhd/wyly/" target="_blank">我要留言</a> </li>
        <li> <a href="http://hd.gov.cn/zmhd/gdhf/" target="_blank">更多回复</a> </li>
        <li> <a href="http://hd.gov.cn/zmhd/wycx/" target="_blank">我要查询</a> </li>
        <li> <a href="http://hd.gov.cn/zmhd/lytj/" target="_blank">留言统计</a> </li>
        <li> <a href="http://lt.hd.gov.cn/index.jhtml" target="_blank">邯郸论坛</a> </li>
        <li> <a href="http://hd.gov.cn/zmhd/yjzj/" target="_blank">意见征集</a> </li>
        <li> <a href="http://www.hd.gov.cn/qcrx/" target="_blank">清晨热线</a> </li>
    </ul>
    <ul>
        <li class="first"> <a href="http://hdzfxxgk.hd.gov.cn/zfwj/jinqixxgk/#">专题专栏</a> </li>
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
        <div class="img img1"><script type="text/javascript">document.write(unescape("%3Cspan id='_ideConac' %3E%3C/span%3E%3Cscript src='http://dcs.conac.cn/js/05/107/0000/41468768/CA051070000414687680001.js' type='text/javascript'%3E%3C/script%3E"));</script><span id="_ideConac"><a href="http://bszs.conac.cn/sitename?method=show&amp;id=0A87C46FEE4D331AE053022819ACDC8C" target="_blank"><img id="imgConac" vspace="0" hspace="0" border="0" src="./邯郸市政府信息公开1_files/red.png" data-bd-imgshare-binded="1"></a></span><script src="./邯郸市政府信息公开1_files/CA051070000414687680001.js.下载" type="text/javascript"></script><span id="_ideConac"></span></div>
        <div class="img img2"><script id="_jiucuo_" sitecode="1304000009" src="./邯郸市政府信息公开1_files/jiucuo.js.下载"></script></div>
    </div>
</div>
</div>
<script src="./邯郸市政府信息公开1_files/new_xxgkindex.js.下载"></script>
<script language="JavaScript">
    function executeSearch()
    {
        document.trssearchform.method = 'post';
        document.trssearchform.submit();
    }
    function cancelSearch()
    {
        //去掉链接参数中的searchType，searchValue参数
        var oParams = top.location.search.toQueryParams() || {};
        delete oParams["searchType"];
        delete oParams["searchValue"];
        var sUrl = top.location.href;
        var match = /^([^\?]+).*$/.exec(sUrl);
        if(match){
            sUrl = match[1];
            var sParams = $toQueryStr(oParams);
            if(sParams && sParams.length > 0){
                sUrl += "?" + sParams
            }
        }
        window.top.location.href = sUrl;
    }
</script>

</body></html>




