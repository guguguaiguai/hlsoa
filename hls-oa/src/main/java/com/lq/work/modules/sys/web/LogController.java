/**
 * 
 */
package com.lq.work.modules.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.entity.Log;
import com.lq.work.modules.sys.service.LogService;

/**
 * 日志Controller
 * 
 * @version 2013-6-2
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;
	
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = {"list", ""})
	public String list(Log log, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Log> page = logService.findPage(new Page<Log>(request, response), log); 
        model.addAttribute("page", page);
		return "modules/sys/logList";
	}
	/**
	 * 批量删除日志
	 * **/
	@RequiresPermissions("sys:log:delete")
	@RequestMapping(value = "del")
	public void logDel(Log log,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(log.getIds())){
			renderString(response, new Message(Boolean.FALSE,"请选择需要删除的数据！"));
		}else{
			List<Log> list = new ArrayList<Log>();
			for(String id:StringUtils.split(log.getIds(), ",")){
				list.add(new Log(id));
			}
			try {
				int f=this.logService.del(list);
				renderString(response, new Message(Boolean.TRUE,"日志删除成功！"+f));
			} catch (Exception e) {
				renderString(response, new Message(Boolean.FALSE,"数据删除异常！"+e.getMessage()));
			}
			
		}
	}

}
