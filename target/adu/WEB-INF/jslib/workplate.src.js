/**
 * _IsPosting = false function initMenu (pid, isleaf, obj) { // 设置菜单为激活状态 if ($
 * (obj).attr ("class") && $ (obj).attr ("class").indexOf ("submenu") >= 0){ $
 * (".submenu").removeClass ("active"); $ (obj).addClass ("active"); } //
 * 如果正在执行返回等待 if (_IsPosting || $ ("#" + pid + " li").length > 0){ return; } if
 * (isleaf == 1){ return; } _IsPosting = true; $.post ("base/menu/list", {
 * nodeid : pid }, function (rslt) { genLeftMenu (rslt.rows, pid); _IsPosting =
 * false; }) } function genLeftMenu (menu, pid) { pid = pid || "leftMenu"; var s =
 * ''; $.each (menu, function (i, m) { var tmps = m.url != '' ? '<a
 * target="ifrmMain" href="' + m.url + '?colSym=' + m.sym + '&colTitle=' +
 * m.title + '">' : '<a href="#">'; tmps += m.img != '' ? '<i class="' + m.img +
 * '"></i>' : '<i class="fa fa-circle-o"></i>'; //打乱菜单，考核用 //if
 * (m.baseTree.pathName.indexOf ("测试") >= 0){ // tmps += '&nbsp;&nbsp;<span>' +
 * m.id + "_" + m.title.split ("_")[1] + '</span>'; //} //else{ // tmps +=
 * '&nbsp;&nbsp;<span>' + m.title + '</span>'; //}
 * 
 * tmps += '&nbsp;&nbsp;<span>' + m.title + '</span>'; if (m.baseTree.isLeaf ==
 * 0){ tmps += '<i class="fa fa-angle-left pull-right"></i></a>'; tmps += '
 * <ul id="' + m.id + '" class="treeview-menu" style="padding-left:20px;">
 * </ul>'; } else{ tmps += '</a>'; } if (pid == "leftMenu"){ tmps = '
 * <li class="treeview" onclick="javascript:initMenu(' + m.id + ',' + m.baseTree.isLeaf + ',this)">' +
 * tmps + '</li>'; } else{ tmps = '
 * <li class="submenu" onclick="javascript:initMenu(' + m.id + ',' + m.baseTree.isLeaf + ',this)">' +
 * tmps + '</li>'; } s += tmps; }) $ ("#" + pid).append (s); }
 */

function initMenu (){
    var s = ""
    $.each (_Menus, function (i, v) {
    	if(m.baseTree.parentId == 0){
            s += genTopMenu(v)
		}
	})

    $("#leftMenu").append(s)
}


function genTopMenu (m) {
    if (m.isActive == 0){
        return true;
    }
    var url = ""
    var url = _BasePath + m.url.indexOf ("?") >= 0 ? m.url + "&colSym=" + m.sym : m.url + "?colSym=" + m.sym;
    var className = '';
    if (m.baseTree.isLeaf == 0){
        className = '<b class="arrow fa fa-angle-down"></b>'
    }
    var tmps = '<li  class="">';
    tmps += m.url != '' ? '<a calss="dropdown-toggle" target="ifrmMain" href="' + _BasePath + url + '&colTitle=' + encodeURI(m.title) + '&template=' + encodeURI(m.template) + '>' : '<a>';
    tmps += m.img != '' ? '<i class="menu-icon ' + m.img + '"></i>' : '<i class="menu-icon fa fa-circle-o"></i>';
    tmps += '&nbsp;&nbsp;<span class="menu-text">' + m.title + '</span> ' + className;
    tmps += '</a> <b class="arrow"></b>'
    if (m.baseTree.isLeaf == 0){
        // tmps += '<i class="fa fa-angle-left pull-right"></i></a>';
        tmps += genMenu(m)
    }
    tmps += '</li>'
    return tmps;
}

function genMenu (menu) {

    $.each (_Menus, function (i, m) {
        if (m.isActive == 0 ){
            return true;
        }
        if(m.baseTree.parentId == menu.baseTree.parentId){
            var url = ""
            var url = _BasePath + m.url.indexOf ("?") >= 0 ? m.url + "&colSym=" + m.sym : m.url + "?colSym=" + m.sym;
            // var clicks = 'javascript:initMenu(' + m.id + ',' + m.baseTree.parentId + ',' + m.baseTree.isLeaf
            //     + ',$(this).parent())'
            var className = '';
            if (m.baseTree.isLeaf == 0){
                className = '<b class="arrow fa fa-angle-down"></b>'
            }

            var tmps = '<li  class="">';
            tmps = m.url != '' ? '<a calss="dropdown-toggle" target="ifrmMain" href="' + _BasePath + url + '&colTitle=' + encodeURI(m.title) + '&template=' + encodeURI(m.template) + '>' : '<a>';
            tmps += m.img != '' ? '<i class="menu-icon ' + m.img + '"></i>' : '<i class="menu-icon fa fa-circle-o"></i>';

            tmps += '&nbsp;&nbsp;<span class="menu-text">' + m.title + '</span> ' + className;
            tmps += '</a> <b class="arrow"></b>'
            if (m.baseTree.isLeaf == 0){
                tmps += '<ul id="' + m.id + '" class="submenu"></ul>';
            }
            if (pid == "leftMenu"){
                tmps = '<li  class="">' + tmps + '</li>';
            }
            else{
                tmps = '<li class="submenu" onclick="javascript:initMenu(' + m.id + ',' + m.baseTree.parentId + ','
                    + m.baseTree.isLeaf + ',this)">' + tmps + '</li>';
            }
            s += tmps;
		}

    })
    $ ("#" + pid).empty ();
    $ ("#" + pid).append (s);
}

// 生成左部导航菜单
function genLeftMenu (menu, pid, obj) {
    var s = '';
    $.each (menu, function (i, m) {
        if (m.isActive == 0){
            return true;
        }
        var url = ""
        var url = _BasePath + m.url.indexOf ("?") >= 0 ? m.url + "&colSym=" + m.sym : m.url + "?colSym=" + m.sym;
        var clicks = 'javascript:initMenu(' + m.id + ',' + m.baseTree.parentId + ',' + m.baseTree.isLeaf
            + ',$(this).parent())'
		var className = '';
        if (m.baseTree.isLeaf == 0){
            className = '<b class="arrow fa fa-angle-down"></b>'
        }
        var tmps = m.url != '' ? '<a calss="dropdown-toggle" target="ifrmMain" href="' + _BasePath + url + '&colTitle=' + encodeURI(m.title) + '&template=' + encodeURI(m.template) + '" onclick="' + clicks
            + '">' : '<a onclick="' + clicks + '">';
        tmps += m.img != '' ? '<i class="menu-icon ' + m.img + '"></i>' : '<i class="menu-icon fa fa-circle-o"></i>';
        // 打乱菜单，考核用
        // if (m.baseTree.pathName.indexOf ("测试") >= 0){
        // tmps += '&nbsp;&nbsp;<span>' + m.id + "_" + m.title.split ("_")[1] +
        // '</span>';
        // }
        // else{
        // tmps += '&nbsp;&nbsp;<span>' + m.title + '</span>';
        // }
        tmps += '&nbsp;&nbsp;<span class="menu-text">' + m.title + '</span> ' + className;
        tmps += '</a> <b class="arrow"></b>'
        if (m.baseTree.isLeaf == 0){
            // tmps += '<i class="fa fa-angle-left pull-right"></i></a>';
            tmps += '<ul id="' + m.id + '" class="submenu"></ul>';
        }
        if (pid == "leftMenu"){
            tmps = '<li  class="">' + tmps + '</li>';
        }
        else{
            tmps = '<li class="submenu" onclick="javascript:initMenu(' + m.id + ',' + m.baseTree.parentId + ','
                + m.baseTree.isLeaf + ',this)">' + tmps + '</li>';
        }
        s += tmps;
    })
    $ ("#" + pid).empty ();
    $ ("#" + pid).append (s);
}
