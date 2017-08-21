package com.hls.ws.modules.task.news;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.hls.ws.modules.news.entity.WsNews;
import com.hls.ws.modules.news.service.WsNewsService;
import com.lq.work.common.utils.SpringContextHolder;
/**
 * 定时 任务
 * **/
@SuppressWarnings("serial")
@Service
@Lazy(false)
public class NewsTask implements Serializable {
	
	/***
	 * 每天凌晨三点执行任务取消到期置顶新闻
	 * @author JERRY
	 * **/
	@Scheduled(cron="0 0 23 * * ?")
	public void cancelTop(){
		/**
		 * 新闻判断取消置顶
		 * **/
		WsNewsService wsNewsService=SpringContextHolder.getBean(WsNewsService.class);
		WsNews news = new WsNews();
		news.setEndTopDate(new Date());
		news.setNewsTop("1");
		List<WsNews> list = wsNewsService.findList(news);
		if(list!=null){
			for(WsNews wn:list){
				wn.setNewsTop("0");
				wsNewsService.cancelTop(wn);
			}
		}
		System.out.println(list.size()+"....size");
		System.out.println("取消置顶定时任务"+new Date());
	}
}
