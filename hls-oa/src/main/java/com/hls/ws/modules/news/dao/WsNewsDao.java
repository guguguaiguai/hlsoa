/**
 * 
 */
package com.hls.ws.modules.news.dao;

import java.util.List;

import com.hls.ws.modules.news.entity.WsNews;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 新闻信息DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface WsNewsDao extends CrudDao<WsNews> {
	/**
	 * 更新点击次数
	 * @author lq
	 * @version 2016-05-07
	 * **/
	public int updateClick(WsNews news);
	/**
	 * 取消置顶
	 * @author JERRY
	 * **/
	public int cancelTop(WsNews news);
	/**
	 * 新闻查看列表
	 * @author JERRY
	 * **/
	public List<WsNews> newsList(WsNews news);
	/**
	 * 首页新闻信息
	 * @author JERRY
	 * **/
	public List<WsNews> mainNews(WsNews news);
}