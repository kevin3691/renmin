package com.zzb.comm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/comm/picker")
public class CommPickerController {

	/**
	 * 图标选择
	 * 
	 * @return
	 */
	@RequestMapping(value = "/icon")
	public String icon() {
		return "/comm/picker/icon";
	}
}
