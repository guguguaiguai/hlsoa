/**
 * 
 */
package com.hls.ws.modules.mail.dao;

import java.util.List;

import com.hls.ws.modules.mail.entity.MsgEmail;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 内部邮件DAO接口
 * @author lq
 * @version 2016-05-07
 */
@MyBatisDao
public interface MsgEmailDao extends CrudDao<MsgEmail> {
	/**
	 * 查询当前登录者收件箱信息
	 * **/
	public List<MsgEmail> findReceiveList(MsgEmail msgEmail);
	/**
	 * 草稿箱信息
	 * @author JERRY
	 * **/
	public List<MsgEmail> draftMailList(MsgEmail msgEmail);
	/**
	 * 草稿箱邮件删除
	 * **/
	public int draftDel(MsgEmail msgEmail);
	/**
	 * 收件箱删除邮件
	 * **/
	public List<MsgEmail> mailDelList(MsgEmail msgEmail);
	/**
	 * 详情
	 * **/
	public MsgEmail detail(MsgEmail msgEmail);
	/**
	 * 邮件撤回
	 * **/
	public int mailBack(MsgEmail msgEmail);
	/**
	 * 首页邮件查询
	 * @author JERRY
	 * **/
	public List<MsgEmail> mainMail(MsgEmail msgEmail);
	/**
	 * 收件箱邮件删除
	 * @author JERRY
	 * **/
	public int receiveDel(MsgEmail msgEmail);
}