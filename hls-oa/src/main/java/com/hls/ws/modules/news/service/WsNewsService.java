/**
 * 
 */
package com.hls.ws.modules.news.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.news.entity.WsNews;
import com.hls.ws.modules.news.dao.WsNewsDao;

/**
 * 新闻信息Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class WsNewsService extends CrudService<WsNewsDao, WsNews> {

	public WsNews get(String id) {
		return super.get(id);
	}
	
	public List<WsNews> findList(WsNews wsNews) {
		return super.findList(wsNews);
	}
	
	public Page<WsNews> findPage(Page<WsNews> page, WsNews wsNews) {
		return super.findPage(page, wsNews);
	}
	
	@Transactional(readOnly = false)
	public void save(WsNews wsNews) {
		super.save(wsNews);
	}
	
	@Transactional(readOnly = false)
	public void delete(WsNews wsNews) {
		super.delete(wsNews);
	}
	/**
	 * 更新点击次数
	 * @author lq
	 * @version 2016-05-07
	 * **/
	@Transactional(readOnly = false)
	public int updateClick(WsNews news){
		return this.dao.updateClick(news);
	}
	/**
	 * 取消置顶
	 * @author JERRY
	 * **/
	@Transactional(readOnly = false)
	public int cancelTop(WsNews news){
		return dao.cancelTop(news);
	}
	/**
	 * 新闻查看列表
	 * @author JERRY
	 * **/
	public Page<WsNews> newsList(Page<WsNews> page,WsNews news){
		news.setPage(page);
		page.setList(dao.newsList(news));
		return page;
	}
	/**
	 * 首页新闻信息
	 * @author JERRY
	 * **/
	public List<WsNews> mainNews(WsNews news){
		return dao.mainNews(news);
	}
}