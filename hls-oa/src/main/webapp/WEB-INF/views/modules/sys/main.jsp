<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
		body {
    font-family: "open sans","Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 13px;
    color: #676a6c;
    overflow-x: hidden;
}
a {
    color: #337ab7;
    text-decoration: none;
}
p {
    display: block;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
}
h3, h4, h5 {
    margin-top: 5px;
    font-weight: 600;
	    line-height: 1.1;
}
		.gray-bg {
			background-color: #f3f3f4;
		}
		.wrapper-content {
    padding: 20px;
}
.ibox {
    clear: both;
    margin-bottom: 25px;
    margin-top: 0;
    padding: 0;
}
.ibox-title {
    background-color: #51b3eb;
    border-color: #e7eaec;
    -webkit-border-image: none;
    -o-border-image: none;
    border-image: none;
    border-style: solid solid none;
    border-width: 4px 0 0;
    color: inherit;
    margin-bottom: 0;
    padding: 14px 15px 7px;
    min-height: 25px;
}
.ibox-title h5 {
    display: inline-block;
    font-size: 14px;
    margin: 0 0 7px;
    padding: 0;
    text-overflow: ellipsis;
    float: left;
	color:#fff;
}
.ibox-title h5 a {
    display: inline-block;
    font-size: 14px;
    margin: 0 0 7px;
    padding: 0;
    text-overflow: ellipsis;
    float: left;
	color:#fff;
	text-decoration: none;
}
.ibox-tools {
    display: inline-block;
    float: right;
    margin-top: 0;
    position: relative;
    padding: 0;
}
.ibox-tools a {
    cursor: pointer;
    margin-left: 5px;
    color: #c4c4c4;
}
.ibox-content {
    clear: both;
}
.ibox-content {
    background-color: #f5f5f5;
    color: inherit;
    /*padding: 15px 20px 20px;*/
    border-color: #e7eaec;
    -webkit-border-image: none;
    -o-border-image: none;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 0;
}
.no-padding {
    padding: 0!important;
}
.no-padding .list-group {
    margin-bottom: 0;
}
.list-group {
    padding-left: 0;
	margin-left:0;
    margin-bottom: 20px;
}
.list-group-item {
    background-color: inherit;
    border: 1px solid #e7eaec;
    display: block;
    margin-bottom: -1px;
	padding: 0px 10px 0px 10px;
    /*padding: 10px 15px;*/
    position: relative;
}
.no-padding .list-group-item {
    border-left: none;
    border-right: none;
    border-bottom: none;
}
.text-info {
    color: #23c6c8;
}
.text-muted {
    color: #888;
}
.fa {
    display: inline-block;
    font: normal normal normal 14px/1 FontAwesome;
    font-size: inherit;
    text-rendering: auto;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}
.no-padding .list-group-item:first-child {
    border-left: none;
    border-right: none;
    border-bottom: none;
    border-top: none;
}

.feed-activity-list .feed-element {
    border-bottom: 1px solid #e7eaec;
}
.feed-element, .media-body {
    overflow: hidden;
}
.feed-element, .feed-element .media {
    margin-top: 0px;
}
.feed-element {
    padding-bottom: 10px;
}
.feed-element:first-child {
    margin-top: 0;
}
.span6{
	    position: relative;
    min-height: 1px;
    padding-right: 15px;
    padding-left: 15px;
}
.feed-element>.pull-left {
    margin-right: 10px;
}
.feed-element, .media-body {
    overflow: hidden;
}
.media-body, .sidebard-panel .feed-element, .sidebard-panel p {
    font-size: 12px;
}

.chat-element, .media-body {
    overflow: hidden;
}
.media-body, .media-left, .media-right {
    display: table-cell;
    vertical-align: top;
}
.media-body {
    display: block;
    width: auto;
	padding: 10px 10px 0px 10px;
}
.pull-right {
    float: right!important;
}
.small, small {
    font-size: 85%;
}
.text-muted {
    color: #888;
}
	</style>
	<script type="text/javascript">
		$(function(){
			$(".ibox-tools a").click(function(){
				window.parent.addTab($("#"+$(this).attr("tab_")),true);
			});
		});
		function msg_detail(id){
			top.$.jBox.open("iframe:${ctx}/common/system/msg?id="+id,"消息详情",800,300,{"top":'8%',"iframeScrolling":'yes'});
		}
		function notify_detail(id){
			top.$.jBox.open("iframe:${ctx}/common/system/notify?id="+id,"公告详情",1000,550,{"top":'8%',"iframeScrolling":'yes'});
		}
		function news_detail(id){
			top.$.jBox.open("iframe:${ctx}/common/system/news?id="+id,"新闻详情",1000,550,{"top":'7%',"iframeScrolling":'yes'});
		}
		function mail_detail(id){
			top.$.jBox.open("iframe:${ctx}/common/system/mail?fd=0&id="+id,"邮件详情",1000,550,{"top":'7%',"iframeScrolling":'yes'});
		}
		function index_tab(obj,name){
			//alert($(obj).attr("data-url"));
			//window.parent.tab_($(obj).attr("data-url"),name,name);
		}
	</script>
</head>
<body>
<div class="hide">
	<a class="menu" href="${ctx}/oa/oaNotify/index" id="my_notify"><i class="icon-bullhorn"><span>我的通告</span></i></a>
	<a class="menu" href="${ctx}/message/msgInternal" id="inner_msg"><i class="icon-bullhorn"><span>内部消息</span></i></a>
	<a class="menu" href="${ctx}/mail/msgEmail/index" id="msg_email"><i class="icon-bullhorn"><span>内部邮箱</span></i></a>
	<a class="menu" href="${ctx}/news/wsNews/newsList" id="news_"><i class="icon-bullhorn"><span>查阅新闻</span></i></a>
</div>
	<div class="wrapper wrapper-content">
        <div class="row-fluid">
            <div class="span6">
				<div class="ibox-title">
					<h5><a data-url="${ctx}/oa/oaNotify/index" href="javascript:void(0);" ><i class="icon-bullhorn"></i>&nbsp;公告通知</a></h5>
					<div class="ibox-tools">
						<!--<span class="label label-success">10条未读</span>-->
						<a href="javascript:void(0);" style="color:#fff;" alt="更多" title="更多" tab_="my_notify">&gt;&gt;</a>
					</div>
				</div>
				<div class="ibox-content no-padding">
					<ul class="list-group">
						<c:if test="${fn:length(obj.notifyList)>0}">
							<c:forEach items="${obj.notifyList}" var="nl">
								<li class="list-group-item">
									<p>${nl.createBy.name} &nbsp;&nbsp;&nbsp;&nbsp;<a class="text-info" href="javascript:void(0);" onclick="notify_detail('${nl.id}')">${nl.title} </a>
										<span style="float:right;"><fmt:formatDate value="${nl.createDate}" pattern="yyyy-MM-dd"/></span>
									</p>
									<!--<span></span>
									<small class="block text-muted"><i class="fa fa-clock-o"></i> </small>-->
								</li>
							</c:forEach>
							
						</c:if>
						<c:if test="${fn:length(obj.notifyList)<1}">
							<li class="list-group-item">无公告信息！</li>
						</c:if>
					</ul>
				</div>
			</div>
			<div class="span6">
			  <div class="ibox float-e-margins">	
                    <div class="ibox-title">
                        <h5><a href="javascript:void(0);"><i class="icon-bell"></i>&nbsp;内部消息</a></h5>
                        <div class="ibox-tools">
                            <!--<span class="label label-important">10条未读</span>-->
							<a href="javascript:void(0);" style="color:#fff;" alt="更多" title="更多" tab_="inner_msg">&gt;&gt;</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
								<c:if test="${fn:length(obj.irList)>0}">
									<c:forEach items="${obj.irList}" var="irl">
										<div class="feed-element">
											<div class="media-body ">
												<small class="pull-right"><fmt:formatDate value="${irl.msgId.createDate}" pattern="yyyy-MM-dd"/></small>
												<strong>${irl.sendId.name}</strong> &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="msg_detail('${irl.msgId.id}')">${irl.msgId.msgContent}</a>
												<br>
											</div>
										</div>
									</c:forEach>
									
								</c:if>
								<c:if test="${fn:length(obj.irList)<1}">
									<div class="feed-element">
										<div class="media-body ">
										无内部消息！
										</div>
									</div>
								</c:if>
                            </div>
                        </div>
                    </div>
                </div>
			</div></div>
			<div class="row-fluid">
			<div class="span6" style="margin-top:30px;">
				<div class="ibox-title">
						<h5><a href="javascript:void(0);"><i class="icon-list-alt"></i>&nbsp;院内新闻</a></h5>
						<div class="ibox-tools">
							<!--<span class="label label-success">10条未读</span>-->
							<a href="javascript:void(0);" style="color:#fff;" alt="更多" title="更多" tab_="news_">&gt;&gt;</a>
						</div>
				</div>
				<div class="ibox-content no-padding">
					<ul class="list-group">
						<c:if test="${fn:length(obj.newsList)>0}">
							<c:forEach items="${obj.newsList}" var="nsl">
								<li class="list-group-item">
									<p><a class="text-info" href="javascript:void(0);" onclick="news_detail('${nsl.id}')">${nsl.newsTitle}</a> 
										<span style="float:right;"><fmt:formatDate value="${nsl.createDate}" pattern="yyyy-MM-dd"/></span>
									</p>
								</li>
							</c:forEach>
							
						</c:if>
						<c:if test="${fn:length(obj.newsList)<1}">
							<li class="list-group-item">无新闻信息！</li>
						</c:if>
					</ul>
				</div>
			</div>
			<div class="span6" style="margin-top:30px;">
			  <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><a href="javascript:void(0);"><i class="icon-envelope-alt"></i>&nbsp;内部邮件</a></h5>
                        <div class="ibox-tools">
                            <!--<span class="label label-important">10条未读</span>-->
							<a href="javascript:void(0);" style="color:#fff;" alt="更多" title="更多" tab_="msg_email">&gt;&gt;</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
								<c:if test="${fn:length(obj.mailList)>0}">
									<c:forEach items="${obj.mailList}" var="ml">
										<div class="feed-element">
											<div class="media-body ">
												<small class="pull-right"><fmt:formatDate value="${ml.createDate}" pattern="yyyy-MM-dd"/></small>
												<strong>${ml.createBy.name}</strong> &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="mail_detail('${ml.id}')">${ml.mailTitle}</a>
												<br>
											</div>
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(obj.mailList)<1}">
									<div class="feed-element">
										<div class="media-body ">
										无内部邮件！
										</div>
									</div>
								</c:if>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
    </div>
  </div>
</body>
</html>