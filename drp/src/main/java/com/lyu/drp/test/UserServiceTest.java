package com.lyu.drp.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.lyu.drp.sysmanage.service.IUserService;

/**
 * 类名称: 用户业务测试类
 * 类描述: 用于测试UserService类
 * 全限定性类名: com.lyu.drp.test.UserServiceTest
 * @author 曲健磊
 * @date 2018年1月16日 上午11:45:06
 * @version V1.0
 */
public class UserServiceTest {
	private ApplicationContext ac = null;
	private IUserService userService = null;
	
	@Before
	public void init() {
		ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		userService = (IUserService) ac.getBean("userService");
	}
	
	@Test
	public void testUserLogin() {
		System.out.println(userService.loginUser("admin", "123456"));
	}
	
}
