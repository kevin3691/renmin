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

import com.zzb.cms.entity.CmsLink;
import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsLinkService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * Controller 链接
 * 
 * @author 
 * @CreatedAt 2016年08月26日
 */
@Controller
@RequestMapping("/cms/link")
public class CmsLinkController extends BaseController {
	@Resource
	private CmsLinkService cmsLinkService;

	/**
	 * 构造函数
	 */
	public CmsLinkController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/cms/link/index";
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
		CmsLink link = new CmsLink();
		link.setColSym(colSym);
		link.setColTitle(colTitle);
		if (id > 0) {
			link = cmsLinkService.dtl(id);
		}
		map.addAttribute("o", link);
		return "/cms/link/edit";
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
	public QueryResult<CmsLink> list(CmsLink link, HttpServletRequest request) {
		return cmsLinkService.list(request);
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
	public Map<String, Object> save(CmsLink link, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		link = cmsLinkService.save(link, request);
		if (link.getLineNo() == 0) {
			link.setLineNo(link.getId());
			cmsLinkService.save(link, request);
		}
		map.put("entity", link);
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
		cmsLinkService.del(id);
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
		map.addAttribute("colSym", colSym);
		map.addAttribute("colTitle", colTitle);
	}

}
