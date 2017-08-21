/**
 * 
 */
package com.hls.ws.modules.news.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.lq.work.common.persistence.DataEntity;

/**
 * 新闻信息Entity
 * @author lq
 * @version 2016-05-06
 */
public class WsNews extends DataEntity<WsNews> {
	
	private static final long serialVersionUID = 1L;
	private String newsTitle;		// 新闻标题
	private String newsContent;		// 新闻内容
	private String newsTop;		// 是否置顶
	private String newsSort;		// 排序
	private Date topStart;		// 置顶开始时间
	private Date topEnd;		// 置顶结束时间
	private String newsClick;		// 点击次数
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private Date endTopDate;//置顶结束时间，查询使用
	
	public WsNews() {
		super();
	}

	public WsNews(String id){
		super(id);
	}

	public Date getEndTopDate() {
		return endTopDate;
	}

	public void setEndTopDate(Date endTopDate) {
		this.endTopDate = endTopDate;
	}

	@Length(min=1, max=300, message="新闻标题长度必须介于 1 和 300 之间")
	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	
	public String getNewsContent() {
		return newsContent;
	}

	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}
	
	@Length(min=0, max=1, message="是否置顶长度必须介于 0 和 1 之间")
	public String getNewsTop() {
		return newsTop;
	}

	public void setNewsTop(String newsTop) {
		this.newsTop = newsTop;
	}
	
	public String getNewsSort() {
		return newsSort;
	}

	public void setNewsSort(String newsSort) {
		this.newsSort = newsSort;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTopStart() {
		return topStart;
	}

	public void setTopStart(Date topStart) {
		this.topStart = topStart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTopEnd() {
		return topEnd;
	}

	public void setTopEnd(Date topEnd) {
		this.topEnd = topEnd;
	}
	
	public String getNewsClick() {
		return newsClick;
	}

	public void setNewsClick(String newsClick) {
		this.newsClick = newsClick;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
		
}