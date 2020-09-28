<%@ page language="java" pageEncoding="utf-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table border="1" align="center" width="60%">
	<tr>
	<th>序号</th>
	<th>用户名</th>
	<th>身份</th>
	<th>电话</th>
	<th>地址</th>
	<th>管理</th>
	</tr>
	<c:forEach var="u" items="${users }" varStatus="vs">
	<tr>
	<td>${vs.count }</td>
	<td>${u.username }</td>
	<td>
	<c:if test="${u.ident == 1}">
	管理员
	</c:if>
	<c:if test="${u.ident == 0}">
	普通用户
	</c:if>
	</td>
	<td>${u.telephone }</td>
	<td>${u.address }</td>
	<td><a href="delete3?id=${u.id }" onclick="return confirm('确定要删除该用户吗?')">删除</a></td>
	</tr>
	</c:forEach>
</table>