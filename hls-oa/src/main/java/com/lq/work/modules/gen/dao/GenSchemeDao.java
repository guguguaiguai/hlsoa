/**
 * 
 */
package com.lq.work.modules.gen.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * 
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenSchemeDao extends CrudDao<GenScheme> {
	
}
