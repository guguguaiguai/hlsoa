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
import com.hls.ws.modules.files.entity.FileHistory;
import com.hls.ws.modules.files.service.FileHistoryService;

/**
 * 文件下载记录Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/files/fileHistory")
public class FileHistoryController extends BaseController {

	@Autowired
	private FileHistoryService fileHistoryService;
	
	@ModelAttribute
	public FileHistory get(@RequestParam(required=false) String id) {
		FileHistory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = fileHistoryService.get(id);
		}
		if (entity == null){
			entity = new FileHistory();
		}
		return entity;
	}
	
	@RequiresPermissions("files:fileHistory:view")
	@RequestMapping(value = {"list", ""})
	public String list(FileHistory fileHistory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FileHistory> page = fileHistoryService.findPage(new Page<FileHistory>(request, response), fileHistory); 
		model.addAttribute("page", page);
		return "modules/files/fileHistoryList";
	}

	@RequiresPermissions("files:fileHistory:view")
	@RequestMapping(value = "form")
	public String form(FileHistory fileHistory, Model model) {
		model.addAttribute("fileHistory", fileHistory);
		return "modules/files/fileHistoryForm";
	}

	@RequiresPermissions("files:fileHistory:edit")
	@RequestMapping(value = "save")
	public String save(FileHistory fileHistory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileHistory)){
			return form(fileHistory, model);
		}
		fileHistoryService.save(fileHistory);
		addMessage(redirectAttributes, "保存文件下载记录成功");
		return "redirect:"+Global.getAdminPath()+"/files/fileHistory/?repage";
	}
	
	@RequiresPermissions("files:fileHistory:edit")
	@RequestMapping(value = "delete")
	public String delete(FileHistory fileHistory, RedirectAttributes redirectAttributes) {
		fileHistoryService.delete(fileHistory);
		addMessage(redirectAttributes, "删除文件下载记录成功");
		return "redirect:"+Global.getAdminPath()+"/files/fileHistory/?repage";
	}

}