/**
 * 
 */
package com.lq.work.modules.sys.dao;

import java.util.List;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.sys.entity.Log;

/**
 * 日志DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {
	/**
	 * 批量删除日志信息
	 * **/
	public int del(List<Log> list); 
}
