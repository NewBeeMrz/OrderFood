<%@page import="service.FoodService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用户点餐情况</title>
<style type="text/css">
	.default{
		margin:0 auto;/*左和右外边距设置为auto，规定的是均等地分配可用的外边距。结果就是居中的元素*/
		width:18%;
		border:1px solid #FF0000;
		border-collapse:collapse;//将表格边框折叠为单一边框
	}
	td{
	text-align:left;
	border:1px solid #3366CC;
	background-color:#f0f0f0;
	padding:5px;
	font-family:Cursive;
	font-size:16px;
	font-weight:bold;/*字体加粗*/
	}
	.title{
		text-align:left;
		background-color:#00AAFF;
		color:#EE0000;/*字体颜色*/
	}
</style>
</head>
<body>
<%@include file="admin_head.jsp" %>
<c:forEach items="${dcs }" var="dc">
	<c:set value="0" var="sum"/>
	<table class="default">
		<tr><td class="title" colspan="2">点餐用户：${dc.key }</td></tr>
		<c:forEach items="${dc.value }" var="food">
			<tr>
			<td>${food.foodname }</td>
			<td>${food.price }元</td>
			</tr>
			<c:set value="${sum+food.price }" var="sum"/>
		</c:forEach>
		<tr>
		<td>合计</td>
		<td><c:out value="${sum }"/>元</td>
		</tr>
	</table><br>
</c:forEach>
</body>
</html>