<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<font color="red">${message }</font>
	<form action="hello.jsp" method="post">
		username:<input type="text" name="username" value="${param.username }"/>
		password:<input type="password" name="password"/>
		<input type="submit" value="Submit"/>
	</form>
	
	<br><br>
	
	<h4>演示登录，用到UserNameFilter和PasswordFilter两个过滤器</h4>

</body>
</html>