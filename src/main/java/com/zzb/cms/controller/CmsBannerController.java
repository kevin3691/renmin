package com.zzb.cms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsNewsService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * Controller Banner 横幅广告
 * 
 * 
 * @CreatedAt 2016年09月02日
 */
@Controller
@RequestMapping("/cms/banner")
public class CmsBannerController extends BaseController {
	@Resource
	private CmsNewsService cmsNewsService;

	/**
	 * 构造函数
	 */
	public CmsBannerController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/cms/banner/index";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String template = request.getParameter("template") != null ? request
				.getParameter("template") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		CmsNews news = new CmsNews();
		news.setColSym(colSym);
		news.setColTitle(colTitle);
		if (id > 0) {
			news = cmsNewsService.dtl(id);
		}
		map.addAttribute("o", news);
		return "/cms/banner/edit";
	}

	/**
	 * 获取列表数据 list
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CmsNews> list(CmsNews news, HttpServletRequest request) {
		return cmsNewsService.list(request);
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CmsNews news, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		news = cmsNewsService.save(news, request);
		if (news.getLineNo() == 0) {
			news.setLineNo(news.getId());
			cmsNewsService.save(news, request);
		}
		map.put("entity", news);
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
		cmsNewsService.del(id);
		return map;
	}

	// 排序
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String order = request.getParameter("order") != null ? request
				.getParameter("order") : "";
		map.put("IsSuccess", true);
		cmsNewsService.sort(id, colSym, order);
		return map;
	}

	/**
	 * 接收并设置参数
	 * 
	 * @param request
	 * @param map
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String returnUrl = request.getParameter("returnUrl") != null ? request
				.getParameter("returnUrl") : "";
		map.addAttribute("colSym", colSym);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("returnUrl", returnUrl);
	}

}