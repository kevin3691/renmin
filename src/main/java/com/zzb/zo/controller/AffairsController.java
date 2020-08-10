package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import com.zzb.zo.entity.Affairs;
import com.zzb.zo.entity.Seal;
import com.zzb.zo.service.AffairsService;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/affairs")
class AffairsController extends BaseController {

    @Autowired
    private AffairsService affairsService;

    String mode = "RW";
    String category = "";
    String uploadLabel = "";
    String applyTo = "";
    int refNum = 0;
    String title = "";
    String allowExt = "*.*";
    long allowSize = 1000 * 1024 * 1024L;
    String destDir = "upload/seal/";


    /**
     * 构造函数
     */
    AffairsController() {
    }

    @RequestMapping(value = "/index5")
    public String index5(){

        return "/affairs/index5";
    }


    @RequestMapping(value = "/index")
    public String index(){

        return "/affairs/index";
    }

    /**
     * 接收并设置参数
     *
     * @param request
     * @param
     */
    public void setPara(HttpServletRequest request, ModelMap model) {
        mode = request.getParameter("mode") != null ? request.getParameter(
                "mode").toString() : mode;
        category = request.getParameter("category") != null ? request
                .getParameter("category").toString() : category;
        uploadLabel = request.getParameter("uploadLabel") != null ? request
                .getParameter("uploadLabel").toString() : "";
        applyTo = request.getParameter("applyTo") != null ? request
                .getParameter("applyTo").toString() : applyTo;
        refNum = request.getParameter("refNum") != null ? Integer
                .valueOf(request.getParameter("refNum")) : refNum;
        title = request.getParameter("title") != null ? request.getParameter(
                "title").toString() : title;
        allowExt = request.getParameter("allowExt") != null ? request
                .getParameter("allowExt").toString() : allowExt;
        allowSize = request.getParameter("allowSize") != null ? Long
                .valueOf(request.getParameter("allowSize")) : allowSize;
        destDir = request.getParameter("destDir") != null
                && request.getParameter("destDir") != "" ? request
                .getParameter("destDir").toString() : destDir;
        model.put("mode", mode);
        model.put("category", category);
        model.put("uploadLabel", uploadLabel);
        model.put("applyTo", applyTo);
        model.put("refNum", String.valueOf(refNum));
        model.put("allowExt", allowExt);
        model.put("allowSize", String.valueOf(allowSize));
        model.put("destDir", destDir);
    }


    /**
     * View 添加、编辑页 edit
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit")
    //@RequiresPermissions("DOCUMENT:RW")
    public String edit(HttpServletRequest request, ModelMap model) {
        int id = request.getParameter("id") != null ? Integer.valueOf(request
                .getParameter("id")) : 0;
        int stepId = request.getParameter("stepId") != null ? Integer.valueOf(request
                .getParameter("stepId")) : 0;
        String colSym = request.getParameter("colSym") != null ? String.valueOf(request
                .getParameter("colSym")) : "";
        int type = request.getParameter("type") != null ? Integer.valueOf(request
                .getParameter("type")) : 0;
        Affairs affairs = new Affairs();
        if (id > 0) {
            affairs = affairsService.dtl(id);
            affairs.setContent(StringEscapeUtils.unescapeHtml(affairs.getContent()));
        }else{
        }
        setPara(request, model);
        model.addAttribute("o", affairs);
        String url = "/affairs/edit";
        return url;
    }
}

