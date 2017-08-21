/**
 * 
 */
package com.hls.ws.modules.system.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.hls.ws.modules.system.entity.WsPost;

/**
 * 岗位信息DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface WsPostDao extends CrudDao<WsPost> {
	
}