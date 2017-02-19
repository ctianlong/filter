<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<center>
	
	<a href="picture-1.jsp">图片1</a>
	<br></br>
	
	<a href="picture-2.jsp">图片2</a>
	<br></br>
	
	<a href="picture-3.jsp">图片3</a>
	<br></br>
	
	<a href="picture-4.jsp">图片4</a>
	<br></br>
	
	<hr></hr>

	<a href="login.jsp">登录</a>
	<br></br>
	
	<a href="${pageContext.request.contextPath }/LoginServlet?method=logout">注销</a>
	<br></br>
	
	<c:if test="${sessionScope.user.username == '管理员' }">
	<hr></hr>
	<a href="${pageContext.request.contextPath }/authority-manager/authority-manager.jsp">用户管理</a>
	<br></br>
	</c:if>
	
	<hr></hr>
	
	<font color="red">
	<c:if test="${empty sessionScope.user }">
		用户未登录
	</c:if>
	<c:if test="${!empty sessionScope.user }">
		当前登陆用户：${sessionScope.user.username }
	</c:if>
	</font>
	
	</center>
	
</body>
</html>