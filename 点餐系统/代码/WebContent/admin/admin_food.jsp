<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜品管理界面</title>
<style>
	.tr{text-align:center}
</style>
</head>
<body>
	<%@ include file="admin_head.jsp" %>
		<form method="post" action="admin_food.cc">
		<select name="type">
			<option value="">全部</option>
			<c:forEach items="${types }" var="type">
				<option value="${type.id }" ${type.id == param.type?'selected':'' }>${type.typename }</option>
			</c:forEach>
			
		</select>
		<input type="text" name="sn" value="${param.sn }" placeholder="请输入菜名">
		<input type="submit" value="搜索"></form>
		<div align="right"><a href="admin_addfood_.cc?flag=0">添加新菜品</a></div>	
		<table style="margin:0 auto;width:100%" border="1">
		<tr>
			<th>序号</th>
			<th>菜名</th>
			<th>特色</th>
			<th>主料</th>
			<th>价格(元)</th>
			<th>分类</th>
			<th>图片</th>
			<th>点餐率</th>
			<th>备注</th>
			<th>管理</th>
		</tr>
		<c:forEach items="${allfood }" var="food" varStatus="vs">
			<tr class="tr">
			<td>${vs.count }</td>
			<td>${food.foodname }</td>
			<td>${food.feature }</td>
			<td>${food.material }</td>
			<td>${food.price }</td>
			<td>${food.typename }</td>
			<td><img src="${pageContext.request.contextPath }/${food.picture }" alt="${food.foodname }"></td>
			<td>${food.hits }</td>
			<td><c:choose>
				<c:when test="${food.comment == -1 }"></c:when>
				<c:when test="${food.comment == 0 }">厨师推荐</c:when>
				<c:otherwise>特价菜：${food.comment }元</c:otherwise>
			</c:choose>
			</td>
			<td>
				<a href="admin_editfood.cc?id=${food.id }" onclick="return confirm('确定要修改该菜品吗?')">修改</a>
				<a href="admin_deletefood.cc?id=${food.id }" onclick="return confirm('确定要删除该菜品吗?')">删除</a>
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>