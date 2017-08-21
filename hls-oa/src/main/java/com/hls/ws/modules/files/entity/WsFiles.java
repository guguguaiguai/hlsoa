/**
 * 
 */
package com.hls.ws.modules.files.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.common.persistence.DataEntity;

/**
 * 文件Entity
 * @author lq
 * @version 2016-05-06
 */
public class WsFiles extends DataEntity<WsFiles> {
	
	private static final long serialVersionUID = 1L;
	private String fileTitle;		// 文件标题
	private String fileNames;		// 文件名称
	private String filePath;		// 文件路径
	
	public WsFiles() {
		super();
	}

	public WsFiles(String id){
		super(id);
	}

	@Length(min=1, max=1200, message="文件标题长度必须介于 1 和 1200 之间")
	public String getFileTitle() {
		return fileTitle;
	}

	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	
	@Length(min=0, max=2100, message="文件名称长度必须介于 0 和 2100 之间")
	public String getFileNames() {
		return fileNames;
	}

	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}
	
	@Length(min=1, max=2100, message="文件路径长度必须介于 1 和 2100 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}