package com.lyu.pms.test;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

/**
 * 类名称: 测试时间
 * 类描述: 测试时间
 * 全限定性类名: com.lyu.pms.test.TimeTest
 * @author 曲健磊
 * @date 2018年2月11日 下午11:27:33
 * @version V1.0
 */
public class TimeTest {
	
	@Test
	public void testDateTime() {
		Timestamp t = new Timestamp(System.currentTimeMillis());
		System.out.println(t);
	}
	
	@Test
	public void testCurrentTime() {
		// 获取当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(sdf.format(date));
	}
	
}
