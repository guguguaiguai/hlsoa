/**
 * 
 */
package com.lq.work.test.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.test.entity.TestData;

/**
 * 单表生成DAO接口
 * 
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataDao extends CrudDao<TestData> {
	
}