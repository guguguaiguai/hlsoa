/**
 * 
 */
package com.lq.work.modules.oa.dao;

import java.util.List;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.oa.entity.OaNotifyRecord;

/**
 * 通知通告记录DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface OaNotifyRecordDao extends CrudDao<OaNotifyRecord> {

	/**
	 * 插入通知记录
	 * @param oaNotifyRecordList
	 * @return
	 */
	public int insertAll(List<OaNotifyRecord> oaNotifyRecordList);
	
	/**
	 * 根据通知ID删除通知记录
	 * @param oaNotifyId 通知ID
	 * @return
	 */
	public int deleteByOaNotifyId(String oaNotifyId);
	
	/**
	 * 根据当前登录者及公告ID查询是否已读
	 * @author JERRY
	 * **/
	public Long notifyReadCount(OaNotifyRecord onr);
	/**
	 * 按照部门分组统计各部门已读与未读人数
	 * @author JERRY
	 * **/
	public List<OaNotifyRecord> notifyReadInfo(OaNotifyRecord onr);
}