<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>网络点餐系统首页</title>
<Style>

</Style>
</head>
<body>
	<br>
	<h1 style="text-align:center;color:#F0F">网络点餐系统</h1>
	<div style="text-align:right">
	<a href="login.html">登录</a>
	<a href="register.html">注册</a>
	<hr style="border:1px solid #0F0">
	</div>
	<table style="margin:0 auto; width:30%;line-height:40px">
		<tr>
			<td colspan="3" ><B>热点菜品</B></td>
		</tr>
		<tr>
			<c:forEach items="${hot }" var="food">
			<td>
			<img src="${pageContext.request.contextPath }/${food.picture }" alt="${food.foodname }"><br>
			<a href="show_detail.cc?id=${food.id }" target="_blank">${food.foodname }</a>
			${food.price }元
			</td>
			</c:forEach>
		</tr>
		<tr>
			<td colspan="3" ><B>特价菜品</B></td>
		</tr>
		<tr>
			<c:forEach items="${cheap }" var="food">
			<td>
			<img src="${pageContext.request.contextPath }/${food.picture }" alt="${food.foodname }"><br>
			<a href="show_detail.cc?id=${food.id }" target="_blank">${food.foodname }</a>
			${food.comment }元
			</td>
			</c:forEach>
		</tr>
		<tr>
			<td colspan="3" ><B>厨师推荐菜品</B></td>
		</tr>
		<tr>
			<c:forEach items="${recomm }" var="food">
			<td>
			<img src="${pageContext.request.contextPath }/${food.picture }" alt="${food.foodname }"><br>
			<a href="show_detail.cc?id=${food.id }" target="_blank">${food.foodname }</a>
			${food.price }元
			</td>
			</c:forEach>
		</tr>
	</table>
	</body>
	</html>