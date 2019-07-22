/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import java.io.*;
import java.util.*;

import javax.annotation.Resource;
import javax.security.auth.Subject;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.entity.BaseDict;
import com.zzb.base.service.BaseDictService;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.utils.OfficeUtils;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.DocTypeService;
import com.zzb.zo.service.DuBanService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.poi.ss.formula.WorkbookDependentFormula;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.zzb.base.entity.BaseUser;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/document")
public class DocumentController extends BaseController {
	@Resource
	private DocumentService documentService;

	@Resource
	private DuBanService duBanService;

	@Resource
	private WfInstanceService insService;
	
	@Resource
	private WfWorkflowService wfService;
	
	@Resource
	private WfStepService wsService;

	@Resource
	private BaseDictService baseDictService;

	@Resource
	private CommAttachmentService commAttachmentService;
	
	@Resource
	private BaseUserService baseUserService;

	@Resource
	private DocTypeService docTypeService;

	
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
	public DocumentController() {

	}


	@RequestMapping(value = "/doc")
	public String doc(ModelMap map){
		String url = request.getParameter("url") !=null ? String.valueOf(request.getParameter("url")) : "";
		map.addAttribute("url",url);
		return "/document/doc";
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

		return "/document/index";
	}

	@RequestMapping(value = "/index5")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index5(ModelMap map) {
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

		return "/document/index5";
	}

	@RequestMapping(value = "/dsel")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dsel(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dsel";
	}

	@RequestMapping(value = "/dindex")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dindex(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dindex";
	}

	@RequestMapping(value = "/dindex2")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dindex2(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dindex2";
	}

	@RequestMapping(value = "/dindex3")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dindex3(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dindex3";
	}

	@RequestMapping(value = "/dindex4")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dindex4(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dindex4";
	}

	@RequestMapping(value = "/dindex5")
	//@RequiresPermissions("DOCUMENT:RO")
	public String dindex5(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		return "/document/dindex5";
	}

    @RequestMapping(value = "/dedit")
    //@RequiresPermissions("DOCUMENT:RW")
    public String dedit(HttpServletRequest request, ModelMap model) {
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
        Document doc = new Document();
        if (id > 0) {
            doc = documentService.dtl(id);
            doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
            BaseUser user = (BaseUser)SecurityUtils.getSubject()
                    .getSession().getAttribute("baseUser");
            WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
            model.addAttribute("ins", ins);
        }else{
            doc.setCategory(colTitle);
            doc.setColTitle(colTitle);
            doc.setColSym(colSym);
            doc.setType(type);
        }
        setPara(request, model);


        model.addAttribute("o", doc);
        String url = "/document/dedit";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
        return url;
    }


	@RequestMapping(value = "/dview")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dview(HttpServletRequest request, ModelMap model) {
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
		int insId = request.getParameter("insId") != null ? Integer.valueOf(request
				.getParameter("insId")) : 0;
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			//WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			WfInstance ins = insService.dtl(insId);
			model.addAttribute("ins", ins);
			model.addAttribute("o",doc);
			QueryResult<WfInstance> insList = insService.listByDocId(doc.getId(),String.valueOf(doc.getType()));
			for (WfInstance ii : insList.getRows())
			{
				if(ii.getDescr() != null && !ii.getDescr().equals("")){
					String s = ii.getDescr();
					s = StringEscapeUtils.unescapeHtml(s);
					s = s.replaceAll("\\'","\\\\'");
					ii.setDescr(s);
				}
			}
			model.addAttribute("list",insList.getRows());
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, model);


		model.addAttribute("o", doc);
		String url = "/document/dview";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}


	@RequestMapping(value = "/dview4")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dview4(HttpServletRequest request, ModelMap model) {
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
		int insId = request.getParameter("insId") != null ? Integer.valueOf(request
				.getParameter("insId")) : 0;
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			QueryResult<WfInstance> list = documentService.getIns(doc.getId(),String.valueOf(doc.getType()));
			//WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			WfInstance ins = new WfInstance();
			for (WfInstance wi : list.getRows())
			{
				if(wi.getStepId() > ins.getStepId())
				{
					ins = wi;
				}
			}
			model.addAttribute("ins", ins);
			model.addAttribute("o",doc);
			QueryResult<WfInstance> insList = insService.listByDocId(doc.getId(),String.valueOf(doc.getType()));
			for (WfInstance ii : insList.getRows())
			{
				if(ii.getDescr() != null && !ii.getDescr().equals("")){
					String s = ii.getDescr();
					s = StringEscapeUtils.unescapeHtml(s);
					s = s.replaceAll("\\'","\\\\'");
					ii.setDescr(s);
				}
			}
			model.addAttribute("list",insList.getRows());
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, model);


		model.addAttribute("o", doc);
		String url = "/document/dview";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}


    @RequestMapping(value = "/dact")
    //@RequiresPermissions("DOCUMENT:RW")
    public String dact(HttpServletRequest request, ModelMap model) {
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
        int insId = request.getParameter("insId") != null ? Integer.valueOf(request
                .getParameter("insId")) : 0;
        Document doc = new Document();
        if (id > 0) {
            doc = documentService.dtl(id);
            doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
            BaseUser user = (BaseUser)SecurityUtils.getSubject()
                    .getSession().getAttribute("baseUser");
            //WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
            WfInstance ins = insService.dtl(insId);
            model.addAttribute("ins", ins);
            model.addAttribute("o",doc);
            QueryResult<WfInstance> insList = insService.listByDocId(doc.getId(),String.valueOf(doc.getType()));
			for (WfInstance ii : insList.getRows())
			{
				if(ii.getDescr() != null && !ii.getDescr().equals("")){
					String s = ii.getDescr();
					s = StringEscapeUtils.unescapeHtml(s);
					s = s.replaceAll("\\'","\\\\'");
					ii.setDescr(s);
				}
			}
            model.addAttribute("list",insList.getRows());
        }else{
            doc.setCategory(colTitle);
            doc.setColTitle(colTitle);
            doc.setColSym(colSym);
            doc.setType(type);
        }
        setPara(request, model);


        model.addAttribute("o", doc);
        String url = "/document/dact";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
        return url;
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

		return "/document/index4";
	}

	@RequestMapping(value = "/piInfo")
	//@RequiresPermissions("DOCUMENT:RO")
	public String piInfo(ModelMap map) {

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
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			map.addAttribute("ins", ins);
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, map);
		map.addAttribute("o", doc);
		String url = "/document/piInfo";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}
	
	@RequestMapping(value = "/ins")
	//@RequiresPermissions("DOCUMENT:RO")
	public String ins(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		switch (colSym) {
		case "DOCUMENT_DAIBAN":
			map.addAttribute("yesNo", "no");
			break;
		case "DOCUMENT_YIBAN":
			map.addAttribute("yesNo", "yes");
			break;
		
		default:
			break;
		}
		
		return "/document/ins";
	}
	@RequestMapping(value = "/duban")
	//@RequiresPermissions("DOCUMENT:RO")
	public String duban(ModelMap map) {

		return "/document/duban";
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
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			model.addAttribute("ins", ins);
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, model);


		model.addAttribute("o", doc);
		String url = "/document/edit";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}



	@RequestMapping(value = "/liangtian")
	//@RequiresPermissions("DOCUMENT:RW")
	public String liangtian(HttpServletRequest request, ModelMap model) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int docTypeId = request.getParameter("docTypeId") != null ? Integer.valueOf(request
				.getParameter("docTypeId")) : 0;
		DocType type = docTypeService.dtl(docTypeId);

		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
//			BaseUser user = (BaseUser)SecurityUtils.getSubject()
//					.getSession().getAttribute("baseUser");
		}else{
			if(docTypeId > 0)
			{
				doc.setDocTypeName(type.getName());
				doc.setDocTypeId(type.getId());
			}
		}
		setPara(request, model);


		model.addAttribute("o", doc);
		String url = "/document/liangtian";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
		return url;
	}



    @RequestMapping(value = "/print")
    //@RequiresPermissions("DOCUMENT:RW")
    public String print(HttpServletRequest request, ModelMap model) {
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
        Document doc = new Document();
        if (id > 0) {
            doc = documentService.dtl(id);
			doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
//            BaseUser user = (BaseUser)SecurityUtils.getSubject()
//                    .getSession().getAttribute("baseUser");
//            WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			QueryResult<WfInstance> insList = insService.listByDocId(id,String.valueOf(doc.getType()));
			for (WfInstance ii : insList.getRows())
			{
				if(ii.getDescr() != null && !ii.getDescr().equals("")){
					String s = ii.getDescr();
					s = StringEscapeUtils.unescapeHtml(s);
					s = s.replaceAll("\\'","\\\\'");
					ii.setDescr(s);
				}
			}
			model.addAttribute("list",insList.getRows());
        }else{
            doc.setCategory(colTitle);
            doc.setColTitle(colTitle);
            doc.setColSym(colSym);
            doc.setType(type);
        }
        setPara(request, model);
        model.addAttribute("o", doc);
        String url = "/document/print";
		/*if(stepId > 1)
		{
			url = "document/act";
		}*/
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
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = documentService.getIns(id, stepId,String.valueOf(user.getId()),doc.getColSym());
			model.addAttribute("ins", ins);
		}else{
			doc.setCategory(colTitle);
			doc.setColTitle(colTitle);
			doc.setColSym(colSym);
			doc.setType(type);
		}
		setPara(request, model);
		model.addAttribute("o", doc);
		String url = "/document/act";
		
		return url;
	}
	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		Document doc = new Document();
		if (id > 0) {
			doc = documentService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/document/dtl";
		
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
		return "/document/flowInfo";
	}
	@RequestMapping(value = "/flow")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flow(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = documentService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/document/flow";
	}

	@ResponseBody
	@RequestMapping(value = "/list_ins")
	public QueryResult<WfInstance> list_ins(HttpServletRequest request) {
		QueryResult<WfInstance> inslist = insService.list(request);
		//QueryResult<Document> rslt = documentService.list(request);
//		for(Document doc : rslt.getRows())
//		{
//			List<WfInstance> insList = documentService.listIns(doc.getId());
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
		return inslist;
	}


	@RequestMapping(value = "/fileSteamUpload")
	public String  FileSteamUpload(HttpServletRequest request) throws IllegalStateException, IOException
	{
		PrintWriter out = response.getWriter();
		final int NONE = 0; // 状态码，表示没有特殊操作
		final int DATAHEADER = 1; // 表示下一行要读到报头信息
		final int FILEDATA = 2; // 表示下面要读的是上传文件和二进制数据
		final int FIELDDATA = 3; // 表示下面要读到表单域的文本值
		// 请求消息实体的总长度(请求消息中除消息头之外的数据长度)
		int totalbytes = request.getContentLength();
		File f; // 上传文件储存在服务器上
		// 容纳请求消息实体的字节数组
		byte[] dataOrigin = new byte[totalbytes];
		// 对于post多个文件的表单，b作为原始数据的副本提供提取文件数据的操作
		byte[] b = new byte[totalbytes];
		// 请求消息类型
		String contentType = request.getContentType();
		String fieldname = ""; // 表单域的名称
		String fieldvalue = ""; // 表单域的值
		String fileFormName = ""; // 上传的文件再表单中的名称
		String fileRealName = ""; // 上传文件的真实名字
		String boundary = ""; // 分界符字符串
		String lastboundary = ""; // 结束分界符字符串
		int fileSize = 0; // 文件长度
		// 容纳表单域的名称/值的哈希表
		Map formfieldsTable = new HashMap();
		// 容纳文件域的名称/文件名的哈希表
		Map filenameTable = new HashMap();
		// 在消息头类型中找到分界符的定义
		int pos = contentType.indexOf("boundary=");
		int pos2; // position2
		if (pos != -1) {
			pos += "boundary=".length();
			boundary = "--" + contentType.substring(pos); // 解析出分界符
			lastboundary = boundary + "--"; // 得到结束分界符
		}
		int state = NONE; // 起始状态为NONE
		// 得到请求消息的数据输入流
		DataInputStream in = new DataInputStream(request.getInputStream());
		in.readFully(dataOrigin); // 根据长度，将消息实体的内容读入字节数组dataOrigin中
		in.close(); // 关闭数据流
		String reqcontent = new String(dataOrigin); // 从字节数组中得到表示实体的字符串
		// 从字符串中得到输出缓冲流
		BufferedReader reqbuf = new BufferedReader(new StringReader(reqcontent));
		// 设置循环标志
		boolean flag = true;

		// int i = 0;
		while (flag == true) {
			String s = reqbuf.readLine();
			if (s == lastboundary || s == null)
				break;
			switch (state) {
				case NONE:
					if (s.startsWith(boundary)) {
						// 如果读到分界符，则表示下一行一个头信息
						state = DATAHEADER;
						// i += 1;
					}
					break;
				case DATAHEADER:
					pos = s.indexOf("filename=");
					// 先判断出这是一个文本表单域的头信息，还是一个上传文件的头信息
					if (pos == -1) {
						// 如果是文本表单域的头信息，解析出表单域的名称
						pos = s.indexOf("name=");
						pos += "name=".length() + 1; // 1表示后面的"的占位
						s = s.substring(pos);
						int l = s.length();
						s = s.substring(0, l - 1); // 应该是"
						fieldname = s; // 表单域的名称放入fieldname
						out.print("fieldname=" + fieldname);
						state = FIELDDATA; // 设置状态码，准备读取表单域的值
					} else {
						// 如果是文件数据的头，先存储这一行，用于在字节数组中定位
						String temp = s;
						// 先解析出文件名
						pos = s.indexOf("name=");
						pos += "name=".length() + 1; // 1表示后面的"的占位
						pos2 = s.indexOf("filename=");
						String s1 = s.substring(pos, pos2 - 3); // 3表示";加上一个空格
						fileFormName = s1;
						pos2 += "filename=".length() + 1; // 1表示后面的"的占位
						s = s.substring(pos2);
						int l = s.length();
						s = s.substring(0, l - 1);
						pos2 = s.lastIndexOf("\\"); // 对于IE浏览器的设置
						s = s.substring(pos2 + 1);
						fileRealName = s;
						//out.print("fileRealName=" + fileRealName + "");
					/*//out.print("fileRealName.length()=" + fileRealName.length()
							+ "");*/
						if (fileRealName.length() != 0) { // 确定有文件被上传
							// 下面这一部分从字节数组中取出文件的数据
							b = dataOrigin; // 复制原始数据以便提取文件
							pos = byteIndexOf(b, temp, 0); // 定位行
							// 定位下一行，2 表示一个回车和一个换行占两个字节
							b = subBytes(b, pos + temp.getBytes().length + 2,
									b.length);
							// 再读一行信息，是这一部分数据的Content-type
							s = reqbuf.readLine();

							String dirPath = "UploadFile";
							File pfile = new File(dirPath);
							if (!pfile.exists()) {
								pfile.mkdirs();
							}
							// 设置文件输入流，准备写文件
							f = new File(dirPath + File.separator
									+ fileRealName);
							DataOutputStream fileout = new DataOutputStream(
									new FileOutputStream(f));
							// 字节数组再往下一行，4表示两回车换行占4个字节，本行的回车换行2个字节，Content-type的下
							// 一行是回车换行表示的空行，占2个字节
							// 得到文件数据的起始位置
							b = subBytes(b, s.getBytes().length + 4, b.length);
							pos = byteIndexOf(b, boundary, 0); // 定位文件数据的结尾
							b = subBytes(b, 0, pos - 1); // 取得文件数据
							fileout.write(b, 0, b.length - 1); // 将文件数据存盘
							fileout.close();
							fileSize = b.length - 1; // 文件长度存入fileSize
						/*out.print("fileFormName=" + fileFormName + " filename="
								+ fileRealName + " fileSize=" + fileSize + "");*/
							filenameTable.put(fileFormName, fileRealName);
							state = FILEDATA;
						}
					}
					break;
				case FIELDDATA:
					// 读取表单域的值
					s = reqbuf.readLine();
					fieldvalue = s; // 存入fieldvalue
					/*out.print(" fieldvalue=" + fieldvalue + "");*/
					formfieldsTable.put(fieldname, fieldvalue);
					state = NONE;
					break;
				case FILEDATA:
					// 如果是文件数据不进行分析，直接读过去
					while ((!s.startsWith(boundary))
							&& (!s.startsWith(lastboundary))) {
						s = reqbuf.readLine();
						if (s.startsWith(boundary)) {
							state = DATAHEADER;
						} else {
							break;
						}
					}
					break;
			}
		}
		// 指定内容类型，并且可以显示中文
		/*out.println("");
		out.println("");
		out.println("");*/
		// 文件上传结果
		/*out.println("ID为" + formfieldsTable.get("FileID1") + "的文件"
				+ filenameTable.get("FileData1") + "已经上传!");
		out.println("ID为" + formfieldsTable.get("FileID2") + "的文件"
				+ filenameTable.get("FileData2") + "已经上传!");
		// out.println("i = " + i + "");
		out.println("");
		out.println("");*/
		return "/success";
	}

	private static int byteIndexOf(byte[] b, String s, int start) {
		return byteIndexOf(b, s.getBytes(), start);
	}

	private static int byteIndexOf(byte[] b, byte[] s, int start) {
		int i;
		if (s.length == 0) {
			return 0;
		}
		int max = b.length - s.length;
		if (max < 0) {
			return -1;
		}
		if (start > max) {
			return -1;
		}
		if (start < 0) {
			start = 0;
		}
		// 在b中找到s的第一个元素
		search: for (i = start; i <= max; i++) {
			if (b[i] == s[0]) {
				// 找到了s中的第一个元素后，比较剩余的部分是否相等
				int k = 1;
				while (k < s.length) {
					if (b[k + i] != s[k]) {
						continue search;
					}
					k++;
				}
				return i;
			}
		}
		return -1;
	}

	private static byte[] subBytes(byte[] b, int from, int end) {
		byte[] result = new byte[end - from];
		System.arraycopy(b, from, result, 0, end - from);
		return result;
	}

	private static String subBytesString(byte[] b, int from, int end) {
		return new String(subBytes(b, from, end));
	}


	@ResponseBody
    @RequestMapping(value = "/list_ins_old")
    public QueryResult<WfInstance> list_ins_old(HttpServletRequest request) {
        QueryResult<WfInstance> inslist = insService.list4(request);

        for(WfInstance ins : inslist.getRows()){
            WfInstance temp = insService.getLastIns(ins.getRefNum());
            ins.setStepName(temp.getStepName());
            ins.setActorName(temp.getActorName());
            ins.setId(temp.getId());
        }


        return inslist;
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
	public QueryResult<Document> list(HttpServletRequest request) {
		QueryResult<Document> rslt = documentService.list(request);
//		for(Document doc : rslt.getRows())
//		{
//			List<WfInstance> insList = documentService.listIns(doc.getId());
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

	@ResponseBody
	@RequestMapping(value = "/listYwdb")
	public QueryResult<Document> listYwdb(HttpServletRequest request) {
		QueryResult<Document> rslt = documentService.list(request);

		return rslt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/listIns")
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		QueryResult<WfInstance> rslt = documentService.listIns(request);
		return rslt;
	}

	@ResponseBody
	@RequestMapping(value = "viewdoc",method = RequestMethod.POST)
	public Map<String,Object> viewdoc(int id,HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		//CommAttachment att = commAttachmentService.dtl(id);
		Document doc = documentService.dtl(id);
		String url = "";
		if(doc.getFileExt().contains("docx")){
			try {
				url = OfficeUtils.word2007ToHtml(doc.getFilePath());
			}catch (Exception e){}

		}else{
			url = OfficeUtils.DocxToHtml(doc.getFilePath());
		}
		if(!url.equals("")){
			url = doc.getFileUrl().substring(0,doc.getFileUrl().lastIndexOf("/") +1) + url;
			url = url + ".html";
		}
		map.put("url",url);
		return map;
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
	public Map<String, Object> save(Document doc,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		//doc.setContent("录入批办信息!");
		doc = documentService.save(doc, request);

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
			int cnt = documentService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
					1, String.valueOf(user.getId()));
			if(cnt > 0)
			{
				ins = documentService.getIns(doc.getId(), 1);
			}else{
				ins = savewf(doc,user,1,"document/edit","document/dtl");
			}
		}*/
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}


    @ResponseBody

    @RequestMapping(value = "/save_ins", method = RequestMethod.POST)
    public Map<String, Object> save_ins(@RequestParam int docId,@RequestParam int actorId,@RequestParam String actorName,@RequestParam int type,
                                        HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Document doc = documentService.dtl(docId);
        doc.setIsPi(1);
        doc.setType(type);
        doc = documentService.save(doc, request);
        WfWorkflow flow = wfService.dtl(type);
        QueryResult<WfStep> steps = wsService.list(type);
        WfStep step = steps.getRows().get(steps.getRows().size()-1);
        WfInstance ins = new WfInstance();
        if(doc.getId() > 0)
        {
            BaseUser user = (BaseUser)SecurityUtils.getSubject()
                    .getSession().getAttribute("baseUser");
            int cnt = documentService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
                    1, String.valueOf(user.getId()));
            if(cnt > 0)
            {
                ins = documentService.getIns(doc.getId(), 1);
            }else{
                ins = saveins(doc,user.getBasePersonId(),user.getBasePersonName(),1,"创建公文","document/edit","document/dtl");
                ins.setActAt(new Date());
                ins.setYesNo("yes");
                ins = insService.save(ins,request);
            }
            cnt = documentService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
                    step.getId(), String.valueOf(actorId));
            if(cnt > 0)
            {
                ins = documentService.getIns(doc.getId(), step.getId());
            }else{
                ins = saveins(doc,actorId,actorName,step.getId(),step.getTitle(),"document/edit","document/dtl");
            }
        }
        map.put("entity", doc);
        //map.put("ins", ins);
        return map;
    }







    @ResponseBody

    @RequestMapping(value = "/act_ins", method = RequestMethod.POST)
    public Map<String, Object> act_ins(@RequestParam int docId,@RequestParam  String content,@RequestParam int insId,
                                       HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Document doc = documentService.dtl(docId);

        WfInstance cins = insService.dtl(insId);
        WfStep nwf = wsService.dtl(cins.getStepId() + 1);
        cins.setActAt(new Date());
        cins.setYesNo("yes");
        cins.setDescr(content);
        cins = insService.save(cins,request);

        if(nwf != null && nwf.getWfWorkflowId() == doc.getType()){
            WfStep ws = wsService.dtl(cins.getStepId());
            WfInstance ins = new WfInstance();
            BaseUser user = (BaseUser)SecurityUtils.getSubject()
                    .getSession().getAttribute("baseUser");
            int cnt = documentService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
                    nwf.getId(), String.valueOf(nwf.getActorId()));
            if(cnt > 0)
            {
                ins = documentService.getIns(doc.getId(), nwf.getId());
            }else{
                ins = saveins(doc,nwf.getActorId(),nwf.getActorName(),nwf.getId(),nwf.getTitle(),"document/edit","document/dtl");
            }
        }else{
            WfInstance ins = new WfInstance();
            WfInstance fins = documentService.getIns(doc.getId(),1);
            int cnt = documentService.checkInsExist(String.valueOf(doc.getDocTypeId()), doc.getId(),
                    99, String.valueOf(fins.getRecordInfo().getCreatedBy()));
            if(cnt > 0)
            {
                ins = documentService.getIns(doc.getId(), 99);
            }else{
                ins = saveins(doc,Integer.valueOf(fins.getActorId()),fins.getActorName(),99,"归档","document/edit","document/dtl");
                ins = insService.save(ins,request);
            }
        }


        map.put("entity", doc);
        //map.put("ins", ins);
        return map;
    }


    @ResponseBody

    @RequestMapping(value = "/finish_ins", method = RequestMethod.POST)
    public Map<String, Object> finish_ins(@RequestParam int docId,@RequestParam int insId,
                                          HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Document doc = documentService.dtl(docId);
        doc = documentService.save(doc, request);
        WfInstance cins = insService.dtl(insId);
        WfStep nwf = wsService.dtl(cins.getStepId() + 1);
        cins.setActAt(new Date());
        cins.setYesNo("yes");
        cins = insService.save(cins,request);


        map.put("entity", doc);
        //map.put("ins", ins);
        return map;
    }

    @ResponseBody

    @RequestMapping(value = "/du_ins", method = RequestMethod.POST)
    public Map<String, Object> du_ins(@RequestParam int docId,@RequestParam int insId,
                                          HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Document doc = documentService.dtl(docId);
        doc.setIsDu(1);
        doc = documentService.save(doc, request);
        WfInstance cins = insService.dtl(insId);
        WfStep nwf = wsService.dtl(cins.getStepId() + 1);
        cins.setIsDu(1);
        cins = insService.save(cins,request);
        int cnt = duBanService.checkExist(doc.getId());
        if (cnt == 0) {
            DuBan du = new DuBan();
            du.setColSym("YEWU");
            du.setCategory(new String("业务督办"));
            du.setDocTypeId(doc.getDocTypeId());
            du.setDocTypeName(doc.getDocTypeName());
            du.setIsActive(1);
            du.setTitle(doc.getTitle());
            du.setSym(doc.getLwbh());
            du.setRefNum(doc.getId());
            du.setChengbanchushiId("");
            du = duBanService.save(du, request);
        }
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
		Document doc = new Document();
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
		doc = documentService.save(doc,request);
		att.setRefNum(doc.getId());
		att.setApplyTo(doc.getDocTypeName());
		att = commAttachmentService.save(att,request);
		map.put("entity", doc);
		return map;
	}


	public WfInstance savewf(Document doc,BaseUser user,int stepId, String actUrl, String dtlUrl){

		WfInstance ins = new WfInstance();
		ins.setCategory(doc.getCategory());
		ins.setTitle(doc.getTitle());
		ins.setApplyTo(String.valueOf(doc.getType()));
		ins.setRefNum(doc.getId());
		//ins.setDescr(doc.getContent());
		ins.setStepId(stepId);
		ins.setStepName("创建文档！");
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

	public WfInstance saveins(Document doc,int actorId,String actorName,int stepId, String stepName,String actUrl, String dtlUrl){

		WfInstance ins = new WfInstance();
		ins.setCategory(doc.getCategory());
		ins.setTitle(doc.getTitle());
		ins.setApplyTo(String.valueOf(doc.getType()));
		ins.setRefNum(doc.getId());
		//ins.setDescr(doc.getContent());
		ins.setStepId(stepId);
		ins.setStepName(stepName);
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(String.valueOf(actorId));
		ins.setActorName(actorName);
		ins.setActUrl(actUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setListUrl("");
		ins.setOkUrl("");
		ins.setIsActive(5);
		ins.setYesNo("");
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
	public Map<String, Object> savePi(int docId,int isDu,@RequestBody PishiList wsList,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		//WfInstance ins = documentService.getIns(docId, 1);
		Document doc = documentService.dtl(docId);
		doc.setIsDu(isDu);
		//doc = documentService.save(doc,request);
		int stepId = -11;
		for (Pishi ws : wsList.getPishiList()) {
			if(!ws.getActorId().equals("") && !ws.getContent().equals("")){
				WfInstance ins = insService.getIns(docId, String.valueOf(ws.getId()));
				if(ins == null)
					ins = new WfInstance();
				ins.setCategory(doc.getCategory());
				ins.setTitle(doc.getTitle());
				ins.setApplyTo(String.valueOf(ws.getId()));
				ins.setStatus(ws.getStatus());
				ins.setRefNum(doc.getId());
				ins.setDescr(ws.getContent());
				ins.setStepId(stepId);
				ins.setStepName("文件批转");
				ins.setNextStepId(stepId);
				ins.setNextStepName("");
				ins.setActorId(ws.getActorId());
				ins.setActorName(ws.getActorName());
				ins.setActUrl("document/dtl");
				ins.setDtlUrl("document/dtl");
				ins.setListUrl("");
				ins.setOkUrl("");
				ins.setIsActive(-2);
				ins.setActAt(ws.getDate());
				ins = insService.save(ins, request);
				stepId++;
			}
		}
//		WfWorkflow wf = wfService.dtl("DOCUMENT");
//		//QueryResult<WfStep> wsList = wsService.list(wf.getId());
//		doc.setWfWorkflowId(wf.getId());
		//doc.setContent("文件批转");
		doc = documentService.save(doc, request);


//		if(doc.getIsDu() == 1){
//
//			int cnt = duBanService.checkExist(doc.getId());
//			if (cnt == 0){
//				DuBan du = new DuBan();
//				du.setColSym("YEWU");
//				du.setCategory(new String("业务督办"));
//				du.setDocTypeId(doc.getDocTypeId());
//				du.setDocTypeName(doc.getDocTypeName());
//				du.setIsActive(1);
//				du.setTitle(doc.getTitle());
//				du.setSym(doc.getLwbh());
//				du.setRefNum(doc.getId());
//
//				du = duBanService.save(du,request);
//			}

//		}




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
			ins.setApplyTo("DUBAN_YEWU");
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
	
	@RequestMapping(value = "/pizhuan")
	//@RequiresPermissions("DOCUMENT:RO")
	public String pizhuan(ModelMap map) {
		int insId = request.getParameter("insId") != null ? Integer.valueOf(request
				.getParameter("insId")) : -1 ;
		int docId = request.getParameter("docId") != null ? Integer.valueOf(request
				.getParameter("docId")) : -1 ;
		Document doc = documentService.dtl(docId);
		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");
		doc.setContent(StringEscapeUtils.unescapeHtml(doc.getContent()));
		WfWorkflow wf = wfService.dtl(doc.getType());
		QueryResult<WfStep> wsList = wsService.list(wf.getId());
		int index = 1;
		for (WfStep ws : wsList.getRows()) {
			WfInstance ins = insService.getIns(doc.getId(), String.valueOf(ws.getId()));
			if(ins != null && ins.getId() > 0)
			{
				ins.setDescr(StringEscapeUtils.unescapeHtml(ins.getDescr()));
				ws.setDescr(ins.getDescr());
				ws.setOkMsg(ins.getStatus());
				RecordInfo info = ins.getRecordInfo();
				info .setCreatedAt(ins.getActAt());
				ws.setRecordInfo(info);
			}else{
				if(index == wsList.getRows().size()){
					ws.setActorId(user.getBasePersonId());
					ws.setActorName(user.getBasePersonName());
					ws.setDescr(doc.getContent());
				}
			}
			index++;
		}
		map.addAttribute("doc", doc);
		map.addAttribute("wf", wf);
		map.addAttribute("insId",insId);
		map.addAttribute("wsList", wsList.getRows());
		
		return "/document/pizhuan";
	}
	
	@ResponseBody
	@RequestMapping(value = "/chuanyue", method = RequestMethod.POST)
	public Map<String, Object> chuanyue(String actorId, String actorName, int insId,
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
		Document doc = documentService.dtl(ins.getRefNum());
		String content = DateUtils.format(ins.getActAt(),"yyyy-MM-dd HH:mm") + "传阅[";
		
		doc.setIsFinish(1);
		int stepId = ins.getStepId() + 1;
		String[] actorIds = actorId.split(",");
		String[] actorNames = actorName.split(",");
		int len = actorIds.length;
		for(int i = 0; i < len; i++)
		{
			if(actorIds[i] != "")
			{
				WfInstance tins = new WfInstance();
				tins.setRefNum(ins.getRefNum());
				tins.setApplyTo(ins.getApplyTo());
				tins.setCategory(ins.getCategory());
				tins.setStepName("文档传阅");
				tins.setDescr("文档传阅");
				tins.setTitle(ins.getTitle());
				tins.setActUrl("document/dtl");
				tins.setDtlUrl("document/dtl");
				tins.setStepId(stepId);
				tins.setActorId(actorIds[i]);
				tins.setActorName(actorNames[i]);
				tins.setYesNo("yes");
				tins.setDescr("");
				tins.setActAt(new Date());
				tins.setRecordInfo(new RecordInfo());
				tins = insService.save(tins, request);
				content += actorNames[i];
				if(i < len - 1)
					content += ",";
			}
		}
		content += "]";
		//doc.setContent(content);
		doc = documentService.save(doc, request);
		map.put("result", "success");
		return map;
	}
	@ResponseBody
	@RequestMapping(value = "/actdoc", method = RequestMethod.POST)
	public Map<String, Object> actdoc(WfInstance ins,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		ins.setYesNo("yes");
		ins.setActAt(new Date());
		ins = insService.save(ins, request);
		WfInstance tins = (WfInstance) ins.clone();
		tins.setActAt(null);
		tins.setDescr("");
		tins.setYesNo("");
		tins.setStepId(ins.getStepId() + 1);
		tins.setActorId(String.valueOf(ins.getRecordInfo().getCreatedByUser()));
		tins.setActorName(ins.getRecordInfo().getCreatedByName());
		tins.setId(0);
		tins = insService.save(tins, request);
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
		Document doc = documentService.dtl(ins.getRefNum());
		doc.setIsFinish(1);
		doc = documentService.save(doc, request);
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
		documentService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/delIns", method = RequestMethod.POST)
	public Map<String, Object> delIns(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int refNum = Integer.valueOf(request.getParameter("refNum"));
		map.put("IsSuccess", true);
		documentService.del(refNum);
		documentService.delByRefNum(refNum);
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
