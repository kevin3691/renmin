/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseDict;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseDictService;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.core.utils.DateUtils;
import com.zzb.core.utils.OfficeUtils;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfStep;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.DocFileTypeService;
import com.zzb.zo.service.DocTypeService;
import com.zzb.zo.service.DocFileService;
import com.zzb.zo.service.DuBanService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/docfile")
public class DocFileController extends BaseController {
	@Resource
	private DocFileService docFileService;


	@Resource
	private BaseDictService baseDictService;

	@Resource
	private CommAttachmentService commAttachmentService;
	


	
	String mode = "RW";
	String category = "";
	String uploadLabel = "";
	String applyTo = "";
	int refNum = 0;
	String title = "";
	String allowExt = "*.*";
	long allowSize = 1000 * 1024 * 1024L;
	String destDir = "upload/docfile/";
	
	/**
	 * 构造函数
	 */
	public DocFileController() {

	}


	@RequestMapping(value = "/doc")
	public String doc(ModelMap map){
		String url = request.getParameter("url") !=null ? String.valueOf(request.getParameter("url")) : "";
		map.addAttribute("url",url);
		return "/docfile/doc";
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

		return "/docfile/index";
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
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		DocFile doc = new DocFile();
		if (id > 0) {
			doc = docFileService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, model);


		model.addAttribute("o", doc);
		String url = "/docfile/edit";
		/*if(stepId > 1)
		{
			url = "docFile/act";
		}*/
		return url;
	}



	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		DocFile doc = new DocFile();
		if (id > 0) {
			doc = docFileService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/docfile/dtl";
		
		return url;
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
	public QueryResult<DocFile> list(HttpServletRequest request) {
		QueryResult<DocFile> rslt = docFileService.list(request);
//		for(DocFile doc : rslt.getRows())
//		{
//			List<WfInstance> insList = docFileService.listIns(doc.getId());
//			WfInstance ins = insList.get(insList.size() - 1);
//			BaseUser user = baseUserService.dtl(Integer.valueOf(ins.getActorId()));
//			String descr = "";
//			/*if(ins.getStepId() > 1)
//			{
//				if(doc.getIsFinish() != 1)
//				{
//					descr += DateUtils.format(ins.getRecordInfo().getCreatedAt(),"yyyy-MM-dd HH:mm");
//					descr += " 交与 [" + user.getBaseOrgName() + "--" + ins.getActorName() + "]办理!";
//				}else{
//					descr += DateUtils.format(ins.getActAt(),"yyyy-MM-dd HH:mm");
//					descr += " [" + user.getBaseOrgName() + "--" + ins.getActorName() + "]办理完结!";
//				}
//			}else{
//				descr += DateUtils.format(ins.getRecordInfo().getCreatedAt(),"yyyy-MM-dd HH:mm");
//				descr += " [" + user.getBaseOrgName() + "--" + ins.getActorName() + "]新建文档!";
//			}*/
//			
//			doc.setContent(descr);
//		}
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
	public Map<String, Object> save(DocFile doc,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		//doc.setContent("录入批办信息!");
		doc = docFileService.save(doc, request);

		int cnt = baseDictService.checkExist(doc.getOrg());
		if(cnt == 0){
			BaseDict pdict = baseDictService.dtlBySym("LWDW");
			BaseDict dict = new BaseDict();
			dict.setTitle(doc.getOrg());
			dict.setIsActive(1);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(pdict.getId());
			String path = pdict.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + pdict.getId()
					+ "." : path + pdict.getId() + ".");
			String pathname = pdict.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ pdict.getTitle() + "." : pathname + pdict.getTitle()
					+ ".");
			dict.setBaseTree(tree);

			int count = baseDictService.getCount("LWDW") + 1;
			dict.setSym("LWDW_" + count);
			dict = baseDictService.save(dict,request);
		}

		/*WfInstance ins = new WfInstance();
		if(doc.getId() > 0)
		{
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			int cnt = docFileService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
					1, String.valueOf(user.getId()));
			if(cnt > 0)
			{
				ins = docFileService.getIns(doc.getId(), 1);
			}else{
				ins = savewf(doc,user,1,"docFile/edit","docFile/dtl");
			}
		}*/
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}





    @ResponseBody
	@RequestMapping(value = "/saveDoc", method = RequestMethod.POST)
	public Map<String, Object> saveDoc(int docTypeId,String docTypeName,int fileId,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		CommAttachment att = commAttachmentService.dtl(fileId);
		DocFile doc = new DocFile();
		doc.setTitle(att.getTitle());
		doc.setDocTypeName(docTypeName);
		doc.setDocTypeId(docTypeId);
		doc.setFileId(fileId);
		doc.setFileName(att.getTitle());
		doc.setFilePath(att.getFilePath());
		doc.setFileUrl(att.getFileUrl());
		doc.setFileExt(att.getFileExt());
		doc.setFileSize(att.getFileSize());
		doc.setIsActive(1);
		doc = docFileService.save(doc,request);
		att.setRefNum(doc.getId());
		att.setApplyTo(doc.getDocTypeName());
		att = commAttachmentService.save(att,request);
		map.put("entity", doc);
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
		docFileService.del(id);
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
		docFileService.sort(id, order);
		return map;
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
