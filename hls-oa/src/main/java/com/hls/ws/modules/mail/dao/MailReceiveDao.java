/**
 * 
 */
package com.hls.ws.modules.mail.dao;

import java.util.List;

import com.hls.ws.modules.mail.entity.MailReceive;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 邮件接收信息DAO接口
 * @author lq
 * @version 2016-05-07
 */
@MyBatisDao
public interface MailReceiveDao extends CrudDao<MailReceive> {
	/**
	 * 批量插入邮件接收者数据
	 * @author JERRY
	 * **/
	public int insertAll(List<MailReceive> list);
	/**
	 * 批量标记阅读
	 * @author JERRY
	 * **/
	public int readFlag(MailReceive mr);
	/**
	 * 删除接收邮件
	 * @author JERRY
	 * **/
	public int delReceive(MailReceive mr);
	/**
	 * 邮件接收者阅读情况
	 * @author JERRY
	 * **/
	public List<MailReceive> mailRead(MailReceive mr);
	/**
	 * 根据邮件ID删除接收者信息
	 * **/
	public int mailDel(MailReceive mr);
	/**
	 * 查询未读邮件数量
	 * **/
	public Long unreadCount(MailReceive mr);
	/**
	 * 邮件撤回时更新接收者删除状态
	 * **/
	public int backDel(MailReceive mr);
	/**
	 * 更新是否下载文件
	 * @author JERRY
	 * **/
	public int fdCount(MailReceive mr);
}