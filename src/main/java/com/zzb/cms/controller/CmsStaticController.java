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
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsNewsService;
import com.zzb.cms.service.ICmsStaticService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * Controller 生成静态页
 * 
 * 
 * @CreatedAt 2016年08月04日
 */
@Controller
@RequestMapping("/cms/static")
public class CmsStaticController extends BaseController {
	/**
	 * 构造函数
	 */
	public CmsStaticController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		String template = request.getParameter("template") != null ? request
				.getParameter("template") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		map.addAttribute("template", template);
		map.addAttribute("colSym", colSym);
		map.addAttribute("colTitle", colTitle);
		return "/cms/static/index";
	}

	/**
	 * 执行生成静态页
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/handler", method = RequestMethod.POST)
	public Map<String, Object> handler(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String template = request.getParameter("template") != null ? request
				.getParameter("template") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colSym") : "";
		String flag = request.getParameter("flag") != null ? request
				.getParameter("flag") : "";
		// 请求生成静态页
		WebApplicationContext wac = ContextLoader
				.getCurrentWebApplicationContext();
		ICmsStaticService st = (ICmsStaticService) wac
				.getBean("cmsStaticService");
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("template", template);
		para.put("colSym", colSym);
		para.put("flag", flag);
		st.handler(para);

		map.put("IsSuccess", true);
		return map;
	}

}