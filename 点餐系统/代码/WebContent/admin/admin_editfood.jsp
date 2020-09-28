<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	.default{
		margin:0 auto;/*左和右外边距设置为auto，规定的是均等地分配可用的外边距。结果就是居中的元素*/
		width:20%;
		border:1px solid #3366CC;
	}
	td{
	border:1px solid #3366CC;
	font-family:Cursive;
	font-size:16px;
	background-color:#f0f0f0;
	padding:5px;
	}
	.item{
		text-align:right;
		font-family:Cursive;
		font-size:16px;
		font-weight:bold;/*字体加粗*/
		background-color:#f0f0f0;
	}
</style>
<%@include file="admin_head.jsp" %>
<c:if test="${not empty food }">
<form method="post" action="admin_updatefood.cc?id=${food.id }">
<table class="default" border="1">
	<tr>
		<th class="item">菜名</th>
		<td align="center">${food.foodname }</td>	
	</tr>
	
	<tr>
		<th class="item">特色</th>
		<td><textarea name="feature" rows="3" cols="20" style="resize:none">${food.feature }</textarea></td>	
	</tr>
	
	<tr>
		<th class="item">食材</th>
		<td><textarea name="material" rows="3" cols="20" style="resize:none">${food.material }</textarea></td>	
	</tr>
	
	<tr>
		<th class="item">价格</th>
		<td><input type="text" name="price" value="${food.price }">元</td>	
	</tr>
	<tr>
		<th class="item">类型</th>
		<td>
		<select name="type">
			<option value="">全部</option>
			<c:forEach items="${types }" var="type">
				<option value="${type.id }" ${type.id == food.type?'selected':'' }>${type.typename }</option>
			</c:forEach>
		</select>
		</td>	
	</tr>
	<tr>
		<th class="item">图片</th>
		<td><img src="${pageContext.request.contextPath }/${food.picture }" alt="${food.name }"></td>	
	</tr>
	<tr>
		<th class="item">点击率</th>
		<td>${food.hits }</td>	
	</tr>
	<tr>
		<th class="item">备注</th>
		<td>
		${food.comment >0?'特价菜:':'' }<input type="text" name="comment" value="${food.comment == 0?'厨师推荐':food.comment > 0?food.comment:'' }">${food.comment >0?'元':'' }
		</td>	
	</tr>
	<tr>
		<th colspan="2" bgcolor="#f0f0f0">
		<input type="submit" value="修改">
		<input type="reset">
		</th>
	</tr>

</table>
</form>
</c:if>