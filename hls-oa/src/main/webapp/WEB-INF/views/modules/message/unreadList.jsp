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
					if($(this).prop("checked")&&$(this).attr("is_read")=='1'){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择已读内部消息！', '提示');
				}else{
					top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
						if (v == 'ok'){
							$.getJSON("${ctx}/message/internalReceive/delmsg",{mid:nids.join(",")},function(data){
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
		});
		function msg_detail(id){
			top.$.jBox.open("iframe:${ctx}/message/msgInternal/detail?id="+id,"消息详情",800,300,{"top":'10%',"iframeScrolling":'no',closed:function(){window.location.reload();}});
		}
		
		function msg_del(mid){
			if(mid==null||mid==""){
				top.$.jBox.info("请选择删除数据","提示");
				return;
			}
			top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
				if (v == 'ok'){
					$.getJSON("${ctx}/message/internalReceive/delmsg",{mid:mid},function(data){
						if(data.success){
							top.$.jBox.success("数据删除成功","提示");
							window.location.reload();
						}else{
							top.$.jBox.error("删除失败，"+data.msg,"异常");
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
	<form:form id="searchForm" modelAttribute="internalReceive" action="${ctx}/message/internalReceive/unreadList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${rlist.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${rlist.pageSize}"/>
		<ul class="ul-form">
			<li><label>发信人：</label>
				<sys:treeselect id="send_id" name="sendId.id" value="${internalReceive.sendId.id}" labelName="" labelValue="${internalReceive.sendId.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true" isAll="true"/>
			</li>
			
			<li>
			<li><label>消息内容：</label>
				<form:input path="msgId.msgContent" htmlEscape="false" maxlength="3000" class="input-medium"/>
			</li>
			<%--<li><label>消息类别：</label>
				<form:radiobuttons path="msgId.msgType" items="${fns:getDictList('internal_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			 <li><label>发信时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${msgInternal.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${msgInternal.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btach_del" class="btn btn-primary" type="button" value="删除"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="message_check" />
				</th>
				<th>发信人</th>
				<th>消息内容</th>
				<th>阅读状态</th>
				<th>消息类别</th>
				<th>发信时间</th>
				<shiro:hasPermission name="message:msgInternal:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${rlist.list}" var="msgInternal">
			<tr>
				<td>
					<input type="checkbox" name="list_check" value="${msgInternal.msgId.id}" is_read="${msgInternal.readState}" />
				</td>
				<td>
					${msgInternal.sendId.name}
				</td>
				<td><a href="javascript:void(0);" onclick="msg_detail('${msgInternal.msgId.id}')">
					${msgInternal.msgId.msgContent}</a>
				</td>
				<td>
					${fns:getDictLabel(msgInternal.readState, 'oa_notify_read', '')}
				</td>
				<td>
					${fns:getDictLabel(msgInternal.msgId.msgType, 'internal_msg_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${msgInternal.readDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<a href="javascript:void(0);" onclick="msg_del('${msgInternal.msgId.id}')">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${rlist}</div>
</body>
</html>