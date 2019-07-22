package com.zzb.cms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
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
 * Controller 新闻
 * 
 * @author 
 * @CreatedAt 2016年08月26日
 */
@Controller
@RequestMapping("/cms/news")
public class CmsNewsController extends BaseController {
	@Resource
	private CmsNewsService cmsNewsService;

	/**
	 * 构造函数
	 */
	public CmsNewsController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/cms/news/index";
	}

	/**
	 * View 审核页 audit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/audit")
	public String audit(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/cms/news/audit";
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
			news.setContent(StringEscapeUtils.unescapeHtml(news.getContent()));
		}
		map.addAttribute("o", news);
		return "/cms/news/edit";
	}

	/**
	 * View 详细页 dtl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dtl")
	public String dtl(HttpServletRequest request, ModelMap map) {
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
			news.setContent(StringEscapeUtils.unescapeHtml(news.getContent()));
		}
		map.addAttribute("o", news);
		return "/cms/news/dtl";
	}

	/**
	 * View 文档页 article
	 * 
	 * @return
	 */
	@RequestMapping(value = "/article")
	public String article(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String template = request.getParameter("template") != null ? request
				.getParameter("template") : "";
		CmsNews news = cmsNewsService.dtl(colSym, "");
		news.setContent(StringEscapeUtils.unescapeHtml(news.getContent()));
		news.setColSym(colSym);
		news.setColTitle(colTitle);
		map.addAttribute("o", news);
		return "/cms/news/article";
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
		news.setContent(StringEscapeUtils.unescapeHtml(news.getContent()));
		news = cmsNewsService.save(news, request);
		if (news.getLineNo() == 0) {
			news.setLineNo(news.getId());
			cmsNewsService.save(news, request);
		}
		map.put("entity", news);
		// 请求生成静态页
		WebApplicationContext wac = ContextLoader
				.getCurrentWebApplicationContext();
		ICmsStaticService st = (ICmsStaticService) wac
				.getBean("cmsStaticService");
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("template", news.getTemplate());
		para.put("colSym", news.getColSym());
		para.put("colTitle", news.getColTitle());
		para.put("flag", "save");
		para.put("news", news);
		st.handler(para);
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
		CmsNews news = cmsNewsService.dtl(id);
		map.put("IsSuccess", true);
		cmsNewsService.del(id);

		// 请求生成静态页
		WebApplicationContext wac = ContextLoader
				.getCurrentWebApplicationContext();
		ICmsStaticService st = (ICmsStaticService) wac
				.getBean("cmsStaticService");
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("template", news.getTemplate());
		para.put("colSym", news.getColSym());
		para.put("colTitle", news.getColTitle());
		para.put("news", news);
		para.put("flag", "del");
		st.handler(para);

		return map;
	}

	/**
	 * 修改数据
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Map<String, Object> update(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		CmsNews news = cmsNewsService.update(request);
		// 请求生成静态页
		WebApplicationContext wac = ContextLoader
				.getCurrentWebApplicationContext();
		ICmsStaticService st = (ICmsStaticService) wac
				.getBean("cmsStaticService");
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("template", news.getTemplate());
		para.put("colSym", news.getColSym());
		para.put("colTitle", news.getColTitle());
		para.put("news", news);
		para.put("flag", "update");
		st.handler(para);

		map.put("IsSuccess", true);
		return map;
	}

	/**
	 * 接收并设置参数
	 * 
	 * @param request
	 * @param map
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		String template = request.getParameter("template") != null ? request
				.getParameter("template") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String returnUrl = request.getParameter("returnUrl") != null ? request
				.getParameter("returnUrl") : "";
		map.addAttribute("template", template);
		map.addAttribute("colSym", colSym);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("returnUrl", returnUrl);
	}

}