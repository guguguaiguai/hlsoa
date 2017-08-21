/**
 * 
 */
package com.lq.work.test.dao;

import com.lq.work.common.persistence.TreeDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * 
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}