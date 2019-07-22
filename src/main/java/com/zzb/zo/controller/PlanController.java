/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.PlanService;
import com.zzb.zo.service.WorkPlanService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/plan")
public class PlanController extends BaseController {
	@Resource
	private PlanService planService;

	@Resource
	private WorkPlanService workPlanService;

	@Resource
	private WfInstanceService insService;
	
	@Resource
	private WfWorkflowService wfService;

	@Resource
	private WfStepService wsService;


	@Resource
	private CommAttachmentService commAttachmentService;
	
	@Resource
	private BaseUserService baseUserService;

	
	String mode = "RW";
	String category = "";
	String uploadLabel = "";
	String applyTo = "";
	int refNum = 0;
	String title = "";
	String allowExt = "*.*";
	long allowSize = 1000 * 1024 * 1024L;
	String destDir = "upload/plan/";
	
	/**
	 * 构造函数
	 */
	public PlanController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		/*switch (colSym) {
		case "DOCUMENT_YUEBAN":
			map.addAttribute("type", 1);
			break;
		case "DOCUMENT_PIBAN":
			map.addAttribute("type", 2);
			break;
		case "DOCUMENT_ZYUEBAN":
			map.addAttribute("type", 3);
			break;
		case "DOCUMENT_ZPIBAN":
			map.addAttribute("type", 4);
			break;

		default:
			break;
		}*/

		return "/plan/index";
	}


	@RequestMapping(value = "/index2")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index2(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);

		return "/plan/index2";
	}


    @RequestMapping(value = "/index3")
    //@RequiresPermissions("DOCUMENT:RO")
    public String index3(ModelMap map) {
        String colSym = request.getParameter("colSym") != null ? String.valueOf(request
                .getParameter("colSym")) : "";
        String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
                .getParameter("colTitle")) : "";
        map.addAttribute("category", colTitle);
        map.addAttribute("colTitle", colTitle);
        map.addAttribute("colSym", colSym);
        setPara(request, map);

        return "/plan/index3";
    }

    @RequestMapping(value = "/index4")
    //@RequiresPermissions("DOCUMENT:RO")
    public String index4(ModelMap map) {
        String colSym = request.getParameter("colSym") != null ? String.valueOf(request
                .getParameter("colSym")) : "";
        String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
                .getParameter("colTitle")) : "";
        map.addAttribute("category", colTitle);
        map.addAttribute("colTitle", colTitle);
        map.addAttribute("colSym", colSym);
        setPara(request, map);

        return "/plan/index4";
    }



	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Plan plan = new Plan();
		if (id > 0) {
			plan = planService.dtl(id);
			plan.setContent(StringEscapeUtils.unescapeHtml(plan.getContent()));
		}else{
			plan.setCategory(colSym);
		}
		setPara(request, model);
		model.addAttribute("o", plan);
		String url = "/plan/edit";
		return url;
	}


	@RequestMapping(value = "/edit2")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Plan plan = new Plan();
		if (id > 0) {
			plan = planService.dtl(id);
			plan.setContent(StringEscapeUtils.unescapeHtml(plan.getContent()));
		}else{
			plan.setCategory(colSym);
		}
		setPara(request, model);
		model.addAttribute("o", plan);
		String url = "/plan/edit2";
		return url;
	}


	@RequestMapping(value = "/sel")
	//@RequiresPermissions("DOCUMENT:RW")
	public String sel(HttpServletRequest request, ModelMap model) {

		String url = "/plan/sel";
		return url;
	}



	@RequestMapping(value = "/act")
	//@RequiresPermissions("DOCUMENT:RW")
	public String act(HttpServletRequest request, ModelMap model) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Plan doc = new Plan();
		if (id > 0) {
			doc = planService.dtl(id);
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = planService.getIns(id, stepId,String.valueOf(user.getId()));
			model.addAttribute("ins", ins);
		}
		setPara(request, model);
		model.addAttribute("o", doc);
		String url = "/plan/act";
		
		return url;
	}
	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		Plan doc = new Plan();
		if (id > 0) {
			doc = planService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/plan/dtl";
		
		return url;
	}
	
	@RequestMapping(value = "/flowInfo")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flowInfo(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = planService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/plan/flowInfo";
	}
	@RequestMapping(value = "/flow")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flow(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = planService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/plan/flow";
	}
	


	/**
	 * 获取列表数据 list
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<Plan> list(HttpServletRequest request) {
		QueryResult<Plan> rslt = planService.list(request);

		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/list4sel")
	public QueryResult<Plan> list4sel(HttpServletRequest request) {
		QueryResult<Plan> rslt = planService.list4sel(request);

		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/listYwdb")
	public QueryResult<Plan> listYwdb(HttpServletRequest request) {
		QueryResult<Plan> rslt = planService.list(request);

		return rslt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/listIns")
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		QueryResult<WfInstance> rslt = planService.listIns(request);
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
	public Map<String, Object> save(Plan doc, CashList cashList,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc = planService.save(doc, request);

		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/savePlans", method = RequestMethod.POST)
	public Map<String, Object> savePlans(@RequestBody PlanList plans,
										 HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WorkPlan wp = new WorkPlan();
		for (PlanContent o : plans.getPlanList()){
			if(wp == null || wp.getId() ==0)
				wp = workPlanService.dtl(o.getRefNum());
			Plan p = planService.dtlByDate(wp.getId(),o.getDay());
			if(p == null || p.getId() == 0){
				p = new Plan();
				p.setContent(o.getContent());
				p.setContent2(o.getContent2());
				p.setPlandate(o.getDay());
				p.setRefNum(o.getRefNum());
				p.setStatus(0);
				p.setCategory(wp.getCategory());
				p.setApplyTo(wp.getColSym());
				p.setIsActive(1);
				p.setOrg(wp.getOrg());
				p.setOrgId(wp.getOrgId());
				p.setPerson(wp.getPerson());
				p.setPersonId(wp.getPersonId());
				p.setType(wp.getType());
				p.setTypeId(wp.getTypeId());
			}else {
				p.setContent(o.getContent());
				p.setContent2(o.getContent2());
			}
			p = planService.save(p,request);
		}

		map.put("result", "success");
		//map.put("ins", ins);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/savePlansResult", method = RequestMethod.POST)
	public Map<String, Object> savePlansResult(@RequestBody PlanList plans,
										 HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WorkPlan wp = new WorkPlan();
		for (PlanContent o : plans.getPlanList()){
			if(wp == null || wp.getId() ==0)
				wp = workPlanService.dtl(o.getRefNum());
			Plan p = planService.dtlByDate(wp.getId(),o.getDay());
			if(p == null || p.getId() == 0){

			}else {
				p.setResult(o.getContent());
			}
			p = planService.save(p,request);
		}

		map.put("result", "success");
		//map.put("ins", ins);
		return map;
	}


	
	
	public WfInstance savewf(Plan doc,BaseUser user,int stepId, String actUrl, String dtlUrl){
		
		WfInstance ins = new WfInstance();
		ins.setCategory("CASH");
		ins.setApplyTo(String.valueOf(doc.getType()));
		ins.setRefNum(doc.getId());
		ins.setStepId(stepId);
		ins.setStepName("");
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(String.valueOf(user.getId()));
		ins.setActorName(user.getBasePersonName());
		ins.setActUrl(actUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setListUrl("");
		ins.setOkUrl("");
		ins = insService.save(ins, request);
		return ins;
	}

	@ResponseBody
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public Map<String, Object> submit(String actorId, String actorName, int insId,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfInstance ins = new WfInstance();
		if(insId > 0)
		{
			ins = insService.dtl(insId);
			ins.setActAt(new Date());
			ins.setYesNo("yes");
			ins = insService.save(ins, request);
		}
		int stepId = ins.getStepId() + 1;
		Plan doc = planService.dtl(ins.getRefNum());
		WfWorkflow wf = wfService.dtl("DOCUMENT");
		//QueryResult<WfStep> wsList = wsService.list(wf.getId());
		doc = planService.save(doc, request);
		
		
	
		map.put("result", "success");
		return map;
	}
	

	/**
	 * 删除数据
	 * 
	 * @param request
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public Map<String, Object> del(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int id = Integer.valueOf(request.getParameter("id"));
        map.put("IsSuccess", true);
        planService.del(id);
        return map;
    }



	@ResponseBody
	@RequestMapping(value = "/delIns", method = RequestMethod.POST)
	public Map<String, Object> delIns(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int refNum = Integer.valueOf(request.getParameter("refNum"));
		map.put("IsSuccess", true);
		planService.del(refNum);
		planService.delByRefNum(refNum);
		return map;
	}
	
	/**
	 * 排序
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order");
		map.put("IsSuccess", true);
		planService.sort(id, order);
		return map;
	}


	
	
	@RequestMapping(value = "/multiSelSubmit")
	public String multiSelSubmit(HttpServletRequest request, ModelMap model) {
		String ids = request.getParameter("ids") != null ? request
				.getParameter("ids") : "";
				List<Integer> idList = new ArrayList<Integer>();
				List<BaseUser> userList = new ArrayList<BaseUser>();
				if(ids != "")
				{
					String[] qids = ids.split(",");
					for(String id : qids)
					{
						if(!id.equals(""))
						{
							idList.add(Integer.parseInt(id));
						}
					}
					
					for(int id : idList)
					{
						BaseUser user = baseUserService.dtl(id);
						userList.add(user);
					}
				}
				
				
				model.addAttribute("ids", ids);
				model.addAttribute("userList", userList);
		return "/base/user/multiSelSubmit";
	}

	/**
	 * 接收并设置参数
	 *
	 * @param request
	 * @param
	 */
	public void setPara(HttpServletRequest request, ModelMap model) {
		mode = request.getParameter("mode") != null ? request.getParameter(
				"mode").toString() : mode;
		category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : category;
		uploadLabel = request.getParameter("uploadLabel") != null ? request
				.getParameter("uploadLabel").toString() : "";
		applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : applyTo;
		refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : refNum;
		title = request.getParameter("title") != null ? request.getParameter(
				"title").toString() : title;
		allowExt = request.getParameter("allowExt") != null ? request
				.getParameter("allowExt").toString() : allowExt;
		allowSize = request.getParameter("allowSize") != null ? Long
				.valueOf(request.getParameter("allowSize")) : allowSize;
		destDir = request.getParameter("destDir") != null
				&& request.getParameter("destDir") != "" ? request
				.getParameter("destDir").toString() : destDir;
		model.put("mode", mode);
		model.put("category", category);
		model.put("uploadLabel", uploadLabel);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		model.put("allowExt", allowExt);
		model.put("allowSize", String.valueOf(allowSize));
		model.put("destDir", destDir);
	}
}
