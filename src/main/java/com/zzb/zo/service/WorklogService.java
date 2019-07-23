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
        String titlei = request.getParameter("titlei") !=null ? request.getParameter("titlei") :"";

        QueryPara qp = new QueryPara(request);
        List<Object> args = new ArrayList<Object>();
        String hql = "FROM Worklog WHERE 1=1";
        if(!titlei.equals("")){
            hql += " and titlei like ?";
            args.add("%"+titlei+"%");
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