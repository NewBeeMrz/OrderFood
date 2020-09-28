<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>管理系统用户信息修改</title>
<style type="text/css">
	.default{
		margin:0 auto;/*左和右外边距设置为auto，规定的是均等地分配可用的外边距。结果就是居中的元素*/
		width:18%;
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
	}
</style>
</head>
<body>
	<%@ include file="admin_head.jsp" %>
	<form method="post" action="admin_updateuser.cc">
		<table class="default" style="width=40%">
		<tr class="title">
			<th colspan="2">用户信息修改</th>
		</tr>
		
		<tr>
			<td class="item" >用户名：</td>
			<td><input type="text" name="un" value="${user.username }" readonly></td>
		</tr>
		
		<tr>
			<td class="item">密码：</td>
			<td><input type="password" name="pw" value="${user.password }" required></td>
		</tr>
		
		<tr>
			<td class="item">身份：</td>
			<td>
			 <input type="radio" name="ident" value="0" ${user.ident == 0?"checked":"" }>普通用户
			 <input type="radio" name="ident" value="1" ${user.ident == 1?"checked":"" } >管理员
			</td>
		</tr>
			
		<tr>
			<td class="item" >电话：</td>
			<td><input type="text" name="tel" value="${user.telephone }" required></td>
		</tr>	
		
		<tr>
			<td class="item">地址：</td>
			<td><textarea name="addr" rows="3" cols="20" style="resize:none">${user.address }</textarea></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="submit" value="修改">
				<input type="reset">
			</td>
		</tr>
		</table>
	</form>
</body>
</html>