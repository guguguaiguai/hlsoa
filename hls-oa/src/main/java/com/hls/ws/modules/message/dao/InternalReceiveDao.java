/**
 * 
 */
package com.hls.ws.modules.message.dao;

import java.util.List;

import com.hls.ws.modules.message.entity.InternalReceive;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 内部消息接收DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface InternalReceiveDao extends CrudDao<InternalReceive> {
	/**
	 * 批量插入接收者信息
	 * @author JERRY
	 * @version 2016-05-09
	 * **/
	public int insertAll(List<InternalReceive> list);
	/**
	 * 根据消息主键删除接收者信息
	 * @author JERRY
	 * **/
	public int delReceive(String msgId);
	/**
	 * 查询当前登录者内部消息
	 * **/
	public List<InternalReceive> unreadList(InternalReceive ir);
	/**
	 * 更新消息阅读状态
	 * **/
	public int updateState(InternalReceive ir);
	/**
	 * 查询消息是否已读
	 * **/
	public Long selectRead(InternalReceive ir);
	/**
	 * 根据消息ID，接收者ID删除消息
	 * **/
	public int delMsg(InternalReceive ir);
	/**
	 * 消息撤回
	 * **/
	public int msgBack(InternalReceive ir);
	/**
	 * 查询消息接收者阅读情况
	 * **/
	public List<InternalReceive> findReceive(InternalReceive ir);
	/**
	 * 主页默认读取5条消息
	 * @author JERRY
	 * **/
	public List<InternalReceive> mainInternalReceive(InternalReceive ir);
}