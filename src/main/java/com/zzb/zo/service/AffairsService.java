package com.zzb.zo.service;

import com.zzb.base.entity.BaseUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.zo.dao.AffairsDao;
import com.zzb.zo.entity.Affairs;
import com.zzb.zo.entity.Seal;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("affairsService")
public class AffairsService extends BaseService<Affairs> {


    @Resource
    private AffairsDao affairsDao;
    @Resource
    private WfInstanceDao wfInstanceDao;


    /**
     * 查询
     *
     * @param request
     * @return
     */
    public QueryResult<Affairs> list(HttpServletRequest request) {             
        int isActive = request.getParameter("isPi") != null
                && !request.getParameter("isPi").equals("") ? Integer
                .valueOf(request.getParameter("isPi")) : -1;
        int orgId = request.getParameter("orgId") != null
                && !request.getParameter("orgId").equals("") ? Integer
                .valueOf(request.getParameter("orgId")) : -1;
        int sprId = request.getParameter("sprId") != null
                && !request.getParameter("sprId").equals("") ? Integer
                .valueOf(request.getParameter("sprId")) : -1;
        int sealTypeId = request.getParameter("sealTypeId") != null
                && !request.getParameter("sealTypeId").equals("") ? Integer
                .valueOf(request.getParameter("sealTypeId")) : -1;
        int status = request.getParameter("status") != null
                && !request.getParameter("status").equals("") ? Integer
                .valueOf(request.getParameter("status")) : -1;
        String sealdNo = request.getParameter("sealdNo") != null ? request
                .getParameter("sealdNo") : "";
        String type = request.getParameter("type") != null ? request
                .getParameter("type") : "";
        String category = request.getParameter("category") != null ? request
                .getParameter("category") : "";

        BaseUser user = (BaseUser) SecurityUtils.getSubject()
                .getSession().getAttribute("baseUser");
        QueryPara qp = new QueryPara(request);
        List<Object> args = new ArrayList<Object>();
        String hql = "FROM Seal WHERE 1=1";
        if (isActive > 0) {
            hql += " AND isActive=?";
            args.add(isActive);
        }

        if (sprId > 0) {
            hql += " AND sprId=?";
            args.add(sprId);
        }

        if (sealTypeId > 0) {
            hql += " AND sealTypeId=?";
            args.add(sealTypeId);
        }

        if (orgId > 0) {
            if(user.getBaseOrgName().equals("办公室") || user.getBaseRoleName().contains("管理员")){

            }else{
                hql += " AND orgId=?";
                args.add(orgId);
            }

        }

        if (status > -1) {
            hql += " AND status = ?";
            args.add(status);
        }

        if (!type.equals("")) {
            hql += " AND type LIKE ?";
            args.add('%' + type + '%');
        }

        if (!category.equals("")) {
            hql += " AND category LIKE ?";
            args.add('%' + category + '%');
        }



        qp.setArgs(args);
        qp.setHql(hql);
        QueryResult<Affairs> qr = affairsDao.list(qp);
        return qr;
    }


    /**
     * 排序
     *
     * @param id
     */
    public void sort(int id, String order) {
        affairsDao.sort(id, order);
    }

    public int checkInsExist(String applyTo,int refNum,int stepId, String actorId) {
        List<Object> args = new ArrayList<Object>();
        String hql = "SELECT COUNT(*) FROM WfInstance WHERE 1=1";
        if (!applyTo.equals("")) {
            hql += " AND applyTo=?";
            args.add(applyTo);
        }
        if (refNum > 0) {
            hql += " AND refNum=? ";
            args.add(refNum);
        }
        if (stepId > 0) {
            hql += " AND stepId=? ";
            args.add(stepId);
        }
        if (!actorId.equals("")) {
            hql += " AND actorId=?";
            args.add(actorId);
        }
        return (int) ((long) wfInstanceDao.uniqueResult(hql, args));
    }

    public Affairs dtl(int id) {
        Affairs doc = affairsDao.dtl(id);
        return doc;
    }

    public void del(int id) {
        affairsDao.del(id);
    }




}
