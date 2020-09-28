<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜品添加表</title>
<style type="text/css">
	.default{
		margin:0 auto;/*左和右外边距设置为auto，规定的是均等地分配可用的外边距。结果就是居中的元素*/
		width:35%;
		border:1px solid #FF0000;
		border-collapse:collapse;//将表格边框折叠为单一边框
	}
	td{
	border:1px solid #3366CC;
	background-color:#f0f0f0;
	padding:5px;
	}
	.title{
		text-align:center;
		background-color:#00AAFF;
		color:#EE0000;/*字体颜色*/
	}
	.item{
		text-align:right;
		font-family:Cursive;
		font-size:16px;
		font-weight:bold;/*字体加粗*/
		witdth:20%;
	}
</style>
</head>
<body>
	<%@ include file="admin_head.jsp"%>
	<form method="post" action="admin_addfood.cc" enctype="multipart/form-data">
		<table class="default">
		<tr class="title">
			<th colspan="2">菜品信息</th>
		</tr>
		
		<tr>
			<td class="item" >菜名：</td>
			<td><input type="text" name="foodname"></td>
		</tr>
		
		<tr>
			<td class="item">特色：</td>
			<td><textarea name="feature" rows="3" cols="20" placeholder="请在此输入菜品特色" style="resize:none"></textarea></td>
		</tr>
		
		<tr>
			<td class="item">主料：</td>
			<td><textarea name="material" rows="3" cols="20" placeholder="请在此输入菜品主料" style="resize:none"></textarea></td>
		</tr>
		<tr>
			<td class="item">价格：</td>
			<td><input type="text" name="price"></td>
		</tr>
		
		<tr>
			<td class="item">分类：</td>
			<td>
			<select name="type">
				<option>--请选择--</option>
				<c:forEach items="${types }" var="type">
					<option value="${type.id }" ${type.id == param.type?'selected':'' }>${type.typename }</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td class="item">图片：</td>
            <td><input type="file" name="picture"></td>
        </tr>
        
		<tr>
			<td class="item">备注：</td>
			<td><input type="text" name="comment"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="添加">
				<input type="reset">
			</td>
		</tr>
		</table>
	</form>
</body>
</html>