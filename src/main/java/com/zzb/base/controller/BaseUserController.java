package com.zzb.base.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zzb.base.entity.BaseOrg;
import com.zzb.base.entity.BasePerson;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseOrgService;
import com.zzb.base.service.BasePersonService;
import com.zzb.base.service.BaseUserService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/base/user")
public class BaseUserController extends BaseController {

	@Resource
	private BaseUserService baseUserService;
	
	@Resource
	private BasePersonService basePersonService;
	
	@Resource
	private BaseOrgService baseOrgService;
	
	

	@Autowired
	private SessionDAO sessionDAO;
	
	/**
	 * 构造函数
	 */
	public BaseUserController() {
		System.out
				.println("this is BaseUserController constructed function... ");
	}
	
	/**
	 * View 在线用户管理 onlineManage
	 * 
	 * @return
	 *
	 */
	
	@RequestMapping(value = "/onlineManage")
	@RequiresPermissions("BASE_USER:RO")
	public String onlineManage(ModelMap map){
		
		return "/base/user/onlineManage";
	}
	
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_USER:RO")
	public String index(ModelMap map) {
		return "/base/user/index";
	}
	
	
	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_USER:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int orgId = request.getParameter("orgId") != null ? Integer.valueOf(request
				.getParameter("orgId")) : 0;
		BaseUser user = new BaseUser();
		BaseOrg org = new BaseOrg();
		if (id > 0) {
			user = baseUserService.dtl(id);
		}
		if (orgId > 0) {
			org = baseOrgService.dtl(orgId);
		}
		model.addAttribute("org",org);
		model.addAttribute("o", user);
		return "/base/user/edit";
	}
	
	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/base/user/sel";
	}

	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel(HttpServletRequest request, ModelMap model) {
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
		return "/base/user/multiSel";
	}
	
	
	@RequestMapping(value = "/multiSel4")
	public String multisel4(HttpServletRequest request, ModelMap model) {
		String ids = request.getParameter("ids") != null ? request
				.getParameter("ids") : "";
				String baseRoleName = request.getParameter("baseRoleName") != null ? request
						.getParameter("baseRoleName") : "";
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
				
				model.addAttribute("baseRoleName",baseRoleName);
				model.addAttribute("ids", ids);
				model.addAttribute("userList", userList);
		return "/base/user/multiSel4";
	}
	
	/**
	 * View 设置坚石加密锁
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/etKeySet")
	public String etKeySet(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		BaseUser user = new BaseUser();
		if (id > 0) {
			user = baseUserService.dtl(id);
		}

		model.addAttribute("o", user);
		return "/base/user/etKeySet";
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
	public QueryResult<BaseUser> list(HttpServletRequest request) {
		QueryResult<BaseUser> rslt = baseUserService.list(request);
		return rslt;
	}
	
	/**
	 * 获取在线用户列表 getOnlineUser
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getOnlineUser")
	public QueryResult<BaseUser> getOnlineUser(HttpServletRequest request){
		int orgid = request.getParameter("baseOrgId") != null
				&& !request.getParameter("baseOrgId").equals("") ? Integer
				.valueOf(request.getParameter("baseOrgId")) : 0;
		String personname = request.getParameter("basePersonName") != null ? request
				.getParameter("basePersonName") : "";
		String username = request.getParameter("username") != null ? request
				.getParameter("username") : "";
		QueryPara qp = new QueryPara(request);
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		List<BaseUser> list = new ArrayList<BaseUser>();
		for(Session session:sessions){
			BaseUser user = (BaseUser) session.getAttribute(
					"baseUser");
			
			if(user != null)
			{
				user.setKeySN(session.getId().toString());
				if(orgid > 0 && personname.equals("") && username.equals(""))
				{
					if(user.getBaseOrgId() == orgid)
						list.add(user);
				}
				else if(orgid == 0 && !personname.equals("") && username.equals(""))
				{
					if(user.getBasePersonName().contains(personname))
						list.add(user);
				}
				else if(orgid == 0 && personname.equals("") && !username.equals(""))
				{
					if(user.getUsername().contains(username))
						list.add(user);
				}
				else if(orgid == 0 && !personname.equals("") && !username.equals(""))
				{
					if(user.getBasePersonName().contains(personname) && user.getUsername().contains(username))
						list.add(user);
				}
				else if(orgid > 0 && !personname.equals("") && username.equals(""))
				{
					if(user.getBasePersonName().contains(personname) && user.getBaseOrgId() == orgid)
						list.add(user);
				}
				else if(orgid > 0 && personname.equals("") && !username.equals(""))
				{
					if(user.getUsername().contains(username) && user.getBaseOrgId() == orgid)
						list.add(user);
				}
				else if(orgid > 0 && !personname.equals("") && !username.equals(""))
				{
					if(user.getBasePersonName().contains(personname) && user.getBaseOrgId() == orgid && user.getUsername().contains(username))
						list.add(user);
				}else{
					list.add(user);
				}
			}
			
		}
		QueryResult<BaseUser> rslt = new QueryResult<BaseUser>();
		
		long total = list.size();
		if(total > 0)
		{
			long totalPage = 0;
			int index = qp.getPageIndex();
			if(index == 0)
			{
				index = 1;
			}
			int size = qp.getPageSize();
			if (index > 0 & size > 0) {
				totalPage = total % size == 0 ? total / size : total / size + 1;
				int first = (index - 1) * size;
				// 最后一页时，设置pageSize为所剩记录数
				if (index == (int) totalPage) {
					size = (int) total % size;
					if (size == 0) {
						size = qp.getPageSize();
					}
				}
				size = first + size;
				List<BaseUser> t = new ArrayList<BaseUser>();
				if (first >= 0 && size > 0) {
					for(int i = first; i< size;i++)
					{
						t.add(list.get(i));
					}
					rslt.setRows(t);
					rslt.setTotal(total);
					rslt.setRecords(list.size());
					
					
				}
				
				
			}
		}
		
		return rslt;
		
	}
	
	
	/**
	 * 强制用户下线
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/offline", method = RequestMethod.POST)
	public String  offline(HttpServletRequest request,RedirectAttributes redirectAttributes) {
		String sessionid = request.getParameter("sessionid") != null ? request
				.getParameter("sessionid") : "";
				
		
		Serializable sessionId = (Serializable)sessionid;
		try {  
            Session session = sessionDAO.readSession(sessionId);  
            if(session != null) {  
            	session.setTimeout(0);
            	session.setAttribute("baseUser", null);
                session.setAttribute(  
                    "SESSION_FORCE_LOGOUT_KEY", Boolean.TRUE); 
                session.stop();
            }  
        } catch (Exception e) {/*ignore*/}
		
		redirectAttributes.addFlashAttribute("msg", "强制退出成功！");  
        return "redirect:/home/index";
	}
	
	
	/**
	 * 获取列表数据 GETMENUS
	 * 
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getMenus")
	public String getMenus(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String rslt = "";
		BaseUser user = baseUserService.dtl(id);
		rslt = user.getPurMenus();
		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param user
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(BaseUser user, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = baseUserService.checkExist(user.getId(), user.getUsername());
		if (cnt == 0) {
			user = baseUserService.save(user, request);
			map.put("entity", user);
		} else {
			map.put("error", "该用户名已经存在");
		}
		return map;
		
	}
	
	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Map<String, Object> update(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		BaseUser user = baseUserService.update(request);
		map.put("entity", user);
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
		
		BaseUser user = baseUserService.dtl(id);
		if(user.getUsername().equals("sysadmin"))
		{
			map.put("error", "超级管理员用户不可删除！");
		}else{
			
			basePersonService.del(user.getBasePersonId());
			baseUserService.del(id);
			map.put("IsSuccess", true);
		}
		
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
		baseUserService.sort(id, order);
		return map;
	}
}
