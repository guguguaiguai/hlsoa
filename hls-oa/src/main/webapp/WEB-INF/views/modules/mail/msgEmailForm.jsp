<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%

String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html>
<head>
	<title>写邮件</title>
	<meta name="decorator" content="default"/>
	<base href="<%=basePath%>">
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.mail-search {
			max-width: 300px;
		}
		.mailbox-content {
			background: 0 0;
			border: none;
			padding: 10px;
		}
		.ibox-content {
			background-color: #fff;
			color: inherit;
			padding: 15px 20px 20px;
			border-color: #e7eaec;
			-webkit-border-image: none;
			-o-border-image: none;
			border-image: none;
			/*border-style: solid solid none;*/
			border-width: 1px 0;
		}
		a {
			cursor: pointer;
			color: #337ab7;
			text-decoration: none;
		}
		.folder-list li a {
			color: #666;
			display: block;
			padding: 5px 0;
			text-decoration: none;
		}
		ol, ul {
			margin-top: 0;
			margin-bottom: 10px;
		}
		.folder-list li {
			border-bottom: 1px solid #e7eaec;
			display: block;
		}
		.pull-right {
			float: right;
		}
		.m-b-md {
			margin-bottom: 20px;
		}
		.file-manager h5 {
			text-transform: uppercase;
		}
		.folder-list li i {
			margin-right: 8px;
			color: #3d4d5d;
		}
		.folder-list li {
			border-bottom: 1px solid #e7eaec;
			display: block;
		}
		.gray-bg {
			background-color: #f3f3f4;
		}
		.mail-box {
    background-color: #fff;
    /*border: 1px solid #e7eaec;*/
    border-top: 0;
    padding: 0;
    margin-bottom: 20px;
}
		.mail-body {
    border-top: 1px solid #e7eaec;
    padding: 20px;
}
.form-control, .single-line {
    background-color: #FFF;
    background-image: none;
    border: 1px solid #e5e6e7;
    border-radius: 1px;
    color: inherit;
    display: block;
    padding: 6px 12px;
    -webkit-transition: border-color .15s ease-in-out 0s,box-shadow .15s ease-in-out 0s;
    transition: border-color .15s ease-in-out 0s,box-shadow .15s ease-in-out 0s;
    width: 75%;
    font-size: 14px;
}
.form-horizontal .control-label {
    padding-top: 7px;
    margin-bottom: 0;
    text-align: center;
}
.mail-body .form-group {
    margin-bottom: 5px;
}
.container {
    width: 190px;
    margin: 0px auto;
	
}
html ul.tabs li.active, html ul.tabs li.active a:hover {
    background: #fff;
    border-bottom: 1px solid #fff;
}
ul.tabs {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height: 32px;
    border-bottom: 1px solid #999;
    /*border-left: 1px solid #999;*/
    width: 100%;
}
ul.tabs li {
    float: left;
    margin: 0;
    padding: 0;
    height: 31px;
    line-height: 31px;
    border: 1px solid #999;
    border-left: none;
	border-top:none;
    margin-bottom: -1px;
    background: #e0e0e0;
    overflow: hidden;
    position: relative;
}
ul.tabs li a {
    text-decoration: none;
    color: #000;
    display: block;
    font-size: 1.2em;
    padding: 0 20px;
    border: 1px solid #fff;
    outline: none;
}
li.active, ul.tabs li.active a:hover {
    background: #fff;
    border-bottom: 1px solid #fff;
}
.ztree {overflow:auto;margin:0;_margin-top:10px;padding:5px 0 0 1px;}
	</style>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/uploadify/uploadify.css" />
	<script type="text/javascript" src="${ctxStatic}/uploadify/jquery.uploadify.js"></script>
	<script type="text/javascript">
		var file_ids=new Array();var tree=null;
		var update_file=${fns:toJson(msgEmail.files)};
		if(update_file.length>0){
			$.each(update_file,function(i,d){
				file_ids.push(d.id);
			});
		}
		$(document).ready(function() {
			var path=encodeURIComponent("邮箱")+'/'+encodeURIComponent("内部邮箱");
			$('#mailUpload').uploadify({
		   　　 'swf':'${ctxStatic}/uploadify/uploadify.swf',
		 　　　 'uploader':'<%=basePath%>/servlet/fu?uid=${fns:getUser().id}',
				'cancelImg':'${ctxStatic}/uploadify/uploadify-cancel.png',
				'formData':{'fileModule':'email','filePath':'/'+path},
				'queueID': 'fileQueue',
				'width': '50',  
				'height': '30',
				'fileSizeLimit':'100MB',
				'queueSizeLimit':'20',
				'buttonText': '选择文件',
				'preventCaching' :  true,
			   	'removeCompleted' :true,
				'removeTimeout' : 0,
				//限制文件格式,不设置默认全部格式
		            'fileTypeExts' : '',
		            //上传结束时调用的方法
		            onUploadSuccess: function (file,data,response) {//上传完成时触发（每个文件触发一次）
					data = $.parseJSON(data);
		            	if (data==null||data.id==""||data.id==undefined||data.id==null) {
		            		$.jBox.alert("文件保存失败","错误");
		            	}
		            	else {
							var li_="<li>";
							li_+="<a href=\"\" url=\"\" target=\"_blank\">"+data.fileOname+"</a>&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"fileDel('"+data.id+"',this)\">×</a>"
							li_+="</li>";
							$("#filesPreview").append(li_);
							file_ids.push(data.id);
		            	}
		            }, 
		            //上传开始时调用的方法
		            onUploadStart : function(file) {
		            },
					onUploadComplete:function(file){
						console.log(file);
					},
		            onUploadError: function(file) {
		                alert("文件:" + file.name + "上传失败");
		            },
					onSelectError:function(file, errorCode, errorMsg){
		            switch(errorCode) {
		                case -100:
		                	this.queueData.errorMsg = "上传的文件数量已经超出系统限制的"+$('#mailUpload').uploadify('settings','queueSizeLimit')+"个文件！";
		                    break;
		                case -110:
		                	this.queueData.errorMsg = "文件 ["+file.name+"] 大小超出系统限制的"+$('#mailUpload').uploadify('settings','fileSizeLimit')+"大小！";
		                    break;
		                case -120:
		                	this.queueData.errorMsg = "文件 ["+file.name+"] 大小异常！";
		                    break;
		                case -130:
		                	this.queueData.errorMsg =  "文件 ["+file.name+"] 类型不正确！";
		                    break;
		            }
		        }
		　　　});
			//$("#name").focus();
			$("#mail_send").click(function(){
				$("#isSend").val("0");
				$("#fids").val(file_ids.join(","));
				$("#inputForm").submit();
			});
			/*存草稿*/
			$("#btn_draft").click(function(){
				$("#isSend").val("1");
				$("#fids").val(file_ids.join(","));
				$("#inputForm").submit();
			});
			/*取消*/
			$("#btn_cancel").click(function(){
				top.$.jBox.confirm("确定放弃吗？", "提示", function(v,h,f){
					if (v == 'ok'){
						window.location.href="${ctx }/mail/msgEmail/index";
					}
				});
			});
			$("#inputForm").validate({
				submitHandler: function(form){
					var name_val=new Array();
					$.each($("#mailAcceptor").select2('data'),function(i,d){
						name_val.push(d.name);
					});
					$("#acceptorNames").val(name_val.join(","));
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
			/*按钮提示信息*/
			$("#send_operation button").tooltip();
			$("#send_mail").click(function(){
				window.location.href="${ctx}/mail/msgEmail/form";
			});
			$("#mailAcceptor").select2({
				width:"70.5%",
				placeholder: "请输入拼音码或姓名或工号查询",  
                minimumInputLength: 2,  
				multiple:true, 
				tags: false,
				multiple             : true,
				separator            : ",",                             // 分隔符
				maximumSelectionSize : 500,                               // 限制数量
				initSelection        : function (element, callback) {   // 初始化时设置默认值
					var data = [];
					var name_="${msgEmail.receiveNames}";
					var ids_="${msgEmail.receiveIds}";
					$(ids_.split(",")).each(function (i,d) {
						data.push({id: d, text: name_.split(",")[i]});
					});
					callback(data);
				},
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
			var acceptor_=${fns:toJson(msgEmail.ruser)};
			if(acceptor_!=""&&acceptor_!=null){
				$("#mailAcceptor").select2("data",acceptor_);
			}
			/**标签页**/
			//Default Action  
			$(".tab_content").hide(); //Hide all content  
			$("ul.tabs li:first").addClass("active").show(); //Activate first tab  
			$(".tab_content:first").show(); //Show first tab content  
			$("ul.tabs li").click(function() {  
				$("ul.tabs li").removeClass("active"); //Remove any "active" class  
				$(this).addClass("active"); //Add "active" class to selected tab  
				$(".tab_content").hide(); //Hide all tab content  
				var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content  
				$(activeTab).fadeIn(); //Fade in the active content  
				return false;  
			});  
			/*部门人员，树型结构*/
			$.get("${ctx}/sys/office/treeData?type=3&extId=&isAll=true&module=&t="+new Date().getTime()
					+ new Date().getTime(), function(zNodes){
				// 初始化树结构
				tree = $.fn.zTree.init($("#ztree"), setting, zNodes);
				
				// 默认展开一级节点
				var nodes = tree.getNodesByParam("level", 0);
				for(var i=0; i<nodes.length; i++) {
					tree.expandNode(nodes[i], true, false, false);
				}
				//异步加载子节点（加载用户）
				var nodesOne = tree.getNodesByParam("isParent", true);
				for(var j=0; j<nodesOne.length; j++) {
					tree.reAsyncChildNodes(nodesOne[j],"!refresh",true);
				}
			});
			/*选择用户*/
			$("#checked_").click(function(){
				var nodes = [],d_=new Array();
					nodes =  $.fn.zTree.getZTreeObj("ztree").getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++){
						$.fn.zTree.getZTreeObj("ztree").checkNode(nodes[i], false, false, false);
						if (nodes[i].level == 0||nodes[i].isParent){
							continue;
						}
						var pnode=nodes[i].getParentNode();
						d_.push({"officeName":pnode.name,"id":nodes[i].id.replace(/u_/ig,""),"name":nodes[i].name});
						continue;
					}
					var s_data=$("#mailAcceptor").select2('data');//已选择收件人数据
					$.each(s_data,function(i,d){
						d_.push({"officeName":d.officeName,"id":d.id,"name":d.name});
					});
					if(d_.length>0){
						$("#mailAcceptor").select2("data",d_);
					}
			});
			/*选择常用联系人*/
			$("#mc_confirm").click(function(){
				var objs_=[];
				var obj=$(".link_user:checked");
				if(obj.length<1){
					$.jBox.alert("请选择常用联系人！","提示");
				}else{
					$.each(obj,function(i,d){
						objs_.push({"officeName":$(d).attr("oname"),"id":$(d).attr("uid"),"name":$(d).attr("uname")})
					});
					if(objs_.length>0){
						var s_data=$("#mailAcceptor").select2('data');//已选择收件人数据
						$.each(s_data,function(i,d){
							objs_.push({"officeName":d.officeName,"id":d.id,"name":d.name});
						});
						$("#mailAcceptor").select2("data",objs_);
					}
				}
			});
			/*添加常用联系人*/
			$("#mail_common").click(function(){
				var ids = [],nodes = [];
					nodes =  $.fn.zTree.getZTreeObj("ztree").getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++){
						$.fn.zTree.getZTreeObj("ztree").checkNode(nodes[i], false, false, false);
						if (nodes[i].level == 0||nodes[i].isParent){
							continue;
						}
						ids.push(nodes[i].id.replace(/u_/ig,""));
						continue;
					}
					if(ids.length>0){
						$.getJSON("${ctx}/mail/mailCommon/add",{mcids:ids.join(",")},function(data){
							if(data.success){
								$.jBox.alert("常用联系人添加成功","提示");
								common_list();
							}else{
								$.jBox.error(data.msg,"异常");
							}
						});
					}
			});
			/*全选*/
			$("#common_all").click(function(){
				$(".link_user").prop("checked",$(this).prop("checked"));
			});
			/*批量删除*/
			$("#mc_del").click(function(){
				var obj=$(".link_user:checked");
				if(obj.length<1){
					$.jBox.alert("请选择常用联系人","提示");
				}else{
					var ids_=[];
					$.each(obj,function(i,d){
						ids_.push($(d).attr("mcid"));
					});
					common_del(ids_.join(","),obj);
				}
			});
		});
		/*删除常用联系人*/
		function common_del(ids,obj){
			$.getJSON("${ctx}/mail/mailCommon/del",{ids:ids},function(data){
				if(data.success){
					$.jBox.alert(data.msg,"提示");
					/*删除元素*/
					$.each(obj,function(i,d){
						$(d).parent().remove();
					});
				}else{
					$.jBox.error(data.msg,"异常");
				}
			});
		}
		/**
		*移除已删除元素
		**/
		function common_remove(id,obj){
			var objs=[];
			objs.push(obj);
			common_del(id,objs);
		}
		/**
		*查询当前登录者常用联系人信息
		**/
		function common_list(){
			$.getJSON("${ctx}/mail/mailCommon/mclist",{},function(data){
				var mc=data.obj;
				if(mc.length>0){
					$("#mail_commons").children(":gt(0)").remove();
					$.each(mc,function(i,d){
						/*添加到常用*/
						var common_info=[];
						common_info.push("<li>");
						common_info.push("<input type=\"checkbox\" name=\"link_user\" mcid=\""+d.id+"\" uid=\""+d.linkUser.id+"\" uname=\""+d.linkUser.name+"\" oname=\""+d.linkUser.officeName+"\" class=\"link_user\" value=\"\">");
						common_info.push("<a href=\"javascript:void(0);\">"+d.linkUser.name+"</a>&nbsp;&nbsp;");
						common_info.push("<a href=\"javascript:void(0);\">"+d.linkUser.officeName+"</a>&nbsp;&nbsp;");
						common_info.push("<a href=\"javascript:\" onclick=\"common_remove('"+d.id+"',this)\">×</a>");
						common_info.push("</li>");
						$("#mail_commons").append(common_info.join(""));
					});
				}
			});
		}
		/**
		*删除附件
		**/
		function fileDel(id,obj){
			if(id==""||id==null){
				$.jBox.alert("附件删除错误","提示");
			}else{
				$.post("${ctx}/attach/fileAttach/fdel",{"id":id},function(data){
					if(data.success){
						file_ids.remove(id);
						$(obj).parent().remove();
					}else{
						$.jBox.error(data.msg,"异常");
					}
				})
			}
		}
		var setting = {view:{selectedMulti:false,dblClickExpand:false},check:{enable:"true",nocheckInherit:true},
				async:{enable:true,url:"${ctx}/sys/user/treeData",autoParam:["id=officeId"]},
				data:{simpleData:{enable:true}},callback:{
					onClick:function(event, treeId, treeNode){
						tree.expandNode(treeNode);
					},onCheck: function(e, treeId, treeNode){
						var nodes = tree.getCheckedNodes(true);
						for (var i=0, l=nodes.length; i<l; i++) {
							tree.expandNode(nodes[i], true, false, false);
						}
						return false;
					},onAsyncSuccess: function(event, treeId, treeNode, msg){
						var nodes = tree.getNodesByParam("pId", treeNode.id, null);
						for (var i=0, l=nodes.length; i<l; i++) {
							try{tree.checkNode(nodes[i], treeNode.checked, true);}catch(e){}
						}
					},onDblClick: function(){
						top.$.jBox.getBox().find("button[value='ok']").trigger("click");
					}
				}
			}
	</script>
</head>
<body class="gray-bg">
	<div class="container-fluid">
        <div class="row-fluid show-grid">
            <div class="row span2">
                <div class="ibox float-e-margins" style="height: 800px;border: 1px solid #e7eaec;border-left: 0px;border-bottom: 0px;border-top: 0px;">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                             <!-- <a class="btn btn-block btn-primary compose-mail" href="${ctx}/mail/msgEmail/form">写邮件</a>-->
							<input id="send_mail" class="btn btn-block btn-primary compose-mail" type="button" value="写邮件"/>
                            <div style="margin:10px 0;"></div>
                            <ul class="folder-list m-b-md" style="padding: 0;margin:0;">
								 <li>
                                    <a href="${ctx }/mail/msgEmail/index"> <i class="icon-inbox"></i> 收件箱 </a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail"> <i class="icon-envelope"></i> 已发送</a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail/draft"> <i class="icon-file-alt"></i> 草稿箱 </a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail/draft"> <i class="icon-trash"></i> 已删除</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row span10">
				<div class="mail-box-header">
                        <div class="input-append input-prepend pull-right" id="send_operation">
                            <!-- <button id="mail_send" class="btn btn-primary btn-sm" data-toggle="tooltip" data-placement="bottom" title="发送邮件">发送 </button>&nbsp;&nbsp;
							<a href="javascript:void(0);"><button id="btn_draft" class="btn btn-primary btn-sm" data-toggle="tooltip" data-placement="bottom" title="保存草稿">存稿</button></a>&nbsp;&nbsp;
							<a href="javascript:void(0);"><button id="btn_cancel" class="btn btn-primary btn-sm" data-toggle="tooltip" data-placement="bottom" title="放弃">放弃</button></a>&nbsp;&nbsp; -->
							<input id="mail_send" class="btn btn-primary btn-sm" type="button" value="发送"/>
							<input id="btn_draft" class="btn btn-primary btn-sm" type="button" value="存稿"/>
							<input id="btn_cancel" class="btn btn-primary btn-sm" type="button" value="放弃"/>
                        </div>
                    <h3>
                    	写邮件
                </h3>
                </div>
				<div class="mail-box">
                    <div class="mail-body">
                        <form:form id="inputForm" modelAttribute="msgEmail" action="${ctx}/mail/msgEmail/save" method="post" class="form-horizontal">
                            <form:hidden path="id"/>
                            <form:hidden path="isSend"/>
							<form:hidden path="fids"/>
							<form:hidden path="acceptorNames" />
							<sys:message content="${message}"/>	
							<div class="form-group">
                                <label class="col-sm-2 control-label" style="width:70px;">发送到：</label>
                                <div class="form-group">
									<input type="text" class="input-xlarge" name="mailAcceptor" id="mailAcceptor"/>
									<span class="help-inline" style="padding-left:8px;"><font color="red">*</font> </span>
									<!--<sys:treeselect id="mailAcceptor" name="mailAcceptor" value="${msgEmail.receiveIds}" labelName="acceptorNames" labelValue="${msgEmail.receiveNames}"
									title="收件人" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true" checked="true" isAll="true" cssStyle="width:100%" divStyle="width:69%"/>-->
                                    <!--<input type="text" class="form-control" value="">-->
                                </div>
								
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" style="width:70px;">主&nbsp;&nbsp;题：</label>
                                <div class="col-sm-10">
                                    <form:input path="mailTitle" htmlEscape="false" maxlength="300" class="input-xlarge required" style="width:69%"/>
									<span class="help-inline"><font color="red">*</font> </span>
                                </div>
                            </div>
							<div class="control-group">
								<label class="control-label" style="width:70px;">附&nbsp;&nbsp;件：</label>
								<div class="controls" style="margin-left:20px;">
									<input type="file" name="mailUpload" id="mailUpload" />
									<div id="fileQueue">
										<ol id="filesPreview">
										<c:forEach items="${msgEmail.files}" var="mf">
											<li>
												<a href="" url="" target="_blank">${mf.fileOname}</a>&nbsp;&nbsp;
												<a href="javascript:" onclick="fileDel('${mf.id}',this)">×</a>
											</li>
										</c:forEach>
										</ol>
									</div>

									<!--<form:hidden id="filePath" path="filePath" htmlEscape="false" class="input-xlarge"/>
									<sys:ckfinder input="filePath" type="files" uploadPath="/邮箱/内部邮箱" selectMultiple="true" maxHeight="500" viewType="list"/>-->
								</div>
							</div>
							<div class="control-group" style="width:80%;">
								<form:textarea id="mailContent" htmlEscape="false" path="mailContent" rows="4" class="input-xxlarge"/>
								<sys:ckeditor replace="mailContent" uploadPath="/邮箱/内部邮箱" />
							</div>
                        </form:form>
                    </div>
					<!--<div style="position:absolute;background-color:red;height:400px;top:40px;right:5px;width:18%;overflow-y:auto;">-->
					<div class="container" style="position:absolute;height:400px;top:40px;right:5px;width:18%;border:1px solid #7f9db9">
							<ul class="tabs">  
								<li class="active"><a href="#tab1">常用</a></li>  
								<li><a href="#tab4">科室人员</a></li>  
							</ul>  
							<div class="tab_container">  
								<div id="tab1" class="tab_content" style="display: block; "> 
									<div>
										<input id="mc_confirm" class="btn btn-primary btn-sm" type="button" value="选择"/>
										<input id="mc_del" class="btn btn-primary btn-sm" type="button" value="删除"/>
									</div>
									<div style="width:100%;overflow-y:auto;height:330px;">
										<ul class="unstyled" id="mail_commons" style="padding:5px 0 0 10px;">
											<li>
												<input type="checkbox"id="common_all">
											</li>
											<c:forEach items="${mclist}" var="mc">
												<li>
													<input type="checkbox" name="link_user" mcid="${mc.id}" uid="${mc.linkUser.id}" uname="${mc.linkUser.name}" oname="${mc.linkUser.officeName}" class="link_user" value="">
													<a href="" url="" target="_blank">${mc.linkUser.name}</a>&nbsp;&nbsp;
													<a href="" url="" target="_blank">${mc.linkUser.officeName}</a>&nbsp;&nbsp;
													<a href="javascript:" onclick="common_remove('${mc.id}',this)">×</a>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>  
								  
								<div id="tab4" class="tab_content" style="display: none; ">  
										<input id="checked_" class="btn btn-primary btn-sm" type="button" value="选择"/>
										<input id="mail_common" class="btn btn-primary btn-sm" type="button" value="添加常用"/>
									<div id="ztree" class="ztree" style="width:100%;overflow-y:auto;height:330px;"></div>
								</div>  
							</div>  
						</div>  
					<!--</div>-->
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	
</script>
</html>