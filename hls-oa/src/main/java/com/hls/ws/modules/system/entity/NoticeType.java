/**
 * 
 */
package com.hls.ws.modules.system.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.common.persistence.DataEntity;

/**
 * 公告类别Entity
 * @author lq
 * @version 2016-05-06
 */
public class NoticeType extends DataEntity<NoticeType> {
	
	private static final long serialVersionUID = 1L;
	private String ntName;		// 名称
	private String ntFile;		// 图片路径
	private Integer ntSort=0;     //排序
	
	public NoticeType() {
		super();
	}

	public NoticeType(String id){
		super(id);
	}

	@Length(min=1, max=60, message="名称长度必须介于 1 和 60 之间")
	public String getNtName() {
		return ntName;
	}

	public void setNtName(String ntName) {
		this.ntName = ntName;
	}
	
	@Length(min=0, max=200, message="图片路径长度必须介于 0 和 200 之间")
	public String getNtFile() {
		return ntFile;
	}

	public void setNtFile(String ntFile) {
		this.ntFile = ntFile;
	}

	public Integer getNtSort() {
		return ntSort;
	}

	public void setNtSort(Integer ntSort) {
		this.ntSort = ntSort;
	}
	
}