/**
 * 
 */
package com.hls.ws.modules.files.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.hls.ws.modules.files.entity.FileHistory;

/**
 * 文件下载记录DAO接口
 * @author lq
 * @version 2016-05-06
 */
@MyBatisDao
public interface FileHistoryDao extends CrudDao<FileHistory> {
	
}