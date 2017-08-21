<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部消息接收管理</title>
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
		<c:forEach items="${rlist}" var="ir">
			<tr>
				<td>${ir.receiveId.name }</td>
				<td>${fns:getDictLabel(ir.readState, 'oa_notify_read', '')}</td>
				<td><fmt:formatDate value="${ir.readDate}" pattern="yyyy-MM-dd"/></td>
				<td>${fns:getDictLabel(ir.delFlag, 'del_flag', '')}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>