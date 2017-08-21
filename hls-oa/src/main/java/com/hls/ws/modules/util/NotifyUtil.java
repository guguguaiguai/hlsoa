package com.hls.ws.modules.util;

import java.util.List;

import com.hls.ws.modules.system.dao.NoticeTypeDao;
import com.hls.ws.modules.system.entity.NoticeType;
import com.lq.work.common.utils.CacheUtils;
import com.lq.work.common.utils.SpringContextHolder;
import com.lq.work.common.utils.StringUtils;

/**
 * 通知类别字典
 * @author JERRY
 * @version 2016-05-08
 * **/
public class NotifyUtil {
	private static NoticeTypeDao noticeTypeDao = SpringContextHolder.getBean(NoticeTypeDao.class);
	
	public static String NOTIFY_TYPE_LIST="notice_type_list";
	/**
	 * 根据主键读取名称
	 * @param id:主键；value:默认值
	 * @author JERRY
	 * @version 2016-05-08
	 * **/
	public static String noticeTypeName(String id,String value){
		if(StringUtils.isEmpty(id))
			return value;
		List<NoticeType> list = noticeList();
		for(NoticeType nt:list){
			if(StringUtils.equals(id, nt.getId()))
				return nt.getNtName();
		}
		return value;
	}
	/**
	 * 查询通告类别列表信息
	 * @author JERRY
	 * @version 2016-05-08
	 * **/
	public static List<NoticeType> noticeList(){
		@SuppressWarnings("unchecked")
		List<NoticeType> list = (List<NoticeType>)CacheUtils.get(NOTIFY_TYPE_LIST);
		if(list==null){
			list=noticeTypeDao.findAllList(new NoticeType());
			CacheUtils.put(NOTIFY_TYPE_LIST, list);
		}
		return list;
	}
}
