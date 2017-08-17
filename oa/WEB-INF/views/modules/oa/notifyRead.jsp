<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知查看情况</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<form:form id="searchForm" action="${ctx}/oa/oaNotify/rinfo" method="post" class="breadcrumb form-search">
		<input type="hidden" id="nid" name="nid" value="${param.nid}" />
		<ul class="ul-form">
			<li><label>姓名：</label>
				<input type="text" id="qm" name="qm" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>阅读人</th>
				<th>部门</th>
				<th>阅读时间</th>
				<th>查阅状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${nr}" var="ri">
				<tr>
					<td>${ri.uname }</td>
					<td>${ri.depName }</td>
					<td><fmt:formatDate value="${ri.readDate}" pattern="yyyy-MM-dd"/></td>
					<td>${fns:getDictLabel(ri.readFlag, 'oa_notify_read', '')}</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
</body>
</html>