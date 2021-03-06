/**
 * 
 */
package com.lq.work.test.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.test.entity.TestDataMain;

/**
 * 主子表生成DAO接口
 * 
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataMainDao extends CrudDao<TestDataMain> {
	
}