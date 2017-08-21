<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻信息管理</title>
	<meta name="decorator" content="default"/>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#news_check").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			$("#btn_del").click(function(){
				var news_ids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop('checked'))
						news_ids.push($(this).val());
				});
				if(news_ids.length<1){
					top.$.jBox.info("请选择删除数据！","提示",{opacity:0.6});
				}else{
					top.$.jBox.confirm("确定删除已选数据？","确认",function(v,h,f){
						if(v=='ok'){
							$.getJSON("${ctx}/news/wsNews/bd",{nids:news_ids.join(',')},function(data){
								if(data.success){
									top.$.jBox.info("数据删除成功！","提示",{opacity:0.3,closed:function(){
										window.location.reload();
									}});
								}else{
									top.$.jBox.info("数据删除失败："+data.msg,"异常",{opacity:0.3});
								}
							});
						}
					},{opacity:0.3})
				}
			});
			/*添加新闻*/
			$("#btn_add").click(function(){
				window.location.href="${ctx}/news/wsNews/form";
			});
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
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/news/wsNews/">新闻信息列表</a></li>
		<shiro:hasPermission name="news:wsNews:edit"><li><a href="${ctx}/news/wsNews/form">新闻信息添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="wsNews" action="${ctx}/news/wsNews/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>新闻标题：</label>
				<form:input path="newsTitle" htmlEscape="false" maxlength="300" class="input-medium"/>
			</li>
			<li><label>创建者：</label>
				<sys:treeselect id="createBy" name="createBy.id" value="${wsNews.createBy.id}" labelName="createBy.createBy.name" labelValue="${wsNews.createBy.createBy.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li style="width:360px;"><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:25%"
					value="<fmt:formatDate value="${wsNews.beginCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:25%"
					value="<fmt:formatDate value="${wsNews.endCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<shiro:hasPermission name="news:wsNews:edit">
					<input id="btn_add" class="btn btn-primary" type="button" value="添加"/>
					<input id="btn_del" class="btn btn-primary" type="button" value="删除"/>
				</shiro:hasPermission>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">
					<input type="checkbox" id="news_check" />
				</th>
				<th width="8%">发布者</th>
				<th width="45%">新闻标题</th>
				<th width="5%">是否置顶</th>
				<th width="10%">置顶过期时间</th>
				<th width="8%">发布时间</th>
				<th width="7%">查阅次数</th>
				<shiro:hasPermission name="news:wsNews:edit"><th width="10%">操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wsNews">
			<tr>
				<td>
					<input type="checkbox" name="list_check" value="${wsNews.id}" />
				</td>
				<td>
					${wsNews.createBy.name}
				</td>
				<td><a href="${ctx}/news/wsNews/detail?id=${wsNews.id}">
					${wsNews.newsTitle}
				</a></td>
				<td>
					${fns:getDictLabel(wsNews.newsTop,'is_top','')}
				</td>
				<td>
					<fmt:formatDate value="${wsNews.topEnd}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${wsNews.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${wsNews.newsClick}
				</td>
				<shiro:hasPermission name="news:wsNews:edit"><td>
    				<a href="${ctx}/news/wsNews/form?id=${wsNews.id}">修改</a>
					<a href="${ctx}/news/wsNews/delete?id=${wsNews.id}" onclick="return confirmx('确认要删除该新闻信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>