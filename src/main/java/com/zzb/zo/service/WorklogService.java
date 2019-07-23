package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.WorkPlanDao;
import com.zzb.zo.dao.WorklogDao;
import com.zzb.zo.entity.Worklog;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("WorklogService")
public class WorklogService extends BaseService<Worklog> {

    @Resource
    private WorklogDao worklogDao;

    /**
     * 查询
     *
     * @param request
     * @return
     */
    public QueryResult<Worklog> list(HttpServletRequest request) {
        int isActive = request.getParameter("isPi") != null
                && !request.getParameter("isPi").equals("") ? Integer
                .valueOf(request.getParameter("isPi")) : -1;
        String startdate = request.getParameter("startdate") != null ? request
                .getParameter("startdate") : "";
        String finishdate = request.getParameter("finishdate") != null ? request
                .getParameter("finishdate") : "";

        String status = request.getParameter("status") != null ? request
                .getParameter("status") : "";
        String type = request.getParameter("type") != null ? request
                .getParameter("type") : "";
        String category = request.getParameter("category") != null ? request
                .getParameter("category") : "";
        String titlei = request.getParameter("titlei") !=null ? request.getParameter("titlei") :"";

        QueryPara qp = new QueryPara(request);
        List<Object> args = new ArrayList<Object>();
        String hql = "FROM Worklog WHERE 1=1";
        if(!titlei.equals("")){
            hql += " and titlei = ?";
            args.add(titlei);
        }
        if (isActive > 0) {
            hql += " AND isActivei =?";
            args.add(isActive);
        }
        if (!finishdate.equals("")) {
            hql += " AND date_format(finishdatei,'%Y-%m-%d') <= ?";
            args.add(finishdate);
        }
        if (!startdate.equals("")) {
            hql += " AND date_format(startdatei,'%Y-%m-%d') >= ?";
            args.add(startdate);
        }

        if (!status.equals("")) {
            hql += " AND statusi LIKE ?";
            args.add('%' + status + '%');
        }

        if (!type.equals("")) {
            hql += " AND typei LIKE ?";
            args.add('%' + type + '%');
        }

        if (!category.equals("")) {
            hql += " AND categoryi LIKE ?";
            args.add('%' + category + '%');
        }
        qp.setArgs(args);
        qp.setHql(hql);
        QueryResult<Worklog> qr = worklogDao.list(qp);
        return qr;
    }

    public Worklog save(Worklog doc, HttpServletRequest request) {
        System.out.println(doc);
        doc = worklogDao.save(doc);
        return doc;
    }
    public Worklog dtl(int id) {
        Worklog doc = worklogDao.dtl(id);
        return doc;
    }
    public void del(int id) {
        worklogDao.del(id);
    }

    public Worklog save2(Worklog worklog,HttpServletRequest request){
        worklog = worklogDao.save(worklog);
        return worklog;
    }
}