package com.hls.ws.modules.task.his;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.lq.work.common.utils.SpringContextHolder;
import com.lq.work.modules.sys.service.SystemService;

/**
 * His人员信息定时同步
 * @author JERRY
 * **/
@SuppressWarnings("serial")
@Service
@Lazy(false)
public class HisUserSync {

	/**
	 * 人员定时更新定，全部.23:35开始
	 * **/
	@Scheduled(cron="0 35 23 * * ?")
	public void userSync(){
		SystemService systemService = SpringContextHolder.getBean(SystemService.class);
		Map map = new HashMap();
		systemService.hisUser(map);
		System.out.println(map.get("proc_result")+"...定时更新"+new Date());
	}
}
