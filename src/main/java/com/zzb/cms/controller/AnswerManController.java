package com.zzb.cms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.cms.entity.AnswerMan;
import com.zzb.cms.service.AnswerManService;
import com.zzb.cms.service.SurveyItemsService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * 
 * @author
 *
 */
@Controller
@RequestMapping("/cms/answerMan")
public class AnswerManController extends BaseController {
	@Resource
	private AnswerManService answerManService;
	@Resource
	private SurveyItemsService surveyItemsService;

	/**
	 * 构造函数
	 */
	public AnswerManController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap map) {
		return "/cms/answerMan/index";
	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/mainIndex")
	public String mainIndex(@RequestParam(value="itemId")int itemId,  ModelMap map) {
		map.addAttribute("itemId", itemId);
		return "/cms/answerMan/mainIndex";
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
		int itemId = Integer.valueOf(request.getParameter("itemId")); //调查项id
		AnswerMan person = new AnswerMan();
		if (id > 0) {
			person = answerManService.dtl(id);
		}
		model.addAttribute("o", person);
		
		model.addAttribute("item", surveyItemsService.dtl(itemId));
		return "/cms/answerMan/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/cms/answerMan/sel";
	}

	/**
	 * View 选择页 simpleSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleSel")
	public String simpleSel(HttpServletRequest request, ModelMap map) {
		return "/cms/answerMan/simpleSel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/cms/answerMan/multiSel";
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
	public QueryResult<AnswerMan> list(HttpServletRequest request) {
		QueryResult<AnswerMan> rslt = answerManService.list(request);
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
	public Map<String, Object> save(AnswerMan person,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		person = answerManService.save(person, request);
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
		answerManService.del(id);
		return map;
	}
}
