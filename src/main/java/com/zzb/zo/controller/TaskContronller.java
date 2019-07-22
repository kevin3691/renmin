package com.zzb.zo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/task")
public class TaskContronller {

	public TaskContronller() {
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = "/index")
	public String index(ModelMap map){
		return "/task/index";
		
	}
}
