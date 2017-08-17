<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻信息管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.bordered{border:solid #ccc 0px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;-webkit-box-shadow:0 1px 1px #ccc;-moz-box-shadow:0 1px 1px #ccc;box-shadow:0 1px 1px #ccc}.bordered tr:hover{-o-transition:all .1s ease-in-out;-webkit-transition:all .1s ease-in-out;-moz-transition:all .1s ease-in-out;-ms-transition:all .1s ease-in-out;transition:all .1s ease-in-out}.bordered td,.bordered th{border-left:0px solid #ccc;border-top:0px solid #ccc;padding:10px;text-align:left}.bordered th{-webkit-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;box-shadow:0 1px 0 rgba(255,255,255,.8) inset;text-shadow:0 1px 0 rgba(255,255,255,.5)}.bordered th:first-child{-moz-border-radius:6px 0 0 0;-webkit-border-radius:6px 0 0 0;border-radius:6px 0 0 0}.bordered th:last-child{-moz-border-radius:0 6px 0 0;-webkit-border-radius:0 6px 0 0;border-radius:0 6px 0 0}.bordered th:only-child{-moz-border-radius:6px 6px 0 0;-webkit-border-radius:6px 6px 0 0;border-radius:6px 6px 0 0}.bordered tr:last-child td:first-child{-moz-border-radius:0 0 0 6px;-webkit-border-radius:0 0 0 6px;border-radius:0 0 0 6px}.bordered tr:last-child td:last-child{-moz-border-radius:0 0 6px 0;-webkit-border-radius:0 0 6px 0;border-radius:0 0 6px 0}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/news/wsNews/">新闻信息列表</a></li>
		<li class="active"><a href="${ctx}/news/wsNews/form?id=${wsNews.id}">新闻信息<shiro:hasPermission name="news:wsNews:edit">${not empty wsNews.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="news:wsNews:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/> --%>
	<form:form id="inputForm" modelAttribute="wsNews" action="${ctx}/news/wsNews/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="bordered" style="border-spacing:0;width:100%">
			<tbody>
			    <tr>
					<td colspan="4" style="text-align:left;">
						<shiro:hasPermission name="news:wsNews:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="发 布"/>&nbsp;</shiro:hasPermission>
						<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
					</td>
				</tr>
				<tr>
					<th width="10%">新闻标题：</th>
					<td colspan="3">
						<form:input path="newsTitle" htmlEscape="false" maxlength="300" class="input-xlarge required" style="width:61%;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<th>是否置顶：</th>
					<td>
						<form:radiobuttons path="newsTop" items="${fns:getDictList('is_top')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
					</td>
				</tr>
				<tr>
					<th>过期时间：</th>
					<td>
						<input id="topEnd" name="topEnd" type="text" readonly="readonly" maxlength="20" class="input-small Wdate" style="width:40%;"
							value="<fmt:formatDate value="${wsNews.topEnd}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						<span class="help-inline">过期时间可为空，过期后取消置顶。</span>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<form:textarea id="newsContent" htmlEscape="false" path="newsContent" rows="6" class="input-xxlarge required"/>
						<sys:ckeditor replace="newsContent" uploadPath="/新闻模块/新闻" />
						<%-- <form:textarea path="newsContent" htmlEscape="false" rows="4" class="input-xxlarge required"/> --%>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align:left;">
						<shiro:hasPermission name="news:wsNews:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="发 布"/>&nbsp;</shiro:hasPermission>
						<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</html>