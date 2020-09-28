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
<br>
<h1 style="text-align:center;color:#F0F">菜品详情</h1>
<div style="text-align:right">
<hr>
</div>
<c:if test="${not empty food }">
<table class="default" border="1">
	<tr>
		<th class="item">菜名</th>
		<td>${food.foodname }</td>	
	</tr>
	
	<tr>
		<th class="item">特色</th>
		<td>${food.feature }</td>	
	</tr>
	
	<tr>
		<th class="item">食材</th>
		<td>${food.material }</td>	
	</tr>
	
	<tr>
		<th class="item">价格</th>
		<td>${food.price }元</td>	
	</tr>
	<tr>
		<th class="item">类型</th>
		<td>${food.typename }</td>	
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
			<c:choose>
				<c:when test="${food.comment == -1 }"></c:when>
				<c:when test="${food.comment == 0 }">厨师推荐</c:when>
				<c:otherwise>特价菜：${food.comment }元</c:otherwise>
			</c:choose>
		</td>	
	</tr>

</table>
</c:if>