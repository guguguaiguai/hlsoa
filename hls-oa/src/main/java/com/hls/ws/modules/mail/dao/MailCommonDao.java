/**
 * 
 */
package com.hls.ws.modules.mail.dao;

import java.util.List;

import com.hls.ws.modules.mail.entity.MailCommon;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 常用联系人DAO接口
 * @author lq
 * @version 2016-09-10
 */
@MyBatisDao
public interface MailCommonDao extends CrudDao<MailCommon> {
	/**
	 * 查询当前登录者常用联系人
	 * @author JERRY
	 * **/
	public List<MailCommon> commonList(MailCommon mailCommon);
	
	/**
	 * 查询常用联系人用于判断重复使用
	 * @author JERRY
	 * **/
	public List<MailCommon> findCommon(MailCommon mailCommon);
	/**
	 * 根据ID删除常用联系人信息
	 * @author JERRY
	 * **/
	public int delCommon(MailCommon mailCommon);
}