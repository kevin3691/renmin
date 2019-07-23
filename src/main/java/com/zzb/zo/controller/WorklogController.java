package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.CashList;
import com.zzb.zo.entity.Worklog;
import com.zzb.zo.service.WorklogService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/worklog")
public class WorklogController extends BaseController {

    @Resource
    private WorklogService worklogService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request){
        return "/worklog/index";
    }

    @ResponseBody
    @RequestMapping(value = "/list")
    public QueryResult<Worklog> list(HttpServletRequest request) {
        QueryResult<Worklog> rslt = worklogService.list(request);
        return rslt;
    }

    /**
     * 保存数据（添加、编辑）方法
     *
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public Map<String, Object> save(Worklog doc, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        doc.setMakedayi(new Date());
        doc = worklogService.save(doc, request);
        map.put("entity", doc);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/dtl", method = RequestMethod.POST)
    public Map<String, Object> dtl(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int id = Integer.valueOf(request.getParameter("id"));
        Worklog plan = worklogService.dtl(id);
        map.put("entity", plan);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public Map<String, Object> del(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int id = Integer.valueOf(request.getParameter("id"));
        map.put("IsSuccess", true);
        worklogService.del(id);
        return map;
    }

    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, ModelMap map){
        int id = request.getParameter("id") != null ? Integer.valueOf(request.getParameter("id")) : 0;
        System.out.println(id);
        Worklog worklog = new Worklog();
        if(id>0){
            worklog = worklogService.dtl(id);
        }
        map.addAttribute("o",worklog);
        return "/worklog/edit";
    }
    @ResponseBody
    @RequestMapping(value = "/save2",method = RequestMethod.POST)
    public Map<String,Object> save2 (Worklog worklog, HttpServletRequest request){
        Map<String,Object> map = new HashMap<String, Object>();
        worklog = worklogService.save2(worklog,request);
        map.put("entity",worklog);
        return map;
    }
}