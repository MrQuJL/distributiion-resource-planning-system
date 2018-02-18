package com.lyu.pms.sysmanage.mapper;

import com.lyu.pms.sysmanage.entity.RoleToDept;

/**
 * 类名称: 角色-部门对应表mapper接口
 * 类描述: 封装了对角色-部门对应表的一些操作
 * 全限定性类名: com.lyu.pms.sysmanage.mapper.RoleToDeptMapper
 * @author 曲健磊
 * @date 2018年2月5日 下午2:16:00
 * @version V1.0
 */
public interface RoleToDeptMapper {
	
	/**
	 * 新增角色-部门对应表的一条记录
	 * @param 
	 * @return
	 */
	int saveRoleToDept(RoleToDept roleToDept);
	
	/**
	 * 根据角色id，删除角色-部门对应表的记录
	 * @param 
	 * @return
	 */
	int deleteRoleToDept(Long roleId);
	
	/**
	 * 根据部门id，删除角色-部门对应表的记录
	 * @param 
	 * @return
	 */
	int deleteRoleToDeptByDId(Long deptId);
	
}