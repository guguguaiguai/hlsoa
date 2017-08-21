/**
 * 
 */
package com.hls.ws.modules.attach.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.lq.work.common.persistence.DataEntity;

/**
 * 附件信息Entity
 * @author lq
 * @version 2016-09-08
 */
public class FileAttach extends DataEntity<FileAttach> {
	
	private static final long serialVersionUID = 1L;
	private String fileOname;		// 文件名
	private String fileName;		// 新文件名
	private String fileExt;		// 文件扩展名
	private String fileType;		// 附件类型
	private Long totalBytes;		// 文件大小
	private String filePath;		// 文件存放路径
	private String mid;//模块主键
	
	public FileAttach() {
		super();
	}

	public FileAttach(String id){
		super(id);
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	@Length(min=1, max=900, message="文件名长度必须介于 1 和 900 之间")
	public String getFileOname() {
		return fileOname;
	}

	public void setFileOname(String fileOname) {
		this.fileOname = fileOname;
	}
	
	@Length(min=1, max=900, message="新文件名长度必须介于 1 和 900 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=32, message="文件扩展名长度必须介于 0 和 32 之间")
	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	
	@Length(min=1, max=128, message="附件类型长度必须介于 1 和 128 之间")
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	@NotNull(message="文件大小不能为空")
	public Long getTotalBytes() {
		return totalBytes;
	}

	public void setTotalBytes(Long totalBytes) {
		this.totalBytes = totalBytes;
	}
	
	@Length(min=1, max=300, message="文件存放路径长度必须介于 1 和 300 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}