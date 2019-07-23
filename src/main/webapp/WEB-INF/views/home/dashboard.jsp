<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head5.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
    <link rel="stylesheet" type="text/css"
          href="jslib/fullcalendar/fullcalendar.css">
    <link rel="stylesheet" type="text/css"
          href="jslib/fullcalendar/fullcalendar.print.css" media='print'>

    <script type="text/javascript" src="jslib/fullcalendar/fullcalendar.min.js"></script>
    <script type="text/javascript" src="jslib/fullcalendar/locale-all.js"></script>

<title>公文-编辑</title>
<script type="text/javascript">
//装载表格
function loadGrid_duban () {
        $ ("#grid_duban").jqGrid ({
            url : "duban/list4duban",
            postData : {
                status:1
            },
            height : document.body.clientHeight - 130,
            rownumbers : true,
            colModel : [
                {
                    label : '类别',
                    name : 'docTypeName',
                    index : 'docTypeName',
                    width : 80
                },{
                    label : '标题',
                    name : 'title',
                    index : 'title',
                    width : 240
                },{
                    label : '承办部门',
                    name : 'chengbanchushi',
                    index : 'chengbanchushi',
                    width : 240
                },{
                    label : '开始时间',
                    name : 'starttime',
                    index : 'starttime',
                    width : 180,
                    formatter : function (value, options, row) {
                        return jsonDateTimeFormatter (value, 3);
                    }
                },{
                    label : '完成时间',
                    name : 'finishtime',
                    index : 'finishtime',
                    width : 180,
                    formatter : function (value, options, row) {
                        return jsonDateTimeFormatter (value, 3);
                    }
                },{
                    label : ' ',
                    name : 'id',
                    width : 120,
                    align : 'center',
                    sortable : false,
                    formatter : function (value, options, row) {
                        var btn = "";

                        if(row.status == 1)
                            btn += '&nbsp;<a href="javascript:onDu('+  row.id +')" title="">督办</a>'
                        if(row.status == 2)
                            btn += '&nbsp;<a href="javascript:onView('+  row.id +')" title="">查看</a>'

                        return btn;
                    }
                },{
                    name : 'refNum',
                    hidden : true
                }
            ],
            rowNum : 20,
            rowList : [
                20, 50, 100
            ],
            pager : '#pager',
            sortname : 'id',
            sortorder : "desc"
        });
        jQuery ("#grid_duban").jqGrid ('bindKeys', {
            "onEnter" : function (rowid) {
                //alert ("你enter了一行， id为:" + rowid)
            },
            "onRightKey" : function (rowid) {
                onSave (rowid)
            },
            "onLeftKey" : function (rowid) {
                onDel (rowid)
            },
            "onSpace" : function (rowid) {
            }
        });
    }


function loadGrid_chaoshi () {
    $ ("#grid_chaoshi").jqGrid ({
        url : "duban/list4chaoshi",
        postData : {

        },
        height : document.body.clientHeight - 130,
        rownumbers : true,
        colModel : [
            {
                label : '类别',
                name : 'docTypeName',
                index : 'docTypeName',
                width : 80
            },{
                label : '标题',
                name : 'title',
                index : 'title',
                width : 240
            },{
                label : '承办部门',
                name : 'chengbanchushi',
                index : 'chengbanchushi',
                width : 240
            },{
                label : '开始时间',
                name : 'starttime',
                index : 'starttime',
                width : 180,
                formatter : function (value, options, row) {
                    return jsonDateTimeFormatter (value, 3);
                }
            },{
                label : '完成时间',
                name : 'finishtime',
                index : 'finishtime',
                width : 180,
                formatter : function (value, options, row) {
                    return jsonDateTimeFormatter (value, 3);
                }
            },{
                label : ' ',
                name : 'id',
                width : 120,
                align : 'center',
                sortable : false,
                formatter : function (value, options, row) {
                    var btn = "";

                    if(row.status == 1)
                        btn += '&nbsp;<a href="javascript:onDu('+  row.id +')" title="">督办</a>'
                    if(row.status == 2)
                        btn += '&nbsp;<a href="javascript:onView('+  row.id +')" title="">查看</a>'

                    return btn;
                }
            },{
                name : 'refNum',
                hidden : true
            }
        ],
        rowNum : 20,
        rowList : [
            20, 50, 100
        ],
        pager : '#pager',
        sortname : 'id',
        sortorder : "desc"
    });
    jQuery ("#grid_chaoshi").jqGrid ('bindKeys', {
        "onEnter" : function (rowid) {
            //alert ("你enter了一行， id为:" + rowid)
        },
        "onRightKey" : function (rowid) {
            onSave (rowid)
        },
        "onLeftKey" : function (rowid) {
            onDel (rowid)
        },
        "onSpace" : function (rowid) {
        }
    });
}


function loadGrid_dbgw() {
    $ ("#grid_dbgw").jqGrid ({
        title: '待处理公文',
        width: '100%',
        height: document.body.clientHeight - 30,
        url: 'document/list_ins',
        postData : {
            isDu:0,
            isGui:0,
            actorId:"${baseUser.basePersonId}",
            yesno:"no",
            isActive:5
        },
        rownumbers : true,
        colModel : [
            {
                label : '文件名称',
                name : 'title',
                index : 'title',
                align : 'center',
                width : 240
            }, {
                label : '创建时间',
                name : 'recordInfo.createdAt',
                index : 'recordInfo.createdAt',
                sortable : false,
                align : 'center',
                width : 130,
                formatter : function (value, options, row) {
                    return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
                }
            }, {
                label : '创建者',
                name : 'recordInfo.createdByName',
                index : 'recordInfo.createdByName',
                sortable : false,
                align : 'center',
                width : 70,
                formatter : function (value, options, row) {
                    return row.recordInfo.createdByName;
                }
            }, {
                label : '当前环节',
                name : 'stepName',
                index : 'stepName',
                align : 'center',
                width : 80
            }, {
                label : '执行人',
                name : 'actorName',
                index : 'actorName',
                sortable : false,
                align : 'center',
                width : 130,
                formatter : function (value, options, row) {
                    //return value == 1 ? '是' : '<span style="color:gray;">否</span>'
                    return value
                }
            },  {
                label : '操作',
                name : 'id',
                index : 'id',
                width : 130,
                align : 'center',
                sortable : false,
                formatter : function (value, options, row) {

                    var btn = "";
                    btn += '&nbsp;<a href="javascript:onPi(' + row.refNum + ',' +row.id+ ')" title="">查看</a>'

                    return btn;
                }
            }
        ]
    });

}

function onPi(id,insId){
    id = id || 0;
    insId = insId || 0;
    var title = "录入批转信息"

    // parent.layer.open ({
    //     type : 2,
    //     title : title,
    //     shadeClose : true,
    //     shade : 0.8,
    //     area : [
    //         '90%', '80%'
    //     ],
    //     content : 'document/pizhuan?docId=' + id
    // });

    var url = 'document/dact?id=' + id + '&insId=' + insId
    //win(url,title)
    document.location.href = url

}
    //保存
    function onSave (id) {
        id = id || 0;
        var title = "添加督办事项"
        if (id > 0){
            title = "编辑督办事项"
        }
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'duban/edit?id=' + id + '&colSym=ZHUANXIANG?colTitle=' + encodeURI("专项督办") //iframe的url
        });
    }

    function onDu(id){
        id = id || 0;
        document.location.href = 'duban/duban?id=' + id
    }

    function onView(id){
        id = id || 0;
        document.location.href = 'duban/view?id=' + id
    }

    function onDtl (refNum) {
        refNum = refNum || 0;
        var title = "查看公文"
        document.location = 'document/dtl?id=' + refNum
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
        $ ("#grid_duban").trigger ("reloadGrid");
        layer.closeAll ();
    }
    //删除
    function onDel (refNum) {
        layer.confirm ('确定要删除文档？', {
            btn : [
                '确定', '取消'
            ]
            //按钮
        }, function () {
            $.post ("document/delIns", {
                refNum : refNum
            }, function () {
                $ ("#grid_duban").trigger ("reloadGrid");
            });
            layer.closeAll ();
        });
    }
    //排序
    function onSort (id, order) {
        $.post ("document/sort", {
            id : id,
            order : order
        }, function () {
            $ ("#grid").trigger ("reloadGrid");
        });
    }
    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
        onQ (node.id);
    }
    //查询
    function onQ () {
        var para = {
            title : $ ("#title").val ()
        };
        $ ("#grid_duban").jqGrid ("setGridParam", {
            page : 0,
            postData : para
        }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
        $ ("#title").val ("");
        onQ (0);
    }

    function init(){
        $.post ("goods/getInfo", {

        }, function (result,status) {
            $("#docCount").html(result.docCount)
            $("#docPiCount").html(result.docPiCount)
            $("#docDuCount").html(result.docDuCount)
            $("#docFinishCount").html(result.docFinishCount)
        });
    }

    function workplan(){
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                //right: 'month,agendaWeek,agendaDay,listMonth'
                right: 'month,listMonth'
            },
            editable: false,
            locale : "zh-cn",
            timezone:"local",
            dayClick: function (date, allDay, jsEvent, view) {
                AddCalendar(date.format("YYYY-MM-DD HH:mm"));
            },
            eventMouseover: function (calEvent, jsEvent, view) {
                var fstart = calEvent.start.format("YYYY-MM-DD HH:mm");
                var fend = calEvent.end.format("YYYY-MM-DD HH:mm");
                $(this).attr('title', fstart + " - " + fend + " " + "标题" + " : " + calEvent.title);
                $(this).css('font-weight', 'normal');
            },
            eventClick: function (event) {
                OpenCalendar(event.id);
            },
            events: function (start, end, timezone,callback) {
                var datestart = start.format("YYYY-MM-DD");
                var dateend = end.format("YYYY-MM-DD");
                // $.post ('cash/save', {}, function (result, status) {
                //         parent.$("#calendar").fullCalendar('refetchEvents');
                //         onReset()
                //         $('#newcal').modal('hide');
                //     }
                //
                // );
                $.ajax({
                    url: 'workplanlist/list',
                    dataType: 'json',
                    cache: false,
                    data: {
                        startdate: datestart,
                        finishdate: dateend
                    },
                    success: function (result) {
                        var events = [];
                        for (var i = 0; i < result.rows.length; i++) {
                            events.push({
                                title: result.rows[i].title,
                                start:jsonDateTimeFormatter(result.rows[i].startdate,1),
                                end: jsonDateTimeFormatter(result.rows[i].finishdate,1),
                                // start:"2018-08-08 00:00:00",
                                // end: "2018-08-08 01:00:00",
                                id: result.rows[i].id
                            });
                        }
                        callback(events);
                    }
                });
            }
        });
    }




function log(){
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    $('#work').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            //right: 'month,agendaWeek,agendaDay,listMonth'
            right: 'month,listMonth'
        },
        editable: false,
        locale : "zh-cn",
        timezone:"local",
        dayClick: function (date, allDay, jsEvent, view) {
            tian(date.format("YYYY-MM-DD HH:mm"));
        },
        eventMouseover: function (calEvent, jsEvent, view) {
            var fstart = calEvent.start.format("YYYY-MM-DD HH:mm");
            var fend = calEvent.end.format("YYYY-MM-DD HH:mm");
            $(this).attr('title', fstart + " - " + fend + " " + "标题" + " : " + calEvent.title);
            $(this).css('font-weight', 'normal');
        },
        eventClick: function (event) {
            update(event.id);
        },
        events: function (start, end, timezone,callback) {
            var datestarti = start.format("YYYY-MM-DD");
            var dateendi = end.format("YYYY-MM-DD");
            $.ajax({
                url: 'worklog/list',
                dataType: 'json',
                cache: false,
                data: {
                    startdatei: datestarti,
                    finishdatei: dateendi
                },
                success: function (result) {
                    var events = [];
                    for (var i = 0; i < result.rows.length; i++) {
                        events.push({
                            title: result.rows[i].titlei,
                            start:jsonDateTimeFormatter(result.rows[i].startdatei,1),
                            end: jsonDateTimeFormatter(result.rows[i].finishdatei,1),
                            id: result.rows[i].id
                        });
                    }
                    callback(events);
                }
            });
        }
    });
}
//打开窗口
function tian(pDate) {
    $("#btnDeli").hide(); //删除
    //$('#newcal').find('form').form('clear');
    $("#startdatei").val(pDate.toString());
    $("#finishdatei").val(pDate.toString());
    // $("#startdate").datetimepicker('setValue', pDate.toString());
    // $("#finishdate").datetimepicker('setValue', pDate.toString());
    $("#titlei").val("");
    $("#contenti").val("");
    $("#orgIdi").val("${baseUser.baseOrgId}");
    $("#orgi").val("${baseUser.baseOrgName}");
    $("#personIdi").val("${baseUser.basePersonId}");
    $("#personi").val("${baseUser.basePersonName}");
    $("#makedayi").val("");
    $("#statusi").val(0);
    $("#repeateri").val(0);
    $("#roundi").val(0);
    $("#leveli").val(0);
    $("#typei").val("");
    $('#newca2').modal('show');
    // $("#btn_DlgAdd").show(); //添加保存
    // $("#btn_DlgCancle").show(); //清空
    // $("#btn_DlgEdit").hide(); //编辑保存
    // $("#btn_DlgDel").hide(); //删除
    // dlg_All.dialog({
    //     iconCls: 'icon-add',
    //     title: '添加信息'
    // });
    // dlg_All.find('form').form('clear');
    // $("#Start_Date").datebox('setValue', pDate.toString());
    // $('#Start_Time').timespinner('setValue', '00:00');
    // $("#End_Date").datebox('setValue', pDate.toString());
    // $('#End_Time').timespinner('setValue', '23:59');
    // $('#dlg_ff').form('validate')
    // dlg_All.dialog('open');
}
//添加
function tianjia() {
    if (!$ ('#mainFormi').validate ().form ()){
        return false;
    }
    if ($("#startdatei").val() > $("#finishdatei").val()) {
        alert("【开始日期】不能大于【结束日期】！");
        return false;
    }
    var para = $ ("#mainFormi").serialize ();
    $.post ('worklog/save', $ ("#mainFormi").serialize (), function (result, status) {
            $("#work").fullCalendar('refetchEvents');
            rest()
            $('#newca2').modal('hide');
        }
    );
}
//初始化
function rest() {
    $("#idi").val(0);
    // $("#startdate").val("");
    // $("#finishdate").val("");
    $("#titlei").val("");
    $("#contenti").val("");
    $("#orgIdi").val("");
    $("#orgi").val("");
    $("#personIdi").val("");
    $("#personi").val("");
    $("#makedayi").val("");
    $("#statusi").val(0);
    $("#repeateri").val(0);
    $("#roundi").val(0);
    $("#leveli").val(0);
    $("#typei").val("");
}
//修改
function update(id) {
    $("#btnDeli").show()
    $("#idi").val(id);
    $("#mtitle").html("编辑日程")
    $.post ('worklog/dtl', {id:id}, function (result, status) {
        var plan = result.entity
        $("#startdatei").val(jsonDateTimeFormatter(plan.startdatei,1));
        $("#finishdatei").val(jsonDateTimeFormatter(plan.finishdatei,1));
        $("#titlei").val(plan.titlei);
        $("#contenti").val(plan.contenti);
        $("#orgIdi").val(plan.orgIdi);
        $("#orgi").val(plan.orgi);
        $("#personIdi").val(plan.personIdi);
        $("#personi").val(plan.personi);
        $("#makedayi").val(plan.makedayi);
        $("#statusi").val(plan.statusi);
        $("#repeateri").val(plan.repeateri);
        $("#roundi").val(plan.roundi);
        $("#leveli").val(plan.leveli);
        $("#typei").val(plan.typei);
        $('#newca2').modal('show');
    });
}
//删除
function Del() {
    $.post ("worklog/del", {
        id : $("#idi").val()
    }, function () {
        $("#work").fullCalendar('refetchEvents');
        $('#newca2').modal('hide');
    });
};

function AddCalendar(pDate) {
    $("#btnDel").hide(); //删除
    //$('#newcal').find('form').form('clear');
    $("#startdate").val(pDate.toString());
    $("#finishdate").val(pDate.toString());
    // $("#startdate").datetimepicker('setValue', pDate.toString());
    // $("#finishdate").datetimepicker('setValue', pDate.toString());
    $("#title").val("");
    $("#content").val("");
    $("#orgId").val("${baseUser.baseOrgId}");
    $("#org").val("${baseUser.baseOrgName}");
    $("#personId").val("${baseUser.basePersonId}");
    $("#person").val("${baseUser.basePersonName}");
    $("#makeday").val("");
    $("#status").val(0);
    $("#repeater").val(0);
    $("#round").val(0);
    $("#level").val(0);
    $("#type").val("");


    $('#newcal').modal('show');

    // $("#btn_DlgAdd").show(); //添加保存
    // $("#btn_DlgCancle").show(); //清空
    // $("#btn_DlgEdit").hide(); //编辑保存
    // $("#btn_DlgDel").hide(); //删除
    // dlg_All.dialog({
    //     iconCls: 'icon-add',
    //     title: '添加信息'
    // });
    // dlg_All.find('form').form('clear');
    // $("#Start_Date").datebox('setValue', pDate.toString());
    // $('#Start_Time').timespinner('setValue', '00:00');
    // $("#End_Date").datebox('setValue', pDate.toString());
    // $('#End_Time').timespinner('setValue', '23:59');
    // $('#dlg_ff').form('validate')
    // dlg_All.dialog('open');
}

function OpenCalendar(id) {
    $("#btnDel").show()
    $("#id").val(id);
    $("#mtitle").html("编辑日程")
    $.post ('workplanlist/dtl', {id:id}, function (result, status) {
        var plan = result.entity
        $("#startdate").val(jsonDateTimeFormatter(plan.startdate,1));
        $("#finishdate").val(jsonDateTimeFormatter(plan.finishdate,1));
        $("#title").val(plan.title);
        $("#content").val(plan.content);
        $("#orgId").val(plan.orgId);
        $("#org").val(plan.org);
        $("#personId").val(plan.personId);
        $("#person").val(plan.person);
        $("#makeday").val(plan.makeday);
        $("#status").val(plan.status);
        $("#repeater").val(plan.repeater);
        $("#round").val(plan.round);
        $("#level").val(plan.level);
        $("#type").val(plan.type);
        $('#newcal').modal('show');
        });
}

function onReset() {
    $("#id").val(0);
    // $("#startdate").val("");
    // $("#finishdate").val("");
    $("#title").val("");
    $("#content").val("");
    $("#orgId").val("");
    $("#org").val("");
    $("#personId").val("");
    $("#person").val("");
    $("#makeday").val("");
    $("#status").val(0);
    $("#repeater").val(0);
    $("#round").val(0);
    $("#level").val(0);
    $("#type").val("");
}

function onSave() {
    if (!$ ('#mainForm').validate ().form ()){
        return false;
    }
    if ($("#startdate").val() > $("#finishdate").val()) {
        alert("【开始日期】不能大于【结束日期】！");
        return false;
    }

    var para = $ ("#mainForm").serialize ();

    $.post ('workplanlist/save', $ ("#mainForm").serialize (), function (result, status) {

        $("#calendar").fullCalendar('refetchEvents');
        onReset()
        $('#newcal').modal('hide');
        }
    );
}




function onDel() {
     $.post ("workplanlist/del", {
        id : $("#id").val()
    }, function () {
        $("#calendar").fullCalendar('refetchEvents');
         $('#newcal').modal('hide');
    });
};

    //页面加载完成后执行
    $ (function () {
        //$ (".select2").select2 ();

        $ ('#startdate').datetimepicker ({
            minView : 0,
            minuteStep:1,
            todayHighlight: 1,
            format: "yyyy-mm-dd hh:ii"
            //时间，默认为日期时间
        });

        $ ('#finishdate').datetimepicker ({
            minView : 0,
            minuteStep:1,
            todayHighlight: 1,
            format: "yyyy-mm-dd hh:ii"
            //时间，默认为日期时间
        });


        loadGrid_duban ();
        loadGrid_chaoshi ();
        loadGrid_dbgw ();
        init()
        workplan()
        log();
    });






</script>
<style>

</style>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
        <div class="row">
            <iframe scrolling="no" src="https://tianqiapi.com/api.php?style=tg&skin=pitaya" frameborder="0" width="470" height="60" allowtransparency="true"></iframe>
            <%--
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                    <div class="inner">
                        <h3 id="docCount"></h3>

                        <p>文档总数</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-bag"></i>
                    </div>
                    <a href="javascript:;" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-green">
                    <div class="inner">
                        <h3 id="docPiCount"></h3>

                        <p>批办文档数</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                    <a href="javascript:;" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3 id="docDuCount"></h3>

                        <p>督办文档数</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person-add"></i>
                    </div>
                    <a href="javascript:;" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-red">
                    <div class="inner">
                        <h3 id="docFinishCount"></h3>

                        <p>完成文档数</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-pie-graph"></i>
                    </div>
                    <a href="javascript:;" class="small-box-footer"><i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
        --%></div>
        <div class="col-md-5 col-sm-5">
            <div class="box box-default box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">领导工作计划</h3>
                    <div class="box-tools pull-right">
                        <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                    </div>
                </div>
                <div class="box-body" id="calendar">

                </div>
            </div>
        </div>

        <div class="col-md-5 col-sm-5">
            <div class="box box-default box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">工作日志</h3>
                    <div class="box-tools pull-right">

                        <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                    </div>
                </div>
                <div class="box-body" id="work">
                    <%--<table id="grid"></table>--%>
                </div>
            </div>
        </div>

  <%--      <div class="col-md-6 col-sm-6">
            <div class="box box-default box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">待办公文列表</h3>

                    <div class="box-tools pull-right">
                        <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                    </div>
                </div>
                <div class="box-body">
                    <table id="grid_dbgw"></table>
                </div>
            </div>
        </div>--%>

<%--        <div class="col-md-6 col-sm-6">
            <div class="box box-default box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">督办超时列表</h3>

                    <div class="box-tools pull-right">
                        <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                    </div>
                </div>
                <div class="box-body">
                    <table id="grid_chaoshi"></table>
                </div>
            </div>
        </div>--%>

	<%--	<div class="col-md-6 col-sm-6">
			<div class="box box-default box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">督办列表</h3>

              <div class="box-tools pull-right">
                <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
              </div>
            </div>
            <div class="box-body">
              <table id="grid_duban"></table>
            </div>
          </div>
		</div>--%>


		<%--<div class="col-md-6 col-sm-6">--%>
			<%--<div class="box box-info box-solid">--%>
            <%--<div class="box-header with-border">--%>
              <%--<h3 class="box-title">已办列表</h3>--%>

              <%--<div class="box-tools pull-right">--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<div class="box-body">--%>
            	<%--<table id="grid_yiban"></table>--%>
            <%--</div>--%>
          <%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<div class="col-md-6 col-sm-6">--%>
			<%--<div class="box box-primary box-solid">--%>
            <%--<div class="box-header with-border">--%>
              <%--<h3 class="box-title">督办列表</h3>--%>

              <%--<div class="box-tools pull-right">--%>
                <%--<!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<div class="box-body">--%>
              <%--<table id="grid_duban"></table>--%>
            <%--</div>--%>
          <%--</div>--%>
		<%--</div>--%>
		<%--<div class="col-md-6 col-sm-6">--%>
			<%--<div class="box box-danger box-solid">--%>
            <%--<div class="box-header with-border">--%>
              <%--<h3 class="box-title">日程安排</h3>--%>

              <%--<div class="box-tools pull-right">--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<div class="box-body">--%>
            <%----%>
            <%--</div>--%>
          <%--</div>--%>
		<%--</div>--%>
	</div>

    <div class="modal" id="newcal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="mtitlei">新建日程</h4>
                </div>
                <div class="modal-body">
                    <form id="mainForm" class="form-horizontal" >
                        <input type="hidden" id="id" name="id"/>
                        <input type="hidden" id="personId" name="personId" />
                        <input type="hidden" id="person" name="person" />
                        <input type="hidden" id="orgId" name="orgId" />
                        <input type="hidden" id="org" name="org"  />
                        <input type="hidden" id="makeday" name="makeday"  />
                        <input type="hidden" id="status" name="status"  />
                        <input type="hidden" id="descr" name="descr"  />
                        <input type="hidden" id="starttime" name="starttime"  />
                        <input type="hidden" id="finishtime" name="finishtime"  />

                        <input type="hidden" id="repeater" name="repeater"  />
                        <input type="hidden" id="round" name="round"  />
                        <input type="hidden" id="level" name="level" />
                        <input type="hidden" id="type" name="type" />
                        <div>&nbsp;</div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="startdate">开始日期</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input class="form-control" id="startdate" name="startdate"
                                           type="text" />
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"
                                           onclick="$('#startdate').datetimepicker('show');"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="finishdate">结束日期</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input class="form-control" id="finishdate" name="finishdate"
                                           type="text" />
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"
                                           onclick="$('#finishdate').datetimepicker('show');"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="title">标题</label>
                            <div class="col-sm-10">
                                <input class="form-control" id="title" name="title"
                                       value="" type="text"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="content">内容</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="content" name="content" rows=3></textarea>
                            </div>
                        </div>
                        <%--<div class="form-group">--%>
                            <%--<label class="col-sm-1 control-label" for="status">状态</label>--%>
                            <%--<div class="col-sm-11">--%>
                                <%--<select id="status" name="type" class="form-control select2" style="width: 320px">--%>
                                    <%--<option value="0">普通费用报销</option>--%>
                                    <%--<option value="1">差旅报销</option>--%>
                                    <%--<option value="其它">其它</option>--%>
                                <%--</select>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-danger" id="btnDel" onclick="onDel()">删除</button>
                    <button type="button" class="btn btn-primary" id="btnShow" onclick="onReset()">清空</button>
                    <button type="button" class="btn btn-primary" id="btnSave" onclick="onSave()">保存</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>





    <div class="modal" id="newca2">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="mtitle">新建日志</h4>
                </div>
                <div class="modal-body">
                    <form id="mainFormi" class="form-horizontal" >
                        <input type="hidden" id="idi" name="id"/>
                        <input type="hidden" id="personIdi" name="personIdi" />
                        <input type="hidden" id="personi" name="personi" />
                        <input type="hidden" id="orgIdi" name="orgIdi" />
                        <input type="hidden" id="orgi" name="orgi"  />
                        <input type="hidden" id="makedayi" name="makedayi"  />
                        <input type="hidden" id="statusi" name="statusi"  />
                        <input type="hidden" id="descri" name="descri"  />
                        <input type="hidden" id="starttimei" name="starttimei"  />
                        <input type="hidden" id="finishtimei" name="finishtimei"  />

                        <input type="hidden" id="repeateri" name="repeateri"  />
                        <input type="hidden" id="roundi" name="roundi"  />
                        <input type="hidden" id="leveli" name="leveli" />
                        <input type="hidden" id="typei" name="typei" />
                        <div>&nbsp;</div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="startdate">开始日期</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input class="form-control" id="startdatei" name="startdatei"
                                           type="text" />
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"
                                           onclick="$('#startdate').datetimepicker('show');"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="finishdate">结束日期</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input class="form-control" id="finishdatei" name="finishdatei"
                                           type="text" />
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"
                                           onclick="$('#finishdate').datetimepicker('show');"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="title">标题</label>
                            <div class="col-sm-10">
                                <input class="form-control" id="titlei" name="titlei"
                                       value="" type="text"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="content">内容</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="contenti" name="contenti" rows=3></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-danger" id="btnDeli" onclick="Del()">删除</button>
                    <button type="button" class="btn btn-primary" id="btnShowi" onclick="rest()">清空</button>
                    <button type="button" class="btn btn-primary" id="btnSavei" onclick="tianjia()">保存</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
