package com.zzb.base.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionManager;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.util.ThreadContext;
import org.apache.shiro.web.env.WebEnvironment;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BaseDict;
import com.zzb.base.entity.BaseLog;
import com.zzb.base.entity.BaseMenu;
import com.zzb.base.entity.BasePerson;
import com.zzb.base.entity.BaseRole;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseLogService;
import com.zzb.base.service.BaseMenuService;
import com.zzb.base.service.BasePersonService;
import com.zzb.base.service.BaseRoleService;
import com.zzb.base.service.BaseUserService;
import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsNewsService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.core.security.TokenUtils;
import com.zzb.core.utils.IPUtils;
import com.zzb.core.utils.SiteConfig;
import com.zzb.core.utils.VerifyCodeUtil;

@Controller
@RequestMapping("/home")
public class HomeController extends BaseController {

	@Resource
	private BaseUserService baseUserService;

	@Resource
	private BasePersonService basePersonService;

	
	@Resource
	private BaseMenuService baseMenuService;

	@Resource
	private BaseLogService baseLogService;
	
	
	
	@Resource
	private BaseRoleService baseRoleService;
	
	
	
	@Resource
	private CmsNewsService cmsNewsService;

	@Autowired
	private SessionDAO sessionDAO;
	
	/**
	 * View 登录页 login
	 * 
	 * @return
	 */
	@RequestMapping(value = "/redirectUrl")
	public String redirectUrl(ModelMap model) {
		String token = request.getSession().getAttribute("OWASP_CSRFTOKEN") != null ? request
				.getSession().getAttribute("OWASP_CSRFTOKEN").toString()
				: "";
		String srcUrl = request.getParameter("srcUrl");
		srcUrl = StringEscapeUtils.escapeJavaScript(srcUrl);
		System.out.println("redirectUrl--srcUrl:" + srcUrl);
		System.out.println("t--token:" + token);
		model.put("srcUrl", srcUrl);
		model.put("t", token);
		return "/home/redirectUrl";
	}

	/**
	 * View 登录页 login
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login")
	public String login() {
		// 避免扫描工具报loginCSRF漏洞，验证OWASPTOKEN,如无则跳转到redirectUrl加TOKEN
		if (TokenUtils.validateToken(request)) {
			SiteConfig.setContextConfig(super.request.getSession()
					.getServletContext());
			return "/home/login";
		} else {
			return "redirect:/home/redirectUrl?srcUrl=home/login";
		}

	}
	


	/**
	 * View 首页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request,ModelMap model) {
		// 避免扫描工具报loginCSRF漏洞，验证OWASPTOKEN,如无则跳转到redirectUrl加TOKEN
		
		if (TokenUtils.validateToken(request)) {
			SiteConfig.setContextConfig(super.request.getSession()
					.getServletContext());
			QueryResult<CmsNews> qrT = cmsNewsService.getTopNews(13, "CMSNEWS_TZGG");
			if(qrT.getRows().size() > 0)
			{
				//CmsNews cn = qrT.getRows().get(0);
				//cn.setContent(StringUtils.htmlFilter(cn.getContent()));
				model.addAttribute("TopNews",qrT.getRows().get(0));
			}
			if(qrT.getRows().size() > 1)
			{
				List<CmsNews> newsList = qrT.getRows();
				newsList.remove(0);
				model.addAttribute("NewsList",newsList);
			}
			qrT = cmsNewsService.getTopNews(5, "CMSNEWS_TPXW");
			if(qrT.getRows().size() > 0){
				model.addAttribute("PicNews",qrT.getRows());
			}
			QueryResult<BasePerson> personList= basePersonService.getTopPerson(4, "TALENT");
			if(qrT.getRows().size() > 0){
				model.addAttribute("rcfc",qrT.getRows());
			}
			qrT= cmsNewsService.getTopNews(4, "CMSNEWS_RCZY_RCLY");
			if(qrT.getRows().size() > 0){
				model.addAttribute("rcly",qrT.getRows());
			}
			qrT= cmsNewsService.getTopNews(4, "CMSNEWS_RCZY_RCSC");
			if(qrT.getRows().size() > 0){
				model.addAttribute("rcsc",qrT.getRows());
			}
			qrT= cmsNewsService.getTopNews(10, "CMSNEWS_ZWGK_XXSD");
			if(qrT.getRows().size() > 0)
			{
				//CmsNews cn = qrT.getRows().get(0);
				//cn.setContent(StringUtils.htmlFilter(cn.getContent()));
				model.addAttribute("TopZwgk",qrT.getRows().get(0));
			}
			if(qrT.getRows().size() > 1)
			{
				List<CmsNews> newsList = qrT.getRows();
				newsList.remove(0);
				model.addAttribute("XxsdList",newsList);
			}
			qrT= cmsNewsService.getTopNews(9, "CMSNEWS_ZWGK_RCZC");
			if(qrT.getRows().size() > 0)
			{
				model.addAttribute("RczcList",qrT.getRows());
			}
			qrT= cmsNewsService.getTopNews(9, "CMSNEWS_ZWGK_WJXZ");
			if(qrT.getRows().size() > 0)
			{
				model.addAttribute("WjxzList",qrT.getRows());
			}
			qrT= cmsNewsService.getTopNews(9, "CMSNEWS_ZWGK_RCZT");
			if(qrT.getRows().size() > 0)
			{
				model.addAttribute("RcztList",qrT.getRows());
			}
			QueryResult<BaseMenu> bsdtList = baseMenuService.list("BSDT_");
			if(bsdtList.getRows().size() > 0){
				model.addAttribute("BsdtList",bsdtList.getRows());
			}
			Date nowTime = new Date();
			model.addAttribute("NowTime",nowTime);
			return "/home/index";
		} else {
			return "redirect:/home/redirectUrl?srcUrl=home/index";
		}

	}
	
	
	@RequestMapping(value = "/overview")
	public String overview(HttpServletRequest request,ModelMap model) {
		QueryResult<CmsNews> qrT = cmsNewsService.getTopNews(6, "CMSNEWS_HDGK");
		List<CmsNews> newsList = qrT.getRows();
		model.addAttribute("NewsList",newsList);
		Date nowTime = new Date();
		model.addAttribute("NowTime",nowTime);
		return "/home/overview";

	}
	
	@RequestMapping(value = "/talent")
	public String talent(HttpServletRequest request,ModelMap model) {
		QueryResult<CmsNews> qrT = cmsNewsService.getTopNews(16, "CMSNEWS_RCZY_RCLY");
		List<CmsNews> rclyList = qrT.getRows();
		if(rclyList.size() > 0)
			model.addAttribute("rclyList",rclyList);
		QueryResult<BasePerson> personList= basePersonService.getTopPerson(5, "TALENT");
		if(personList.getRows().size() > 0)
			model.addAttribute("rcfcList",personList.getRows());
		qrT = cmsNewsService.getTopNews(2, "CMSNEWS_RCZY_RCSC");
		List<CmsNews> rcscList = qrT.getRows();
		if(rcscList.size() > 0)
			model.addAttribute("rcscList",rcscList);
		Date nowTime = new Date();
		model.addAttribute("NowTime",nowTime);
		return "/home/talent";

	}
	
	@RequestMapping(value = "/zwgk")
	public String zwgk(@RequestParam(value="colSym")String colSym,ModelMap model) {
		QueryResult<CmsNews> qrt = new QueryResult<CmsNews>();
		if(!colSym.equals("")){
			qrt = cmsNewsService.getTopNews(7, colSym);
		}else{
			qrt = cmsNewsService.getTopNews(7, "CMSNEWS_ZWGK_XXSD");
		}
		model.addAttribute("NewsList",qrt.getRows());
		Date nowTime = new Date();
		model.addAttribute("NowTime",nowTime);
		return "/home/zwgk";

	}
	
	
	@RequestMapping(value = "/register")
	public String register(ModelMap model) {
		BaseUser user = new BaseUser();
		model.addAttribute("o",user);
		Date nowTime = new Date();
		model.addAttribute("NowTime",nowTime);
		return "/home/register";

	}

	@RequestMapping("/info")
	public String info(@RequestParam(value="id")int id, ModelMap map)
	{
		CmsNews info = cmsNewsService.dtl(id);
		map.addAttribute("info",info);
		return "/home/info";
	}
	
	/**
	 * 跳转到二级页
	 * @param map
	 * @return
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="colSym")String colSym, ModelMap map)
	{
		map.addAttribute("colSym",colSym);
		return "/home/list";
	}
	
	/**
	 * 跳转到二级页
	 * @param map
	 * @return
	 */
	@RequestMapping("/list4")
	public String list4(@RequestParam(value="colSym")String colSym, ModelMap map)
	{
		map.addAttribute("colSym",colSym);
		return "/home/list4";
	}
	/**
	 * 搜索页
	 * @param
	 * @param map
	 * @return
	 */
	@RequestMapping("/searchList")
	public String searchListPage(@RequestParam(value="condition")String condition, ModelMap map)
	{
		//搜索条件
		map.addAttribute("condition",condition);
		return "/home/searchList";
	}
	/**
	 * 网上投诉
	 * @return
	 */
	@RequestMapping("/complain")
	public String complain( ModelMap map)
	{
		return "/home/complain";
	}
	
	
	
	
	/**
	 * View UsbKey登录(坚石ET199) keyLogin
	 * 
	 * @return
	 */
	@RequestMapping(value = "/keyLogin")
	public String keyLogin() {
		// 避免扫描工具报loginCSRF漏洞，验证OWASPTOKEN,如无则跳转到redirectUrl加TOKEN
		if (TokenUtils.validateToken(request)) {
			SiteConfig.setContextConfig(super.request.getSession()
					.getServletContext());
			return "/home/keyLogin";
		} else {
			return "redirect:/home/redirectUrl?srcUrl=home/keyLogin";
		}
	}

	/**
	 * View 用户登出 logout
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		BaseUser user = new BaseUser();
		//ThreadContext.bind(SecurityUtils.getSubject()); 
		Subject subject = SecurityUtils.getSubject();
		try {
			//user= (BaseUser) subject.getSession().getAttribute("baseUser");
			user = (BaseUser) request.getSession().getAttribute(
					"baseUser");
			BaseLog log = new BaseLog();
			log.setCategory("系统日志-登出系统");
			log.setTitle(user.getBasePersonName() + " 登出系统");
			log.setDescr(user.getBaseOrgName() + " " + user.getBasePersonName());
			baseLogService.save(log, request);
			
		} catch (Exception ex) {

		}

		/*Subject subject = SecurityUtils.getSubject();*/
		
       /* ServletContext servletContext = null; 
        		WebEnvironment webEnv = WebUtils.getRequiredWebEnvironment(servletContext);
        		org.apache.shiro.mgt.SecurityManager sm = webEnv.getWebSecurityManager();
        		SecurityUtils.setSecurityManager(sm);
        		Subject subject = SecurityUtils.getSubject();
       */
		//subject.logout();
		/*Collection<Session> sessions = sessionDAO.getActiveSessions();
		for(Session session:sessions){
			String s = String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY));
			
			if(s != null && user.getUsername().equals(s)) {

			//session.setTimeout(0);//设置session立即失效，即将其踢出系统
			session.setAttribute("IsLogin", false);
			}
		}*/
		
		/*Collection<Session> sessions = sessionDAO.getActiveSessions();
		for(Session session:sessions){
			String s = String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY));
			if(user.getUsername().equals(s)) {

			//session.setTimeout(0);//设置session立即失效，即将其踢出系统
				session.setAttribute("IsLogin", true);

			}
		}*/
		Session session = subject.getSession();
		session.stop();
		/*Session session = subject.getSession();
		
		session.stop();
		session.setAttribute(DefaultSubjectContext.AUTHENTICATED_SESSION_KEY,false);*/
		/*SiteConfig.setContextConfig(super.request.getSession()
				.getServletContext());*/
		try {
            subject.logout();
        } catch (Exception e) { //ignore
        }
		return "redirect:/home/redirectUrl?srcUrl=home/index";
	}

	/**
	 * View 框架页 workplate
	 * 
	 * @param
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/workplate")
	public String workplate(ModelMap model) {
		QueryResult<BaseMenu> qr = baseMenuService.list(request);
		String index = request.getParameter("index") != null ? request
				.getParameter("index") : "";
		model.addAttribute("menu", qr);
		model.addAttribute("index",index);
		return "/home/workplate";
	}

	/**
	 * View 框架首页 dashboard
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dashboard")
	public String dashboard(HttpServletRequest request,ModelMap model) {
		
		return "/home/dashboard";
	}

	/**
	 * Action 非实体登录方法 login
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public Map<String, Object> login(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String username = request.getParameter("username") != null ? request
				.getParameter("username") : "";
		String password = request.getParameter("password") != null ? request
				.getParameter("password") : "";
		// 避开敏感字符
		if (username == "") {
			username = request.getParameter("u") != null ? request
					.getParameter("u") : "";
		}
		if (password == "") {
			password = request.getParameter("p") != null ? request
					.getParameter("p") : "";
		}
		password = new Md5Hash(password, username).toHex();
		String cip = IPUtils.getIpAddr(request);
		
		//检测重复登录
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		boolean isLogin = false;
		for(Session session:sessions){
			BaseUser user = (BaseUser) session.getAttribute(
					"baseUser");
			//String s = String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY));
			//String s = user.getUsername();
			if(user != null)
			{
				String s = user.getUsername();
				if(username.equals(s) && !user.getBaseRoleName().contains("管理员") && !user.getRecordInfo().getClientIP().equals(cip)) {

					//session.setTimeout(0);//设置session立即失效，即将其踢出系统
						isLogin = true;
						break;
					}
			}


		}
		//boolean isLogin = false;
	    if(isLogin)
	    {
	    	map.put("IsLogin", isLogin);
	    }else{
	    	BaseUser user = baseUserService.getUserByLogin(username, password);
	    	
			boolean rslt = false;
			System.out.println("-----------------\r\n" + user.getBasePersonName());
			if(user !=null && user.getId() > 0)
			{
				
				rslt = true;
				user = baseUserService.login(username, password);
				System.out.println("HomeController login..." + user);
				BaseRole role = baseRoleService.dtl(user.getBaseRoleId());
				RecordInfo info = user.getRecordInfo();
		    	info.setClientIP(cip);
		    	user.setRecordInfo(info);
				Subject subject = SecurityUtils.getSubject();
				if (subject != null) {
					Session session = subject.getSession();
					if (session != null) {
						session.setAttribute("baseUser", user);
					}
				}
				
				map.put("IsSuccess", rslt);
				map.put("url", role.getHomeSet());
				
			}else{
				rslt = false;
			}
			
	    	BaseLog log = new BaseLog();
			log.setCategory("系统日志-登录系统");
			log.setTitle(rslt ? user.getBasePersonName() + " 登录系统" : username
					+ " 登录失败");
			log.setDescr(rslt ? user.getBaseOrgName() + " "
					+ user.getBasePersonName() : "");

			baseLogService.save(log, request);
	    }

		
		
		return map;
	}
	
	private boolean getLoginedSession(String username) {  
		DefaultWebSecurityManager securityManager = (DefaultWebSecurityManager) SecurityUtils.getSecurityManager();
        DefaultWebSessionManager sessionManager = (DefaultWebSessionManager)securityManager.getSessionManager();
        Collection<Session> sessions = sessionManager.getSessionDAO().getActiveSessions();//获取当前已登录的用户session列表

        boolean isLogin = false;
        for(Session session:sessions){
            //清除该用户以前登录时保存的session
            if(username.equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)))) {
               isLogin = true;
            }
        }
		return isLogin;
		}  

	/**
	 * Action keyLogin
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/keyLogin", method = RequestMethod.POST)
	public Map<String, Object> keyLogin(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String username = request.getParameter("username") != null ? request
				.getParameter("username") : "";
		String password = request.getParameter("password") != null ? request
				.getParameter("password") : "";
		String keySN = request.getParameter("keySN") != null ? request
				.getParameter("keySN") : "";
		// 避开敏感字符
		if (username == "") {
			username = request.getParameter("u") != null ? request
					.getParameter("u") : "";
		}
		if (password == "") {
			password = request.getParameter("p") != null ? request
					.getParameter("p") : "";
		}
		boolean rslt = false;
		String msg = "密码错误";
		BaseUser user = new BaseUser();
		user = baseUserService.dtl(username, keySN);
		if (user != null && user.getId() > 0) {
			user = baseUserService.login(username, password);
			if (user != null && user.getId() > 0) {
				// session.setAttribute("BaseUser", user);
				rslt = true;
				msg = "登录成功";
			}
		} else {
			msg = "加密锁验证失败，请联系系统管理员";
		}
		map.put("IsSuccess", rslt);
		map.put("Message", msg);
		BaseLog log = new BaseLog();
		log.setCategory("系统日志-登录系统");
		log.setTitle(rslt ? user.getBasePersonName() + " 登录系统" : username
				+ " 登录失败");
		log.setDescr(rslt ? user.getBaseOrgName() + " "
				+ user.getBasePersonName() : "");
		baseLogService.save(log, request);
		return map;
	}
	
	
	
	/**
	 * 获取验证码图片和文本(验证码文本会保存在HttpSession中)
	 */
	@RequestMapping("/verifyimage")
	public void getVerifyCodeImage(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// 设置页面不缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String verifyCode = VerifyCodeUtil.generateTextCode(
				VerifyCodeUtil.TYPE_NUM_ONLY, 4, null);
		// 将验证码放到HttpSession里面
		request.getSession().setAttribute("verifyCode", verifyCode);
		System.out.println("本次生成的验证码为[" + verifyCode + "],已存放到HttpSession中");
		// 设置输出的内容的类型为JPEG图像
		response.setContentType("image/jpeg");
		BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(
				verifyCode, 90, 30, 3, true, Color.WHITE, Color.BLACK, null);
		// 写给浏览器
		ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
	}

	/**
	 * modifyPwd 修改密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/modifyPwd")
	public String modifyPwd(HttpServletRequest request, ModelMap model) {
		BaseUser user = (BaseUser) request.getSession()
				.getAttribute("baseUser");
		model.addAttribute("o", user);
		return "/home/modifyPwd";
	}

	/**
	 * Action modifyPwdAct 修改密码
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyPwdAct", method = RequestMethod.POST)
	public Map<String, Object> xgmmAct(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String password = request.getParameter("password") != null ? request
				.getParameter("password") : "";
		Boolean flag = true;
		try {
			BaseUser user = (BaseUser) request.getSession().getAttribute(
					"baseUser");
			user.setPassword(password);

			baseUserService.modifyPwd(user, request);
		} catch (Exception e) {
			System.out.println("密码修改失败..." + e.getMessage());
			flag = false;
		}

		map.put("IsSuccess", flag);
		return map;
	}

}
