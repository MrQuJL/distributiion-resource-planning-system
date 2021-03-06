<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/pages/include/taglib.jsp" %>
<!doctype html>
<html>
<head>
	<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
	<title>区域管理</title>
	<meta name='keywords' content='权限管理'>
	<meta name='description' content='菜单，部门，区域等资源权限于一体的按钮级权限管理系统'>
	<%@ include file="/WEB-INF/pages/include/head.jsp"%>
	<script type="text/javascript">
		$(function() {
			$("#treeTable").treeTable({expandLevel : 5});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0);">区域列表</a></li>
		<li><a href="${ctx}/sysmgr/gotoAreaEdit.action?editFlag=1">区域添加</a></li>
	</ul>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>区域名称</th>
				<th>排序</th>
				<th>编码</th>
				<th>备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="treeTableList">
			<c:forEach items="${areaList}" var="area">
				<tr id="${area.id}" pId="${area.parentId}">
					<td><a href="${ctx}/sysmgr/gotoAreaEdit.action?editFlag=2&areaId=${area.id}">${area.name}</a></td>
					<td>${area.sort}</td>
					<td>${area.code}</td>
					<td>${area.remarks}</td>
					<td>
						<a href="${ctx}/sysmgr/gotoAreaEdit.action?editFlag=2&areaId=${area.id}">修改</a>
						<a href="javascript:areaMgr.confirmHasSubArea(${area.id});">删除</a>
						<a href="${ctx}/sysmgr/gotoAreaEdit.action?editFlag=1&areaId=${area.id}">添加下级区域</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script type="text/javascript">
		var areaMgr = {
			// 确认是否有子区域
			confirmHasSubArea : function(areaId) {
				$.ajax({
					type : "post",
					url : "${ctx}/sysmgr/confirmHasSubArea.action",
					data : {"areaId" : areaId},
					dataType : "json",
					success : function(data) {
						if (data.message == "yes") { // 有子区域不能删除
							alert("该区域下面有子区域，请先删除子区域再删除该区域！");
						} else {
							areaMgr.delArea(areaId);
						}
					}
				});
			},
			// 如果没有子区域则删除该取悦
			delArea : function(areaId) {
				if (confirm("您确定要删除该区域吗?")) {
					loading("正在删除...");
					$.ajax({
						type : "post",
						url : "${ctx}/sysmgr/delArea.action",
						data : {"areaId" : areaId},
						dataType : "json",
						success : function(data) {
							alert(data.message);
							top.$.jBox.closeTip();
							location.reload();
						}
					});
				}
			}
		}
	</script>
</body>
</html>