<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>点餐登录界面</title>
<style>
	.tr{text-align:center}
</style>
</head>
<body>
	<%@ include file="user_head.jsp" %>
	<br>
	<form method="post" action="user_index.cc">
		<select name="type">
			<option value="">全部</option>
			<c:forEach items="${types }" var="type">
				<option value="${type.id }" ${type.id == param.type?'selected':'' }>${type.typename }</option>
			</c:forEach>
			
		</select>
		<input type="text" name="sn" value="${param.sn }" placeholder="请输入菜名">
		<input type="submit" value="搜索"></form><br>
		
	<form action="user_add_dc.cc" method="post">
		<table style="margin:0 auto;width:90%" border="1">
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
			<th>选择</th>
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
			<td><input type="checkbox" name="fids" value="${food.id }"></td>
		</tr>
		</c:forEach>
	</table>
	<p style="text-align:center"><input type="submit" value="加入点餐车"></p>
	</form>
</body>
</html>