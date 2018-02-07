package com.lyu.drp.sysmanage.service;

import java.util.List;

import com.lyu.drp.sysmanage.entity.UserToRole;

/**
 * 类名称: 用户角色服务接口
 * 类描述: 用于操作用户-角色对应表的数据
 * 全限定性类名: com.lyu.drp.sysmanage.service.IUserToRoleService
 * @author 曲健磊
 * @date 2018年2月7日 下午2:27:52
 * @version V1.0
 */
public interface IUserToRoleService {
	
	/**
	 * 通过用户id查询他的角色列表 
	 * @param 
	 * @return
	 */
	List<UserToRole> listRoleByUId(Long userId);
	
}