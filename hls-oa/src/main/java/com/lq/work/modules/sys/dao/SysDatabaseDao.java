/**
 * 
 */
package com.lq.work.modules.sys.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.sys.entity.SysDatabase;

/**
 * 数据库备份DAO接口
 * @author lq
 * @version 2016-06-27
 */
@MyBatisDao
public interface SysDatabaseDao extends CrudDao<SysDatabase> {
	
}