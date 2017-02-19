<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript">
	$(function() {
		$(":submit[name='login']").click(function() {
			var $name = $(":text[name='name']");
			var name = $name.val();
			//去空格
			name = $.trim(name);
			$name.val(name);
			if (name == "") {
				$("#nullmessage").show();
				$("#loginmessage").hide();
				return false;
			} else {
				var $password = $(":password[name='password']");
				var password = $password.val();
				if(password == ""){
					$("#nullmessage2").show();
					$("#loginmessage").hide();
					return false;
				}
			}
		});
	});
</script>
</head>
<body>
	<center>
	<c:if test="${!empty sessionScope.user }">
		<font>您已登录</font>
		<br></br>
		<a href="${pageContext.request.contextPath }/authority-manager/pictures.jsp">返回</a>
	</c:if>

	<c:if test="${empty sessionScope.user }">
		<font id="loginmessage" color="red"> <c:choose>
				<c:when test="${!empty requestScope.notExist }">该用户不存在</c:when>
				<c:when test="${!empty requestScope.passwordWrong }">密码错误</c:when>
				<c:otherwise>您还未登录，请登录</c:otherwise>
			</c:choose>
		</font>
		<font id="nullmessage" color="red" style="display: none;">用户名不能为空</font>
		<font id="nullmessage2" color="red" style="display: none;">密码不能为空</font>
		<form
			action="${pageContext.request.contextPath }/LoginServlet?method=login"
			method="post">
			<table>
				<tr>
					<td>用户名：</td>
					<td><input type="text" name="name" value="${param.name }" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr>
					<td><input type="submit" name="login" value="登录" /></td>
					<td><a
						href="${pageContext.request.contextPath }/authority-manager/pictures.jsp">返回</a></td>
				</tr>
			</table>
		</form>
		<br/><br/>
		<hr></hr>
		<br/><br/>
		默认用户<br/>
		管理员：123456<br/>
		游客：123456
	</c:if>
	</center>
</body>
</html>