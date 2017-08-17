<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<base href="<%=basePath%>">
	<!-- 2016-10-21 -->
	<!-- <script type="text/javascript">
	$(function(){
		var files="${mnotify.files}";
		var fc="";
		$.each(files.split("|"),function(i,d){
			if(d!="")
				fc+="<li><a href=\"../../../servlet/fd?url="+decodeURIComponent(d)+"\" url=\""+d+"\" target=\"_blank\">"+decodeURIComponent(d.substring(d.lastIndexOf("/")+1))+"</a></li>";
		});
		$("#file_preview").append(fc);
	});
	</script> -->
</head>
<body>
	<div class="container">
		<div class="span12">
			<h3 style="color:#555555;font-size:20px;text-align:center;">
			${mnotify.title}
			</h3>
			<div style="border-bottom:1px dotted #ddd;padding-bottom:2px;margin:1px 0px 20px 0px;text-align:right;">
				${mnotify.createBy.name} &nbsp; 
				<fmt:formatDate value="${mnotify.createDate}" pattern="yyyy-MM-dd"/> &nbsp; 
			</div>
			<div>${fns:unescapeHtml(mnotify.content) }</div>
		</div>
		<div class="span12" style="border-top:1px dotted #ddd;">
		<c:if test="${!empty mnotify.files}">
		<span class="label label-success">附件：</span>
			<ol id="file_preview">
				<c:forEach items="${mnotify.files}" var="mf">
						<li>
							<a href="<%=basePath%>/servlet/fd?url=&fid=${mf.id}&fd=1&m=0" url="" target="_blank">${mf.fileOname}</a>&nbsp;&nbsp;											
							<%-- <a href="javascript:" onclick="fileDel('${mf.id}',this)">×</a> --%>
						</li>
				</c:forEach>
			</ol>
		</c:if>
		</div>
	</div>
</body>

</html>