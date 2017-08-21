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
import com.hls.ws.modules.files.entity.WsFiles;
import com.hls.ws.modules.files.service.WsFilesService;

/**
 * 文件Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/files/wsFiles")
public class WsFilesController extends BaseController {

	@Autowired
	private WsFilesService wsFilesService;
	
	@ModelAttribute
	public WsFiles get(@RequestParam(required=false) String id) {
		WsFiles entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wsFilesService.get(id);
		}
		if (entity == null){
			entity = new WsFiles();
		}
		return entity;
	}
	
	@RequiresPermissions("files:wsFiles:view")
	@RequestMapping(value = {"list", ""})
	public String list(WsFiles wsFiles, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WsFiles> page = wsFilesService.findPage(new Page<WsFiles>(request, response), wsFiles); 
		model.addAttribute("page", page);
		return "modules/files/wsFilesList";
	}

	@RequiresPermissions("files:wsFiles:view")
	@RequestMapping(value = "form")
	public String form(WsFiles wsFiles, Model model) {
		model.addAttribute("wsFiles", wsFiles);
		return "modules/files/wsFilesForm";
	}

	@RequiresPermissions("files:wsFiles:edit")
	@RequestMapping(value = "save")
	public String save(WsFiles wsFiles, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wsFiles)){
			return form(wsFiles, model);
		}
		wsFilesService.save(wsFiles);
		addMessage(redirectAttributes, "保存文件成功");
		return "redirect:"+Global.getAdminPath()+"/files/wsFiles/?repage";
	}
	
	@RequiresPermissions("files:wsFiles:edit")
	@RequestMapping(value = "delete")
	public String delete(WsFiles wsFiles, RedirectAttributes redirectAttributes) {
		wsFilesService.delete(wsFiles);
		addMessage(redirectAttributes, "删除文件成功");
		return "redirect:"+Global.getAdminPath()+"/files/wsFiles/?repage";
	}

}