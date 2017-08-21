/**
 * 
 */
package com.hls.ws.modules.news.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.news.entity.NewsHistory;
import com.hls.ws.modules.news.dao.NewsHistoryDao;

/**
 * 新闻阅读历史Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class NewsHistoryService extends CrudService<NewsHistoryDao, NewsHistory> {

	public NewsHistory get(String id) {
		return super.get(id);
	}
	
	public List<NewsHistory> findList(NewsHistory newsHistory) {
		return super.findList(newsHistory);
	}
	
	public Page<NewsHistory> findPage(Page<NewsHistory> page, NewsHistory newsHistory) {
		return super.findPage(page, newsHistory);
	}
	
	@Transactional(readOnly = false)
	public void save(NewsHistory newsHistory) {
		super.save(newsHistory);
	}
	
	@Transactional(readOnly = false)
	public void delete(NewsHistory newsHistory) {
		super.delete(newsHistory);
	}
	
}