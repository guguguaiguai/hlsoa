<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>邮件查阅情况</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>接收人</th>
				<th>阅读状态</th>
				<th>查阅时间</th>
				<th>删除</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${mrlist}" var="ir">
			<tr>
				<td>${ir.mailReceive.name }</td>
				<td>${fns:getDictLabel(ir.mailState, 'oa_notify_read', '')}</td>
				<td><fmt:formatDate value="${ir.readDate}" pattern="yyyy-MM-dd"/></td>
				<td>${fns:getDictLabel(ir.isDel, 'del_flag', '')}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>