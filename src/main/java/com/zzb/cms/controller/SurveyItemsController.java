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

import com.zzb.cms.entity.SurveyItems;
import com.zzb.cms.entity.SurveyTopics;
import com.zzb.cms.service.SurveyItemsService;
import com.zzb.cms.service.SurveyTopicsService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * 
 * @author
 *
 */
@Controller
@RequestMapping("/cms/surveyItems")
public class SurveyItemsController extends BaseController {
	@Resource
	private SurveyItemsService surveyItemsService;
	@Resource
	private SurveyTopicsService surveyTopicsService;
	/**
	 * 构造函数
	 */
	public SurveyItemsController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap map) {
		return "/cms/surveyItems/index";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		SurveyItems person = new SurveyItems();
		if (id > 0) {
			person = surveyItemsService.dtl(id);
		}
		else
		{
			String topicId = request.getParameter("topicId"); 
			if (topicId != null && !topicId.equals("")) //说明点击了页面左侧的调查主题列表
			{
				int topic = Integer.parseInt(topicId);
				SurveyTopics dtl = surveyTopicsService.dtl(topic);
				person.setTopicId(topic);
				person.setTopicTitle(dtl.getTopicTitle());
			}
		}
		model.addAttribute("o", person);
		return "/cms/surveyItems/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/cms/surveyItems/sel";
	}

	/**
	 * View 选择页 simpleSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleSel")
	public String simpleSel(HttpServletRequest request, ModelMap map) {
		return "/cms/surveyItems/simpleSel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/cms/surveyItems/multiSel";
	}

	/**
	 * View 选择页 simpleMultiSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleMultiSel")
	public String multiSel(HttpServletRequest request, ModelMap map) {
		return "/base/person/simpleMultiSel";
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
	public QueryResult<SurveyItems> list(HttpServletRequest request) {
		QueryResult<SurveyItems> rslt = surveyItemsService.list(request);
		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param person
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(SurveyItems person,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		person = surveyItemsService.save(person, request);
		map.put("entity", person);
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
		surveyItemsService.del(id);
		return map;
	}
}
