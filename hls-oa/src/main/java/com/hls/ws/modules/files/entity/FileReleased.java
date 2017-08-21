/**
 * 
 */
package com.hls.ws.modules.files.entity;

import org.hibernate.validator.constraints.Length;
import com.lq.work.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import com.lq.work.modules.sys.entity.Office;
import java.util.Date;

import com.lq.work.common.persistence.DataEntity;

/**
 * 文件共享Entity
 * @author lq
 * @version 2016-05-06
 */
public class FileReleased extends DataEntity<FileReleased> {
	
	private static final long serialVersionUID = 1L;
	private String fileId;		// 文件主键
	private User fileShare;		// 文件共享人，文件查看权，单个人共享
	private User fileGrantee;		// 文件授权者，共享文件的人（文件拥有人）
	private String fileDownload;		// 文件下载权，是否拥有文件下载权，0：有，1：无
	private String fileEdit;		// 文件修改权，0：有，1：无
	private Office fileDep;		// 共享文件到部门
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	
	public FileReleased() {
		super();
	}

	public FileReleased(String id){
		super(id);
	}

	@Length(min=1, max=64, message="文件主键长度必须介于 1 和 64 之间")
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	public User getFileShare() {
		return fileShare;
	}

	public void setFileShare(User fileShare) {
		this.fileShare = fileShare;
	}
	
	@NotNull(message="文件授权者，共享文件的人（文件拥有人）不能为空")
	public User getFileGrantee() {
		return fileGrantee;
	}

	public void setFileGrantee(User fileGrantee) {
		this.fileGrantee = fileGrantee;
	}
	
	@Length(min=1, max=1, message="文件下载权，是否拥有文件下载权，0：有，1：无长度必须介于 1 和 1 之间")
	public String getFileDownload() {
		return fileDownload;
	}

	public void setFileDownload(String fileDownload) {
		this.fileDownload = fileDownload;
	}
	
	@Length(min=1, max=1, message="文件修改权，0：有，1：无长度必须介于 1 和 1 之间")
	public String getFileEdit() {
		return fileEdit;
	}

	public void setFileEdit(String fileEdit) {
		this.fileEdit = fileEdit;
	}
	
	public Office getFileDep() {
		return fileDep;
	}

	public void setFileDep(Office fileDep) {
		this.fileDep = fileDep;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
		
}