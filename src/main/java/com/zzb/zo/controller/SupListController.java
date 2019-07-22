/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.service.BaseUserService;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.Goods;
import com.zzb.zo.entity.SupList;
import com.zzb.zo.service.GoodsService;
import com.zzb.zo.service.SupListService;
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

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/goods/suplist")
public class SupListController extends BaseController {
	@Resource
	private SupListService supListService;

	@Resource
	private GoodsService goodsService;


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
	String destDir = "upload/goods/suplist/";
	
	/**
	 * 构造函数
	 */
	public SupListController() {

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

		return "/goods/suplist/index";
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

		return "/goods/suplist/index4";
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
		int refNum = request.getParameter("refNum") != null ? Integer.valueOf(request
				.getParameter("refNum")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		SupList cash = new SupList();
		if (id > 0) {
			cash = supListService.dtl(id);
		}
		setPara(request, model);
		Goods goods = goodsService.dtl(cash.getRefNum());
		model.addAttribute("goods", goods);
		model.addAttribute("o", cash);
		String url = "/goods/suplist/edit";
		return url;
	}


	@RequestMapping(value = "/edit4")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit4(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer.valueOf(request
				.getParameter("refNum")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		SupList cash = new SupList();
		if (id > 0) {
			cash = supListService.dtl(id);
		}
		setPara(request, model);
		Goods goods = goodsService.dtl(cash.getRefNum());
		model.addAttribute("goods", goods);
		model.addAttribute("o", cash);
		String url = "/goods/suplist/edit4";
		return url;
	}

	@RequestMapping(value = "/buy")
	//@RequiresPermissions("DOCUMENT:RW")
	public String buy(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer.valueOf(request
				.getParameter("refNum")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Goods goods = goodsService.dtl(refNum);
		SupList cash = new SupList();
		if (id > 0) {
			cash = supListService.dtl(id);
		}else{
			cash.setRefNum(refNum);
			cash.setSym(goods.getCategory());
			cash.setType(0);
		}
		setPara(request, model);
		model.addAttribute("goods", goods);
		model.addAttribute("o", cash);
		String url = "/goods/suplist/buy";
		return url;
	}
	@RequestMapping(value = "/sell")
	//@RequiresPermissions("DOCUMENT:RW")
	public String sell(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer.valueOf(request
				.getParameter("refNum")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Goods goods = goodsService.dtl(refNum);
		SupList cash = new SupList();
		if (id > 0) {
			cash = supListService.dtl(id);
		}else{
			cash.setRefNum(refNum);
			cash.setSym(goods.getCategory());
			cash.setType(1);
		}
		setPara(request, model);
		model.addAttribute("goods", goods);
		model.addAttribute("o", cash);
		String url = "/goods/suplist/sell";
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
	public QueryResult<SupList> list(HttpServletRequest request) {
		QueryResult<SupList> rslt = supListService.list(request);

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
	public Map<String, Object> save(SupList doc,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();


		doc = supListService.save(doc, request);
		Goods goods = goodsService.dtl(doc.getRefNum());
		if(doc.getType() == 0){
			goods.setTotal(goods.getTotal() + doc.getNum());
			goods.setQuanity(goods.getQuanity()+ doc.getNum());
		}
		if(doc.getType() == 1){
			goods.setQuanity(goods.getQuanity()- doc.getNum());
		}
		goods = goodsService.save(goods,request);
		map.put("entity", doc);
		//map.put("ins", ins);
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
		supListService.del(id);
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
