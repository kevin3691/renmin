package com.zzb.base.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.zo.entity.Document;
import com.zzb.zo.entity.ReceivePerson;
import com.zzb.zo.service.DocumentService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BasePerson;
import com.zzb.base.service.BasePersonService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/base/person")
public class BasePersonController extends BaseController {
	@Resource
	private BasePersonService basePersonService;

	@Resource
	private DocumentService documentService;
	/**
	 * 构造函数
	 */
	public BasePersonController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_PERSON:RO")
	public String index(ModelMap map) {
		return "/base/person/index";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_PERSON:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		BasePerson person = new BasePerson();
		if (id > 0) {
			person = basePersonService.dtl(id);
		}
		model.addAttribute("o", person);
		return "/base/person/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/base/person/sel";
	}


	@RequestMapping(value = "/sel4doc")
	public String sel4doc(HttpServletRequest request, ModelMap model) {
		int docId = request.getParameter("docId") != null ? Integer.valueOf(request
				.getParameter("docId")) : 0;
		Document doc = new Document();
		if (docId > 0) {
			doc = documentService.dtl(docId);
		}
		ReceivePerson rp = new ReceivePerson();
		rp.setRefNum(docId);
		rp.setDocId(docId);
		rp.setDocTitle(doc.getTitle());
		rp.setReciveDate(new Date());
		rp.setApplyTo("LJR");
		rp.setIsActive(1);
		model.addAttribute("doc", doc);
		model.addAttribute("o", rp);
		return "/base/person/sel4doc";
	}

	/**
	 * View 选择页 simpleSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleSel")
	public String simpleSel(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/base/person/simpleSel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/base/person/multiSel";
	}

	/**
	 * View 选择页 simpleMultiSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleMultiSel")
	public String multiSel(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/base/person/simpleMultiSel";
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
	public QueryResult<BasePerson> list(HttpServletRequest request) {
		QueryResult<BasePerson> rslt = basePersonService.list(request);
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
	public Map<String, Object> save(BasePerson person,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		person = basePersonService.save(person, request);
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
		basePersonService.del(id);
		return map;
	}

	/**
	 * 排序
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order");
		map.put("IsSuccess", true);
		basePersonService.sort(id, order);
		return map;
	}

	/**
	 * 接收并设置参数
	 * 
	 * @param request
	 * @param map
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		int baseOrgId = request.getParameter("baseOrgId") != null ? Integer
				.valueOf(request.getParameter("baseOrgId")) : 0;
		String baseOrgName = request.getParameter("baseOrgName") != null ? request
				.getParameter("baseOrgName") : "";
		map.addAttribute("baseOrgId", baseOrgId);
		map.addAttribute("baseOrgName", baseOrgName);
	}

}
