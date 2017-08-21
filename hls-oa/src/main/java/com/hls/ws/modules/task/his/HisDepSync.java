package com.hls.ws.modules.task.his;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.lq.work.common.utils.SpringContextHolder;
import com.lq.work.modules.sys.service.OfficeService;

/**
 * his科室信息定时同步
 * **/
@SuppressWarnings("serial")
@Service
@Lazy(false)
public class HisDepSync {

	/**
	 * 科室同步，全部,23:15开始同步
	 * **/
	@Scheduled(cron="0 0 23 * * ?")
	public void depSync(){
		OfficeService officeService=SpringContextHolder.getBean(OfficeService.class);
		Map map = new HashMap();
		officeService.hisDep(map);
		System.out.println(map.get("office_result")+"...定时更新"+new Date());
	}
}
