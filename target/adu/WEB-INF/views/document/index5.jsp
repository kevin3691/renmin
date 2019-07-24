﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>用户管理--列表</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
    <link rel="stylesheet" href="jslib/ztree/css/metroStyle/metroStyle.css"
          type="text/css">
    <script src="jslib/ztree/js/jquery.ztree.all.min.js"></script>
    <style type="text/css">
        ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:360px;overflow-y:scroll;overflow-x:auto;}
        ul.log {border: 1px solid #617775;background: #f0f6e4;width:300px;height:170px;overflow: hidden;}
        ul.log.small {height:45px;}
        ul.log li {color: #666666;list-style: none;padding-left: 10px;}
        ul.log li.dark {background-color: #E3E3E3;}
    </style>
	<script>
        function loadGrid () {
            $ ("#grid").jqGrid ({
                height: document.body.clientHeight - 30,
                rownumbers: true,
                url: 'document/list',
                postData:{
                },
                colModel : [
                    {
                        label : '类别',
                        name : 'docTypeName',
                        index : 'docTypeName',
                        align : 'center',
                        width : 80
                    }, {
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
                    },{
                        label : '是否批转',
                        name : 'isPi',
                        index : 'isPi',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, options, row) {
                            return value == 1 ? '是' : '<span style="color:gray;">否</span>'
                        }
                    },{
                        label : '是否督办',
                        name : 'isDu',
                        index : 'isDu',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, options, row) {
                            return value == 1 ? '是' : '<span style="color:gray;">否</span>'
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
                            // if(row.isPi == 1){
                            //     btn += '&nbsp;<a href="javascript:onPi(' + value + ')" title="">录入批转信息</a>'
                            // }
                            btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\',\''+row.fileExt+'\','+value+')" title="">下载文件</a>'
                            //btn += '&nbsp;<a href="javascript:onView(' + value + ')" title="">查看</a>'
                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑信息</a>'
                            btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                            //btn += '&nbsp;<a href="javascript:onKeySet(' + value + ')" title="">设置加密锁</a>'
                            return btn;
                        }
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

        }
        window.onresize = function () {
            $ ("#grid").setGridWidth (document.body.clientWidth - 12);
        }



        function onQ () {
            var para = {
                title : $ ("#title").val (),
                docTypeId : $ ("#docTypeId").val (),
                orgId : $ ("#orgId").val (),
                lwbh : $ ("#lwbh").val (),
                miji : $ ("#miji").val (),
                jbrId : $ ("#jbrId").val (),
                sprId : $ ("#sprId").val (),
                starttime : $ ("#starttime").val (),
                finishtime : $ ("#finishtime").val ()
                //dob : $ ("dob").val()
            };
            //alert (para.category)
            $ ("#grid").jqGrid ("setGridParam", {
                postData : para
            }).trigger ("reloadGrid");
        }
        //显示全部
        function showAll () {
            $ ("#title").val ("");
            $ ("#docTypeId").val (0);
            $ ("#docTypeName").val ("");
            $ ("#orgId").val (0);
            $ ("#lwbh").val ("");
            $ ("#miji").val ("");
            $ ("#jbrId").val (0);
            $ ("#jbr").val ("");
            $ ("#sprId").val (0);
            $ ("#spr").val ("");
            $ ("#starttime").val ("");
            $ ("#finishtime").val ("");
            onQ ();
        }

        var FLAG = 1
        var ACTORID = ''
        var ACTORNAME = ''

        function onSel(flag){
            FLAG = flag
            var title = "选择经办人"
          if(FLAG==1){
              title = "选择审批人"
          }
            layer.open ({
                type : 2,
                title : title,
                shadeClose : true,
                shade : 0.8,
                area : [
                    '90%', '90%'
                ],
                content : 'base/user/multiSel'
            });
        }


        function onSelOk (nodes) {
            $("#jbrId").val("")
            $("#jbr").val("")
            $("#sprId").val("")
            $("#spr").val("")
            ACTORID = ""
            ACTORNAME = ""
            layer.closeAll ();

            $.each (nodes, function (i, node) {
                ACTORID += node.id + ","
                ACTORNAME += node.basePersonName + ","
            })
            if(FLAG == 1){
                $("#jbrId").val(ACTORID)
                $("#jbr").val(ACTORNAME)
            }
            if(FLAG == 2){
                $("#sprId").val(ACTORID)
                $("#spr").val(ACTORNAME)
            }


        }

        var lwdw  = []
        function getLwdw(){
            $.post ("base/dict/listBySym", {
                parentSym : "lwdw"
            }, function (rslt) {
                if (rslt.rows == null)
                    return;
                var rows = rslt.rows;
                for (var i = 0; i < rows.length; i++){
                    var entity = new Object()
                    entity.title = rows[i].title
                    entity.id = rows[i].id
                    entity.value = rows[i].title
                    lwdw.push(entity)
                }
                $( "#org" ).autocomplete({
                    minLength: 1,
                    source: lwdw,
                    focus: function( event, ui ) {
                        $( "#org" ).val( ui.item.title );
                        return false;
                    },
                    select: function( event, ui ) {
                        $( "#org" ).val( ui.item.title );
                        $( "#orgId" ).val( ui.item.id );
                        return false;
                    }
                })
                    .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
                    return $( "<li>" )
                        .append( "<a>" + item.title + "</a>" )
                        .appendTo( ul );
                };

            })
        }


        function beforeClick(treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            zTree.checkNode(treeNode, !treeNode.checked, null, true);
            return false;
        }

        function onCheck(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree"),
                nodes = zTree.getCheckedNodes(true),
                v = "",
                ids = "";
            for (var i=0, l=nodes.length; i<l; i++) {
                v += nodes[i].name + ",";
                ids += nodes[i].id + ",";
            }
            if (v.length > 0 ) v = v.substring(0, v.length-1);
            var cityObj = $("#docTypeName");
            cityObj.attr("value", v);
            $("#docTypeId").val(ids);
        }

        function showMenu() {
            var cityObj = $("#docTypeName");
            var cityOffset = $("#docTypeName").offset();
            $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

            $("body").bind("mousedown", onBodyDown);
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "docTypeName" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                hideMenu();
            }
        }


        function bindType(){
            $.post ("doctype/list", {
                nodeid : -1,//-1查出所有记录
                isActive : 1
                //只显示启用的记录
            }, function (rslt) {
                $.fn.zTree.init ($ ("#tree"), {
                    callback : {
                        beforeClick: beforeClick,
                        onCheck: onCheck
                    },
                    check: {
                        enable: true,
                        chkboxType: {"Y":"", "N":""}
                    },
                    view: {
                        dblClickExpand: false
                    },
                    data: {
                        simpleData: {
                            enable: true
                        }
                    }
                }, rslt.rows);
                //如果只有一个根节点则展开
                var treeObj = $.fn.zTree.getZTreeObj ("tree");
                var nodes = treeObj.getNodes ();
                if (nodes.length == 1){
                    //打开指定节点会导致框架页布局错乱，暂时用打开所有节点
                    //treeObj.expandNode(nodes[0], true);
                    treeObj.expandAll (true);
                }
            })
        }


        //页面加载完成后执行
        $ (function () {
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#starttime").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#starttime').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#starttime').inputmask ("yyyy-mm-dd");

            //为日期设置格式输入
            $ ("#finishtime").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#finishtime').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#finishtime').inputmask ("yyyy-mm-dd");

            $ ('#starttime').on('changeDate',function(ev){
                if(ev.date){
                    $('#finishtime').datetimepicker('setStartDate', new Date(ev.date.valueOf()))
                }else{
                    $('#finishtime').datetimepicker('setStartDate',null);
                }
            });

            getLwdw()
            bindType()
            loadGrid()
		})

	</script>
</head>

<body>
<div class="container-fluid">
	<div class="form-group">
		<div class="breadcrumb content-header form-inline"
			 style="padding:8px;">
			<div class="form-group">
				<label for="title">文件名称</label> <input class="form-control input-sm"
													 id="title" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="docTypeName">类别</label>
                <input  id="docTypeId" value="" type="hidden" />
                <input class="form-control input-sm"
												   id="docTypeName" value="" type="text" readonly onclick="showMenu()"/>
			</div>
			<div class="form-group">
				<label for="org">来文单位</label> <input
                    class="form-control input-sm" id="orgId" value="" type="hidden" />
                <input
					class="form-control input-sm" id="org" value="" type="text" />
			</div>

			<div class="form-group">
				<label for="lwbh">来文编号</label> <input
					class="form-control input-sm" id="lwbh" value="" type="text" />
			</div>

            <div class="form-group">
                <label for="miji">密级</label>
                <select id="miji" name="miji" style="width: 100px;"
                        class="select2">
                    <option value=''>全部</option>
                    <option value='否'>否</option>
                    <option value='秘密'>秘密</option>
                    <option value='机密'>机密</option>
                    <option value='内部保密'>内部保密</option>
                </select>
            </div>
            <div class="form-group">
                <label for="jbr">经办人</label>
                <input  id="jbrId" value="" type="hidden" />
                <input
                        class="form-control input-sm" id="jbr" value="" type="text" readonly onclick="onSel(1)"/>
            </div>


            <div class="form-group">
                <label for="sprId">审批人</label>
                <input  id="sprId" value="" type="hidden" />
                <input
                        class="form-control input-sm" id="spr" value="" type="text" readonly onclick="onSel(2)"/>
            </div>

            <div class="form-group">
                <label for="starttime">开始时间</label>
                <input
                        class="form-control input-sm" id="starttime" value="" type="text" />
            </div>

            <div class="form-group">
                <label for="finishtime">结束时间</label>
                <input
                        class="form-control input-sm" id="finishtime" value="" type="text" />
            </div>

			<div class="form-group">
				<button class="btn btn-info" id="btnOnQ" type="button"
						onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
						onclick="showAll()">显示全部</button>
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</div>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
    <ul id="tree" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
</div>
</body>
</html>
<script type="text/javascript">

</script>
