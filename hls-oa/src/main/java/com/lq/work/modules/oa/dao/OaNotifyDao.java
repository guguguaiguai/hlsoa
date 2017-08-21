/**
 * 
 */
package com.lq.work.modules.oa.dao;

import java.util.List;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.oa.entity.OaNotify;

/**
 * 通知通告DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface OaNotifyDao extends CrudDao<OaNotify> {
	
	/**
	 * 获取通知数目
	 * @param oaNotify
	 * @return
	 */
	public Long findCount(OaNotify oaNotify);
	/**
	 * 根据当前登录者所在部门查询通知
	 * **/
	public List<OaNotify> findNotifyDep(OaNotify oaNotify);
	/**
	 * 通知回退
	 * **/
	public int notifyBack(OaNotify oaNotify);
	/**
	 * 详情
	 * **/
	public OaNotify detail(OaNotify oaNotify);
	/**
	 * 首页公告信息
	 * **/
	public List<OaNotify> mainNotify(OaNotify oaNotify);
	/**
	 * 公告管理列表
	 * **/
	public List<OaNotify> findNotifyList(OaNotify oaNotify);
}