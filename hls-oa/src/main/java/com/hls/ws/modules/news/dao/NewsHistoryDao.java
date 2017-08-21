/**
 * 
 */
package com.hls.ws.modules.news.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.hls.ws.modules.news.entity.NewsHistory;

/**
 * 新闻阅读历史DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface NewsHistoryDao extends CrudDao<NewsHistory> {
	
}