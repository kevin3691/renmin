package com.zzb.workflow.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfWorkDayDao;
import com.zzb.workflow.entity.WfWorkDay;

/**
 * Service 工作日
 * 
 * @author 
 * @createdAt 2016年09月13日
 */

@Transactional
@Service("wfWorkDayService")
public class WfWorkDayService extends BaseService<WfWorkDay> {
	@Resource
	private WfWorkDayDao wfWorkDayDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfWorkDay> list(HttpServletRequest request) {
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();

		String hql = "FROM WfWorkDay WHERE 1=1";
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfWorkDay> qr = wfWorkDayDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfWorkDay save(WfWorkDay workDay, HttpServletRequest request) {
		workDay = wfWorkDayDao.save(workDay);
		return workDay;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public WfWorkDay dtl(int id) {
		WfWorkDay workDay = wfWorkDayDao.dtl(id);
		return workDay;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		wfWorkDayDao.del(id);
	}
	
	/**
	 *
	 * return Calendar 返回类型 返回相加day天 throws
	 */
	public String addDateByWorkDay(Calendar calendar, int day) {
		try {
			for (int i = 0; i < day; i++) {
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				if (check(calendar)) {
					i--;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(calendar.getTime());
	}

	/**
	 * return boolean 返回类型 返回true是节假日，返回false不是节假日 throws
	 */
	public boolean check(Calendar calendar) throws Exception {
		// 判断是否是节假日
		if (checkHoliday(0,calendar.getTime()) > 0) {
			return true;
		}
		// 判断日期是否是周六周日
		if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY
				|| calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
			if (checkHoliday(1,calendar.getTime()) <= 0) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 检查是否节假日
	 * 
	 * @param request
	 * @return
	 */
	public int checkHoliday(int ifClass,Date d) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM WfWorkDay WHERE 1=1 AND ifClass=? AND wfDate=?";
		args.add(ifClass);
		args.add(d);
		return (int) ((long) wfWorkDayDao.uniqueResult(hql, args));
	}

}
