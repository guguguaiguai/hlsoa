<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
		body{background-size: 100%;width:100%;text-align:center;}
		input{margin:0;padding:0;}
      htmtable{background-color:#f5f5f5;width:100%;text-align:center;}
	  .form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;margin-left:28px;color:#0663a2;}
      .form-signin{position:relative;text-align:left;width:300px;padding:25px 29px 5px;margin:0 auto 20px;
	  /*background-color:#fff;border:1px solid #e5e5e5;*/
        	-webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
      .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} 
	  .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:50px;padding-top:10px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0; position:relative;}
	  ul, ol {list-style: none outside none;}
	  #ul_login{position: relative;width: 100%;height: 226px;padding-top: 5px;}
	  #ul_login li{position: relative;height: 100%;padding: 0 19px 0;}
	  .textBox{height:30px;padding:5px;border:1px solid #cecece;position:relative;background:white;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;-moz-box-shadow:inset 1px 1px 3px rgba(0,0,0,.1);-webkit-box-shadow:inset 1px 1px 3px rgba(0,0,0,.1);box-shadow:inset 1px 1px 3px rgba(0,0,0,.1)}
	  .textBox .i-user, .i-phone, .textBox .i-password {position: relative;left: 5px;top: 5px;margin-right: 6px;}
	  .i-user ,.i-pwd{width:16px;height:16px;    display: inline-block;background: url(../static/images/login.png) no-repeat;}
	  .i-user{background-position: -45px -180px;} .i-pwd{    background-position: -64px -180px;}
	  .textBox_label {position: absolute;left: 34px;top: 10px;_top: 13px;color: #CCC;font-size: 12px;}
	  .textBox_user ,.textBox_pw{width: 218px;height: 18px;border: 0;outline: 0;font-size: 14px;cursor: text;overflow: visible;}
	  .textBox_user, .textBox_pw, .textBox_label {font-size: 14px;cursor: text;}
	  .footer{color:#fff;position:relative;padding-top:75%;}
	  .footer_{color:#fff;position:relative;padding-top:4%;}
    </style>
	<script type="text/javascript">
		$(document).ready(function() {
			var agent=navigator.userAgent.toLowerCase();
			//var v_=navigator.appVersion;
			var browser=getBrowserInfo();
			//var verinfo = (browser+"").replace(/[^0-9.]/ig,"");
			if($.NV('shell')=='搜狗浏览器'||$.NV('shell')=='360极速浏览器'||$.NV('shell')=='360安全浏览器'||$.NV('shell')=='3遨游浏览器'||$.NV('shell')=='QQ浏览器'){
				$("#browser_info").show();
			}else if(agent.indexOf("chrome")>0 || agent.indexOf("firefox")>0)  {
				$("#footer").removeClass("footer_").addClass("footer");
				$("#browser_info").hide();
			  }
			  
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
			var intervalId=window.setInterval(function (){
				if($("#username").val().value!=""){
				  $("#label_user").hide();
				  clearInterval(intervalId);
				}else{
					$("#label_user").show();
				}
				if($("#password").value!=""){
				  $("#label_pwd").hide();
				  clearInterval(intervalId);
				}else{
					$("#label_pwd").show();
				}
			  },1000);
			  $("#btn_login").click(function(){$("#loginForm").submit();});
			/*当验证错误时操作*/
			if($("#username").val().length>0){
				label_($("#username"),$("#label_user"));
			}
			if($("#password").val().length>0){
				label_($("#password"),$("#label_pwd"));
			}
			/*提示信息隐藏*/
			$("#username")[0].focus();
			$("#username").keyup(function(event){
				label_($(this),$("#label_user"));
				if(event.keyCode==13){
					$("#password")[0].focus();
				}
			}).focus(function(){
				$(this).select();
			});
			$("#password").keyup(function(event){
				label_($(this),$("#label_pwd"));
				if(event.keyCode==13){
					$("#loginForm").submit();
				}
			}).focus(function(){
				$(this).select();
			});
		});
		function label_($obj,$label){
			if($obj.val().length>0)
				$label.hide();
			else
				$label.show();
		}
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		function getBrowserInfo()
		{
			var agent = navigator.userAgent.toLowerCase() ;

			var regStr_ie = /msie [\d.]+;/gi ;
			var regStr_ff = /firefox\/[\d.]+/gi;
			var regStr_chrome = /chrome\/[\d.]+/gi ;
			var regStr_saf = /safari\/[\d.]+/gi ;
			//IE
			if(agent.indexOf("msie") > 0)
			{
			return agent.match(regStr_ie) ;
			}

			//firefox
			if(agent.indexOf("firefox") > 0)
			{
			return agent.match(regStr_ff) ;
			}

			//Chrome
			if(agent.indexOf("chrome") > 0)
			{
			return agent.match(regStr_chrome) ;
			}

			//Safari
			if(agent.indexOf("safari") > 0 && agent.indexOf("chrome") < 0)
			{
			return agent.match(regStr_saf) ;
			}
		}
	</script>
</head>
<body>
	<div style="position:fixed;top:0;left:0;bottom:0; right:0; z-index:-1;">
		<img src="${ctxStatic}/images/yyzh.png" style="height:100%;width:100%; border:0; ">
	</div>
	<div style=""><a target="blank" href="http://10.36.10.202:8080/oa" style="float:right;padding-top:10px;padding-right:20px;color:#08059A;font-weight:bold;">旧版OA系统登录</a></div>
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>
	<!--<form id="loginForm" class="form-signin" action="${ctx}/login" method="post" style="filter:alpha(Opacity=70);background:rgba(255,255,255,0.6);">-->
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post" style="padding-top:100px;">
		<ul class="ul_login">
			<li style="display:block;">
				<dl>
					<dd>
						<div class="textBox">
							<i class="i-user" style="left:1px;"></i>
							<input type="text" id="username" name="username" title="请输入用户名" class="required textBox_user" value="${username}" style="padding: 5px;width: 218px;height: 18px;border: 0;outline: 0;font-size: 14px;cursor: text;overflow: visible;position:absolute;" />
							<label for="username" class="textBox_label" id="label_user" style="display: block;">登录账号</label>
						</div>
					</dd>
					<dd style="padding-top:15px;">
						<div class="textBox">
							<i class="i-pwd" style="margin-top:5px;"></i>
							<input type="password" id="password" name="password" title="请输入密码" class="textBox_pw"  style="padding: 5px;width: 218px;height: 18px;border: 0;outline: 0;" />
							<label for="password" class="textBox_label" id="label_pwd" style="display: block;">密码</label>
						</div>
					</dd>
					<c:if test="${isValidateCodeLogin}">
					<dd style="padding-top:15px;">
						<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
					</dd></c:if>
					<dd style="padding-top:25px;">
						<div>
							<input id="btn_login" class="btn btn-large btn-primary" type="button" value="登 录"/>
							<!--<a target="blank" href="http://10.36.10.202:8080/oa" style="float:right;padding-top:20px;color:#08059A;">旧版OA系统登录</a>->
						</div>
					</dd>
				</dl>
			</li>
		</ul>
		<!--<div style="bottom:90px;position:relative;left:115%;">
			<input class="btn btn-large btn-primary" type="submit" value="登 录"/>
		</div>-->
		 <!--<div class="controls">
			<div class="input-prepend" style="height:30px;">
			  <span class="add-on"><i class="icon-user"></i></span>
			  <input type="text" id="username" name="username" title="请输入用户名" class="input-block-level required" value="${username}" style="width:260px;" />
			  <label for="username" class="textBox_label" id="label_pass" style="display: block;">用户名</label>
			</div>
		  </div>
		<label class="input-label" for="username" style="color:#2fa4e7">登录名</label>
		<input type="text" id="username" name="username" class="input-block-level required" value="${username}" style="width:260px;height:30px;" /></div>
		-->
		<!--<div class="controls">
			<div class="input-prepend" style="position:relative;">
			  <span class="add-on"><i class="icon-lock"></i></span>
			  <input type="password" id="password" name="password" title="请输入密码" class="input-block-level"  style="width:260px;height:30px;" />
			  <label for="password" class="textBox_label" id="label_pass" style="display: block;">密码</label>
			</div>
		  </div>
		<label class="input-label" for="password" style="color:#2fa4e7">密码</label>
		<i class="icon-lock"></i>
		<input type="password" id="password" name="password" class="input-block-level"  style="width:260px;height:30px;" /></div>-->
		<%--<c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode" style="color:#2fa4e7;">验证码</label>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if>
		<label for="mobile" title="手机登录"><input type="checkbox" id="mobileLogin" name="mobileLogin" ${mobileLogin ? 'checked' : ''}/></label> --%>
		<%-- <label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/> 记住我（公共场所慎用）</label> --%>
		<div id="themeSwitch" class="dropdown">
			<!--<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>-->
			<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
		</div>
	</form>
	<br/><div id="browser_info" class='alert alert-block' style="text-align:left;padding-bottom:10px;"><h4>温馨提示：</h4><p>为了获得更好的浏览体验，我们强烈建议您使用 <a href="../browser/chrome浏览器.zip">Chrome谷歌浏览器</a>。</p></div>
	
	<div class="footer_" id="footer">
		Copyright &copy; 2012-${fns:getConfig('copyrightYear')} 北京海林思 ${fns:getConfig('version')} 
	</div>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>