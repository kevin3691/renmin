/**
 * 描述 : 显示试题交互核心
 * 注明 :
 *      试卷数据(paperData) : {
 *          "info" : {
 *              "paperId" : 主试卷ID, 
 *              "name"    : 试卷名称,
 *              "state"   : 可用状态0=禁用, 1=可用
 *              "points"  : 总分数
 *          },
 *          "data" : [
 *              {
 *                  "paperDataId" : 数据库中的ID, 新添加的为null
 *                  "points"      : 试题浮点分数, null=joint当文本处理
 *                  "node"        : 试题数据
 *              }, ...
 *          ]
 *      }
 * 作者 : Edgar.lee
 */
var examCorePapersObj = {
    'paperData'          : null,                                //试卷数据
    'questionStructList' : {},                                  //试题结构列表

    /**
     * 描述 : 初始化
     * 参数 :
     *      data   : 显示试题的数据
     *      system : 一些额外参数 {
     *          "obj"        : 试题插入的节点
     *          "rand"       : false(默认)=正常顺序,true=随机顺序
     *          "showPoints" : 强制显示分数
     *          "ctnr"       : 试题容器 {
     *              "before" : 容器前追加的html
     *              "after"  : 容器后追加的html
     *          }
     *      }
     * 作者 : Edgar.lee
     */
    'init'      : function(data, system) {
        var temp, posNode, typeNum = 0;                                                                                 //临时, 定位节点, 题型号
        var scalePoints = isNaN(temp = (system.showPoints || data.info.points) / data.info.points) ? 1 : temp;
        data.info.points *= scalePoints;                                                                                //卷子总分
        examCorePapersObj.paperData = data;
        system.ctnr = $.extend({'before' : '', 'after' : ''}, system.ctnr || {});                                       //参数初始化
        $(system.obj).attr('examCorePapersRootBlock', '');
        $.each(data.data, function () {
            if( this.points === null )                                                                                  //文本处理
            {
                typeNum += 1;
                $(system.ctnr.before + '<span class="exam_core_papers-text_mode">' +this.node+ '</span>' + system.ctnr.after).appendTo(system.obj);
            } else {
                typeNum || (typeNum = 1);                                                                               //如果题型为0 || 题型号设1
                String(temp = this.points * scalePoints).indexOf('.') > -1 && (temp = temp.toFixed(2));                 //展示分数格式化
                posNode = $(system.ctnr.before + '<span class="exam_core_papers-question_mode">' +
                    '<span class="exam_core_papers-question_number" number="' +typeNum+ '" ></span>' +
                    '<span class="exam_core_papers-question_points">' + temp + L.getText("分") +'</span>' +
                '</span>' + system.ctnr.after);
                // 乱序，排除判断题的选项
                var isBinaryChoice = (typeof this.node == 'object') && ('binaryChoice' == this.node.info.type);
                //乱序，排除简答题的选项
                var isShortAnswer = (typeof this.node == 'object') && ('shortAnswer' == this.node.info.type);
                if(system.rand && !L.cookie('exam_' + data.info.examId + '=`t'))                                        //随机
                {
                    temp = [$('.exam_core_papers-question_mode > .exam_core_papers-question_number[number=' +typeNum+ ']', system.obj)];

                    if( (temp[1] = Math.floor(temp[2] = Math.random() * (temp[0].length + 1))) === temp[0].length )
                    {
                        posNode.appendTo(system.obj);
                    } else {
                        temp[0].eq(temp[1]).parentsUntil('[examCorePapersRootBlock]').eq(-1).before(posNode);
                    }
                } else {
                    posNode.appendTo(system.obj);
                }

                if( !posNode.hasClass('exam_core_papers-question_mode') )                                               //没有样式(被system.ctnr.before包含)
                {
                    posNode = posNode.find('.exam_core_papers-question_mode');                                          //重新定位posNode
                }
                temp = $('<span class="exam_core_papers-question_border" questionId="' +this.node.info.questionId+ '"></span>').appendTo(posNode).get(0);
                examCorePapersObj.questionStructList[this.node.info.questionId] = examCoreQuestionsObj.show(this.node, {
                    'obj'  : temp,
                    'rand' : !!system.rand && !isShortAnswer && !isBinaryChoice && !L.cookie('exam_' + data.info.examId + '=`t')
                });
            }
        });

        while (typeNum) {                                                                                               //更新试题序号
            $('.exam_core_papers-question_mode > .exam_core_papers-question_number[number=' +typeNum+ ']', system.obj).each(function(i){
                this.innerHTML = ++i + ".";
                this.setAttribute('number', this.getAttribute('number') + '.' + i);
            });
            typeNum -= 1;
        }

        examCorePapersObj.snapshot({});                                                                                 //快照初始化
        
        // 存储考试状态
        // var examInfo = {};
        // examInfo['exam_' + data.info.examId] = 1;
        // L.cookie(examInfo)
    },

    /**
     * 描述 : 提交答题信息
     * 参数 :
     *      params : {"url" : 指定提交的路径, "expand" : 一些扩展数据, "callback" : 提交后回调}
     * 作者 : Edgar.lee
     */
    'submit' : function(params) {
        var result = {"info" : examCorePapersObj.paperData.info, "data" : {}, "expand" : params.expand};

        $.each(examCorePapersObj.questionStructList, function(key){         //更新试题数据
            result.data[key] = examCoreQuestionsObj.update(this);
        });

        params.url && $.post(params.url, result).always(params.callback);
        return result;
    },

    /**
     * 描述 : 保存考试信息(断电保护)
     * 参数 :
     *      params : {
     *          "url"      : 指定提交的路径, 
     *          "expand"   : 一些扩展数据, 
     *          "callback" : 提交后回调,接收一参数,0=未达到保存标准,1=保存成功,其它=保存失败
     *          "enforce"  : true=总是发送,false(默认)=有变化时发送
     *      }
     * 作者 : Edgar.lee
     */
    'snapshot' : function(params) {
        var lastData = examCorePapersObj.snapshot.lastData;
        var snapshot = examCorePapersObj.submit({});
        var dryCount = 0;                                                   //差异个数
        var drydata = {};                                                   //差异数据

        if( lastData )                                                      //快照比对
        {
            $.each(snapshot.data, function (qk) {
                $.each(this, function (sk) {                                //对比结构
                    if( this.params !== lastData[qk][sk].params )
                    {
                        drydata[qk] = snapshot.data[qk];
                        dryCount += 1;
                        return false;
                    }
                });
            });

            if( dryCount > 0 || params.enforce)                             //有变化 || 强制提交
            {
                params.url && $.post(params.url, {
                    "info"   : snapshot.info,
                    "data"   : drydata, 
                    "expand" : params.expand
                }).always(function (data) {
                    if( data === '1' )                                      //保存成功
                    {
                        examCorePapersObj.snapshot.lastData = snapshot.data;
                    }
                    params.callback && params.callback(data);
                });
            } else if(params.callback) {
                params.callback('0');
            }
        } else {                                                            //初次生成
            examCorePapersObj.snapshot.lastData = snapshot.data;
        }
    }
}