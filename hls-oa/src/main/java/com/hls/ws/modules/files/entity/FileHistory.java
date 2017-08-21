/**
 * 
 */
package com.hls.ws.modules.files.entity;

import org.hibernate.validator.constraints.Length;
import com.lq.work.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.lq.work.common.persistence.DataEntity;

/**
 * 文件下载记录Entity
 * @author lq
 * @version 2016-05-06
 */
public class FileHistory extends DataEntity<FileHistory> {
	
	private static final long serialVersionUID = 1L;
	private String fileId;		// 文件主键
	private User fileDownload;		// 下载者
	private String fileName;		// 下载文件名
	
	public FileHistory() {
		super();
	}

	public FileHistory(String id){
		super(id);
	}

	@Length(min=1, max=64, message="文件主键长度必须介于 1 和 64 之间")
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	@NotNull(message="下载者不能为空")
	public User getFileDownload() {
		return fileDownload;
	}

	public void setFileDownload(User fileDownload) {
		this.fileDownload = fileDownload;
	}
	
	@Length(min=0, max=2100, message="下载文件名长度必须介于 0 和 2100 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}