package com.zzb.base.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.entity.BaseMenu;
import com.zzb.base.entity.Children;
import com.zzb.base.entity.TopMenu;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zzb.base.dao.BaseMenuDao;
import com.zzb.base.dao.BaseRoleDao;
import com.zzb.base.dao.BaseUserDao;
import com.zzb.base.entity.BaseUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("baseUserService")
public class BaseUserService extends BaseService<BaseUser> {
	@Resource
	private BaseUserDao baseUserDao;
	@Resource
	private BaseMenuDao baseMenuDao;
	@Resource
	private BaseRoleDao baseRoleDao;
	@Resource
	private BaseRoleService baseRoleService;

	/**
	 * 用户登录
	 * 
	 * @param user
	 * @return
	 */
	public BaseUser login(BaseUser user) {
		return login(user.getUsername(), user.getPassword());
	}

	/**
	 * 用户登录
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public BaseUser login(String username, String password) {
		//password = new Md5Hash(password, username).toHex();
		UsernamePasswordToken token = new UsernamePasswordToken(username,
				password);
		//token.setRememberMe(true);
		// 获取当前的Subject
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated()) {
			subject.logout();
			subject = SecurityUtils.getSubject();
		}
		try {
			// 在调用了login方法后,SecurityManager会收到AuthenticationToken,并将其发送给已配置的Realm执行必须的认证检查
			// 每个Realm都能在必要时对提交的AuthenticationTokens作出反应
			// 所以这一步在调用login(token)方法时,它会走到MyRealm.doGetAuthenticationInfo()方法中,具体验证方式详见此方法
			System.out.println("对用户[" + username + "]进行登录验证..验证开始");
			subject.login(token);
			System.out.println("对用户[" + username + "]进行登录验证..验证通过");
		} catch (UnknownAccountException uae) {
			uae.printStackTrace();
			System.out.println("对用户[" + username + "]进行登录验证..验证未通过,未知账户");
		} catch (IncorrectCredentialsException ice) {
			ice.printStackTrace();
			System.out.println("对用户[" + username + "]进行登录验证..验证未通过,错误的凭证");
		} catch (LockedAccountException lae) {
			lae.printStackTrace();
			System.out.println("对用户[" + username + "]进行登录验证..验证未通过,账户已锁定");
		} catch (ExcessiveAttemptsException eae) {
			eae.printStackTrace();
			System.out.println("对用户[" + username + "]进行登录验证..验证未通过,错误次数过多");
		} catch (AuthenticationException ae) {
			// 通过处理Shiro的运行时AuthenticationException就可以控制用户登录失败或密码错误时的情景
			System.out.println("对用户[" + username + "]进行登录验证..验证未通过,堆栈轨迹如下");
			ae.printStackTrace();
		}
		// 验证是否登录成功
		if (subject.isAuthenticated()) {
			BaseUser user= (BaseUser) subject.getSession().getAttribute("baseUser");
			System.out.println("用户[" + username
					+ "]登录认证通过(这里可以进行一些认证通过后的一些系统参数初始化操作)");
			return user;
		} else {
			token.clear();
		}
		
		return null;
	}

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BaseUser> list(HttpServletRequest request) {
		int orgid = request.getParameter("baseOrgId") != null
				&& !request.getParameter("baseOrgId").equals("") ? Integer
				.valueOf(request.getParameter("baseOrgId")) : 0;
		String personname = request.getParameter("basePersonName") != null ? request
				.getParameter("basePersonName") : "";
		String username = request.getParameter("username") != null ? request
				.getParameter("username") : "";
		String orgname = request.getParameter("baseOrgName") != null ? request
				.getParameter("baseOrgName") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		String baseRoleName = request.getParameter("baseRoleName") != null ? request
				.getParameter("baseRoleName") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseUser WHERE 1=1";
		if (orgid > 0) {
			hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
			args.add(orgid);
			args.add('%' + "." + String.valueOf(orgid) + "." + '%');
		}
		if (!baseRoleName.equals("")) {
			hql += " AND baseRoleName LIKE ?";
			args.add('%' + baseRoleName + '%');
		}
		if (!personname.equals("")) {
			hql += " AND basePersonName LIKE ?";
			args.add('%' + personname + '%');
		}
		if (!username.equals("")) {
			hql += " AND username LIKE ?";
			args.add('%' + username + '%');
		}
		if (!orgname.equals("")) {
			hql += " AND baseOrgName LIKE ?";
			args.add('%' + orgname + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<BaseUser> qr = baseUserDao.list(qp);
		return qr;
	}
	
	
	public QueryResult<BaseUser> listByOrgId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseUser WHERE 1=1";
		hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');
		
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<BaseUser> qr = baseUserDao.list(qp);
		return qr;
	}

	/**
	 * 保存用戶
	 * 
	 * @param user
	 * @param request
	 * @return
	 */
	public BaseUser save(BaseUser user, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		user.setRecordInfo(super.GenRecordInfo(user.getRecordInfo(), request));
		int orgiRoleId = request.getParameter("orgiRoleId") != null ? Integer
				.valueOf(request.getParameter("orgiRoleId")) : 0;
		// 如果password长度为32则已加密（密码长度应设置为不大于32）
		String pwd = user.getPassword();
		if (pwd.length() < 32) {
			// 使用shiro加密密码
			pwd = new Md5Hash(pwd, user.getUsername()).toHex();
			user.setPassword(pwd);
		}
		// 设置用户菜单权限
		user = setPurMenus(user);
		user = baseUserDao.save(user);
		// 如果角色不为空并且角色发生改变，则更新角色的人员情况
		if (user.getBaseRoleId() > 0 & orgiRoleId != user.getBaseRoleId()) {
			baseRoleService.setRoleUser(0);
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (user.getLineNo() == 0) {
			user.setLineNo(user.getId());
		}

		return user;
	}

	/**
	 * 根据id获取用户
	 * 
	 * @param id
	 * @return
	 */
	public BaseUser dtl(int id) {
		BaseUser user = baseUserDao.dtl(id);
		return user;
	}

	/**
	 * 根据用户名获取用户
	 * 
	 * @param username
	 * @return
	 */
	public BaseUser dtl(String username) {
		String hql = "FROM BaseUser WHERE username =?";
		List<Object> args = new ArrayList<Object>();
		args.add(username);
		return baseUserDao.dtl(hql, args);
	}

	/**
	 * 根据用户名获取用户
	 * 
	 * @param username
	 * @return
	 */
	public BaseUser dtl(String username, String keySN) {
		String hql = "FROM BaseUser WHERE username =? AND keySN=?";
		List<Object> args = new ArrayList<Object>();
		args.add(username);
		args.add(keySN);
		return baseUserDao.dtl(hql, args);
	}
	
	/**
	 * 根据用户名获取用户
	 * 
	 * @param username
	 * @return
	 */
	public BaseUser getUserByLogin(String username, String password) {
		String hql = "FROM BaseUser WHERE username =? AND password=?";
		List<Object> args = new ArrayList<Object>();
		args.add(username);
		args.add(password);
		return baseUserDao.dtl(hql, args);
	}

	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @return
	 */
	public BaseUser update(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String keySN = request.getParameter("keySN") != null ? request
				.getParameter("keySN") : "";
		BaseUser user = new BaseUser();
		if (id > 0) {
			user = dtl(id);
			user.setKeySN(keySN);
			user = baseUserDao.save(user);
		}
		return user;
	}
	
	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @return
	 */
	public BaseUser modifyPwd(BaseUser user,HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		user.setRecordInfo(super.GenRecordInfo(user.getRecordInfo(), request));
		String pwd = user.getPassword();
		if (pwd.length() < 32) {
			// 使用shiro加密密码
			pwd = new Md5Hash(pwd, user.getUsername()).toHex();
			user.setPassword(pwd);
		}
		user = baseUserDao.save(user);
		return user;
	}

	/**
	 * 根据id刪除用戶
	 * 
	 * @param id
	 */
	public void del(int id) {
		baseUserDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		baseUserDao.sort(id, order);
	}

	/**
	 * 检查username是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param id
	 * @param
	 * @return
	 */
	public int checkExist(int id, String username) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM BaseUser WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (username != "") {
			hql += " AND username=?";
			args.add(username);
		}
		return (int) ((long) baseUserDao.uniqueResult(hql, args));
	}

	/**
	 * 设置用户菜单权限
	 * 
	 * @param user
	 */
	public BaseUser setPurMenus(BaseUser user) {
		if (user.getPurPowerIds() == null || user.getPurPowerIds().equals("")) {
			return user;
		}
		QueryPara qp = new QueryPara();
		String hql = "SELECT menu.id,menu.baseTree.path FROM BaseMenu AS menu,BasePower AS power WHERE power.baseMenuId=menu.id AND power.id IN ("
				+ user.getPurPowerIds() + ")";
		List<Object> menus = baseUserDao.excuteQuery(hql);
		List<Integer> armenuid = new ArrayList<Integer>();
		String ids = "";
		// 获取所有菜单id,包括path中的id
		for (Object row : menus) {
			Object[] obj = (Object[]) row;
			int id = (int) obj[0];
			String path = obj[1].toString();
			if (!armenuid.contains(id)) {
				armenuid.add(id);
				ids += ids == "" ? String.valueOf(id) : ","
						+ String.valueOf(id);
			}
			String[] arpath = path.split("\\.");
			for (String s : arpath) {
				if (s.equals("")) {
					continue;
				}
				if (!armenuid.contains(Integer.valueOf(s))) {
					armenuid.add(Integer.valueOf(s));
					ids += ids == "" ? String.valueOf(id) : ","
							+ String.valueOf(id);
				}
			}
		}

		hql = "FROM BaseMenu WHERE id IN (:armenuid)";
		Map<String, Object> alias = new HashMap<String, Object>();
		alias.put("armenuid", armenuid);
		qp = new QueryPara();
		qp.setHql(hql);
		qp.setAlias(alias);
		qp.setOrderBy("lineNo");
		qp.setOrderDirection("ASC");
		QueryResult<BaseMenu> qr = baseMenuDao.list(qp);
		user.setPurMenuIds(ids);

		user.setPurMenus(JSON.toJSONString(qr.getRows()));
		return user;
	}

	public List<Children> genMenu(BaseMenu menu, List<BaseMenu> menuList){
		List<Children> cl = new ArrayList<>();

		for (BaseMenu m :
			 menuList) {
			if(m.getBaseTree().getParentId() == menu.getId()){
				Children ch = new Children();
				ch.setTitle(m.getTitle());
				ch.setHref(m.getUrl());
				if(m.getBaseTree().getIsLeaf() == 0){
					ch.setChildren(genMenu(m,menuList));
				}
				cl.add(ch);
			}

		}
		return cl;
	}

}
