package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.ReceivePersonDao;
import com.zzb.zo.dao.DocumentDao;
import com.zzb.zo.entity.ReceivePerson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("receivePersonService")
public class ReceivePersonService extends BaseService<ReceivePerson> {
	@Resource
	private ReceivePersonDao receivePersonDao;
	
	@Resource
	private DocumentDao documentDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<ReceivePerson> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		int refNum = request.getParameter("refNum") != null
				&& !request.getParameter("refNum").equals("") ? Integer
				.valueOf(request.getParameter("refNum")) : -1;
		String applyTo = request.getParameter("applyTo") != null
				&& !request.getParameter("applyTo").equals("") ?
				request.getParameter("applyTo") : "";
		String personName = request.getParameter("personName") != null
				&& !request.getParameter("personName").equals("") ?
				request.getParameter("personName") : "";
		String orgName = request.getParameter("orgName") != null
				&& !request.getParameter("orgName").equals("") ?
				request.getParameter("orgName") : "";
		int personId = request.getParameter("personId") != null
				&& !request.getParameter("personId").equals("") ? Integer
				.valueOf(request.getParameter("personId")) : -1;
		int orgId = request.getParameter("orgId") != null
				&& !request.getParameter("orgId").equals("") ? Integer
				.valueOf(request.getParameter("orgId")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM ReceivePerson WHERE 1=1 ";
		if (orgId != -1) {
			hql += " AND orgId=?";
			args.add(orgId);
		}
		if (personId != -1) {
			hql += " AND personId=?";
			args.add(personId);
		}
		if (refNum != -1) {
			hql += " AND refNum=?";
			args.add(refNum);
		}
		if (!applyTo.equals("")){
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (!personName.equals("")){
			hql += " AND personName like ?";
			args.add('%' + personName + '%');
		}
		if (!orgName.equals("")){
			hql += " AND orgName like ?";
			args.add('%' + orgName + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<ReceivePerson> qr = receivePersonDao.list(qp);
		return qr;
	}
	
	public QueryResult<ReceivePerson> listByParentId(int parentId) {
		
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM ReceivePerson WHERE 1=1 ";
		if (parentId > 0) {
			hql += " AND baseTree.parentId=?";
			args.add(parentId);
		}
		
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<ReceivePerson> qr = receivePersonDao.list(qp);
		return qr;
	}

	public ReceivePerson save(ReceivePerson receivePerson, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		receivePerson.setRecordInfo(super.GenRecordInfo(receivePerson.getRecordInfo(), request));
		receivePerson = receivePersonDao.save(receivePerson);
	
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (receivePerson.getLineNo() == 0) {
			receivePerson.setLineNo(receivePerson.getId());
		}
		receivePerson = receivePersonDao.save(receivePerson);
		return receivePerson;
	}

	public ReceivePerson dtl(int id) {
		ReceivePerson receivePerson = receivePersonDao.dtl(id);
		return receivePerson;
	}
	
	/**
	 * 检查username是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param
	 * @param
	 * @return
	 */
	public int checkExist(String name) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM ReceivePerson WHERE 1=1";
		
		if (!name.equals("")) {
			hql += " AND name=?";
			args.add(name);
		}
		return (int) ((long) receivePersonDao.uniqueResult(hql, args));
	}

	
	/**
	 * 获取详细
	 * 
	 * @param
	 * @return
	 */
	public int getCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM Document WHERE isActive=1";
		if (id != 0) {
			hql += " AND  receivePersonId = ?";
			args.add(id);
			count =  (int)((long)documentDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 获取详细
	 * 
	 * @param
	 * @return
	 */
	public int getDocCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM ReceivePerson WHERE isActive=1";
		if (id != 0) {
			hql += " AND  parentId = ?";
			args.add(id);
			count =  (int)((long)receivePersonDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		receivePersonDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		receivePersonDao.sortTree(id, order);
	}
	
}
