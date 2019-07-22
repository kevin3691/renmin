package com.zzb.zo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.DocType;
import com.zzb.zo.entity.Document;
import com.zzb.zo.service.DocTypeService;
import com.zzb.zo.service.DocumentService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/doctype")
public class DocTypeController extends BaseController {

	@Resource
	private DocTypeService docTypeService;
	
	@Resource
	private DocumentService documentService;

	/**
	 * 构造函数
	 */
	public DocTypeController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index() {
		return "/doctype/index";
	}
	

	/**
	 * View 简单列表  为其它模块提供侧栏导航
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {
		return "/doctype/list4";
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
		DocType org = new DocType();
		if (id > 0) {
			org = docTypeService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (parentId > 0) {
			DocType porg = docTypeService.dtl(parentId);
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
		return "/doctype/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/doctype/sel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/doctype/multiSel";
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
	public QueryResult<DocType> list(HttpServletRequest request) {
		QueryResult<DocType> rslt = docTypeService.list(request);
		int count = 0;
		int total = 0;
		for(DocType org : rslt.getRows())
		{
			count = docTypeService.getCount(org.getId());
			total = docTypeService.getDocCount(org.getId());
			
			org.setDocCount(count + total);
		}

		List<DocType> l = new ArrayList<>();
		l = rslt.getRows();
		DocType dt = new DocType();
		dt.setName("");
		dt.setId(0);
		l.add(0,dt);
		return rslt;
	}

	private void updateBaseTree(DocType org){
		QueryResult<DocType> rslt = docTypeService.listByParentId(org.getId());
		for(DocType o : rslt.getRows())
		{
			BaseTree tree = o.getBaseTree();
			int parentId = tree.getParentId();
			if (parentId > 0) {
				//DocType porg = docTypeService.dtl(parentId);
				String path = org.getBaseTree().getPath();
				tree.setPath(path == null || path.equals("") ? "." + org.getId()
						+ "." : path + org.getId() + ".");
				String pathname = org.getBaseTree().getPathName();
				tree.setPathName(pathname == null || pathname.equals("") ? "."
						+ org.getName() + "." : pathname + org.getName() + ".");
				o.setBaseTree(tree);
				docTypeService.save(o, request);
				
			}
			QueryResult<Document> userList = documentService.listByDocTypeId(o.getId());
			for(Document u : userList.getRows())
			{
				u.setDocTypeName(o.getBaseTree().getPathName() + o.getName());
				documentService.save(u, request);
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
	public Map<String, Object> save(DocType org, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(org.getId() > 0)
		{
			BaseTree t = org.getBaseTree();
			int parentId = t.getParentId();
			if (parentId > 0) {
				DocType porg = docTypeService.dtl(parentId);
				String path = porg.getBaseTree().getPath();
				t.setPath(path == null || path.equals("") ? "." + porg.getId()
						+ "." : path + porg.getId() + ".");
				String pathname = porg.getBaseTree().getPathName();
				t.setPathName(pathname == null || pathname.equals("") ? "."
						+ porg.getName() + "." : pathname + porg.getName() + ".");
				org.setBaseTree(t);
			}
			QueryResult<Document> userList = documentService.listByDocTypeId(org.getId());
			for(Document u : userList.getRows())
			{
				u.setDocTypeName(org.getBaseTree().getPathName() + org.getName());
				documentService.save(u, request);
			}
			org = docTypeService.save(org, request);
			if(org.getBaseTree().getIsLeaf() == 0)
			{
				updateBaseTree(org);
			}
			map.put("entity", org);
		}else{
			int cnt = docTypeService.checkExist(org.getName());
			if (cnt == 0) {
				/*BaseTree tree = org.getBaseTree();
				if(tree.getParentId() > 0)
				{
					tree.setPath(tree.getPath() + org.getId() + ".");
					tree.setPathName(tree.getPathName() + org.getName() + ".");
				}else{
					tree.setPath(path);;
				}*/
				org = docTypeService.save(org, request);
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
		docTypeService.del(id);
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
		docTypeService.sort(id, order);
		return map;
	}

}
