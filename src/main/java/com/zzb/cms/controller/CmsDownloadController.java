package com.zzb.cms.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsNewsService;
import com.zzb.core.baseclass.BaseController;

/**
 * Controller 下载
 * 
 * @author 
 * @CreatedAt 2016年08月31日
 */
@Controller
@RequestMapping("/cms/download")
public class CmsDownloadController extends BaseController {

	@Resource
	private CmsNewsService cmsNewsService;

	/**
	 * 构造函数
	 */
	public CmsDownloadController() {

	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/cms/download/index";
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
		return "/cms/download/edit";
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
