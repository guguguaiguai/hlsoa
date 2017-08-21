/**
 * 
 */
package com.hls.ws.modules.message.dao;

import java.util.List;

import com.hls.ws.modules.message.entity.MsgInternal;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 内部消息DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface MsgInternalDao extends CrudDao<MsgInternal> {
	/**
	 * 查询当前登录者未读消息数
	 * @author JERRY
	 * **/
	public Long msgCount(MsgInternal msg);
	/**
	 * 消息撤回
	 * **/
	public int msgBack(MsgInternal msg);
	/**
	 * 详情
	 * **/
	public MsgInternal detail(MsgInternal msg);
	/**
	 * 内部消息批量删除
	 * **/
	public int batch_del(List<MsgInternal> list);
}