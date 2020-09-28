<%@ page language="java" pageEncoding="utf-8"%>
<h1 style="text-align:center;color:#F00">${sessionScope.header }</h1>
	<div style="text-align:center">
		<a href="${pageContext.request.contextPath }/admin/admin_userlist.cc">用户管理</a>&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/admin/admin_foodtype.cc">菜品分类管理</a> &nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/admin/admin_food.cc">菜品管理</a> &nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/admin/admin_diningcar.cc">查看用户点餐情况</a> &nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/logout.cc" onclick="return confirm('确定要退出当前系统吗?')">退出管理系统</a>
	</div>
	<hr style="border:1px solid #0F0"><br>