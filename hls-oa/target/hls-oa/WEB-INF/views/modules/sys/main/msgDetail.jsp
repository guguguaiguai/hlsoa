<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息详情</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		table{border-spacing:0;width:100%}.bordered{border:solid #ccc 1px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;-webkit-box-shadow:0 1px 1px #ccc;-moz-box-shadow:0 1px 1px #ccc;box-shadow:0 1px 1px #ccc}.bordered tr:hover{-o-transition:all .1s ease-in-out;-webkit-transition:all .1s ease-in-out;-moz-transition:all .1s ease-in-out;-ms-transition:all .1s ease-in-out;transition:all .1s ease-in-out}.bordered td,.bordered th{border-left:1px solid #ccc;border-top:1px solid #ccc;padding:10px;text-align:left}.bordered th{-webkit-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;box-shadow:0 1px 0 rgba(255,255,255,.8) inset;text-shadow:0 1px 0 rgba(255,255,255,.5)}.bordered th:first-child{-moz-border-radius:6px 0 0 0;-webkit-border-radius:6px 0 0 0;border-radius:6px 0 0 0}.bordered th:last-child{-moz-border-radius:0 6px 0 0;-webkit-border-radius:0 6px 0 0;border-radius:0 6px 0 0}.bordered th:only-child{-moz-border-radius:6px 6px 0 0;-webkit-border-radius:6px 6px 0 0;border-radius:6px 6px 0 0}.bordered tr:last-child td:first-child{-moz-border-radius:0 0 0 6px;-webkit-border-radius:0 0 0 6px;border-radius:0 0 0 6px}.bordered tr:last-child td:last-child{-moz-border-radius:0 0 6px 0;-webkit-border-radius:0 0 6px 0;border-radius:0 0 6px 0}
	</style>
</head>
<body>
	<table class="bordered">
		<tbody>
			<tr>
				<th width="15%">发信人：</th>
				<td width="35%">${mmsg.createBy.name }</td>
				<th width="15%">时间：</th>
				<td width="35%"><fmt:formatDate value="${mmsg.createDate }" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<th>内容：</th>
				<td colspan="3">${mmsg.msgContent }</td>
			</tr>
		</tbody>
	</table>
</body>
</html>