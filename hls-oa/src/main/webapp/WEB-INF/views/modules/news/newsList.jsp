<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻信息管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		#contentTable table tr td{text-align:center;}
	</style>
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
	<form:form id="searchForm" modelAttribute="wsNews" action="${ctx}/news/wsNews/newsList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${nlist.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${nlist.pageSize}"/>
		<ul class="ul-form">
			<li><label>新闻标题：</label>
				<form:input path="newsTitle" htmlEscape="false" maxlength="300" class="input-medium"/>
			</li>
			<li><label>发布者：</label>
				<sys:treeselect id="createBy" name="createBy.id" value="${createBy.id}" labelName="createBy.createBy.name" labelValue="${createBy.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true" isAll="true"/>
			</li>
			<li><label>发布时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:25%"
					value="<fmt:formatDate value="${wsNews.beginCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:25%"
					value="<fmt:formatDate value="${wsNews.endCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="10%" style="text-align:center;">发布者</th>
				<th width="70%" style="text-align:left;">新闻标题</th>
				<th width="10%" style="text-align:center;">发布时间</th>
				<th width="10%" style="text-align:center;">操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${nlist.list}" var="wsNews">
			<tr>
				<td style="text-align:center;">
					${wsNews.createBy.name}
				</td>
				<td style="text-align:left;"><a href="${ctx}/news/wsNews/detail?id=${wsNews.id}" title="详情">
					${wsNews.newsTitle}
				</a></td>
				<td style="text-align:center;">
					<fmt:formatDate value="${wsNews.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="text-align:center;">
					<a href="${ctx}/news/wsNews/detail?id=${wsNews.id}" title="详情">
						<i class="icon-file-alt"></i>
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${nlist}</div>
</body>
</html>