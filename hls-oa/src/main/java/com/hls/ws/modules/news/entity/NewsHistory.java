/**
 * 
 */
package com.hls.ws.modules.news.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.modules.sys.entity.User;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lq.work.common.persistence.DataEntity;

/**
 * 新闻阅读历史Entity
 * @author lq
 * @version 2016-05-06
 */
public class NewsHistory extends DataEntity<NewsHistory> {
	
	private static final long serialVersionUID = 1L;
	private String newsId;		// 新闻主键
	private User newsReader;		// 阅读者
	private Date readDate;		// 阅读时间
	private Integer readNum;		// 阅读次数
	
	public NewsHistory() {
		super();
	}

	public NewsHistory(String id){
		super(id);
	}

	public NewsHistory(String newsId, User newsReader, Date readDate,
			Integer readNum) {
		super();
		this.newsId = newsId;
		this.newsReader = newsReader;
		this.readDate = readDate;
		this.readNum = readNum;
	}

	@Length(min=1, max=64, message="新闻主键长度必须介于 1 和 64 之间")
	public String getNewsId() {
		return newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}
	
	@NotNull(message="阅读者不能为空")
	public User getNewsReader() {
		return newsReader;
	}

	public void setNewsReader(User newsReader) {
		this.newsReader = newsReader;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="阅读时间不能为空")
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	
	public Integer getReadNum() {
		return readNum;
	}

	public void setReadNum(Integer readNum) {
		this.readNum = readNum;
	}
	
}