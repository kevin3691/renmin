/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.CashList;
import com.zzb.zo.entity.Seal;
import com.zzb.zo.service.SealService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/seal")
public class SealController extends BaseController {

	//照片支持的类型
	private static final List<String> AVATAR_TYPES = new ArrayList<String>();
	//照片的最大上载限制
	private static final long AVATAR_MAX_SIZE = 750*1024;
	static {
		AVATAR_TYPES.add("image/jpg");
		AVATAR_TYPES.add("image/png");
		AVATAR_TYPES.add("image/gif");
		AVATAR_TYPES.add("image/bmp");
	}

	@Resource
	private SealService sealService;



	@Resource
	private WfInstanceService insService;
	
	@Resource
	private WfWorkflowService wfService;

	@Resource
	private WfStepService wsService;


	@Resource
	private CommAttachmentService commAttachmentService;
	
	@Resource
	private BaseUserService baseUserService;

	
	String mode = "RW";
	String category = "";
	String uploadLabel = "";
	String applyTo = "";
	int refNum = 0;
	String title = "";
	String allowExt = "*.*";
	long allowSize = 1000 * 1024 * 1024L;
	String destDir = "upload/seal/";
	
	/**
	 * 构造函数
	 */
	public SealController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);
		/*switch (colSym) {
		case "DOCUMENT_YUEBAN":
			map.addAttribute("type", 1);
			break;
		case "DOCUMENT_PIBAN":
			map.addAttribute("type", 2);
			break;
		case "DOCUMENT_ZYUEBAN":
			map.addAttribute("type", 3);
			break;
		case "DOCUMENT_ZPIBAN":
			map.addAttribute("type", 4);
			break;

		default:
			break;
		}*/


		return "/seal/index";
	}

	/**
	 * View 列表页 index
	 *
	 * @return
	 */
	@RequestMapping(value = "/index5")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index5(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);

		return "/seal/index5";
	}

	/**
	 * 系统管理
	 *
	 * @return
	 */
	@RequestMapping(value = "/sysadmin")
	//@RequiresPermissions("DOCUMENT:RO")
	public String sysadmin(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);

		return "/seal/sysadmin";
	}


	@RequestMapping(value = "/type")
	//@RequiresPermissions("DOCUMENT:RO")
	public String type(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);

		return "/seal/type";
	}


	@RequestMapping(value = "/index2")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index2(ModelMap map) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		map.addAttribute("category", colTitle);
		map.addAttribute("colTitle", colTitle);
		map.addAttribute("colSym", colSym);
		setPara(request, map);

		return "/seal/index2";
	}


    @RequestMapping(value = "/index3")
    //@RequiresPermissions("DOCUMENT:RO")
    public String index3(ModelMap map) {
        String colSym = request.getParameter("colSym") != null ? String.valueOf(request
                .getParameter("colSym")) : "";
        String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
                .getParameter("colTitle")) : "";
        map.addAttribute("category", colTitle);
        map.addAttribute("colTitle", colTitle);
        map.addAttribute("colSym", colSym);
        setPara(request, map);

        return "/seal/index3";
    }

    @RequestMapping(value = "/index4")
    //@RequiresPermissions("DOCUMENT:RO")
    public String index4(ModelMap map) {
        String colSym = request.getParameter("colSym") != null ? String.valueOf(request
                .getParameter("colSym")) : "";
        String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
                .getParameter("colTitle")) : "";
        map.addAttribute("category", colTitle);
        map.addAttribute("colTitle", colTitle);
        map.addAttribute("colSym", colSym);
        setPara(request, map);

        return "/seal/index4";
    }



	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Seal seal = new Seal();
		if (id > 0) {
			seal = sealService.dtl(id);
			seal.setContent(StringEscapeUtils.unescapeHtml(seal.getContent()));


		}else{
		}
		setPara(request, model);
		model.addAttribute("o", seal);
		String url = "/affairs/details";
		return url;
	}

	@RequestMapping(value = "/audit")
	//@RequiresPermissions("DOCUMENT:RW")
	public String audit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Seal seal = new Seal();
		if (id > 0) {
			seal = sealService.dtl(id);
			seal.setContent(StringEscapeUtils.unescapeHtml(seal.getContent()));
		}else{
		}
		setPara(request, model);
		model.addAttribute("o", seal);
		String url = "/seal/audit";
		return url;
	}


	@RequestMapping(value = "/edit2")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Seal seal = new Seal();
		if (id > 0) {
			seal = sealService.dtl(id);
			seal.setContent(StringEscapeUtils.unescapeHtml(seal.getContent()));
		}else{
		}
		setPara(request, model);
		model.addAttribute("o", seal);
		String url = "/seal/edit2";
		return url;
	}


	@RequestMapping(value = "/sel")
	//@RequiresPermissions("DOCUMENT:RW")
	public String sel(HttpServletRequest request, ModelMap model) {

		String url = "/seal/sel";
		return url;
	}



	@RequestMapping(value = "/act")
	//@RequiresPermissions("DOCUMENT:RW")
	public String act(HttpServletRequest request, ModelMap model) {
		String colSym = request.getParameter("colSym") != null ? String.valueOf(request
				.getParameter("colSym")) : "";
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
				.getParameter("stepId")) : 0;
		String colTitle = request.getParameter("colTitle") != null ? String.valueOf(request
				.getParameter("colTitle")) : "";
		int type = request.getParameter("type") != null ? Integer.valueOf(request
				.getParameter("type")) : 0;
		Seal doc = new Seal();
		if (id > 0) {
			doc = sealService.dtl(id);
			BaseUser user = (BaseUser)SecurityUtils.getSubject()
					.getSession().getAttribute("baseUser");
			WfInstance ins = sealService.getIns(id, stepId,String.valueOf(user.getId()));
			model.addAttribute("ins", ins);
		}
		setPara(request, model);
		model.addAttribute("o", doc);
		String url = "/seal/act";
		
		return url;
	}
	@RequestMapping(value = "/dtl")
	//@RequiresPermissions("DOCUMENT:RW")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		
		Seal doc = new Seal();
		if (id > 0) {
			doc = sealService.dtl(id);
		}
		
		model.addAttribute("o", doc);
		String url = "/seal/dtl";
		
		return url;
	}
	
	@RequestMapping(value = "/flowInfo")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flowInfo(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = sealService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/seal/flowInfo";
	}
	@RequestMapping(value = "/flow")
	//@RequiresPermissions("DOCUMENT:RW")
	public String flow(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if (id > 0) {
			List<WfInstance> list = sealService.listIns(id);
			model.addAttribute("insList",list);
		}
		model.addAttribute("id",id);
		return "/seal/flow";
	}



	/**
	 * liebiao
	 * @param
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {

		return "/affairs/list";

	}
	/**
	 * 拍照
	 * @param
	 * @param
	 * @return
	 */
		@RequestMapping(value = "/photo")
		public String photo(HttpServletRequest request, ModelMap model) {
			int id = request.getParameter("id") != null ? Integer.valueOf(request
					.getParameter("id")) : 0;
			Seal seal = new Seal();
			if(id>0)
			{
				seal = sealService.dtl(id);
			}
			model.addAttribute("o", seal);
			return "/seal/photo";
		}


	/**
	 * 保存数据（添加、编辑）方法
	 *
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(Seal doc, CashList cashList,
									HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

//		String[] photo = doc.getPhoto().split("%");
//		String photo = doc.getPhoto();
//		doc.setPhoto("");
		doc = sealService.save(doc, request);


		/*for (){

		}*/
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}

	/**
	 * 签字
	 * @param
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/autograph")
	public String autograph(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		Seal seal = new Seal();
		if(id>0)
		{
			seal = sealService.dtl(id);
		}
		model.addAttribute("o", seal);
		return "/seal/autograph";
	}


	/**
	 * 签字完成,上传图片
	 * @param file
	 * @param session
	 * @return
	 */
	@RequestMapping("addImg")
	public  String change(
			@RequestParam("file") MultipartFile file,
			HttpSession session){
		//检查上传的文件是否为空
		if (file.isEmpty()) {
		}
		//检查文件的大小
		if (file.getSize()>AVATAR_MAX_SIZE) {
		}
		//检查文件的格式
		if (!AVATAR_TYPES.contains(file.getContentType())) {
		}
		//获取上载的文件名
		String originalFilename = file.getOriginalFilename();
		//文件夹
		String realPath = session.getServletContext().getRealPath("upload");
		File parent = new  File(realPath);
		//判断文件是否存在
		if (!parent.exists()) {
			//不存在创建
			parent.mkdirs();
//			parent.mkdir();
		}

		//使用id和username的方法获取
		Integer uid = Integer.valueOf(session.getId());
		String substring = "";
		//获取原文件名的后缀
		if (originalFilename.lastIndexOf(".")>0) {
			substring = originalFilename.substring(originalFilename.lastIndexOf("."));
		}
		//修改时间
		String newdate =System.currentTimeMillis()+"";
		//图片的命名id+用户名+原文件名后缀
		String avatar = uid+"-"+newdate+substring;
		System.out.println("avatar="+avatar);
//		String avatar = uid+username+substring;
		//创建一个file的对象保存文件对象
		File dest = new File (realPath,avatar);
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			System.out.println("上传错误,文件被移动");
		} catch (Exception e) {
			System.out.println("上传错误,文件上传中断,请重新上传");
		}

		String avataroath= "/upload/"+avatar;
		sealService.addImg(uid, avataroath);
		return avataroath;
	}

	/*@ResponseBody
	@RequestMapping(value = "/saveImg", method = RequestMethod.POST)
	public Map<String, Object> saveImg(@RequestBody String body,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		if(id > 0){
			Seal seal = sealService.dtl(id);
			seal.setImg(body);
			seal = sealService.save(seal,request);
			map.put("result","success");
		}else{
			map.put("result","error");
		}
		return map;
	}
*/


	


	/**
	 * 获取列表数据 list
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<Seal> list(HttpServletRequest request) {
		QueryResult<Seal> rslt = sealService.list(request);
		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/list4sel")
	public QueryResult<Seal> list4sel(HttpServletRequest request) {
		QueryResult<Seal> rslt = sealService.list4sel(request);

		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/listYwdb")
	public QueryResult<Seal> listYwdb(HttpServletRequest request) {
		QueryResult<Seal> rslt = sealService.list(request);

		return rslt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/listIns")
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		QueryResult<WfInstance> rslt = sealService.listIns(request);
		return rslt;
	}



	@ResponseBody
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public Map<String, Object> submit(Seal doc, CashList cashList,
									  HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc.setStatus(1);
		doc = sealService.save(doc, request);
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/audit", method = RequestMethod.POST)
	public Map<String, Object> audit(Seal doc, CashList cashList,
									  HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc.setActAt(new Date());
		doc = sealService.save(doc, request);
		map.put("entity", doc);
		//map.put("ins", ins);
		return map;
	}


	
	
	public WfInstance savewf(Seal doc,BaseUser user,int stepId, String actUrl, String dtlUrl){
		
		WfInstance ins = new WfInstance();
		ins.setCategory("SEAL");
		ins.setApplyTo("seal");
		ins.setRefNum(doc.getId());
		ins.setStepId(stepId);
		ins.setStepName("");
		ins.setNextStepId(stepId + 1);
		ins.setNextStepName("");
		ins.setActorId(String.valueOf(user.getId()));
		ins.setActorName(user.getBasePersonName());
		ins.setActUrl(actUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setListUrl("");
		ins.setOkUrl("");
		ins = insService.save(ins, request);
		return ins;
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
        sealService.del(id);
        return map;
    }



	@ResponseBody
	@RequestMapping(value = "/delIns", method = RequestMethod.POST)
	public Map<String, Object> delIns(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int refNum = Integer.valueOf(request.getParameter("refNum"));
		map.put("IsSuccess", true);
		sealService.del(refNum);
		sealService.delByRefNum(refNum);
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
		sealService.sort(id, order);
		return map;
	}


	
	
	@RequestMapping(value = "/multiSelSubmit")
	public String multiSelSubmit(HttpServletRequest request, ModelMap model) {
		String ids = request.getParameter("ids") != null ? request
				.getParameter("ids") : "";
				List<Integer> idList = new ArrayList<Integer>();
				List<BaseUser> userList = new ArrayList<BaseUser>();
				if(ids != "")
				{
					String[] qids = ids.split(",");
					for(String id : qids)
					{
						if(!id.equals(""))
						{
							idList.add(Integer.parseInt(id));
						}
					}
					
					for(int id : idList)
					{
						BaseUser user = baseUserService.dtl(id);
						userList.add(user);
					}
				}
				
				
				model.addAttribute("ids", ids);
				model.addAttribute("userList", userList);
		return "/base/user/multiSelSubmit";
	}

	/**
	 * 接收并设置参数
	 *
	 * @param request
	 * @param
	 */
	public void setPara(HttpServletRequest request, ModelMap model) {
		mode = request.getParameter("mode") != null ? request.getParameter(
				"mode").toString() : mode;
		category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : category;
		uploadLabel = request.getParameter("uploadLabel") != null ? request
				.getParameter("uploadLabel").toString() : "";
		applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : applyTo;
		refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : refNum;
		title = request.getParameter("title") != null ? request.getParameter(
				"title").toString() : title;
		allowExt = request.getParameter("allowExt") != null ? request
				.getParameter("allowExt").toString() : allowExt;
		allowSize = request.getParameter("allowSize") != null ? Long
				.valueOf(request.getParameter("allowSize")) : allowSize;
		destDir = request.getParameter("destDir") != null
				&& request.getParameter("destDir") != "" ? request
				.getParameter("destDir").toString() : destDir;
		model.put("mode", mode);
		model.put("category", category);
		model.put("uploadLabel", uploadLabel);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		model.put("allowExt", allowExt);
		model.put("allowSize", String.valueOf(allowSize));
		model.put("destDir", destDir);
	}




	/**
	 * 详情页
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/details")
	public String details(Integer id){



		return "/affairs/details";
	}

	/**
	 * 指南
	 * @return
	 */
	@RequestMapping(value = "/zhinan")
	public String zhinan(Integer id){



		return "/affairs/gkzn";
	}

}
