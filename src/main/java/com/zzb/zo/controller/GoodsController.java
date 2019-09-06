package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goods")
public class GoodsController extends BaseController {
	@Resource
	private GoodsService goodsService;

	@Resource
	private GoodsRecordService goodsRecordService;
	@Resource
	private GoodTypeService goodTypeService;

	@Resource
	private GoodPlanService goodPlanService;

	@Resource
	private GoodPlanListService goodPlanListService;

	@Resource
	private GPListService gpListService;

	@Resource
	private SupListService supListService;


	@Resource
	private DocumentService documentService;

	/**
	 * 构造函数
	 */
	public GoodsController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String index(ModelMap map) {
		return "/goods/index";
	}

	@RequestMapping(value = "/record")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String record(ModelMap map) {
		return "/goods/record";
	}


	@RequestMapping(value = "/index4")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String index4(ModelMap map) {
		return "/goods/index4";
	}

	@RequestMapping(value = "/plan")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String plan(ModelMap map) {
		return "/goods/plan";
	}


	@RequestMapping(value = "/plan2")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String plan2(ModelMap map) {
		return "/goods/plan2";
	}

	@RequestMapping(value = "/planlist")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String planlist(ModelMap map) {
		return "/goods/planlist";
	}

	@RequestMapping(value = "/planlist2")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String planlist2(ModelMap map) {
		return "/goods/planlist2";
	}

	@RequestMapping(value = "/planlistall")
	//@RequiresPermissions("BASE_PERSON:RO")
	public String planlistall(ModelMap map) {
		return "/goods/planlistall";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int goodTypeId = request.getParameter("goodTypeId") != null ? Integer.valueOf(request
				.getParameter("goodTypeId")) : 0;
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}else {
			if(goodTypeId > 0)
			{
				GoodType type = goodTypeService.dtl(goodTypeId);
				goods.setType(type.getName());
				goods.setTypeId(type.getId());
			}
			goods.setCategory(colSym);

		}
		//setPara(request, model);
		model.addAttribute("o", goods);
		return "/goods/edit";
	}

	/**
	 * View 打印页 print
	 *
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/print")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String print(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		/*
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int goodTypeId = request.getParameter("goodTypeId") != null ? Integer.valueOf(request
				.getParameter("goodTypeId")) : 0;
		*/
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}
		model.addAttribute("o", goods);
		return "/goods/print";
	}
	/**
	 * View 打印页 print
	 *
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/print2")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String print2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}
		model.addAttribute("o", goods);
		return "/goods/print2";
	}

	@RequestMapping(value = "/erWeiMa")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String erWeiMa(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}
		model.addAttribute("o", goods);
		return "/goods/erWeiMa";
	}
	@RequestMapping(value = "/erWeiMa2")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String erWeiMa2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}
		model.addAttribute("o", goods);
		return "/goods/erWeiMa2";
	}
	@RequestMapping(value = "/edit4")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String edit4(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int goodTypeId = request.getParameter("goodTypeId") != null ? Integer.valueOf(request
				.getParameter("goodTypeId")) : 0;
		Goods goods = new Goods();
		if (id > 0) {
			goods = goodsService.dtl(id);
		}else {
			GoodType type = goodTypeService.dtl(goodTypeId);
			goods.setCategory(colSym);
			goods.setType(type.getName());
			goods.setTypeId(type.getId());
		}
		setPara(request, model);
		model.addAttribute("o", goods);
		return "/goods/edit4";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/goods/sel";
	}

	@RequestMapping(value = "/selplan")
	public String selplan() {
		return "/goods/selplan";
	}

	/**
	 * View 选择页 simpleSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleSel")
	public String simpleSel(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/goods/simpleSel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/goods/multiSel";
	}

	/**
	 * View 选择页 simpleMultiSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleMultiSel")
	public String multiSel(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		return "/goods/simpleMultiSel";
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
	public QueryResult<Goods> list(HttpServletRequest request) {
		QueryResult<Goods> rslt = goodsService.list(request);
		return rslt;
	}

	/**
	 * 获取领用记录列表数据 list
	 *
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/recordList")
	public QueryResult<GoodsRecord> recordList(HttpServletRequest request) {
		QueryResult<GoodsRecord> rslt = goodsRecordService.list(request);
		return rslt;
	}

	@ResponseBody
	@RequestMapping(value = "/getInfo")
	public Map<String, Object> getInfo(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int docCount = documentService.getDocCount(0);
		int docPiCount = documentService.getDocCount(1);
		int docDuCount = documentService.getDocCount(2);
		int docFinishCount = documentService.getDocCount(3);
		map.put("docCount", docCount);
		map.put("docPiCount", docPiCount);
		map.put("docDuCount", docDuCount);
		map.put("docFinishCount", docFinishCount);
		return map;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param goods
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(Goods goods,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		goods = goodsService.save(goods, request);
		if(goods.getStatus().equals("领出")){
			GoodsRecord goodsRecord = new GoodsRecord(goods.getId(),goods.getName(),goods.getSpec(),goods.getType(),goods.getTypeId(),goods.getSn(),
					goods.getUnit(),goods.getKeeper(),goods.getKeeperId(),goods.getLocation(),goods.getPrice(),goods.getOrg(),goods.getOrgId(),
					goods.getCategory(),goods.getCategoryId(),goods.getStartdt());
			saveRecord(goodsRecord,request);
		}
		map.put("entity", goods);
		return map;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 *
	 * @param goodsRecord
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveRecord", method = RequestMethod.POST)
	public Map<String, Object> saveRecord(GoodsRecord goodsRecord,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		goodsRecord = goodsRecordService.save(goodsRecord, request);
		map.put("entity", goodsRecord);
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
		goodsService.del(id);
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
		goodsService.sort(id, order);
		return map;
	}

	/**
	 * 接收并设置参数
	 * 
	 * @param request
	 * @param map
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		int typeId = request.getParameter("typeId") != null ? Integer
				.valueOf(request.getParameter("typeId")) : 0;
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		map.addAttribute("typeId", typeId);
		map.addAttribute("type", type);
	}




	@ResponseBody
	@RequestMapping(value = "/listGoodPlan")
	public QueryResult<GoodPlan> listGoodPlan(HttpServletRequest request) {
		QueryResult<GoodPlan> rslt = goodPlanService.list(request);
		return rslt;
	}

	@ResponseBody
	@RequestMapping(value = "/listGoodPlanList")
	public QueryResult<GoodPlanList> listGoodPlanList(HttpServletRequest request) {
		QueryResult<GoodPlanList> rslt = goodPlanListService.list(request);
		return rslt;
	}

	@RequestMapping(value = "/editPlan")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String editPlan(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlan goodPlan = new GoodPlan();
		if (id > 0) {
			goodPlan = goodPlanService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlan);
		return "/goods/editPlan";
	}


	@RequestMapping(value = "/editPlanList")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String editPlanList(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlanList goodPlanList = new GoodPlanList();
		if (id > 0) {
			goodPlanList = goodPlanListService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlanList);
		return "/goods/editPlanList";
	}


	@RequestMapping(value = "/viewPlanList")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String viewPlanList(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlanList goodPlanList = new GoodPlanList();
		if (id > 0) {
			goodPlanList = goodPlanListService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlanList);
		return "/goods/viewPlanList";
	}

	@RequestMapping(value = "/viewPlanList2")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String viewPlanList2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlanList goodPlanList = new GoodPlanList();
		if (id > 0) {
			goodPlanList = goodPlanListService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlanList);
		return "/goods/viewPlanList2";
	}



	@RequestMapping(value = "/viewPlan")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String viewPlan(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlan goodPlan = new GoodPlan();
		if (id > 0) {
			goodPlan = goodPlanService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlan);
		return "/goods/viewPlan";
	}



	@RequestMapping(value = "/auditPlan")
	//@RequiresPermissions("BASE_PERSON:RW")
	public String auditPlan(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlan goodPlan = new GoodPlan();
		if (id > 0) {
			goodPlan = goodPlanService.dtl(id);
		}
		setPara(request, model);
		model.addAttribute("o", goodPlan);
		return "/goods/auditPlan";
	}

	@ResponseBody
	@RequestMapping(value = "/savePlan", method = RequestMethod.POST)
	public Map<String, Object> savePlan(GoodPlan goodPlan,
										HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		goodPlan = goodPlanService.save(goodPlan, request);
		map.put("entity", goodPlan);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/updatePlan", method = RequestMethod.POST)
	public Map<String, Object> updatePlan(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String ids = request.getParameter("ids") != null ? String.valueOf(request
				.getParameter("ids")) : "";
		int status = request.getParameter("status") != null ? Integer.valueOf(request
				.getParameter("status")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer.valueOf(request
				.getParameter("refNum")) : 0;
		for (String str : ids.split(",")){
			int id = Integer.valueOf(str);
			GoodPlan plan = goodPlanService.dtl(id);
			plan.setStatus(status);
			if(refNum > 0){
				plan.setRefNum(refNum);
			}
			plan = goodPlanService.save(plan, request);
		}

		map.put("entity", "");
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/finishPlanList", method = RequestMethod.POST)
	public Map<String, Object> finishPlanList(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		GoodPlanList plan = goodPlanListService.dtl(id);
		plan.setIsActive(2);
		plan = goodPlanListService.save(plan,request);

		map.put("entity", plan);
		return map;
	}


	@ResponseBody
	@RequestMapping(value = "/savePlanList", method = RequestMethod.POST)
	public Map<String, Object> savePlanList(GoodPlanList goodPlanList,
											HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		goodPlanList = goodPlanListService.save(goodPlanList, request);
		map.put("entity", goodPlanList);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/submitPlanList", method = RequestMethod.POST)
	public Map<String, Object> submitPlanList(HttpServletRequest request) {
		int id = Integer.valueOf(request.getParameter("id"));
		String ids = request.getParameter("ids") != null ? String.valueOf(request
				.getParameter("ids")) : "";
		Map<String, Object> map = new HashMap<String, Object>();
		GoodPlanList plan = goodPlanListService.dtl(id);
		plan.setIsActive(1);
		plan = goodPlanListService.save(plan, request);
		for (String str : ids.split(",")){
			int pid = Integer.valueOf(str);
			GoodPlan p = goodPlanService.dtl(pid);
			p.setIsSel(1);
			p.setRefNum(id);
			p = goodPlanService.save(p, request);
		}
		map.put("entity", plan);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/saveAuditPlan", method = RequestMethod.POST)
	public Map<String, Object> saveAuditPlan(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		int flag = Integer.valueOf(request.getParameter("flag"));
		GoodPlan plan = goodPlanService.dtl(id);
		plan.setIsActive(flag);
		if(flag == 1){
			plan.setStatus(1);
		}
		plan = goodPlanService.save(plan,request);
		map.put("IsSuccess", true);
		return map;
	}


	@ResponseBody
	@RequestMapping(value = "/delPlan", method = RequestMethod.POST)
	public Map<String, Object> delPlan(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		goodPlanService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/delPlanList", method = RequestMethod.POST)
	public Map<String, Object> delPlanList(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		goodPlanListService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/saveGPList", method = RequestMethod.POST)
	public Map<String, Object> saveGPList(@RequestBody GPL plans,
										  HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (GPList gpl : plans.getPlans()){

			gpl = gpListService.save(gpl,request);
		}
//        goodPlan = goodPlanService.save(goodPlan, request);
		map.put("entity", "");
		return map;
	}


	@ResponseBody
	@RequestMapping(value = "/buyGPList", method = RequestMethod.POST)
	public Map<String, Object> buyGPList(@RequestBody GPL plans,
										  HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (GPList gpl : plans.getPlans()){
			Goods goods = goodsService.dtl(gpl.getGoodId());
			SupList cash = new SupList();
			cash.setRefNum(goods.getId());
			cash.setSym(goods.getCategory());
			cash.setSupdate(new Date());
			cash.setNum(gpl.getNum());
			cash.setType(0);
			cash.setPrice(gpl.getPrice());
			goods.setTotal(goods.getTotal() + gpl.getNum());
			goods.setQuanity(goods.getQuanity()+ gpl.getNum());
			goods = goodsService.save(goods,request);
			cash = supListService.save(cash,request);
		}
//        goodPlan = goodPlanService.save(goodPlan, request);
		map.put("entity", "");
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/listGPList")
	public QueryResult<GPList> listGPList(HttpServletRequest request) {
		QueryResult<GPList> rslt = gpListService.list(request);
		return rslt;
	}


    @ResponseBody
    @RequestMapping(value = "/delGPList", method = RequestMethod.POST)
    public Map<String, Object> delGPList(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int id = Integer.valueOf(request.getParameter("id"));
        map.put("IsSuccess", true);
        gpListService.del(id);
        return map;
    }
}
