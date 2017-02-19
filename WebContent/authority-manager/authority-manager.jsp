<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript">
	$(function() {
		$(":submit[name='get']").click(function() {
			var $name = $(":text[name='username']");
			var name = $name.val();
			//去空格
			name = $.trim(name);
			$name.val(name);
			if (name == "") {
				$("#nullmessage").show();
				$("#usermessage").hide();
				$("#pwdnullmessage").hide();
				return false;
			}
		});
		
		$(":submit[name='do']").click(function() {
			var $name = $(":text[name='password']");
			var name = $name.val();
			name = $.trim(name);
			$name.val(name);
			if (name == "") {
				$("#pwdnullmessage").show();
				return false;
			}	
			
		});
		
		$("#focus .input_txt").each(function(){
		     var thisVal=$(this).val();
		     //判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
		     if(thisVal!=""){
		       $(this).siblings("span").hide();
		      }else{
		       $(this).siblings("span").show();
		      }
		     //聚焦型输入框验证 
		     $(this).focus(function(){
		       $(this).siblings("span").hide();
		      }).blur(function(){
		        var val=$(this).val();
		        if(val!=""){
		         $(this).siblings("span").hide();
		        }else{
		         $(this).siblings("span").show();
		        } 
		      });
		    });
		
		$("#btn1").click(function(){
			$("#oldpassword").hide();
			$("#newpassword").show();
			$("#usermessage").hide();
		});
		
		$("#btn2").click(function(){
			var content = $(this).parent().parent().find("td:eq(0)").text();
			var flag = confirm("确认要删除" + content + "的用户信息吗？");
			if(flag){
				window.location.href = "${pageContext.request.contextPath }/delete.do?username=" + content;
			}
			return false;
		});
		
	});
</script>
<style type="text/css">
 label{display:block;position:relative;}
 span{position:absolute;float:left;left:10px;color:#BCBCBC;cursor:text;}
 .input_txt{width:120px;border:solid 1px #ccc;box-shadow:0 1px 10px rgba(0,0,0,0.1) inset;text-indent:10px;}
 td{text-align: center;}
</style>
</head>
<body>
	<center>
		<form action="${pageContext.request.contextPath }/get.do" method="post">
		<h4>用户权限管理</h4>
			<table>
				<tr>
					<td>用户名：</td>
					<td><input name="username" type="text" value="${param.username }" /></td>
					<td><input type="submit" name="get" value="创建/修改" /></td>
					<td><input type="button" value="所有用户" onclick="window.location.href='${pageContext.request.contextPath }/getAll.do'"/></td>
					<td><input type="button" value="返回首页" onclick="window.location.href='${pageContext.request.contextPath }/authority-manager/pictures.jsp'"/></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		&nbsp;
		<font id="nullmessage" style="display: none;" color="red">用户名不能为空</font>
		<font id="pwdnullmessage" style="display: none;" color="red">密码不能为空</font>
		<font id="usermessage" color="red">
			<c:if test="${!empty requestScope.notExist }">该用户不存在，请创建</c:if>
			<c:if test="${(!empty requestScope.queryOne) and (empty requestScope.notExist) and (empty requestScope.addOK) and (empty requestScope.updateOK) }">
				该用户已存在，请修改
			</c:if>
			<c:if test="${!empty requestScope.updateOK }">更新成功</c:if>
			<c:if test="${!empty requestScope.addOK }">创建成功</c:if>
			<c:if test="${!empty requestScope.deleteOK }">删除成功</c:if>
		</font>
		&nbsp;
		<hr>
		<c:if test="${!empty requestScope.queryAll }">
			<c:if test="${empty requestScope.usernameList }">
				<font color="red">没有用户</font>
			</c:if>
			<c:if test="${!empty requestScope.usernameList }">
				<table border="1" cellpadding="10" cellspacing="0">
					<c:forEach items="${requestScope.usernameList }" var="name">
						<tr><td>${name }</td></tr>
					</c:forEach>
				</table>
			</c:if>
		</c:if>
		<c:if test="${!empty requestScope.queryOne }">
			<form action="${pageContext.request.contextPath }${empty requestScope.notExist ? '/update.do' : '/add.do' }" method="post" id="focus">
				<!-- 使用隐藏域来保存用户的 username -->
				<input name="username" type="hidden" value="${param.username }" />
				<table border="1" cellpadding="10" cellspacing="0">
					<tr>
						<th>用户名</th>
						<th>权限</th>
						<th>密码</th>
						<th>操作</th>
					</tr>
					<tr>
						<td>${param.username }</td>
						<td>
							<c:forEach items="${requestScope.authorities }" var="auth">
								<c:set var="flag" value="0"></c:set>
								<c:if test="${empty requestScope.notExist }">
									<c:forEach items="${requestScope.user.authorities }" var="ua">
										<c:if test="${auth.url eq ua.url }">
											<c:set var="flag" value="1"></c:set>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${flag eq '1' }">
									<input type="checkbox" name="authority" value="${auth.url }" checked="checked" />${auth.displayName }
								</c:if>
								<c:if test="${flag eq '0' }">
									<input type="checkbox" name="authority" value="${auth.url }" />${auth.displayName }
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:if test="${empty requestScope.notExist }">
								<font id="oldpassword">${requestScope.user.password }</font>
								<label id="newpassword" style="display: none;"><span>请输入新密码</span><input type="text" name="password" value="${requestScope.user.password }" class="input_txt" /></label>
							</c:if>
							<c:if test="${!empty requestScope.notExist }">
								<label><span>请输入新密码</span><input type="text" name="password" class="input_txt" /></label>
							</c:if>
						</td>
						<td><input type="submit" name="do" value="${empty requestScope.notExist ? '更新' : '创建' }" />
							<c:if test="${empty requestScope.notExist }">
								<input type="button" value="修改密码" id="btn1" />	
								<c:if test="${requestScope.user.username ne '管理员' }">
									<input type="button" value="删除" id="btn2"/>								
								</c:if>					
							</c:if>
							<input type="button" value="取消" onclick="window.location.href='${pageContext.request.contextPath }/authority-manager/authority-manager.jsp'">
						</td>
					</tr>
				</table>
			</form>
		</c:if>
	</center>
</body>
</html>