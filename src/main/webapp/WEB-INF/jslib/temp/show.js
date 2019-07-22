/**
 * 描述 : 显示试题交互核心
 * 注明 :
 *      联动列表(linkageData) : {
 *          唯一键 : {
 *              thisObj    : 联动标签所在的组件对象
 *              linkageObj : 需要移动的联动结构对象
 *              func       : 组件对象回调的方法
 *          }, ...
 *      }
 *      对象索引(structList) : {
 *          结构键 : [
 *              {
 *                  obj  : 索引键对应的对象
 *                  其它 : 一些其它的数据
 *              }, ...
 *          ], ...
 *      }
 *      试题信息(editInfo) : {
 *          "questionId" : 主试题ID,新加试题为null
 *          "type"       : 试题类型,questions文件夹的子文件夹名
 *          "state"      : 可用状态0=禁用, 1=可用
 *          "modified"   : 最后修改的时间
 *      }
 * 作者 : Edgar.lee
 */
var examCoreQuestionsObj = {
    'linkageData'  : {},                                                                //联动列表
    'structList'   : {},
    'editInfo'     : {},                                                                //试题信息
    'systemData'   : {},                                                                //系统数据
    'comList'      : {},

    /**
     * 描述 : 初始化
     * 参数 :
     *      data   : 显示试题的数据
     *      system : 一些额外参数 {
     *          "obj"  : 试题插入的节点
     *          "rand" : false(默认)=正常顺序,true=随机顺序
     *      }
     * 作者 : Edgar.lee
     */
    'show'         : function(data, system) {
        examCoreQuestionsObj.structList = {'' : [{'obj' : system.obj}]};                //清空列表
        examCoreQuestionsObj.editInfo = data.info;                                      //试题信息
        examCoreQuestionsObj.systemData = system;                                       //试题信息
        examCoreQuestionsObj.linkageData = {};                                          //清空联动数据

        $.each(data.data, function(){                                                   //初始化结构
            $.each(this, function(){
                $.type(this.params) === 'object' || (this.params = {});
                if($.type(this.params.value)==='string'){
                    this.params.value=this.params.value.replace(/<img\s+src=\s*"\/data/g,'<img src="'+window.ROOT_URL + '/data');
                    this.params.value=this.params.value.replace(/src="\/include/g, 'src="'+ window.ROOT_URL + '/include');
                    this.params.value=this.params.value.replace(/file=/g, 'file='+ window.ROOT_URL);
                }
                examCoreQuestionsObj.addStruct(this);
            });
        });

        $.each(examCoreQuestionsObj.linkageData, function (unique) {
            if( this.thisObj && this.linkageObj )
            {
                this.func.call(this.thisObj, this.linkageObj, unique);
            }
        });
        return examCoreQuestionsObj.structList;
    },

    /**
     * 描述 : 向数据和界面中添加一个结构
     * 参数 :
     *      struct : 添加一个结构数据
     * 作者 : Edgar.lee
     */
    'addStruct'    : function(struct) {
        var structIndex, pStructIndex, temp;                                                                                        //结构引用, 父结构引用
        var structList = examCoreQuestionsObj.structList;                                                                           //引用结构列表
        var linkageData = examCoreQuestionsObj.linkageData;                                                                         //联动引用

        structList[struct.key] || (structList[struct.key] = []);
        structIndex = structList[struct.key][structList[struct.key].push({}) - 1];
        pStructList = structList[struct.pKey][struct.pPos][struct.key] || (structList[struct.pKey][struct.pPos][struct.key] = {});

        if(struct.type === 'block')                                                                                                 //结构块
        {
            if( !pStructList.body )
            {
                pStructList.body = $(
                    '<ul class="exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-block_body exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-block_body_' +struct.key+ '"></ul>'
                ).appendTo(structList[struct.pKey][struct.pPos].obj).get(0);
            }

            structIndex.obj = $(                                                                                                    //添加块级结构
                '<span class="exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-block_mode exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-block_mode_' +struct.key+ '"></span>'
            );
            if( examCoreQuestionsObj.systemData.rand )                                                                              //随机
            {
                temp = [$('> .exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-block_mode', pStructList.body)];
                if( (temp[1] = Math.floor(temp[2] = Math.random() * (temp[0].length + 1))) === temp[0].length )
                {
                    structIndex.obj.appendTo(pStructList.body);
                } else {
                    temp[0].eq(temp[1]).before(structIndex.obj);
                }
            } else {
                structIndex.obj.appendTo(pStructList.body);
            }
            structIndex.obj = structIndex.obj.get(0);

            temp = struct.params.unique;                                                                                            //记录联动信息
            linkageData[temp] || (linkageData[temp] = {});
            linkageData[temp].linkageObj = structIndex.obj;
        } else {                                                                                                                    //文本结构 || 表单结构
            structIndex.obj = $(                                                                                                    //添加区域块
                '<span class="exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-' +struct.type+ '_border exam_core_questions_' +examCoreQuestionsObj.editInfo.type+ '-' +struct.type+ '_border_' +struct.key+ '"></span>'
            ).appendTo(structList[struct.pKey][struct.pPos].obj).get(0);

            examCoreQuestionsObj.comList[struct.com].create.call(structIndex.obj, struct.params, {                                  //创建组件
                'questionId' : examCoreQuestionsObj.editInfo.questionId,
                'key'        : struct.key,
                'type'       : struct.type,
                'isEdit'     : struct.enabled === null && null
            });

            if(struct.type === 'text' && examCoreQuestionsObj.comList[struct.com].linkage)                                          //获取联动标记
            {
                $.each(examCoreQuestionsObj.comList[struct.com].linkage.call(structIndex.obj), function () {
                    linkageData[this] || (linkageData[this] = {});
                    linkageData[this].thisObj = structIndex.obj;
                    linkageData[this].func = examCoreQuestionsObj.comList[struct.com].linkage;
                });
            }
        }

        structIndex.obj.struct = struct;
    },

    /**
     * 描述 : 同步用户答题信息
     * 参数 :
     *      struct : show返回的数据结构
     * 作者 : Edgar.lee
     */
    'update' : function(struct) {
        var temp, result = {};

        $.each(struct, function(){
            $.each(this, function(){
                temp = this.obj.struct;                                                                                         //根节点值为undefined
                if( temp && temp.type === 'form' )
                {
                    examCoreQuestionsObj.comList[temp.com].update.call(this.obj, temp.params, {                                 //更新组件
                        'key'     : temp.key,
                        'type'    : temp.type,
                        'isEdit'  : struct.enabled === null && null
                    });

                    result[temp.questionDataId] = {"params" : window.L.json(temp.params)};
                } else {
                    return false;
                }
            });
        });

        return result;
    },

    /**
     * 为多媒体添加js，控制进度条，播放次数等
     */
    'parseMediaPlayer': function() {
        var killPlayer = function(obj) {
            try {
                JS_OFplayer(obj.id, 'stop');
                JS_OFplayer(obj.id, 'mute');
                if(typeof(JS_OFplayer(obj.id, 'getatt','play','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'play','hidden','false');
                    JS_OFplayer(obj.id, 'adjust', 'play','disable','true');
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','fullscreen','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'fullscreen','hidden','false');
                    JS_OFplayer(obj.id, 'adjust', 'fullscreen','disable','true');
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','progress','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'progress','prop','');
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','volslide','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'volslide','prop','');
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','unmute','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'unmute','hidden','true');
                    JS_OFplayer(obj.id, 'adjust', 'unmute','disable','true');
                    JS_OFplayer(obj.id, 'adjust', 'mute','hidden','false');
                    JS_OFplayer(obj.id, 'adjust', 'mute','disable','true');
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','video','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'setsize', 'video',0,0);
                }
                if(typeof(JS_OFplayer(obj.id, 'getatt','bigPlay','y'))=='number')
                {
                    JS_OFplayer(obj.id, 'adjust', 'bigPlay','disable','true');
                }
            } catch (e) {}
        };
        var mediaPlayerMonitor = function(obj) {

            if (typeof obj.playcount == 'undefined'){
                obj.playcount = obj.getAttribute('playcount') - 0;
            }

            try {
                var progress = JS_OFplayer(obj.id, 'getinfo', 'playback','PlayTimeProgress');
            } catch (e) {}

            if (obj.playcount == 0 && obj.progress === 0) {
                killPlayer(obj);
                obj.timeout && window.clearTimeout(obj.timeout);
                return true;
            }

            if (obj.progress === 0 && progress > 0) {
                obj.playcount--;
            }

            obj.progress = progress;
            obj.timeout = window.setTimeout(function() {
                mediaPlayerMonitor(obj)
            }, 100);
        };

        $('object').each(function(i, ele) {
            var evalVal = $(this).attr('eval');
            if (evalVal) {
                $(this).removeAttr('eval');
                eval(unescape(evalVal));
            }
            ele.progress = null;
            try {
                ele.interval = window.setInterval(function() {
                    if ($(this).attr('JSenable') !=  'false') {
                        mediaPlayerMonitor(ele);
                    }
                    window.clearInterval(ele.interval);
                }, 100);
            } catch(e) {}
        });
    }
}