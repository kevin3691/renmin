package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.DocFileType;
import com.zzb.zo.entity.DocFile;
import com.zzb.zo.service.DocFileService;
import com.zzb.zo.service.DocFileTypeService;
import com.zzb.zo.service.DocFileService;
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
@RequestMapping("/docfiletype")
public class DocFileTypeController extends BaseController {

	@Resource
	private DocFileTypeService docFileTypeService;
	
	@Resource
	private DocFileService docFileService;

	/**
	 * 构造函数
	 */
	public DocFileTypeController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index() {
		return "/docfiletype/index";
	}
	

	/**
	 * View 简单列表  为其它模块提供侧栏导航
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {
		return "/docfiletype/list4";
	}


	/**
	 * View 添加、编辑页 edit
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
		DocFileType org = new DocFileType();
		if (id > 0) {
			org = docFileTypeService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (parentId > 0) {
			DocFileType porg = docFileTypeService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = porg.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + porg.getId()
					+ "." : path + porg.getId() + ".");
			String pathname = porg.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ porg.getName() + "." : pathname + porg.getName() + ".");
			org.setBaseTree(tree);
		}
		model.addAttribute("o", org);
		return "/docfiletype/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/docfiletype/sel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/docfiletype/multiSel";
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
	public QueryResult<DocFileType> list(HttpServletRequest request) {
		QueryResult<DocFileType> rslt = docFileTypeService.list(request);
		int count = 0;
		int total = 0;
		for(DocFileType org : rslt.getRows())
		{
			count = docFileTypeService.getCount(org.getId());
			total = docFileTypeService.getDocCount(org.getId());
			
			org.setDocCount(count + total);
		}

		List<DocFileType> l = new ArrayList<>();
		l = rslt.getRows();
		DocFileType dt = new DocFileType();
		dt.setName("");
		dt.setId(0);
		l.add(0,dt);
		return rslt;
	}

	private void updateBaseTree(DocFileType org){
		QueryResult<DocFileType> rslt = docFileTypeService.listByParentId(org.getId());
		for(DocFileType o : rslt.getRows())
		{
			BaseTree tree = o.getBaseTree();
			int parentId = tree.getParentId();
			if (parentId > 0) {
				//DocFileType porg = docFileTypeService.dtl(parentId);
				String path = org.getBaseTree().getPath();
				tree.setPath(path == null || path.equals("") ? "." + org.getId()
						+ "." : path + org.getId() + ".");
				String pathname = org.getBaseTree().getPathName();
				tree.setPathName(pathname == null || pathname.equals("") ? "."
						+ org.getName() + "." : pathname + org.getName() + ".");
				o.setBaseTree(tree);
				docFileTypeService.save(o, request);
				
			}
			QueryResult<DocFile> userList = docFileService.listByDocTypeId(o.getId());
			for(DocFile u : userList.getRows())
			{
				u.setDocTypeName(o.getBaseTree().getPathName() + o.getName());
				docFileService.save(u, request);
			}
			if(o.getBaseTree().getIsLeaf() == 0)
			{
				updateBaseTree(o);
			}
		}
	}
	
	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param org
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(DocFileType org, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(org.getId() > 0)
		{
			BaseTree t = org.getBaseTree();
			int parentId = t.getParentId();
			if (parentId > 0) {
				DocFileType porg = docFileTypeService.dtl(parentId);
				String path = porg.getBaseTree().getPath();
				t.setPath(path == null || path.equals("") ? "." + porg.getId()
						+ "." : path + porg.getId() + ".");
				String pathname = porg.getBaseTree().getPathName();
				t.setPathName(pathname == null || pathname.equals("") ? "."
						+ porg.getName() + "." : pathname + porg.getName() + ".");
				org.setBaseTree(t);
			}
			QueryResult<DocFile> userList = docFileService.listByDocTypeId(org.getId());
			for(DocFile u : userList.getRows())
			{
				u.setDocTypeName(org.getBaseTree().getPathName() + org.getName());
				docFileService.save(u, request);
			}
			org = docFileTypeService.save(org, request);
			if(org.getBaseTree().getIsLeaf() == 0)
			{
				updateBaseTree(org);
			}
			map.put("entity", org);
		}else{
			int cnt = docFileTypeService.checkExist(org.getName());
			if (cnt == 0) {
				/*BaseTree tree = org.getBaseTree();
				if(tree.getParentId() > 0)
				{
					tree.setPath(tree.getPath() + org.getId() + ".");
					tree.setPathName(tree.getPathName() + org.getName() + ".");
				}else{
					tree.setPath(path);;
				}*/
				org = docFileTypeService.save(org, request);
				map.put("entity", org);
			} else {
				map.put("error", "该名称已经存在");
			}
		}
		
		
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
		docFileTypeService.del(id);
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
		docFileTypeService.sort(id, order);
		return map;
	}

}
