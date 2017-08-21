/**
 * 
 */
package com.lq.work.modules.oa.dao;

import java.util.List;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.oa.entity.OaNotifyDep;
import com.lq.work.modules.oa.entity.OaNotifyRecord;

/**
 * 部门公告记录DAO接口
 * @author lq
 * @version 2016-05-08
 */
@MyBatisDao
public interface OaNotifyDepDao extends CrudDao<OaNotifyDep> {
	/**
	 * 根据通知ID删除通知记录
	 * @param oaNotifyId 通知ID
	 * @return
	 */
	public int deleteByOaNotifyId(String oaNotifyId);
	/**
	 * 插入通知记录
	 * @param oaNotifyRecordList
	 * @return
	 */
	public int insertAll(List<OaNotifyDep> depList);
}