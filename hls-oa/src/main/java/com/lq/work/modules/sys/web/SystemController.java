package com.lq.work.modules.sys.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Lists;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.hls.ws.modules.mail.service.MailReceiveService;
import com.hls.ws.modules.mail.service.MsgEmailService;
import com.hls.ws.modules.message.entity.InternalReceive;
import com.hls.ws.modules.message.entity.MsgInternal;
import com.hls.ws.modules.message.service.MsgInternalService;
import com.hls.ws.modules.news.entity.NewsHistory;
import com.hls.ws.modules.news.entity.WsNews;
import com.hls.ws.modules.news.service.NewsHistoryService;
import com.hls.ws.modules.news.service.WsNewsService;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.oa.entity.OaNotify;
import com.lq.work.modules.oa.service.OaNotifyService;
import com.lq.work.modules.sys.service.SystemService;
import com.lq.work.modules.sys.utils.UserUtils;
/**
 * 系统公共Controller
 * **/
@Controller
@RequestMapping(value = "${adminPath}/common/system")
public class SystemController extends BaseController {

	@Autowired
	private SystemService systemService;
	@Autowired
	private OaNotifyService oaNotifyService;
	@Autowired
	private MsgInternalService msgInternalService;
	@Autowired
	private WsNewsService wsNewsService;
	@Autowired
	private NewsHistoryService newsHistoryService;
	@Autowired
	private MsgEmailService msgEmailService;
	@Autowired
	private MailReceiveService mailReceiveService;
	
	@RequiresPermissions("user")
	@RequestMapping(value = "main")
	public String index(Model model) {
		@SuppressWarnings("rawtypes")
		Map<String,List> map = new HashMap<String,List>();
		/*通知公告*/
		List<OaNotify> notify_list=Lists.newArrayList();
		notify_list=this.systemService.mainNotify(new OaNotify());
		map.put("notifyList", notify_list);
		/*内部消息*/
		List<InternalReceive> ir_list=Lists.newArrayList();
		ir_list=this.systemService.mainInternal(new InternalReceive());
		map.put("irList", ir_list);
		/*院内新闻*/
		List<WsNews> news_list=Lists.newArrayList();
		news_list=this.systemService.mainNews(new WsNews());
		map.put("newsList", news_list);
		/*内部邮件*/
		List<MsgEmail> mail_list=Lists.newArrayList();
		mail_list=this.systemService.mainMail(new MsgEmail());
		map.put("mailList", mail_list);
		model.addAttribute("obj", map);
		return "modules/sys/main";
	}
	/**
	 * 首页信息AJA请求处理
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mi")
	public void mainIndex(HttpServletRequest request,HttpServletResponse response){
		@SuppressWarnings("rawtypes")
		Map<String,List> map = new HashMap<String,List>();
		/*通知公告*/
		List<OaNotify> notify_list=Lists.newArrayList();
		notify_list=this.systemService.mainNotify(new OaNotify());
		map.put("notifyList", notify_list);
		/*内部消息*/
		List<InternalReceive> ir_list=Lists.newArrayList();
		ir_list=this.systemService.mainInternal(new InternalReceive());
		map.put("irList", ir_list);
		/*院内新闻*/
		List<WsNews> news_list=Lists.newArrayList();
		news_list=this.systemService.mainNews(new WsNews());
		map.put("newsList", news_list);
		/*内部邮件*/
		List<MsgEmail> mail_list=Lists.newArrayList();
		mail_list=this.systemService.mainMail(new MsgEmail());
		map.put("mailList", mail_list);
		renderString(response, map);
	}
	/**
	 * 公告详情
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "notify")
	public String notifyDetail(String id,Model model){
		OaNotify notify = new OaNotify();
		if(StringUtils.isNotEmpty(id))
			notify=this.oaNotifyService.detail(new OaNotify(id));
		model.addAttribute("mnotify", notify);
		return "modules/sys/main/oaNotifyDetail";
	}
	/**
	 * 消息详情
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "msg")
	public String msgDetail(String id,Model model){
		/*更新阅读状态*/
		MsgInternal msgInternal = new MsgInternal(id);
		msgInternal.setMsgState("0");
		msgInternal=this.msgInternalService.detail(msgInternal);
		if(msgInternal!=null)
			this.msgInternalService.updateState(msgInternal);
		model.addAttribute("mmsg", msgInternal);
		return "modules/sys/main/msgDetail";
	}
	/**
	 * 新闻详情
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "news")
	public String newsDetail(String id,Model model){
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
		model.addAttribute("newsdetail", wsNews);
		return "modules/sys/main/wsNewsDetail";
	}
	/**
	 * 邮件详情
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mail")
	public String mailDetail(String id,Model model){
		if(StringUtils.isEmpty(id)){
			model.addAttribute("mmail", new MsgEmail());
		}else{
			MsgEmail msgEmail=this.msgEmailService.detail(new MsgEmail(id));
			if(msgEmail==null){
				model.addAttribute("mmail", new MsgEmail());
				return "modules/sys/main/mailDetail";
			}
			/**
			 * 查询是否已读，如果未读则更新
			 * **/
			MailReceive mr = new MailReceive(UserUtils.getUser(),new MsgEmail(msgEmail.getId()));
			
			if(StringUtils.equals(mr.getMailState(), "0")&&StringUtils.equals(mr.getIsDel(), "0")){
				mr.setMailState("1");mr.setReadDate(new Date());
				this.mailReceiveService.readFlag(mr);
				model.addAttribute("mmail", msgEmail);
			}else if(StringUtils.equals(mr.getIsDel(), "1")){
				model.addAttribute("mmail", new MsgEmail());
			}else{
				model.addAttribute("mmail", msgEmail);
			}
		}
		return "modules/sys/main/mailDetail";
	}
}
