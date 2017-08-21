/**
 * 
 */
package com.hls.ws.modules.news.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hls.ws.modules.news.entity.NewsHistory;
import com.hls.ws.modules.news.entity.WsNews;
import com.hls.ws.modules.news.service.NewsHistoryService;
import com.hls.ws.modules.news.service.WsNewsService;
import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;

/**
 * 新闻信息Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/news/wsNews")
public class WsNewsController extends BaseController {

	@Autowired
	private WsNewsService wsNewsService;
	@Autowired
	private NewsHistoryService newsHistoryService;
	
	@ModelAttribute
	public WsNews get(@RequestParam(required=false) String id) {
		WsNews entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wsNewsService.get(id);
		}
		if (entity == null){
			entity = new WsNews();
		}
		return entity;
	}
	
	@RequiresPermissions("news:wsNews:mview")
	@RequestMapping(value = {"list", ""})
	public String list(WsNews wsNews, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WsNews> page = wsNewsService.findPage(new Page<WsNews>(request, response), wsNews); 
		model.addAttribute("page", page);
		return "modules/news/wsNewsList";
	}
	/**
	 * 新闻列表页
	 * **/
	@RequiresPermissions("news:wsNews:view")
	@RequestMapping(value = "newsList")
	public String newsList(WsNews wsNews, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<WsNews> page = wsNewsService.newsList(new Page<WsNews>(request, response), wsNews); 
		model.addAttribute("nlist", page);
		return "modules/news/newsList";
	}

	@RequiresPermissions("news:wsNews:view")
	@RequestMapping(value = "form")
	public String form(WsNews wsNews, Model model) {
		model.addAttribute("wsNews", wsNews);
		return "modules/news/wsNewsForm";
	}
	/**
	 * 新闻详情查看
	 * **/
	@RequiresPermissions("news:wsNews:view")
	@RequestMapping(value = "detail")
	public String detail(String id, Model model) {
		WsNews wsNews = new WsNews();
		if(StringUtils.isNotEmpty(id)){
			/*更新点击次数*/
			this.wsNewsService.updateClick(new WsNews(id));
			wsNews=this.wsNewsService.get(id);
			DateTime now = new DateTime();
			/*插入查看历史*/
			NewsHistory nh = new NewsHistory(id,wsNews.getCurrentUser(),now.toDate(),1);
			this.newsHistoryService.save(nh);
		}
		model.addAttribute("nd", wsNews);
		return "modules/news/wsNewsDetail";
	}
	@RequiresPermissions("news:wsNews:edit")
	@RequestMapping(value = "save")
	public String save(WsNews wsNews, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wsNews)){
			return form(wsNews, model);
		}
		//wsNews.setTopStart(new Date());
		wsNewsService.save(wsNews);
		addMessage(redirectAttributes, "保存新闻信息成功");
		return "redirect:"+Global.getAdminPath()+"/news/wsNews/?repage";
	}
	
	@RequiresPermissions("news:wsNews:edit")
	@RequestMapping(value = "delete")
	public String delete(WsNews wsNews, RedirectAttributes redirectAttributes) {
		wsNewsService.delete(wsNews);
		addMessage(redirectAttributes, "删除新闻信息成功");
		return "redirect:"+Global.getAdminPath()+"/news/wsNews/?repage";
	}
	/**
	 * 批量删除
	 * @author JERRY
	 * @version 2016-05-07
	 * **/
	@RequiresPermissions("news:wsNews:edit")
	@RequestMapping(value = "bd")
	public void batchDel(String nids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(nids)){
			renderString(response, new Message(Boolean.FALSE,"请选择删除数据！"));
		}else{
			for(String id:StringUtils.split(nids, ",")){
				this.wsNewsService.delete(new WsNews(id));
			}
			renderString(response, new Message(Boolean.TRUE,"Success!"));
		}
	}
	/**
	 * 更新点击次数
	 * @author lq
	 * @version 2016-05-07
	 * **/
	@RequiresPermissions("news:wsNews:edit")
	@RequestMapping(value = "uc")
	public void updateClick(WsNews news,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(news.getId())){
			renderString(response, new Message(Boolean.FALSE,"Key is NULL!"));
		}else{
			try {
				this.wsNewsService.updateClick(news);//更新点击次数
				DateTime now = new DateTime();
				/*插入查看历史*/
				NewsHistory nh = new NewsHistory(news.getId(),news.getCurrentUser(),now.toDate(),1);
				this.newsHistoryService.save(nh);
				renderString(response, new Message(Boolean.TRUE,"Success!"));
			} catch (Exception e) {
				renderString(response, new Message(Boolean.FALSE,"Fail:"+e.getMessage()+"!"));
			}
		}
	}
	
}