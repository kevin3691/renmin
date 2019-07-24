examCoreQuestionsObj.comList.input = {
    /**
     * 描述 : 创建组件并初始化
     * 作者 : Edgar.lee
     */
    'create' : function(params, system) {
        params = $.extend({'type' : 'text', 'value' : '', 'valueAttr' : ''}, params);                                       //参数初始化

        this.comObj = $('<input type="' + params.type + '" name="examComponentsInput_' + system.key + '_' + system.questionId + '" />').get(0);
        this.appendChild(this.comObj);

        if( params.type === 'radio' || params.type === 'checkbox' )                                                         //单选 || 复选
        {
            this.comObj.checked = !!params.value;                                                                           //是否选中
            this.comObj.value = params.valueAttr;                                                                           //值
        } else {
            this.comObj.value = params.value;
        }
        if( system.isEdit && system.type === 'form' && params.type === 'radio' )
        {
            $(this.comObj).bind('mousedown click', examCoreQuestionsObj.comList.input.radioChecked);
        }
    },

    /**
     * 描述 : 将组件数据同步到内存中
     * 作者 : Edgar.lee
     */
    'update' : function(params, system) {
        if( params.type === 'radio' || params.type === 'checkbox' )                                                         //单选 || 复选
        {
            params.valueAttr = this.comObj.value || '';
            params.value = $('input[name="' +this.comObj.name+ '"]:checked').length ? 
                this.comObj.checked : '';
        } else {
            params.value = this.comObj.value || '';
        }
    },

    /**
     * 描述 : 单选框选中方式
     * 作者 : Edgar.lee
     */
    'radioChecked' : function(event) {
        if( event.type === 'mousedown' )
        {
            this.lastTimeChecked = this.checked;
        } else {
            this.checked = !this.lastTimeChecked;
        }
    }
};