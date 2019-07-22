package com.zzb.base.realm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import com.zzb.base.entity.BaseRole;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseRoleService;
import com.zzb.base.service.BaseUserService;

public class MainRealm extends AuthorizingRealm {
	@Resource
	BaseUserService baseUserService;
	
	@Resource
	BaseRoleService baseRoleService;
	


	/**
	 * 
	 */
	public MainRealm() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param cacheManager
	 */
	public MainRealm(CacheManager cacheManager) {
		super(cacheManager);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param matcher
	 */
	public MainRealm(CredentialsMatcher matcher) {
		super(matcher);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param cacheManager
	 * @param matcher
	 */
	public MainRealm(CacheManager cacheManager, CredentialsMatcher matcher) {
		super(cacheManager, matcher);
		// TODO Auto-generated constructor stub
	}

	/**
	 * 为当前登录的Subject授予角色和权限
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {

		System.out.println("doGetAuthorizationInfo####");
		// 获取当前登录的用户名,等价于(String)principals.fromRealm(this.getName()).iterator().next()
		String username = (String) super.getAvailablePrincipal(principals);

		List<String> roleList = new ArrayList<String>();
		List<String> powerList = new ArrayList<String>();
		// 从数据库中获取当前登录用户的详细信息(如已登录从Seesion获取)
		Subject subject = SecurityUtils.getSubject();
		BaseUser user = new BaseUser();
		if (subject != null && subject.getSession() != null) {
			user = (BaseUser) subject.getSession().getAttribute("baseUser");
		} else {
			user = baseUserService.dtl(username);
		}
		System.out.println("doGetAuthorizationInfo$$$:" + user);
		if (user != null) {
			if (user.getBaseRoleSym() != null) {
				roleList = Arrays.asList(user.getBaseRoleSym().split(","));
			}
			if (user.getPurPowerSyms() != null) {
				powerList = Arrays.asList(user.getPurPowerSyms().split(","));
			}
		} else {
			throw new AuthorizationException();
		}
		// 为当前用户设置角色和权限
		SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
		simpleAuthorInfo.addRoles(roleList);
		simpleAuthorInfo.addStringPermissions(powerList);
		// 若该方法什么都不做直接返回null的话,就会导致用户访问未授权页时都会自动跳转到unauthorizedUrl指定的地址
		// 详见spring-shiro.xml中的<bean id="shiroFilter">的配置
		return simpleAuthorInfo;
	}

	/**
	 * 验证当前登录的Subject
	 */
	@SuppressWarnings("unused")
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authtoken) throws AuthenticationException {
		// 获取基于用户名和密码的令牌
		// String username = token.getPrincipal().toString();
		// String password = ((char[]) token.getCredentials()).toString();
		// BaseUser user = baseUserService.login(username, password);
		// SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user,
		// user.getPassword(), this.getName());
		// info.setCredentialsSalt(ByteSource.Util.bytes(user.getUsername()));
		// return info;

		// 获取基于用户名和密码的令牌
		// 实际上这个authcToken是从LoginController里面currentUser.login(token)传过来的
		// 两个token的引用都是一样的,当前是org.apache.shiro.authc.UsernamePasswordToken@33799a1e
		UsernamePasswordToken token = (UsernamePasswordToken) authtoken;

		BaseUser user = baseUserService.dtl(token.getUsername());
//		System.out.println("doGetAuthenticationInfo:user.password--"
//				+ user.getPassword());
//		System.out.println("doGetAuthenticationInfo:token.password--"
//				+ ((char[]) token.getPassword()).toString());
		String password = ((char[]) token.getCredentials()).toString();
		System.out.println("password:" + password);
		if (user != null) {
			AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(
					user.getUsername(), user.getPassword(), this.getName());
			System.out.println("doGetAuthenticationInfo:this.getName:"
					+ this.getName());
			
			BaseRole role = baseRoleService.dtl(user.getBaseRoleId());
			this.setSession("baseRole", role);
			this.setSession("baseUser", user);
			this.setSession("baseUserId", user.getId());
			this.setSession("basePersonId", user.getBasePersonId());
			this.setSession("basePersonName", user.getBasePersonName());
			this.setSession("baseOrgName", user.getBaseOrgName());
			this.setSession("homeSet", role.getHomeSet());
			return authcInfo;
		}
		return null;
	}

	/**
	 * 将一些数据放到ShiroSession中,以便于其它地方使用
	 */
	@SuppressWarnings("unused")
	private void setSession(Object key, Object value) {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Session session = subject.getSession();
			if (session != null) {
				session.setAttribute(key, value);
			}
		}
	}

	/*@Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }*/
}
