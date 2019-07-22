package com.zzb.base.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.dao.BaseRoleDao;
import com.zzb.base.entity.BaseRole;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import org.apache.shiro.util.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;


@Transactional
@Service("baseRoleService")
public class BaseRoleService extends BaseService<BaseRole> {
	@Resource
	private BaseRoleDao baseRoleDao;

	public QueryResult<BaseRole> list(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request.getParameter("category") : "sys";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseRole WHERE 1=1";
		if (!category.equals("")) {
			hql += " AND Category like ?";
			args.add(category);
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add(title);
		}
		if (!sym.equals("")) {
			hql += " AND sym like ?";
			args.add(sym);
		}
		if (isActive != -1) {
			hql += " AND isActive = ?";
			args.add(isActive);
		}
		qp.setHql(hql);
		qp.setArgs(args);
		return baseRoleDao.list(qp);
	}

	public BaseRole save(BaseRole role, HttpServletRequest request) {
		role.setRecordInfo(super.GenRecordInfo(role.getRecordInfo(), request));
		// 设置角色权限、菜单
		role = setPurMenus(role);
		// 设置角色用户权限、菜单
		if (role.getUserIds() != "" && role.getCategory().equals("sys")) {
			setUserPowers(role);
			setRoleUser(role.getId());
		}

		role = baseRoleDao.save(role);
		return role;
	}

	public BaseRole dtl(int id) {
		BaseRole role = baseRoleDao.dtl(id);
		return role;
	}

	public BaseRole dtlByName(String name) {
		String hql = "FROM BaseRole WHERE title =?";
		List<Object> args = new ArrayList<Object>();
		args.add(name);
		BaseRole role = baseRoleDao.dtl(hql,args);
		return role;
	}

	public void del(int id) {
		baseRoleDao.del(id);
	}

	public void sort(int id, String order) {
		baseRoleDao.sort(id, order);
	}

	/**
	 * 设置用户菜单权限
	 *
	 * @param role
	 */
	public BaseRole setPurMenus(BaseRole role) {
		if (role.getPurPowerIds() == null || role.getPurPowerIds().equals("")) {
			return role;
		}
		QueryPara qp = new QueryPara();
		String hql = "SELECT menu.id,menu.baseTree.path FROM BaseMenu AS menu,BasePower AS power WHERE power.baseMenuId=menu.id AND power.id IN ("
				+ role.getPurPowerIds() + ")";
		List<Object> menus = baseRoleDao.excuteQuery(hql);
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

		// hql = "FROM BaseMenu WHERE id IN (:ids) AND isActive=1";
		hql = "FROM BaseMenu WHERE id IN (:armenuid)";
		Map<String, Object> alias = new HashMap<String, Object>();
		alias.put("armenuid", armenuid);
		qp = new QueryPara();
		qp.setHql(hql);
		qp.setAlias(alias);
		qp.setOrderBy("lineNo");
		qp.setOrderDirection("ASC");
		QueryResult<BaseRole> qr = baseRoleDao.list(qp);
		role.setPurMenuIds(ids);
		role.setPurMenus(JSON.toJSONString(qr.getRows()));
		return role;
	}

	/**
	 * 设置角色用户权限、菜单
	 *
	 * @param role
	 */
	public void setUserPowers(BaseRole role) {
		String[] aruser = role.getUserIds().split("\\,");
		String hql = "UPDATE BaseUser SET baseRoleId=?,baseRoleName=?,purPowerIds=?,purPowerSyms=?,purPowerTitles=?,purMenuIds=?,purMenus=? WHERE id=?";
		List<Object> args = new ArrayList<Object>();
		args.add(role.getId());
		args.add(role.getTitle());
		args.add(role.getPurPowerIds());
		args.add(role.getPurPowerSyms());
		args.add(role.getPurPowerTitles());
		args.add(role.getPurMenuIds());
		args.add(role.getPurMenus());
		args.add(0);
		for (String id : aruser) {
			System.out.println("#############---" + id);
			args.set(7, Integer.valueOf(id));
			baseRoleDao.executeUpdate(hql, args);
		}
	}

	/**
	 * 设置各角色用户、人员信息
	 */
	public void setRoleUser(int exceptId) {
		String hql = "SELECT id FROM BaseRole WHERE Category != 'temp' OR Category is NULL";
		if (exceptId > 0) {
			hql = "SELECT id FROM BaseRole WHERE id<>" + exceptId;
		}
		List<Object> roles = baseRoleDao.excuteQuery(hql);

		for (Object role : roles) {
			String userHql = "SELECT id,username,basePersonId,basePersonName FROM BaseUser WHERE baseRoleId= "
					+ role.toString();
			List<Object> users = baseRoleDao.excuteQuery(userHql);
			String userIds = "";
			String userNames = "";
			String personIds = "";
			String personNames = "";
			for (Object obj : users) {
				Object[] userObj = (Object[]) obj;
				userIds += userIds == "" ? userObj[0].toString() : ","
						+ userObj[0].toString();
				userNames += userNames == "" ? userObj[1].toString() : ","
						+ userObj[1].toString();
				personIds += personIds == "" ? userObj[2].toString() : ","
						+ userObj[2].toString();
				personNames += personNames == "" ? userObj[3].toString() : ","
						+ userObj[3].toString();
			}
			String updateHql = "UPDATE BaseRole SET userIds=?,userNames=?,personIds=?,personNames=? WHERE id = "
					+ role.toString();
			List<Object> args = new ArrayList<Object>();
			args.add(userIds);
			args.add(userNames);
			args.add(personIds);
			args.add(personNames);
			baseRoleDao.executeUpdate(updateHql, args);
		}
	}
}
