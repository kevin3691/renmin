/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import java.util.*;

import javax.annotation.Resource;
import javax.security.auth.Subject;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.entity.BaseOrg;
import com.zzb.base.service.BaseOrgService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.DuBanService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.poi.ss.formula.WorkbookDependentFormula;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BasePerson;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BasePersonService;
import com.zzb.base.service.BaseUserService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfStep;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.service.DocumentService;
import com.zzb.core.utils.DateUtils;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/duban")
public class DubanController extends BaseController {
	@Resource
	private DocumentService documentService;

	@Resource
	private BaseOrgService baseOrgService;
	@Resource
    private DuBanService duBanService;
	
	@Resource
	private BasePersonService personService;
	
	@Resource
	private WfInstanceService insService;
	
	@Resource
	private WfWorkflowService wfService;
	
	@Resource
	private WfStepService wsService;
	
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
	String destDir = "upload/document/";
	
	/**
	 * 构造函数
	 */
	public DubanController() {

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
		return "/duban/index";
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
		return "/duban/index2";
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
		return "/duban/index3";
	}




    @RequestMapping(value = "/duban")
    //@RequiresPermissions("DOCUMENT:RO")
    public String duban(ModelMap map) {
        int id = request.getParameter("id") != null ? Integer.valueOf(request
                .getParameter("id")) : 0;
        DuBan du = duBanService.dtl(id);
		Document doc = documentService.dtl(du.getRefNum());
        QueryResult<WfInstance> rslt = insService.listDuInfo(du.getId(),1);
        Map<Integer,WfInstance> m = new HashMap<>();
        for (WfInstance wi: rslt.getRows()) {
            m.put(wi.getId(),wi);
        }

        map.addAttribute("list",m);
        map.addAttribute("insList", rslt.getRows());
        map.addAttribute("o", du);
		map.addAttribute("doc",doc);
        return "/duban/duban";
    }

	@RequestMapping(value = "/duban3")
	//@RequiresPermissions("DOCUMENT:RO")
	public String duban3(ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		DuBan doc = duBanService.dtl(id);
		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");

		QueryResult<WfInstance> rslt = insService.listDuInfo(doc.getId(),1);
		Map<Integer,WfInstance> m = new HashMap<>();
		for (WfInstance wi: rslt.getRows()) {
			m.put(wi.getId(),wi);
		}

		map.addAttribute("list",m);
		map.addAttribute("insList", rslt.getRows());
		map.addAttribute("o", doc);

		return "/duban/duban3";
	}

	@RequestMapping(value = "/view3")
	//@RequiresPermissions("DOCUMENT:RO")
	public String view3(ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		DuBan doc = duBanService.dtl(id);
		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");

		QueryResult<WfInstance> rslt = insService.listDuInfo(doc.getId(),1);
		Map<Integer,WfInstance> m = new HashMap<>();
		for (WfInstance wi: rslt.getRows()) {
			m.put(wi.getId(),wi);
		}

		map.addAttribute("list",m);
		map.addAttribute("insList", rslt.getRows());
		map.addAttribute("o", doc);

		return "/duban/view3";
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
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int insId = request.getParameter("insId") != null ? Integer.valueOf(request
				.getParameter("insId")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		DuBan doc = new DuBan();
		if (id > 0) {
			doc = duBanService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
		}else{
			doc.setCategory(colTitle);
			doc.setColSym(colSym);
		}
		setPara(request, model);
		model.addAttribute("o", doc);
		String url = "/duban/edit";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}

	@RequestMapping(value = "/addDuInfo")
	//@RequiresPermissions("DOCUMENT:RW")
	public String addDuInfo(HttpServletRequest request, ModelMap model) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int docId = request.getParameter("docId") != null ? Integer.valueOf(request
				.getParameter("docId")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Document doc = new Document();
		if (id > 0) {
			WfInstance ins = insService.dtl(id);
			doc = documentService.dtl(ins.getRefNum());
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			model.addAttribute("ins", ins);
			model.addAttribute("doc", doc);
		}
		setPara(request, model);
		String url = "/duban/addDuInfo";

		return url;
	}

	@RequestMapping(value = "/addDuOrg")
	//@RequiresPermissions("DOCUMENT:RW")
	public String addDuOrg(HttpServletRequest request, ModelMap model) {
		int parentId = request.getParameter("parentId") != null ? Integer.valueOf(request
				.getParameter("parentId")) : 0;
		int docId = request.getParameter("docId") != null ? Integer.valueOf(request
				.getParameter("docId")) : 0;
		Document doc = new Document();
		if (parentId > 0) {
			WfInstance ins = insService.dtl(parentId);
			DuBan du = duBanService.dtl(docId);
			doc = documentService.dtl(du.getRefNum());
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			model.addAttribute("ins", ins);
			model.addAttribute("doc", doc);
			model.addAttribute("o", du);
		}
		String url = "/duban/addDuOrg";

		return url;
	}
	
	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		DuBan doc = new DuBan();
		if (id > 0) {
			doc = duBanService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/duban/dtl";
		
		return url;
	}
	
	@RequestMapping(value = "/flowInfo")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flowInfo(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = documentService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/duban/flowInfo";
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
	public QueryResult<DuBan> list(HttpServletRequest request) {
		QueryResult<DuBan> rslt = duBanService.list(request);
		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/list4chaoshi")
	public QueryResult<DuBan> list4chaoshi(HttpServletRequest request) {
		QueryResult<DuBan> rslt = duBanService.list4chaoshi(request);
		return rslt;
	}
	@ResponseBody
	@RequestMapping(value = "/list4duban")
	public QueryResult<DuBan> list4duban(HttpServletRequest request) {
		QueryResult<DuBan> rslt = duBanService.list4duban(request);
		return rslt;
	}

    @ResponseBody
    @RequestMapping(value = "/list4Du")
    public QueryResult<Document> list4Du(HttpServletRequest request) {
        QueryResult<Document> rslt = documentService.list4Du(request);
        return rslt;
    }
	
	@ResponseBody
	@RequestMapping(value = "/listIns")
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		QueryResult<WfInstance> rslt = documentService.listIns(request);
		return rslt;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/listDuOrg")
	public List<DuInfoList> listDuOrg(int insId,HttpServletRequest request) {
		List<WfInstance> rslt = documentService.listIns(insId);
		List<DuInfoList> diList = new ArrayList<DuInfoList>();
		for (WfInstance ins : rslt) {
			DuInfoList dil = new DuInfoList();
			dil.setOrgInfo(ins);
			List<WfInstance> infoList = documentService.listIns(ins.getId());
			dil.setInfoList(infoList);
			diList.add(dil);
		}
		return diList;
	}

	@ResponseBody
	@RequestMapping(value = "/startYewu", method = RequestMethod.POST)
	public Map<String, Object> startYewu(int id, int insId,
									 HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(id > 0)
		{
			DuBan du = duBanService.dtl(id);
			du.setStatus(1);


			du = duBanService.save(du,request);
			Document doc = documentService.dtl(du.getRefNum());


			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = new WfInstance();
			if(du.getId() > 0)
			{
				int parentId = 0;
				int step = 1;
				int cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(user.getId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), step,String.valueOf(user.getId()),du.getColSym());
				}else{
					ins = savewf(parentId,du,user,step,"创建文档","duban/edit","duban/dtl",1);
				}


				step ++;
				parentId = ins.getId();
				cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(user.getId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), step,String.valueOf(user.getId()),du.getColSym());
				}else{
					ins = savewf(parentId,du,user,step,"文件批转","duban/edit","duban/dtl",1);
				}

				step ++;
				parentId = ins.getId();
				cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(user.getId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), step,String.valueOf(user.getId()),du.getColSym());
				}else{
					ins = savewf(parentId,du,user,step,"创建督办事项","duban/edit","duban/dtl",1);
				}

				step ++;
				parentId = ins.getId();
				cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(du.getChengbanchushiId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), step,String.valueOf(du.getChengbanchushiId()),du.getColSym());
				}else{
					if(!du.getChengbanchushiId().equals("")){
						String[] ids = du.getChengbanchushiId().split(",");
						String[] names = du.getChengbanchushi().split(",");
						for (int i =0; i < ids.length;i++) {
							if(!ids[i].equals("")){
								cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
										step, String.valueOf(ids[i]));
								if(cnt > 0)
								{
									ins = documentService.getIns(du.getId(), step,String.valueOf(ids[i]),du.getColSym());
								}else{
									BaseOrg org = baseOrgService.dtl(Integer.valueOf(ids[i]));
									ins = savewf2(parentId,du,org,step,"承办处室（"+names[i]+"）","duban/edit","duban/dtl",1);
								}
							}
						}
					}
//					BaseOrg org = baseOrgService.dtl(du.getChengbanchushiId());
//					ins = savewf2(parentId,du,org,step,"承办处室（"+du.getChengbanchushi()+"）","duban/edit","duban/dtl",1);
				}

				if(!du.getXiebanchushi().equals("")){
					String[] ids = du.getXiebanchushiId().split(",");
					String[] names = du.getXiebanchushi().split(",");
					for (int i =0; i < ids.length;i++) {
						if(!ids[i].equals("")){
							cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
									step, String.valueOf(ids[i]));
							if(cnt > 0)
							{
								ins = documentService.getIns(du.getId(), step,String.valueOf(ids[i]),du.getColSym());
							}else{
								BaseOrg org = baseOrgService.dtl(Integer.valueOf(ids[i]));
								ins = savewf2(parentId,du,org,step,"协办处室（"+names[i]+"）","duban/edit","duban/dtl",1);
							}
						}
					}
				}
			}

		}
		map.put("result", "success");
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/start", method = RequestMethod.POST)
	public Map<String, Object> start(int id, int insId,
									 HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(id > 0)
		{
			DuBan du = duBanService.dtl(id);
			du.setStatus(1);
			du = duBanService.save(du,request);

			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = new WfInstance();
			if(du.getId() > 0)
			{
				int parentId = 0;
				int step = 1;
				int cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(user.getId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), 1,String.valueOf(user.getId()),du.getColSym());
				}else{
					ins = savewf(parentId,du,user,step,"创建督办事项","duban/edit","duban/dtl",1);
				}

				step = 2;
				parentId = ins.getId();
				cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
						step, String.valueOf(du.getChengbanchushiId()));
				if(cnt > 0)
				{
					ins = documentService.getIns(du.getId(), step,String.valueOf(du.getChengbanchushiId()),du.getColSym());
				}else{
					if(!du.getChengbanchushiId().equals("")){
						String[] ids = du.getChengbanchushiId().split(",");
						String[] names = du.getChengbanchushi().split(",");
						for (int i =0; i < ids.length;i++) {
							if(!ids[i].equals("")){
								cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
										step, String.valueOf(ids[i]));
								if(cnt > 0)
								{
									ins = documentService.getIns(du.getId(), step,String.valueOf(ids[i]),du.getColSym());
								}else{
									BaseOrg org = baseOrgService.dtl(Integer.valueOf(ids[i]));
									ins = savewf2(parentId,du,org,step,"承办处室（"+names[i]+"）","duban/edit","duban/dtl",1);
								}
							}
						}
					}
//					BaseOrg org = baseOrgService.dtl(du.getChengbanchushiId());
//					ins = savewf2(parentId,du,org,step,"承办处室（"+du.getChengbanchushi()+"）","duban/edit","duban/dtl",1);
				}

				if(!du.getXiebanchushi().equals("")){
					String[] ids = du.getXiebanchushiId().split(",");
					String[] names = du.getXiebanchushi().split(",");
					for (int i =0; i < ids.length;i++) {
						if(!ids[i].equals("")){
							cnt = documentService.checkInsExist(String.valueOf(du.getColSym()), du.getId(),
									step, String.valueOf(ids[i]));
							if(cnt > 0)
							{
								ins = documentService.getIns(du.getId(), step,String.valueOf(ids[i]),du.getColSym());
							}else{
								BaseOrg org = baseOrgService.dtl(Integer.valueOf(ids[i]));
								ins = savewf2(parentId,du,org,step,"协办处室（"+names[i]+"）","duban/edit","duban/dtl",1);
							}
						}
					}
				}
			}

		}
		map.put("result", "success");
		return map;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(DuBan doc,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc = duBanService.save(doc, request);


		map.put("entity", doc);
		return map;
	}


	public WfInstance savewf(int parentId,DuBan doc,BaseUser user,int stepId, String stepName, String actUrl, String dtlUrl,int isActive){

		WfInstance ins = new WfInstance();
		ins.setCategory(doc.getCategory());
		ins.setTitle(doc.getTitle());
		ins.setApplyTo(doc.getColSym());
		ins.setRefNum(doc.getId());
		ins.setDescr("");
		ins.setStepId(stepId);
		ins.setStepName(stepName);
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(String.valueOf(user.getId()));
		ins.setActorName(user.getBasePersonName());
		ins.setActUrl(actUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setParentId(parentId);
		ins.setStartTime(doc.getStarttime());

		if(doc.getColSym().equals("YEWU")) {
			if (stepId < 4)
				ins.setYesNo("yes");
		}else{
			if(stepId < 3)
				ins.setYesNo("yes");
		}
		ins.setListUrl("");
		ins.setOkUrl("");
		ins.setIsActive(isActive);
		ins = insService.save(ins, request);
//		if(parentId > 0){
//			WfInstance pins = insService.dtl(parentId);
//			if(!pins.getForward().contains(ins.getId() + ",")){
//				pins.setForward(pins.getForward() + ins.getId() + ",");
//				pins = insService.save(pins,request);
//			}
//		}

		return ins;
	}

	public WfInstance savewf2(int parentId,DuBan doc,BaseOrg org,int stepId, String stepName, String actUrl, String dtlUrl,int isActive){

		WfInstance ins = new WfInstance();
		ins.setCategory(doc.getCategory());
		ins.setTitle(doc.getTitle());
		ins.setApplyTo(doc.getColSym());
		ins.setRefNum(doc.getId());
		ins.setDescr("");
		ins.setStepId(stepId);
		ins.setStepName(stepName);
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(String.valueOf(org.getId()));
		ins.setActorName(org.getName());
		ins.setActUrl(actUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setParentId(parentId);
		ins.setStartTime(doc.getStarttime());
		if(stepId < 2)
			ins.setYesNo("yes");
		ins.setListUrl("");
		ins.setOkUrl("");
		ins.setIsActive(isActive);
		ins = insService.save(ins, request);
//		if(parentId > 0){
//			WfInstance pins = insService.dtl(parentId);
//			if(!pins.getForward().contains(ins.getId() + ",")){
//				pins.setForward(pins.getForward() + ins.getId() + ",");
//				pins = insService.save(pins,request);
//			}
//		}
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
		Document doc = documentService.dtl(ins.getRefNum());
		//doc.setContent("文件批转");
		WfWorkflow wf = wfService.dtl("DOCUMENT");
		//QueryResult<WfStep> wsList = wsService.list(wf.getId());
		doc.setWfWorkflowId(wf.getId());
		doc = documentService.save(doc, request);
		
		
		/*String[] actorIds = actorId.split(",");
		String[] actorNames = actorName.split(",");
		for(int i = 0; i < actorIds.length; i++)
		{
			if(actorIds[i] != "")
			{
				WfInstance tins = (WfInstance) ins.clone();
				tins.setId(0);
				tins.setStepId(stepId);
				tins.setActorId(actorIds[i]);
				tins.setActorName(actorNames[i]);
				tins.setYesNo("");
				tins.setDescr("");
				tins.setActAt(null);
				tins.setRecordInfo(new RecordInfo());
				tins = insService.save(tins, request);
			}
		}*/
		map.put("result", "success");
		return map;
	}
	
	
	
	/**
	 * @param docId
	 * @param wsList
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/savePi", method = RequestMethod.POST)
	public Map<String, Object> savePi(int docId,@RequestBody PishiList wsList,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		//WfInstance ins = documentService.getIns(docId, 1);
		Document doc = documentService.dtl(docId);
		
		int stepId = 2;
		for (Pishi ws : wsList.getPishiList()) {
			if(!ws.getActorId().equals("") && !ws.getContent().equals("")){
				WfInstance ins = insService.getIns(docId, String.valueOf(ws.getId()));
				if(ins == null)
					ins = new WfInstance();
				ins.setCategory(doc.getCategory());
				ins.setTitle(doc.getTitle());
				ins.setApplyTo(String.valueOf(ws.getId()));
				ins.setRefNum(doc.getId());
				ins.setDescr(ws.getContent());
				ins.setStepId(stepId);
				ins.setStepName("文件批转");
				ins.setNextStepId(stepId + 1);
				ins.setNextStepName("");
				ins.setActorId(ws.getActorId());
				ins.setActorName(ws.getActorName());
				ins.setActUrl("document/dtl");
				ins.setDtlUrl("document/dtl");
				ins.setListUrl("");
				ins.setOkUrl("");
				ins.setIsActive(2);
				ins.setActAt(new Date());
				ins = insService.save(ins, request);
			}
		}
		WfWorkflow wf = wfService.dtl("DOCUMENT");
		//QueryResult<WfStep> wsList = wsService.list(wf.getId());
		doc.setWfWorkflowId(wf.getId());
		//doc.setContent("文件批转");
		doc = documentService.save(doc, request);
		
		
		/*String[] actorIds = actorId.split(",");
		String[] actorNames = actorName.split(",");
		for(int i = 0; i < actorIds.length; i++)
		{
			if(actorIds[i] != "")
			{
				WfInstance tins = (WfInstance) ins.clone();
				tins.setId(0);
				tins.setStepId(stepId);
				tins.setActorId(actorIds[i]);
				tins.setActorName(actorNames[i]);
				tins.setYesNo("");
				tins.setDescr("");
				tins.setActAt(null);
				tins.setRecordInfo(new RecordInfo());
				tins = insService.save(tins, request);
			}
		}*/
		map.put("result", "success");
		return map;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/saveDuInfo", method = RequestMethod.POST)
	public Map<String, Object> saveDuInfo(int insId,int docId, String content,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfInstance wi = insService.dtl(insId);
		Document doc = documentService.dtl(docId);
		wi.setDescr(content);
		wi = insService.save(wi,request);
		/*WfInstance ins = (WfInstance) wi.clone();
		int stepId = 13;
		ins.setId(0);
		ins.setCategory(doc.getCategory());
		ins.setTitle(doc.getTitle());
		ins.setApplyTo("督办信息");
		ins.setRefNum(wi.getId());
		ins.setDescr(content);
		ins.setStepId(stepId);
		ins.setStepName("督办信息");
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(wi.getActorId());
		ins.setActorName(wi.getActorName());
		ins.setActUrl("duban/edit");
		ins.setDtlUrl("duban/dtl");
		ins.setListUrl("");
		ins.setOkUrl("");
		ins.setIsActive(stepId);
		ins.setActAt(new Date());
		ins = insService.save(ins, request);
		*/
		map.put("result", "success");
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/saveDu", method = RequestMethod.POST)
	public Map<String, Object> saveDu(int flag,int docId,int insId,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		//WfInstance ins = documentService.getIns(docId, 1);
		Document doc = documentService.dtl(docId);
		WfInstance wi = insService.dtl(insId);
		wi.setYesNo("yes");
		wi.setActAt(new Date());
		wi = insService.save(wi, request);
		if(flag == 1)
		{
			int stepId = 11;
			WfInstance ins = new WfInstance();
			ins.setCategory(doc.getCategory());
			ins.setTitle(doc.getTitle());
			ins.setApplyTo(doc.getCategory());
			ins.setRefNum(doc.getId());
			ins.setDescr("");
			ins.setStepId(stepId);
			ins.setStepName("督办");
			ins.setNextStepId(stepId + 1);
			ins.setNextStepName("");
			//ins.setActorId(ws.getActorId());
			//ins.setActorName(ws.getActorName());
			ins.setActUrl("duban/edit");
			ins.setDtlUrl("duban/dtl");
			ins.setListUrl("");
			ins.setOkUrl("");
			ins.setIsActive(11);
			//ins.setActAt(new Date());
			ins = insService.save(ins, request);
			
			//doc.setContent("督办");
			
		}else{
			//doc.setContent("办结");
			doc.setIsFinish(1);
		}
		doc = documentService.save(doc, request);
		map.put("result", "success");
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/saveDuOrg", method = RequestMethod.POST)
	public Map<String, Object> saveDuOrg(int docId,int parentId,int personId,Date startTime,Date finishTime,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfInstance parentIns = insService.dtl(parentId);
		DuBan duban = duBanService.dtl(docId);
		Document doc = documentService.dtl(duban.getRefNum());
		BasePerson person = personService.dtl(personId);

		WfInstance ins = new WfInstance();
		int stepId = parentIns.getStepId() + 1;
		ins.setStartTime(startTime);
		ins.setFinishTime(finishTime);
		ins.setCategory(doc.getCategory());
		ins.setTitle(person.getBaseOrgName());
		ins.setApplyTo("督办");
		ins.setRefNum(docId);
		ins.setDescr("");
		ins.setStepId(stepId);
		ins.setStepName(person.getBaseOrgName());
		ins.setNextStepId(stepId + 1);
		ins.setParentId(parentId);
		ins.setActorId(String.valueOf(personId));
		ins.setActorName(person.getName());
		ins.setActUrl("duban/edit");
		ins.setDtlUrl("document/dtl");
		ins.setListUrl(person.getBaseOrgName());
		ins.setOkUrl(String.valueOf(person.getBaseOrgId()));
		ins.setNextStepName(person.getMobile());
		ins.setIsActive(1);
		//ins.setActAt(new Date());
		ins = insService.save(ins, request);
//		if(parentIns.getForward() != null && !parentIns.getForward().equals("")){
//			parentIns.setForward(parentIns.getForward() + "," + ins.getId());
//		}
//		else{
//			parentIns.setForward(String.valueOf(ins.getId()));
//		}
//		parentIns = insService.save(parentIns,request);
		map.put("result", "success");
		
		return map;
	}



	@ResponseBody
	@RequestMapping(value = "/finish", method = RequestMethod.POST)
	public Map<String, Object> finish(int docId, int insId,
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



//		if(ins.getStepId() == 4 || ins.getStepId() == 3){
//			QueryResult<WfInstance> rslt = insService.listDuInfo(ins.getParentId(),1);
//			boolean b = true;
//			for (WfInstance wi : rslt.getRows()){
//				if(!wi.getYesNo().equals("yes")){
//					b = false;
//				}
//			}
//			if (b){
//				ins = insService.dtl(ins.getParentId());
//				ins.setActAt(new Date());
//				ins.setYesNo("yes");
//
//				ins = insService.save(ins, request);
//				DuBan du = duBanService.dtl(ins.getRefNum());
//				du.setStatus(2);
//				du = duBanService.save(du,request);
//			}
//		}

		/*ins = insService.dtl(ins.getRefNum());
		ins.setActAt(new Date());
		ins.setYesNo("yes");
		ins = insService.save(ins, request);*/
		//Document doc = documentService.dtl(docId);
		//doc.setIsFinish(1);
		//doc.setContent("督办结束");
		//doc = documentService.save(doc, request);
		map.put("result", "success");
		return map;
	}




	@ResponseBody
	@RequestMapping(value = "/faile", method = RequestMethod.POST)
	public Map<String, Object> faile(int docId, int insId,
									  HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfInstance ins = new WfInstance();
		if(insId > 0)
		{
			ins = insService.dtl(insId);
			ins.setActAt(new Date());
			ins.setYesNo("no");

			ins = insService.save(ins, request);
		}
		/*ins = insService.dtl(ins.getRefNum());
		ins.setActAt(new Date());
		ins.setYesNo("yes");
		ins = insService.save(ins, request);*/
//		Document doc = documentService.dtl(docId);
//		doc.setIsFinish(1);
//		doc.setContent("督办超时");
//		doc = documentService.save(doc, request);
//		map.put("result", "success");
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
		documentService.del(id);
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
		documentService.sort(id, order);
		return map;
	}

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

}
