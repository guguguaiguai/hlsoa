/**
 * 
 */
package com.lq.work.modules.cms.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.cms.entity.ArticleData;

/**
 * 文章DAO接口
 * 
 * @version 2013-8-23
 */
@MyBatisDao
public interface ArticleDataDao extends CrudDao<ArticleData> {
	
}
