/**
 * 
 */
package com.lq.work.modules.sys.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.lq.work.common.persistence.DataEntity;

/**
 * 数据库备份Entity
 * @author lq
 * @version 2016-06-27
 */
public class SysDatabase extends DataEntity<SysDatabase> {
	
	private static final long serialVersionUID = 1L;
	private String databaseType;		// 数据库类型
	private Date startTime;		// 备份开始时间
	private Date endTime;		// 备份结束时间
	private String filePath;		// 备份文件路径
	private String fileSize;		// 备份文件大小
	private Date beginStartTime;		// 开始 备份开始时间
	private Date endStartTime;		// 结束 备份开始时间
	private Date beginEndTime;		// 开始 备份结束时间
	private Date endEndTime;		// 结束 备份结束时间
	
	public SysDatabase() {
		super();
	}

	public SysDatabase(String id){
		super(id);
	}

	@Length(min=1, max=2, message="数据库类型长度必须介于 1 和 2 之间")
	public String getDatabaseType() {
		return databaseType;
	}

	public void setDatabaseType(String databaseType) {
		this.databaseType = databaseType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="备份开始时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="备份结束时间不能为空")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=1, max=300, message="备份文件路径长度必须介于 1 和 300 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	public Date getBeginStartTime() {
		return beginStartTime;
	}

	public void setBeginStartTime(Date beginStartTime) {
		this.beginStartTime = beginStartTime;
	}
	
	public Date getEndStartTime() {
		return endStartTime;
	}

	public void setEndStartTime(Date endStartTime) {
		this.endStartTime = endStartTime;
	}
		
	public Date getBeginEndTime() {
		return beginEndTime;
	}

	public void setBeginEndTime(Date beginEndTime) {
		this.beginEndTime = beginEndTime;
	}
	
	public Date getEndEndTime() {
		return endEndTime;
	}

	public void setEndEndTime(Date endEndTime) {
		this.endEndTime = endEndTime;
	}
		
}