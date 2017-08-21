/**
 * 
 */
package com.lq.work.modules.sys.dao;

import com.lq.work.common.persistence.TreeDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
