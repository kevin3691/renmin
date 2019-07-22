package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.entity.GoodProvider;
import com.zzb.zo.entity.Goods;
import com.zzb.zo.service.GoodProviderService;
import com.zzb.zo.service.GoodsService;
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
@RequestMapping("/gprovider")
public class GoodProviderController extends BaseController {

	@Resource
	private GoodProviderService goodProviderService;
	
	@Resource
	private GoodsService goodsService;

	/**
	 * ���캯��
	 */
	public GoodProviderController() {
	}

	/**
	 * View �б�ҳ index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index() {
		return "/goodProvider/index";
	}
	

	/**
	 * View ���б�  Ϊ����ģ���ṩ��������
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4() {
		return "/goodProvider/list4";
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
		GoodProvider org = new GoodProvider();
		if (id > 0) {
			org = goodProviderService.dtl(id);
		}
		// ��Ӽ�¼ʱ������baseTree������
		if (parentId > 0) {
			GoodProvider porg = goodProviderService.dtl(parentId);
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
		return "/goodProvider/edit";
	}

	/**
	 * View ѡ��ҳ sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/goodProvider/sel";
	}

	/**
	 * View ��ѡҳ multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/goodProvider/multiSel";
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
	public QueryResult<GoodProvider> list(HttpServletRequest request) {
		QueryResult<GoodProvider> rslt = goodProviderService.list(request);
		int count = 0;
		int total = 0;


		List<GoodProvider> l = new ArrayList<>();
		l = rslt.getRows();
		GoodProvider dt = new GoodProvider();
		dt.setName("");
		dt.setId(0);
		l.add(0,dt);
		return rslt;
	}

	private void updateBaseTree(GoodProvider org){
		QueryResult<GoodProvider> rslt = goodProviderService.listByParentId(org.getId());
		for(GoodProvider o : rslt.getRows())
		{
			BaseTree tree = o.getBaseTree();
			int parentId = tree.getParentId();
			if (parentId > 0) {
				//GoodProvider porg = goodProviderService.dtl(parentId);
				String path = org.getBaseTree().getPath();
				tree.setPath(path == null || path.equals("") ? "." + org.getId()
						+ "." : path + org.getId() + ".");
				String pathname = org.getBaseTree().getPathName();
				tree.setPathName(pathname == null || pathname.equals("") ? "."
						+ org.getName() + "." : pathname + org.getName() + ".");
				o.setBaseTree(tree);
				goodProviderService.save(o, request);
				
			}

			if(o.getBaseTree().getIsLeaf() == 0)
			{
				updateBaseTree(o);
			}
		}
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
	public Map<String, Object> save(GoodProvider org, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(org.getId() > 0)
		{
			BaseTree t = org.getBaseTree();
			int parentId = t.getParentId();
			if (parentId > 0) {
				GoodProvider porg = goodProviderService.dtl(parentId);
				String path = porg.getBaseTree().getPath();
				t.setPath(path == null || path.equals("") ? "." + porg.getId()
						+ "." : path + porg.getId() + ".");
				String pathname = porg.getBaseTree().getPathName();
				t.setPathName(pathname == null || pathname.equals("") ? "."
						+ porg.getName() + "." : pathname + porg.getName() + ".");
				org.setBaseTree(t);
			}

			if(org.getBaseTree().getIsLeaf() == 0)
			{
				updateBaseTree(org);
			}
			map.put("entity", org);
		}else{
			int cnt = goodProviderService.checkExist(org.getName());
			if (cnt == 0) {
				/*BaseTree tree = org.getBaseTree();
				if(tree.getParentId() > 0)
				{
					tree.setPath(tree.getPath() + org.getId() + ".");
					tree.setPathName(tree.getPathName() + org.getName() + ".");
				}else{
					tree.setPath(path);;
				}*/
				org = goodProviderService.save(org, request);
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
		goodProviderService.del(id);
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
		goodProviderService.sort(id, order);
		return map;
	}

}
