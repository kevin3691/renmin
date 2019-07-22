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

import com.zzb.cms.entity.CmsGustBook;
import com.zzb.cms.service.CmsGustBookService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
/**
 * 留言板
 * @author
 * @createdAt 2016年9月3日
 */
@Controller
@RequestMapping("/cms/gustBook")
public class CmsGustBookController extends BaseController {
	@Resource
	private CmsGustBookService cmsGustBookService;
	
	/**
	 * 构造函数
	 */
	public CmsGustBookController() {
	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		map.put("title", title);
		map.put("name", name);
		return "/cms/gustBook/index";
	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/nIndex")
	public String nIndex(HttpServletRequest request, ModelMap map) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		map.put("title", title);
		map.put("name", name);
		return "/cms/gustBook/nIndex";
	}
	
	/**
	 * 获取列表数据 list 
	 * 
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CmsGustBook> list(HttpServletRequest request) {
		QueryResult<CmsGustBook> rslt = cmsGustBookService.list(request);
		return rslt;
	}
	
	/**
	 * 编辑页面
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		CmsGustBook cmsGustBook = new CmsGustBook();
		if (id > 0) {
			cmsGustBook = cmsGustBookService.dtl(id);
		}
		map.addAttribute("o", cmsGustBook);
		return "/cms/gustBook/edit";
	}
	
	/**
	 * 增加/编辑
	 * @param cmsWebUser
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CmsGustBook cmsGustBook,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cmsGustBook = cmsGustBookService.save(cmsGustBook, request);
		map.put("entity", cmsGustBook);
		return map;
	}
	/**
	 * 修改公开状态
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateDisplay", method = RequestMethod.POST)
	public Map<String, Object> updateDisplay(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		cmsGustBookService.updateDisplay(request);
		return map;
	}

	
	/**
	 * 详情
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/dtl")
	public String dtl(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		CmsGustBook cmsGustBook = new CmsGustBook();
		if (id > 0) {
			cmsGustBook = cmsGustBookService.dtl(id);
		}
		map.addAttribute("o", cmsGustBook);
		return "/cms/gustBook/dtl";
	}
	
	
	
}
