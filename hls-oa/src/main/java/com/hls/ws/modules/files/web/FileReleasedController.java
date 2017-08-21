/**
 * 
 */
package com.hls.ws.modules.files.web;

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
import com.hls.ws.modules.files.entity.FileReleased;
import com.hls.ws.modules.files.service.FileReleasedService;

/**
 * 文件共享Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/files/fileReleased")
public class FileReleasedController extends BaseController {

	@Autowired
	private FileReleasedService fileReleasedService;
	
	@ModelAttribute
	public FileReleased get(@RequestParam(required=false) String id) {
		FileReleased entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = fileReleasedService.get(id);
		}
		if (entity == null){
			entity = new FileReleased();
		}
		return entity;
	}
	
	@RequiresPermissions("files:fileReleased:view")
	@RequestMapping(value = {"list", ""})
	public String list(FileReleased fileReleased, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FileReleased> page = fileReleasedService.findPage(new Page<FileReleased>(request, response), fileReleased); 
		model.addAttribute("page", page);
		return "modules/files/fileReleasedList";
	}

	@RequiresPermissions("files:fileReleased:view")
	@RequestMapping(value = "form")
	public String form(FileReleased fileReleased, Model model) {
		model.addAttribute("fileReleased", fileReleased);
		return "modules/files/fileReleasedForm";
	}

	@RequiresPermissions("files:fileReleased:edit")
	@RequestMapping(value = "save")
	public String save(FileReleased fileReleased, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileReleased)){
			return form(fileReleased, model);
		}
		fileReleasedService.save(fileReleased);
		addMessage(redirectAttributes, "保存文件共享成功");
		return "redirect:"+Global.getAdminPath()+"/files/fileReleased/?repage";
	}
	
	@RequiresPermissions("files:fileReleased:edit")
	@RequestMapping(value = "delete")
	public String delete(FileReleased fileReleased, RedirectAttributes redirectAttributes) {
		fileReleasedService.delete(fileReleased);
		addMessage(redirectAttributes, "删除文件共享成功");
		return "redirect:"+Global.getAdminPath()+"/files/fileReleased/?repage";
	}

}