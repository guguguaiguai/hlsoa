/**
 * 
 */
package com.lq.work.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.web.BaseController;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.SysDatabase;
import com.lq.work.modules.sys.service.SysDatabaseService;

/**
 * 数据库备份Controller
 * @author lq
 * @version 2016-06-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysDatabase")
public class SysDatabaseController extends BaseController {

	@Autowired
	private SysDatabaseService sysDatabaseService;
	
	@ModelAttribute
	public SysDatabase get(@RequestParam(required=false) String id) {
		SysDatabase entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysDatabaseService.get(id);
		}
		if (entity == null){
			entity = new SysDatabase();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysDatabase:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysDatabase sysDatabase, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysDatabase> page = sysDatabaseService.findPage(new Page<SysDatabase>(request, response), sysDatabase); 
		model.addAttribute("page", page);
		return "modules/sys/sysDatabaseList";
	}

	@RequiresPermissions("sys:sysDatabase:view")
	@RequestMapping(value = "form")
	public String form(SysDatabase sysDatabase, Model model) {
		model.addAttribute("sysDatabase", sysDatabase);
		return "modules/sys/sysDatabaseForm";
	}

	@RequiresPermissions("sys:sysDatabase:edit")
	@RequestMapping(value = "save")
	public String save(SysDatabase sysDatabase, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysDatabase)){
			return form(sysDatabase, model);
		}
		sysDatabaseService.save(sysDatabase);
		addMessage(redirectAttributes, "保存数据库备份成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysDatabase/?repage";
	}
	
	@RequiresPermissions("sys:sysDatabase:edit")
	@RequestMapping(value = "delete")
	public String delete(SysDatabase sysDatabase, RedirectAttributes redirectAttributes) {
		sysDatabaseService.delete(sysDatabase);
		addMessage(redirectAttributes, "删除数据库备份成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysDatabase/?repage";
	}

}