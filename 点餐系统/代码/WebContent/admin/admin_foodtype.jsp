<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜品分类管理界面</title>
</head>
<body>
	<%@ include file="admin_head.jsp" %>
	<table border="1" align="center" width="20%">
	<tr>
	<th>序号</th>
	<th>分类名称</th>
	<th>管理</th>
	</tr>
	<c:forEach var="ft" items="${foodtypes }" varStatus="vs">
	<tr>
	<td align="center">${vs.count }</td>
	<td align="center">${ft.typename }</td>
	<th>
	<a href="admin_edittype.cc?id=${ft.id }" onclick="return confirm('确定要修改该分类信息吗?')">修改</a>
	<a href="admin_deletetype.cc?id=${ft.id }" onclick="return confirm('确定要删除该分类吗?')">删除</a>
	</th>
	</tr>
	</c:forEach>
	<tr><th colspan="3"><a href="admin_addfoodtype.jsp">添加新分类</a></th></tr>
</table>
</body>
</html>