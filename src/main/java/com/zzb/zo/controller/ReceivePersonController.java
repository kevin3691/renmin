package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.ReceivePerson;
import com.zzb.zo.entity.Document;
import com.zzb.zo.service.ReceivePersonService;
import com.zzb.zo.service.DocumentService;
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
@RequestMapping("/rp")
public class ReceivePersonController extends BaseController {

	@Resource
	private ReceivePersonService receivePersonService;
	
	@Resource
	private DocumentService documentService;

	/**
	 * ���캯��
	 */
	public ReceivePersonController() {
	}

	/**
	 * View �б�ҳ index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index() {
		return "/rp/index";
	}
	

	/**
	 * View ���б�  Ϊ����ģ���ṩ��������
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {
		return "/rp/list4";
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
		ReceivePerson receivePerson = new ReceivePerson();
		if (id > 0) {
			receivePerson = receivePersonService.dtl(id);
		}
		
		model.addAttribute("o", receivePerson);
		return "/rp/edit";
	}

	/**
	 * View ѡ��ҳ sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/rp/sel";
	}

	/**
	 * View ��ѡҳ multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/rp/multiSel";
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
	public QueryResult<ReceivePerson> list(HttpServletRequest request) {
		QueryResult<ReceivePerson> rslt = receivePersonService.list(request);

		return rslt;
	}


	/**
	 * �������ݣ���ӡ��༭������
	 * 
	 * @param receivePerson
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(ReceivePerson receivePerson, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		receivePerson = receivePersonService.save(receivePerson, request);
		map.put("entity", receivePerson);

		
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
		receivePersonService.del(id);
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
		receivePersonService.sort(id, order);
		return map;
	}

}
