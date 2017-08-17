<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部消息发送管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var name_val=new Array();
					$.each($("#acceptor").select2('data'),function(i,d){
						name_val.push(d.name);
					});
					$("#acceptorName").val(name_val.join(","));
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
			/*收件人*/
			$("#acceptor").select2({
				width:"800",
				placeholder: "请输入拼音码或姓名或工号查询",  
                minimumInputLength: 2,  
				multiple:true, 
				tags: false,
				multiple             : true,
				separator            : ",",                             // 分隔符
				maximumSelectionSize : 500,                               // 限制数量
				formatSelection : function (item) { return item.name+"-"+item.officeName; },  // 选择结果中的显示
				formatResult    : function (item) { return item.name+"-"+item.officeName; },  // 搜索列表中的显示				
				ajax:{
					url:"${ctx}/sys/user/uquery", // 异步请求地址 
					type:"post",  
					dataType:"json",  // 数据类型
					data:function(term){// 请求参数（GET）
						return {  
							pydm:term  
						};  
					},
					results:function(data,page){// 构造返回结果
						return {results:data};  
					},
					escapeMarkup : function (m) { return m; }               // 字符转义处理
				}
			});
			var acceptor_=${fns:toJson(msgInternal.ruser)};
			if(acceptor_!=""&&acceptor_!=null){
				$("#acceptor").select2("data",acceptor_);
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/message/msgInternal/">内部消息发送列表</a></li>
		<li class="active"><a href="${ctx}/message/msgInternal/form?id=${msgInternal.id}">内部消息发送<shiro:hasPermission name="message:msgInternal:edit">${not empty msgInternal.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="message:msgInternal:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="msgInternal" action="${ctx}/message/msgInternal/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="acceptorName" />
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">收信人：</label>
			<div class="controls">
				<input type="text" class="input-xlarge" name="acceptor" id="acceptor"/>
				<%-- <sys:treeselect id="acceptor" name="acceptor" value="${msgInternal.receiveIds}" labelName="acceptorName" labelValue="${msgInternal.receiveNames}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true" checked="true" isAll="true"/> --%>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消息内容：</label>
			<div class="controls">
				<form:textarea path="msgContent" style="width:800px;" htmlEscape="false" rows="8" maxlength="3000" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="message:msgInternal:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-info" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>