<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理界面</title>
<style>
	tr{text-align:center}
</style>
</head>
<body>
	<%@ include file="admin_head.jsp" %>
	<table border="1" align="center" width="50%">
	<tr>
	<th>序号</th>
	<th>用户名</th>
	<th>密码</th>
	<th>身份</th>
	<th>电话</th>
	<th>地址</th>
	<th>管理</th>
	</tr>
	<c:forEach var="u" items="${users }" varStatus="vs">
	<tr>
	<td>${vs.count }</td>
	<td>${u.username }</td>
	<td>${u.password }</td>
	<td>
	<c:if test="${u.ident == 1}">
	管理员
	</c:if>
	<c:if test="${u.ident == 0}">
	普通用户
	</c:if>
	</td>
	<td>${u.telephone }</td>
	<td>${u.address }</td>
	<th>
	<a href="admin_edituser.cc?id=${u.id }" onclick="return confirm('确定要修改该用户信息吗?')">修改</a>
	<a href="admin_deleteuser.cc?id=${u.id }" onclick="return confirm('确定要删除该用户吗?')">删除</a>
	</th>
	</tr>
	</c:forEach>
	<tr><th colspan="7"><a href="admin_adduser.jsp">添加新用户</a></th></tr>
</table>
</body>
</html>