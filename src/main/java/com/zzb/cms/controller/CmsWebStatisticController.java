package com.zzb.cms.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.cms.service.CmsWebStatisticService;
import com.zzb.core.baseclass.BaseController;

/**
 * 外网用户统计分析
 * @author
 * @createdAt 2016年9月5日
 */
@Controller
@RequestMapping("/cms/webStatistic")
public class CmsWebStatisticController extends BaseController{
	@Resource
	private CmsWebStatisticService cmsWebStatisticService;
	/**
	 * 构造函数
	 */
	public CmsWebStatisticController() {}
	
	/**
	 * 用户管理统计页面
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/webUser")
	public String webUser(HttpServletRequest request, ModelMap map) {
		return "/cms/webStatistic/webUser";
	}
	
	/**
	 * 留言板统计页面
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/gustBook")
	public String gustBook(HttpServletRequest request, ModelMap map) {
		return "/cms/webStatistic/gustBook";
	}
	/**
	 * 用户管理统计
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/webuserCount")
	public List<Object> webuserCount(HttpServletRequest request) {
		return cmsWebStatisticService.webuserCounttj(request);
	}
	
	/**
	 * 留言板统计
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/gustBookCount")
	public List<Object> gustBookCount(HttpServletRequest request) {
		return cmsWebStatisticService.gustBookCounttj(request);
	}
	

}
