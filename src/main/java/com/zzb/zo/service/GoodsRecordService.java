package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.GoodsRecordDao;
import com.zzb.zo.entity.GoodsRecord;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service("GoodsRecordService")
public class GoodsRecordService extends BaseService<GoodsRecord> {
	@Resource
	private GoodsRecordDao GoodsRecordDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<GoodsRecord> list(HttpServletRequest request) {
		int typeId = request.getParameter("typeId") != null
				&& !request.getParameter("typeId").equals("") ? Integer
				.valueOf(request.getParameter("typeId")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		String qrcode = request.getParameter("qrcode") != null ? request
				.getParameter("qrcode") : "";
		String barcode = request.getParameter("barcode") != null ? request
				.getParameter("barcode") : "";
		String status = request.getParameter("status") != null ? request
				.getParameter("status") : "";
		String sn = request.getParameter("sn") != null ? request
				.getParameter("sn") : "";
		int keeperId = request.getParameter("keeperId") != null
				&& !request.getParameter("keeperId").equals("") ? Integer
				.valueOf(request.getParameter("keeperId")) : -1;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodsRecord WHERE 1=1";
		if (typeId > 0) {
			hql += " AND typeId IN (SELECT id FROM GoodType WHERE id=? OR baseTree.path LIKE ?)";
			args.add(typeId);
			args.add('%' + "." + String.valueOf(typeId) + "." + '%');
		}
		if (!category.equals("")) {
			hql += " AND category = ?";
			args.add(category);
		}
		if (!qrcode.equals("")) {
			hql += " AND qrcode = ?";
			args.add(qrcode);
		}
		if (!barcode.equals("")) {
			hql += " AND barcode = ?";
			args.add(barcode);
		}
		if (!status.equals("")) {
			hql += " AND status = ?";
			args.add( status );
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		if (!sn.equals("")) {
			hql += " AND sn LIKE ?";
			args.add('%' + sn + '%');
		}

		if (keeperId != -1) {
			hql += " AND keeperId=?";
			args.add(keeperId);
		}

		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodsRecord> qr = GoodsRecordDao.list(qp);
		return qr;
	}
	
public QueryResult<GoodsRecord> getTopPerson(int num, String sym) {
		

		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodsRecord WHERE 1=1";
		
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
		QueryResult<GoodsRecord> qr = GoodsRecordDao.list(qp);
		return qr;
	}

	public GoodsRecord save(GoodsRecord person, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		person.setRecordInfo(super.GenRecordInfo(person.getRecordInfo(),
				request));
		person = GoodsRecordDao.save(person);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (person.getLineNo() == 0) {
			person.setLineNo(person.getId());
		}
		return person;
	}

	public GoodsRecord dtl(int id) {
		GoodsRecord person = GoodsRecordDao.dtl(id);
		return person;
	}

	

	public QueryResult<GoodsRecord> listByGoodTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodsRecord WHERE 1=1";
		hql += " AND typeId IN (SELECT id FROM GoodType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodsRecord> qr = GoodsRecordDao.list(qp);
		return qr;
	}

	public QueryResult<GoodsRecord> listAllByGoodTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM GoodsRecord WHERE 1=1";

		hql += " AND typeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<GoodsRecord> qr = GoodsRecordDao.list4(qp);
		return qr;
	}




	public QueryResult<GoodsRecord> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM GoodsRecord WHERE 1=1 ";
		hql += " AND typeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<GoodsRecord> qr = GoodsRecordDao.listNoTotal(qp);
		return qr;
	}
	public void del(int id) {
		GoodsRecordDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		GoodsRecordDao.sort(id, order);
	}



}
