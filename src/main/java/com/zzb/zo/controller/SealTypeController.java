package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.Goods;
import com.zzb.zo.entity.SealType;
import com.zzb.zo.service.GoodsService;
import com.zzb.zo.service.SealTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/sealtype")
public class SealTypeController extends BaseController {

	@Resource
	private SealTypeService sealTypeService;

	@Resource
	private GoodsService goodService;

	/**
	 * ���캯��
	 */
	public SealTypeController() {
	}

	/**
	 * View �б�ҳ index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index() {
		return "/sealtype/index";
	}
	

	/**
	 * View ���б�  Ϊ����ģ���ṩ��������
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {
		return "/sealtype/list4";
	}


	/**
	 * View ��ӡ��༭ҳ edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("BASE_USER:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		SealType org = new SealType();
		if (id > 0) {
			org = sealTypeService.dtl(id);
		}

		model.addAttribute("o", org);
		return "/sealtype/edit";
	}

	/**
	 * View ѡ��ҳ sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/sealtype/sel";
	}

	/**
	 * View ��ѡҳ multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/sealtype/multiSel";
	}

	/**
	 * ��ȡ�б����� list
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<SealType> list(HttpServletRequest request) {
		QueryResult<SealType> rslt = sealTypeService.list(request);
		return rslt;
	}


	/**
	 * �������ݣ���ӡ��༭������
	 * 
	 * @param org
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(SealType org, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(org.getId() > 0)
		{
			org = sealTypeService.save(org, request);

			map.put("entity", org);
		}else{
			int cnt = sealTypeService.checkExist(org.getName());
			if (cnt == 0) {
				org = sealTypeService.save(org, request);
				map.put("entity", org);
			} else {
				map.put("error", "�������Ѿ�����");
			}
		}
		
		
		return map;
	}

	/**
	 * ɾ������
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
		sealTypeService.del(id);
		return map;
	}

	/**
	 * ����
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
		sealTypeService.sort(id, order);
		return map;
	}

}
