package com.zzb.base.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BasePersonDao;
import com.zzb.base.entity.BasePerson;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("basePersonService")
public class BasePersonService extends BaseService<BasePerson> {
	@Resource
	private BasePersonDao basePersonDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BasePerson> list(HttpServletRequest request) {
		int orgid = request.getParameter("baseOrgId") != null
				&& !request.getParameter("baseOrgId").equals("") ? Integer
				.valueOf(request.getParameter("baseOrgId")) : 0;
		String orgName = request.getParameter("baseOrgName") != null ? request
				.getParameter("baseOrgName") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BasePerson WHERE 1=1";
		if (orgid > 0) {
			hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
			args.add(orgid);
			args.add('%' + "." + String.valueOf(orgid) + "." + '%');
		}
		if (!orgName.equals("")) {
			hql += " AND baseOrgName LIKE ?";
			args.add('%' + orgName + '%');
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		if (!sym.equals("")) {
			hql += " AND sym LIKE ?";
			args.add('%' + sym + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<BasePerson> qr = basePersonDao.list(qp);
		return qr;
	}
	
public QueryResult<BasePerson> getTopPerson(int num, String sym) {
		

		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BasePerson WHERE 1=1";
		
		if (!sym.equals("")) {
			hql += " AND sym LIKE ?";
			args.add('%' + sym + '%');
		}
		hql += " AND isActive=?";
		args.add(1);
		qp.setPageSize(num);
		qp.setPageIndex(1);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<BasePerson> qr = basePersonDao.list(qp);
		return qr;
	}

	public BasePerson save(BasePerson person, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		person.setRecordInfo(super.GenRecordInfo(person.getRecordInfo(),
				request));
		person = basePersonDao.save(person);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (person.getLineNo() == 0) {
			person.setLineNo(person.getId());
		}
		return person;
	}

	public BasePerson dtl(int id) {
		BasePerson person = basePersonDao.dtl(id);
		return person;
	}
	
	/**
	 * 检查username是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param id
	 * @param sym
	 * @return
	 */
	public int checkExist(int orgId, String name) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM BaseUser WHERE 1=1";
		if (orgId != 0) {
			hql += " AND baseOrgId =? ";
			args.add(orgId);
		}
		if (name != "") {
			hql += " AND basePersonName=?";
			args.add(name);
		}
		return (int) ((long) basePersonDao.uniqueResult(hql, args));
	}

	public void del(int id) {
		basePersonDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		basePersonDao.sort(id, order);
	}

}
