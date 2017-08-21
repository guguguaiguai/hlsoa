<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻信息详情</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="container">
		<div class="span10">
			<h3 style="color:#555555;font-size:20px;text-align:center;">
			${newsdetail.newsTitle}
			</h3>
			<div style="border-bottom:1px dotted #ddd;padding-bottom:2px;margin:1px 0px 20px 0px;text-align:right;">
				${newsdetail.createBy.name} &nbsp; 
				<fmt:formatDate value="${newsdetail.createDate}" pattern="yyyy-MM-dd"/> &nbsp; 
				阅读数：${newsdetail.newsClick} &nbsp; 
			</div>
			<div>${fns:unescapeHtml(newsdetail.newsContent) }</div>
		</div>
	</div>
</body>
</html>