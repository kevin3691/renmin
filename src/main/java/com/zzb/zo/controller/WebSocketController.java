package com.zzb.zo.controller;

import com.zzb.core.baseclass.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ws")
public class WebSocketController extends BaseController {

    @RequestMapping(value = "/index")
    //@RequiresPermissions("DOCUMENT:RO")
    public String index(ModelMap map) {
        return "/ws/index";
    }
}
