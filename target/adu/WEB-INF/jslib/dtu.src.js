__daterange__ = {"getDayStartEnd": "当天","getWeekStartEnd": "本周", "getFirstHalfMonthStartEnd": "上半月",
                 "getSecondHalfMonthStartEnd": "下半月", "getMonthStartEnd": "本月", "getSeasonStartEnd": "本季度",
                 "getFirstHalfYearStartEnd": "上半年", "getSecondHalfYearStartEnd": "下半年", "getYearStartEnd": "本年",
                 "getNextWeekStartEnd": "下周", "getNextMonthStartEnd": "下一月", "getNextSeasonStartEnd": "下季度",
                 "getNextYearStartEnd": "下一年", "getPastWeekStartEnd": "上周", "getPastMonthStartEnd": "上一月",
                 "getPastSeasonStartEnd": "上季度", "getPastYearStartEnd": "去年","getPastTwoWeekStartEnd":"上两周",
                 "getNextTwoWeekStartEnd":"下两周"}
                 
//paramDict = {'withNone': 'yes'} 
function bopDateRangeOption(fldname, opts, defx, sclass, lblstyle, onchg, sstyle, paramDict) {
   var ar=[]
   var d = defx || ""
   var chg = onchg || ""
   var withNone = paramDict && paramDict["withNone"]? paramDict["withNone"] : 'yes'
   if (sclass)
      var _sclass = ' class="'+sclass+'"'
   else
      var _sclass=''
   if (sstyle)
      var  _sstyle = ' style="' + sstyle + '"'  
   else
      var _sstyle = ''
   if (lblstyle)
      var _lblstyle= '<span class="' + lblstyle + '">'
   else 
      var _lblstyle='<span>'
   st = '<select style="width:80px;" name="'+fldname+'"' + _sclass + _sstyle
   if (chg != '')
       st += ' onChange="' + chg + '"'
   st += ' runat=server id="'+fldname+'">'
   ar[ar.length] = st
   var s = '<option value=""'
   if (d=="") s +=' selected'
   s += '>'+_lblstyle+'&nbsp;'+'</span></option>'
   if (withNone =='yes')
       ar[ar.length] = s
   for (var i=0; i<opts.length; i++) {
        var t = __daterange__[opts[i]]
        t = t ? t : "&lt;无此项 - " + opts[i] + '&gt;'
        var s='<option value='+opts[i]
        if (opts[i] == d) 
            s += ' selected'
        s += '>'+_lblstyle + t + '</span></option>'
        ar[ar.length] = s
   } 
   ar[ar.length] = '</select>'
   return ar.join('\r\n')
} 

//usage: document.write(bopDateRangeOption('O', ['getDayStartEnd', 'getPastYearStartEnd'], '','SEL', 'LBL'))

var datetimeUtils = new Object()
datetimeUtils.__day_start="00:00:00"
datetimeUtils.__day_end = "23:59:59"
datetimeUtils.__daysinmonth__ = [31,0,31,30,31,30,31,31,30,31,30,31]
datetimeUtils.__H = 60*60*1000

datetimeUtils.__daysinfeb__ = function (year) {
  return ((year%100 != 0) && (year %4 == 0)) || (year % 400==0) ? 29:28
}
datetimeUtils.__start_day = function(ds) {
   return ds + ' ' + datetimeUtils.__day_start
}
datetimeUtils.__end_day = function(ds) {
   return ds + ' ' + datetimeUtils.__day_end
}
datetimeUtils.__getDate = function(d) {
   var o = d || new Date()
   if (typeof(d) == typeof('')) {
       var dd = o.split(' ')[0].split('-')
       var tt = o.split(' ')[1].split(':')
       o = new Date(Number(dd[0]),Number(dd[1])-1,Number(dd[2]),Number(tt[0]),Number(tt[1]),Number(tt[2]))
       return o
   }
   if (typeof(d) == typeof(1) || typeof(d) == typeof(1.0))
       o = new Date(d)
   return o   
}
datetimeUtils.formatdate = function(d) {
    var y = d.getFullYear()
    var m = d.getMonth()+1
    m = m < 10? "0"+m : ""+m
    var dd = d.getDate()
    dd = dd < 10 ? "0"+dd : ""+dd
    return ""+y+'-'+m+'-'+dd
}
//return week day the month starts at, and the days in the month 
//we make input/output to be pythonished.
//so, month should be 1-12, and returned week day 0 for Monday, as opposed to JS: 0 for Jan. and 1 for Mon.
datetimeUtils.monthrange = function (year, month) {
    var firstday=new Date(year, month-1, 1)
    var wkday = firstday.getDay() - 1 //make Monday to be 0, and completely Pythonished. 
    if (month == 2) 
        return [wkday, datetimeUtils.__daysinfeb__(year)]
    return [wkday, datetimeUtils.__daysinmonth__[month-1]] 
}
datetimeUtils.getDayStartEnd=function(dt) {
    var d = datetimeUtils.__getDate(dt)
    var ds = datetimeUtils.formatdate(d)
    return [datetimeUtils.__start_day(ds), datetimeUtils.__end_day(ds)]
}
datetimeUtils.getWeekStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var wd = o.getDay()
    wd = wd == 0? 7: wd
    var dt= (wd -1) * 24 * datetimeUtils.__H 
    var mon = new Date()
    mon.setTime(o.getTime() - dt)
    dt = (7-wd) * 24 * datetimeUtils.__H
    var sun = new Date()
    sun.setTime(o.getTime() + dt)
    return [datetimeUtils.__start_day(datetimeUtils.formatdate(mon)), datetimeUtils.__end_day(datetimeUtils.formatdate(sun))]
}

datetimeUtils.getFirstHalfMonthStartEnd = function (dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var m = o.getMonth()
    var s = new Date(y, m, 1)
    var e = new Date(y, m, 15)
    return [datetimeUtils.__start_day(datetimeUtils.formatdate(s)), datetimeUtils.__end_day(datetimeUtils.formatdate(e))]
}
datetimeUtils.getSecondHalfMonthStartEnd = function (dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var m = o.getMonth()
    var s = new Date(y, m, 15)
    var dm = datetimeUtils.monthrange(y, m+1)[1]  
    var e = new Date(y, m, dm)
    return [datetimeUtils.__start_day(datetimeUtils.formatdate(s)), datetimeUtils.__end_day(datetimeUtils.formatdate(e))]
}
datetimeUtils.getMonthRunThrough = function (y, m1, m2) {
    var s = new Date(y, m1-1, 1)
    var dm = datetimeUtils.monthrange(y, m2)[1]  
    var e = new Date(y, m2-1, dm)
    return [datetimeUtils.__start_day(datetimeUtils.formatdate(s)), datetimeUtils.__end_day(datetimeUtils.formatdate(e))]
}
datetimeUtils.getMonthStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var m = o.getMonth() + 1
    return datetimeUtils.getMonthRunThrough(y, m, m)
}
datetimeUtils.getSeasonStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var m = o.getMonth() + 1
    for (var i=0;i<4;i++) {
        var m1 = i*3 + 1 
        var m2 = m1 + 2
        if (m >= m1 && m <= m2)
            break
    }
    return datetimeUtils.getMonthRunThrough(y, m1, m2)
}
datetimeUtils.getFirstHalfYearStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    return datetimeUtils.getMonthRunThrough(y, 1, 6)        
}
datetimeUtils.getSecondHalfYearStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    return datetimeUtils.getMonthRunThrough(y, 7, 12)
}
datetimeUtils.getYearStartEnd = function (dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    return datetimeUtils.getMonthRunThrough(y, 1, 12)
}
datetimeUtils.getNextWeekStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    o.setTime(o.getTime() + 7 * 24 * datetimeUtils.__H)
    return datetimeUtils.getWeekStartEnd(o)
}
datetimeUtils.getNextTwoWeekStartEnd = function (dt) {
    var o = datetimeUtils.__getDate(dt)
    dt1 = datetimeUtils.getNextWeekStartEnd(o)[0]
    o = datetimeUtils.__getDate(dt1)
    dt2 = datetimeUtils.getNextWeekStartEnd(o)[1]
    return [dt1, dt2]
}
datetimeUtils.getNextMonthStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var m = o.getMonth() + 1
    var days = datetimeUtils.monthrange(y, m)[1]
    o.setTime(o.getTime() + days * 24 * datetimeUtils.__H)
    return datetimeUtils.getMonthStartEnd(o)
}
datetimeUtils.getNextSeasonStartEnd =  function(dt) {
    var o = datetimeUtils.__getDate(dt)
    for (var i=0; i<3; i++) {
        var y = o.getFullYear()
        var m = o.getMonth() + 1
        var days = datetimeUtils.monthrange(y, m)[1]
        o.setTime(o.getTime() + days * 24 * datetimeUtils.__H)
    }
    return datetimeUtils.getSeasonStartEnd(o)
}
datetimeUtils.getNextYearStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear() + 1
    var ndt = new Date(y, 1, 1)
    return datetimeUtils.getYearStartEnd(ndt)
}
datetimeUtils.getHalfYearStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var m = o.getMonth() + 1
    if (m < 7)
        return datetimeUtils.getFirstHalfYearStartEnd(o)
    return datetimeUtils.getSecondHalfYearStartEnd(o)
}

datetimeUtils.getPastWeekStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    o.setTime(o.getTime() - 7 * 24 * datetimeUtils.__H)
    return datetimeUtils.getWeekStartEnd(o)
}
datetimeUtils.getPastMonthStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var d = o.getDate()
    o.setTime(o.getTime() - d * 24 * datetimeUtils.__H)
    return datetimeUtils.getMonthStartEnd(o)
}
datetimeUtils.getPastTwoWeekStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    dt2 = datetimeUtils.getPastWeekStartEnd(o)[1]
    o = datetimeUtils.__getDate(dt2)
    dt1 = datetimeUtils.getPastWeekStartEnd(o)[0]
    return [dt1, dt2]
}
datetimeUtils.getPastSeasonStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    for (var i=0;i<3; i++) {
        var d = o.getDate()
        o.setTime(o.getTime() - d * 24 *datetimeUtils.__H)
    }
    return datetimeUtils.getSeasonStartEnd(o)
}
datetimeUtils.getPastYearStartEnd = function(dt) {
    var o = datetimeUtils.__getDate(dt)
    var y = o.getFullYear()
    var ndt = new Date(y-1, 1, 1)
    return datetimeUtils.getYearStartEnd(ndt)
}
dtu=datetimeUtils

PastNDay = new Object()
PastNDay.values = ['7', '14', '21', '28', '90', '180']
PastNDay.captions = ['过去7天', '过去14天', '过去21天', '过去28天', '过去90天', '过去180天']