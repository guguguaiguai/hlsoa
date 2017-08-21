/**
 * 
 */
package com.hls.ws.modules.attach.dao;

import java.util.List;

import com.hls.ws.modules.attach.entity.FileAttach;
import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;

/**
 * 附件信息DAO接口
 * @author lq
 * @version 2016-09-08
 */
@MyBatisDao
public interface FileAttachDao extends CrudDao<FileAttach> {
	/**
	 * 查询邮件附件信息
	 * **/
	public List<FileAttach> fileMail(FileAttach fileAttach);
}