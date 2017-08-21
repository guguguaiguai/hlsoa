/**
 * 
 */
package com.hls.ws.modules.news.web;

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
import com.hls.ws.modules.news.entity.NewsHistory;
import com.hls.ws.modules.news.service.NewsHistoryService;

/**
 * 新闻阅读历史Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/news/newsHistory")
public class NewsHistoryController extends BaseController {

	@Autowired
	private NewsHistoryService newsHistoryService;
	
	@ModelAttribute
	public NewsHistory get(@RequestParam(required=false) String id) {
		NewsHistory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = newsHistoryService.get(id);
		}
		if (entity == null){
			entity = new NewsHistory();
		}
		return entity;
	}
	
	@RequiresPermissions("news:newsHistory:view")
	@RequestMapping(value = {"list", ""})
	public String list(NewsHistory newsHistory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<NewsHistory> page = newsHistoryService.findPage(new Page<NewsHistory>(request, response), newsHistory); 
		model.addAttribute("page", page);
		return "modules/news/newsHistoryList";
	}

	@RequiresPermissions("news:newsHistory:view")
	@RequestMapping(value = "form")
	public String form(NewsHistory newsHistory, Model model) {
		model.addAttribute("newsHistory", newsHistory);
		return "modules/news/newsHistoryForm";
	}

	@RequiresPermissions("news:newsHistory:edit")
	@RequestMapping(value = "save")
	public String save(NewsHistory newsHistory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, newsHistory)){
			return form(newsHistory, model);
		}
		newsHistoryService.save(newsHistory);
		addMessage(redirectAttributes, "保存新闻阅读历史成功");
		return "redirect:"+Global.getAdminPath()+"/news/newsHistory/?repage";
	}
	
	@RequiresPermissions("news:newsHistory:edit")
	@RequestMapping(value = "delete")
	public String delete(NewsHistory newsHistory, RedirectAttributes redirectAttributes) {
		newsHistoryService.delete(newsHistory);
		addMessage(redirectAttributes, "删除新闻阅读历史成功");
		return "redirect:"+Global.getAdminPath()+"/news/newsHistory/?repage";
	}

}