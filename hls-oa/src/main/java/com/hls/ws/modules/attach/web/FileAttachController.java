/**
 * 
 */
package com.hls.ws.modules.attach.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hls.ws.modules.attach.entity.FileAttach;
import com.hls.ws.modules.attach.service.FileAttachService;
import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.Encodes;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;

/**
 * 附件信息Controller
 * @author lq
 * @version 2016-09-08
 */
@Controller
@RequestMapping(value = "${adminPath}/attach/fileAttach")
public class FileAttachController extends BaseController {

	@Autowired
	private FileAttachService fileAttachService;
	
	@ModelAttribute
	public FileAttach get(@RequestParam(required=false) String id) {
		FileAttach entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = fileAttachService.get(id);
		}
		if (entity == null){
			entity = new FileAttach();
		}
		return entity;
	}
	
	@RequiresPermissions("attach:fileAttach:view")
	@RequestMapping(value = {"list", ""})
	public String list(FileAttach fileAttach, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FileAttach> page = fileAttachService.findPage(new Page<FileAttach>(request, response), fileAttach); 
		model.addAttribute("page", page);
		return "modules/attach/fileAttachList";
	}

	@RequiresPermissions("attach:fileAttach:view")
	@RequestMapping(value = "form")
	public String form(FileAttach fileAttach, Model model) {
		model.addAttribute("fileAttach", fileAttach);
		return "modules/attach/fileAttachForm";
	}

	@RequiresPermissions("attach:fileAttach:edit")
	@RequestMapping(value = "save")
	public String save(FileAttach fileAttach, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileAttach)){
			return form(fileAttach, model);
		}
		fileAttachService.save(fileAttach);
		addMessage(redirectAttributes, "保存附件信息成功");
		return "redirect:"+Global.getAdminPath()+"/attach/fileAttach/?repage";
	}
	
	@RequiresPermissions("attach:fileAttach:edit")
	@RequestMapping(value = "delete")
	public String delete(FileAttach fileAttach, RedirectAttributes redirectAttributes) {
		fileAttachService.delete(fileAttach);
		addMessage(redirectAttributes, "删除附件信息成功");
		return "redirect:"+Global.getAdminPath()+"/attach/fileAttach/?repage";
	}
	/**
	 * 删除文件
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "fdel")
	public void fileDel(FileAttach fileAttach,HttpServletRequest request,HttpServletResponse response){
		System.out.println(fileAttach.getFilePath()+"..."+fileAttach.getFileName());
		System.out.println(Encodes.urlDecode(fileAttach.getFilePath()));
		fileAttachService.delete(fileAttach);
		File file = new File(Encodes.urlDecode(fileAttach.getFilePath())+"/"+fileAttach.getFileName());
		if(file.exists()){
			if(file.delete()){
				renderString(response, new Message(Boolean.TRUE,"文件删除成功"));
			}else{
				renderString(response, new Message(Boolean.FALSE,"文件删除失败"));
			}
		}
	}
}