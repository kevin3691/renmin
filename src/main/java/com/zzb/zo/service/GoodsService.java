package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.GoodsDao;
import com.zzb.zo.entity.Document;
import com.zzb.zo.entity.Goods;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.util.*;

@Transactional
@Service("goodsService")
public class GoodsService extends BaseService<Goods> {
	@Resource
	private GoodsDao goodsDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<Goods> list(HttpServletRequest request) {
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
		String hql = "FROM Goods WHERE 1=1";
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
		QueryResult<Goods> qr = goodsDao.list(qp);
		return qr;
	}


	public QueryResult<Goods> list4(HttpServletRequest request) {
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
		String hql = "FROM Goods WHERE 1=1";
		if (typeId > 0) {
			hql += " AND typeId IN (SELECT id FROM SupType WHERE id=? OR baseTree.path LIKE ?)";
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
		QueryResult<Goods> qr = goodsDao.list(qp);
		return qr;
	}
	
public QueryResult<Goods> getTopPerson(int num, String sym) {
		

		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Goods WHERE 1=1";
		
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
		QueryResult<Goods> qr = goodsDao.list(qp);
		return qr;
	}

	public Goods save(Goods person, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		person.setRecordInfo(super.GenRecordInfo(person.getRecordInfo(),
				request));
		person = goodsDao.save(person);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (person.getLineNo() == 0) {
			person.setLineNo(person.getId());
		}
		return person;
	}

	public Goods dtl(int id) {
		Goods person = goodsDao.dtl(id);
		return person;
	}

	

	public QueryResult<Goods> listByGoodTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Goods WHERE 1=1";
		hql += " AND typeId IN (SELECT id FROM GoodType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Goods> qr = goodsDao.list(qp);
		return qr;
	}

	public QueryResult<Goods> listAllByGoodTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Goods WHERE 1=1";

		hql += " AND typeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<Goods> qr = goodsDao.list4(qp);
		return qr;
	}




	public QueryResult<Goods> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Goods WHERE 1=1 ";
		hql += " AND typeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<Goods> qr = goodsDao.listNoTotal(qp);
		return qr;
	}
	public void del(int id) {
		goodsDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		goodsDao.sort(id, order);
	}



}
