<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻信息详情</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<a href="javascript:history.go(-1);" title="返回" style="float:right;padding-right:20px;">
		<img alt="返回" src="${ctxStatic }/images/ws-oa/back_32.png" />
	</a>
	<div class="container">
		<div class="span10">
			<h3 style="color:#555555;font-size:20px;text-align:center;">
			${nd.newsTitle}
			</h3>
			<div style="border-bottom:1px dotted #ddd;padding-bottom:2px;margin:1px 0px 20px 0px;text-align:right;">
				${nd.createBy.name} &nbsp; 
				<fmt:formatDate value="${nd.createDate}" pattern="yyyy-MM-dd"/> &nbsp; 
				阅读数：${nd.newsClick} &nbsp; 
			</div>
			<div>${fns:unescapeHtml(nd.newsContent) }</div>
		</div>
	</div>
</body>
</html>