<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部邮件管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/mail/msgEmail/">内部邮件列表</a></li>
		<shiro:hasPermission name="mail:msgEmail:edit"><li><a href="${ctx}/mail/msgEmail/form">内部邮件添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="msgEmail" action="${ctx}/mail/msgEmail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>接收者姓名：</label>
				<form:input path="acceptorNames" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>邮件标题：</label>
				<form:input path="mailTitle" htmlEscape="false" maxlength="300" class="input-medium"/>
			</li>
			<li><label>文件名称：</label>
				<form:input path="fileNames" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>发送时间：</label>
				<input name="beginSendDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${msgEmail.beginSendDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endSendDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${msgEmail.endSendDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>接收者姓名</th>
				<th>邮件标题</th>
				<th>文件名称</th>
				<th>发送时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="mail:msgEmail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="msgEmail">
			<tr>
				<td><a href="${ctx}/mail/msgEmail/form?id=${msgEmail.id}">
					${msgEmail.acceptorNames}
				</a></td>
				<td>
					${msgEmail.mailTitle}
				</td>
				<td>
					${msgEmail.fileNames}
				</td>
				<td>
					<fmt:formatDate value="${msgEmail.sendDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${msgEmail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${msgEmail.remarks}
				</td>
				<shiro:hasPermission name="mail:msgEmail:edit"><td>
    				<a href="${ctx}/mail/msgEmail/form?id=${msgEmail.id}">修改</a>
					<a href="${ctx}/mail/msgEmail/delete?id=${msgEmail.id}" onclick="return confirmx('确认要删除该内部邮件吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>