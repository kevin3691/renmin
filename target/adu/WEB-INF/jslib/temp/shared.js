/**
 * 描述 : 试题编辑展示共用资源
 * 注明 :
 *      事件列表(eventList) : {
 *          事件类型 : [
 *              {
 *                  callback : 回调方法,
 *                  params   : 第二参数
 *              }
 *          ]
 *      }
 * 作者 : Edgar.lee
 */
$.extend(examCoreQuestionsObj, {                //参数初始化
    'eventList'    : {},                        //事件列表

    /**
     * 描述 : 事件管理
     * 参数 :
     *      key    : 事件类型
     *      event  : 对象=触发事件,false=删除事件,方法=添加事件
     *      params : 添加时=指定自定义参数(第二参数),删除时=指定删除的方法,触发时=自定义参数(第一参数),默认null
     * 注明 :
     *      事件类型 : 
     *          papers::snapshot          : 试卷快照保存
     *          questions::linkage::start : 试题编辑联动开始
     *          questions::linkage::sync  : 试题编辑联动同步
     * 作者 : Edgar.lee
     */
    'event' : function (type, event, params) {
        var eventList = examCoreQuestionsObj.eventList;
        eventList[type] || (eventList[type] = []);                                  //初始化事件类型

        switch (typeof event) {
            case 'object'   :                                                       //触发事件
                $.each(eventList[type], function () {
                    this.callback.call(event, params, this.params);
                });
                break;
            case 'boolean'  :                                                       //删除事件
                if( params )
                {
                    $.each(eventList[type], function (i) {
                        this.callback === params && eventList[type].splice(i, 1);
                    });
                } else {
                    delete eventList[type];
                }
                break;
            case 'function' :                                                       //添加事件
                eventList[type].push({
                    'callback' : event,
                    'params'   : params
                });
                break;
        }
    },

    /**
     * 描述 : 取消事件
     * 作者 : Edgar.lee
     */
    'cancelEvent' : function (event) {
        if(event.preventDefault && event.stopPropagation) {
            event.preventDefault();
            event.stopPropagation();
        } else {
            event.returnValue = false;
            event.cancelBubble = true;
        }
    }
});