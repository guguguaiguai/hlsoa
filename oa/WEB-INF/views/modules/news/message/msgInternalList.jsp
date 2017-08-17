<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部消息发送管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#message_check").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			/*批量删除*/
			$("#btach_del").click(function(){
				var nids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop("checked")){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择内部消息！', '提示');
				}else{
					top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
						if (v == 'ok'){
							$.getJSON("${ctx}/message/msgInternal/batchDel",{ids:nids.join(",")},function(data){
								if(data.success){
									top.$.jBox.success('操作成功！', '提示', { closed: function () { window.location.reload(); } });
								}else{
									top.$.jBox.error('操作失败，'+data.msg, '异常');
								}
							});
						}
					});
					
				}
			});
			$("#msg_send").click(function(){
				window.location.href="${ctx}/message/msgInternal/form";
			});
		});
		function msg_read(mid){
			top.$.jBox.open("iframe:${ctx}/message/internalReceive/fr?mid="+mid,"消息阅读情况",800,300,{"top":'10%',"iframeScrolling":'no'});
		}
		function msg_back(mid){
			if(mid==null||mid==""){
				top.$.jBox.info("请选择撤回信息","提示");
				return;
			}
			top.$.jBox.confirm("确定撤回吗？", "提示", function(v,h,f){
				if (v == 'ok'){
					$.getJSON("${ctx}/message/msgInternal/msgback",{mid:mid},function(data){
						if(data.success){
							top.$.jBox.success("信息撤回成功！","提示");
							window.location.reload();
						}else{
							top.$.jBox.error("信息撤回失败，"+data.msg,"异常");
						}
					});
				}
			});
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/message/msgInternal/">内部消息发送列表</a></li>
		<shiro:hasPermission name="message:msgInternal:edit"><li><a href="${ctx}/message/msgInternal/form">内部消息发送添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="msgInternal" action="${ctx}/message/msgInternal/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<!--  <li class="btns"><input id="msg_send" class="btn btn-primary" type="button" value="发消息"/></li>-->
			<li><label>收信人：</label>
				<sys:treeselect id="acceptor" name="acceptor" value="${msgInternal.acceptor}" labelName="acceptorName" labelValue="${msgInternal.acceptorName}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true" isAll="true"/>
			</li>
			<li><label>消息内容：</label>
				<form:input path="msgContent" htmlEscape="false" maxlength="3000" class="input-medium"/>
			</li>
			<%-- <li><label>消息类别：</label>
				<form:radiobuttons path="msgType" items="${fns:getDictList('internal_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li> --%>
			<li><label>发信时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:110px;"
					value="<fmt:formatDate value="${msgInternal.beginCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:110px;"
					value="<fmt:formatDate value="${msgInternal.endCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			
			<li class="btns"><input id="btach_del" class="btn btn-primary" type="button" value="删除"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="5%">
					<input type="checkbox" id="message_check" />
				</th>
				<th width="22%">收信人</th>
				<th width="38%">消息内容</th>
				<th width="7%">消息类别</th>
				<th width="7%">消息状态</th>
				<th width="15%">发信时间</th>
				<shiro:hasPermission name="message:msgInternal:edit"><th width="5%">操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="msgInternal">
			<tr>
				<td>
					<input type="checkbox" name="list_check" value="${msgInternal.id}" />
				</td>
				<td><a href="javascript:void(0);" onclick="msg_read('${msgInternal.id}')">
					${fns:abbr(msgInternal.acceptorName,30)}
				</a></td>
				<td><a href="${ctx}/message/msgInternal/form?id=${msgInternal.id}">
					${msgInternal.msgContent}</a>
				</td>
				<td>
					${fns:getDictLabel(msgInternal.msgType, 'internal_msg_type', '')}
				</td>
				<td>
					${fns:getDictLabel(msgInternal.msgState, 'msg_state_internal', '')}
				</td>
				<td>
					<fmt:formatDate value="${msgInternal.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="message:msgInternal:edit"><td>
					<c:if test="${msgInternal.msgType=='0'&&msgInternal.msgState=='0'}">
						<a href="javascript:void(0);" onclick="msg_back('${msgInternal.id}')">撤回</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>