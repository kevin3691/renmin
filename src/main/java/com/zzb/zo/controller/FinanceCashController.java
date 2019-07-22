/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.core.utils.DateUtils;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfStep;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.FinanceCashDetailsService;
import com.zzb.zo.service.FinanceCashService;
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
@RequestMapping("/cash")
public class FinanceCashController extends BaseController {
	@Resource
	private FinanceCashService financeCashService;

	@Resource
	private FinanceCashDetailsService financeDetailsCashService;
	
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
	String destDir = "upload/cash/";
	
	/**
	 * 构造函数
	 */
	public FinanceCashController() {

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

		return "/cash/index";
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

		return "/cash/index2";
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
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		FinanceCash cash = new FinanceCash();
		if (id > 0) {
			cash = financeCashService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", cash);
		String url = "/cash/edit";
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
		FinanceCash doc = new FinanceCash();
		if (id > 0) {
			doc = financeCashService.dtl(id);
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = financeCashService.getIns(id, stepId,String.valueOf(user.getId()));
			model.addAttribute("ins", ins);
		}
		setPara(request, model);
		model.addAttribute("o", doc);
		String url = "/cash/act";
		
		return url;
	}
	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		FinanceCash doc = new FinanceCash();
		if (id > 0) {
			doc = financeCashService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/cash/dtl";
		
		return url;
	}
	
	@RequestMapping(value = "/flowInfo")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flowInfo(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = financeCashService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/cash/flowInfo";
	}
	@RequestMapping(value = "/flow")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flow(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = financeCashService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/cash/flow";
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
	public QueryResult<FinanceCash> list(HttpServletRequest request) {
		QueryResult<FinanceCash> rslt = financeCashService.list(request);

		return rslt;
	}

	@ResponseBody
	@RequestMapping(value = "/listYwdb")
	public QueryResult<FinanceCash> listYwdb(HttpServletRequest request) {
		QueryResult<FinanceCash> rslt = financeCashService.list(request);

		return rslt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/listIns")
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		QueryResult<WfInstance> rslt = financeCashService.listIns(request);
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
	public Map<String, Object> save(FinanceCash doc, CashList cashList,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc = financeCashService.save(doc, request);

//		for (FinanceCashDetails d:
//				cashList.getCashList()) {
//			d.setRefNum(doc.getId());
//			d = financeDetailsCashService.save(d,request);
//		}
		/*WfInstance ins = new WfInstance();
		if(doc.getId() > 0)
		{
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			int cnt = financeCashService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
					1, String.valueOf(user.getId()));
			if(cnt > 0)
			{
				ins = financeCashService.getIns(doc.getId(), 1);
			}else{
				ins = savewf(doc,user,1,"financeCash/edit","financeCash/dtl");
			}
		}*/
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}


	
	
	public WfInstance savewf(FinanceCash doc,BaseUser user,int stepId, String actUrl, String dtlUrl){
		
		WfInstance ins = new WfInstance();
		ins.setCategory("CASH");
		ins.setTitle(doc.getTitle());
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
		FinanceCash doc = financeCashService.dtl(ins.getRefNum());
		WfWorkflow wf = wfService.dtl("DOCUMENT");
		//QueryResult<WfStep> wsList = wsService.list(wf.getId());
		doc = financeCashService.save(doc, request);
		
		
	
		map.put("result", "success");
		return map;
	}
	
	
	

	
	
	@ResponseBody
	@RequestMapping(value = "/finish", method = RequestMethod.POST)
	public Map<String, Object> finish(int insId,
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
		FinanceCash doc = financeCashService.dtl(ins.getRefNum());
		doc.setStatus(1);
		doc = financeCashService.save(doc, request);
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
		financeCashService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/delIns", method = RequestMethod.POST)
	public Map<String, Object> delIns(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int refNum = Integer.valueOf(request.getParameter("refNum"));
		map.put("IsSuccess", true);
		financeCashService.del(refNum);
		financeCashService.delByRefNum(refNum);
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
		financeCashService.sort(id, order);
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
