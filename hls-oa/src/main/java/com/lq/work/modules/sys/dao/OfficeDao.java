/**
 * 
 */
package com.lq.work.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.lq.work.common.persistence.TreeDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	/**
	 * 根据公告ID查询部门信息
	 * @author JERRY
	 * **/
	public List<Office> notifyOffice(Office office);
	/**
	 * 更新部门信息并接收存储过程返回的值
	 * @author JERRY
	 * **/
	public Map hisDep(Map map);
}
