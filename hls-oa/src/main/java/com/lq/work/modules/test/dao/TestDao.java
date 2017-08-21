/**
 * 
 */
package com.lq.work.modules.test.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.test.entity.Test;

/**
 * 测试DAO接口
 * 
 * @version 2013-10-17
 */
@MyBatisDao
public interface TestDao extends CrudDao<Test> {
	
}
