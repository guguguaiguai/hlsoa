/**
 * 
 */
package com.hls.ws.modules.system.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.common.persistence.DataEntity;

/**
 * 岗位信息Entity
 * @author lq
 * @version 2016-05-06
 */
public class WsPost extends DataEntity<WsPost> {
	
	private static final long serialVersionUID = 1L;
	private String postName;		// 岗位名称
	private String postSort;		// 排序
	private String isView;		// 是否显示
	
	public WsPost() {
		super();
	}

	public WsPost(String id){
		super(id);
	}

	@Length(min=1, max=60, message="岗位名称长度必须介于 1 和 60 之间")
	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}
	
	public String getPostSort() {
		return postSort;
	}

	public void setPostSort(String postSort) {
		this.postSort = postSort;
	}
	
	@Length(min=1, max=1, message="是否显示长度必须介于 1 和 1 之间")
	public String getIsView() {
		return isView;
	}

	public void setIsView(String isView) {
		this.isView = isView;
	}
	
}