<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/pages/include/taglib.jsp" %>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
	<title>角色管理</title>
	
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<%@ include file="/WEB-INF/pages/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#name").focus();
			$("#inputForm").validate({
				rules: {
					name: {remote: "/sys/role/checkName?oldName=" + encodeURIComponent("")}
				},
				messages: {
					name: {remote: "角色名已存在"}
				},
				submitHandler: function(form){
					var ids = [], nodes = tree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						ids.push(nodes[i].id);
					}
					$("#menuIds").val(ids);
					var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
					for(var i=0; i<nodes2.length; i++) {
						ids2.push(nodes2[i].id);
					}
					$("#officeIds").val(ids2);
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
					data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}}};
			
			// 用户-菜单
			var zNodes=[
					{id:"1", pId:"0", name:"功能菜单"},
		            {id:"20", pId:"13", name:"用户管理"},
		            {id:"68", pId:"67", name:"日志查询"},
		            {id:"4", pId:"3", name:"菜单管理"},
		            {id:"28", pId:"27", name:"个人信息"},
		            {id:"13", pId:"2", name:"机构用户"},
		            {id:"27", pId:"1", name:"我的面板"},
		            {id:"7", pId:"3", name:"角色管理"},
		            {id:"17", pId:"13", name:"机构管理"},
		            {id:"29", pId:"28", name:"个人信息"},
		            {id:"84", pId:"67", name:"连接池监视"},
		            {id:"3", pId:"2", name:"系统设置"},
		            {id:"2", pId:"1", name:"系统设置"},
		            {id:"21", pId:"20", name:"查看"},
		            {id:"8", pId:"7", name:"查看"},
		            {id:"11", pId:"10", name:"查看"},
		            {id:"67", pId:"2", name:"日志查询"},
		            {id:"18", pId:"17", name:"查看"},
		            {id:"10", pId:"3", name:"字典管理"},
		            {id:"30", pId:"28", name:"修改密码"},
		            {id:"15", pId:"14", name:"查看"},
		            {id:"14", pId:"13", name:"区域管理"},
		            {id:"5", pId:"4", name:"查看"},
		            {id:"22", pId:"20", name:"修改"},
		            {id:"12", pId:"10", name:"修改"},
		            {id:"19", pId:"17", name:"修改"},
		            {id:"16", pId:"14", name:"修改"},
		            {id:"6", pId:"4", name:"修改"},
		            {id:"9", pId:"7", name:"修改"},
		            ];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids = "".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(true);
			
			// 用户-机构
			var zNodes2=[
					{id:"1", pId:"0", name:"湖南省总公司"},
		            {id:"2", pId:"1", name:"公司领导"},
		            {id:"3", pId:"1", name:"综合部"},
		            {id:"4", pId:"1", name:"市场部"},
		            {id:"5", pId:"1", name:"技术部"},
		            {id:"6", pId:"1", name:"研发部"},
		            {id:"7", pId:"1", name:"长沙市分公司"},
		            {id:"8", pId:"7", name:"公司领导"},
		            {id:"9", pId:"7", name:"综合部"},
		            {id:"10", pId:"7", name:"市场部"},
		            {id:"11", pId:"7", name:"技术部"},
		            {id:"12", pId:"7", name:"芙蓉区分公司"},
		            {id:"13", pId:"12", name:"公司领导"},
		            {id:"14", pId:"12", name:"综合部"},
		            {id:"15", pId:"12", name:"市场部"},
		            {id:"16", pId:"12", name:"技术部"},
		            ];
			// 初始化树结构
			var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
			// 不选择父节点
			tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids2 = "".split(",");
			for(var i=0; i<ids2.length; i++) {
				var node = tree2.getNodeByParam("id", ids2[i]);
				try{tree2.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree2.expandAll(true);
			// 刷新（显示/隐藏）机构
			refreshOfficeTree();
			$("#dataScope").change(function(){
				refreshOfficeTree();
			});
		});
		function refreshOfficeTree(){
			if($("#dataScope").val()==9){
				$("#officeTree").show();
			}else{
				$("#officeTree").hide();
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="roleList.html">角色列表</a></li>
		<li class="active"><a href="roleAdd.html">角色添加</a></li>
	</ul><br/>
	<form id="inputForm" class="form-horizontal" action="#" method="post">
		<input id="id" name="id" type="hidden" value=""/>
<script type="text/javascript">top.$.jBox.closeTip();</script>

		<div class="control-group">
			<label class="control-label">所属机构:</label>
			<div class="controls">

<div class="input-append">
	<input id="officeId" name="office.id" class="required" type="hidden" value="2"/>
	<input id="officeName" name="office.name" readonly="readonly" type="text" value="公司领导" data-msg-required=""
		class="required" style=""/><a id="officeButton" href="javascript:" class="btn  " style="">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">角色名称:</label>
			<div class="controls">
				<input id="oldName" name="oldName" type="hidden" value="">
				<input id="name" name="name" class="required" type="text" value="" maxlength="50"/>
				<span class="help-inline"><span style="color:red">*</span> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否系统数据:</label>
			<div class="controls">
				<select id="sysData" name="sysData">
					<option value="1">是</option><option value="0">否</option>
				</select>
				<span class="help-inline">“是”代表此数据只有超级管理员能进行修改，“否”则表示拥有角色修改人员的权限都能进行修改</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否可用</label>
			<div class="controls">
				<select id="useable" name="useable">
					<option value="1" selected="selected">是</option><option value="0">否</option>
				</select>
				<span class="help-inline">“是”代表此数据可用，“否”则表示此数据不可用</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">数据范围:</label>
			<div class="controls">
				<select id="dataScope" name="dataScope" class="input-medium">
					<option value="1">所有数据</option><option value="2">所在公司及以下数据</option><option value="3">所在公司数据</option><option value="4">所在部门及以下数据</option><option value="5">所在部门数据</option><option value="8" selected="selected">仅本人数据</option><option value="9">按明细设置</option>
				</select>
				<span class="help-inline">特殊情况下，设置为“按明细设置”，可进行跨机构授权</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">角色授权:</label>
			<div class="controls">
				<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
				<input id="menuIds" name="menuIds" type="hidden" value=""/>
				<div id="officeTree" class="ztree" style="margin-left:100px;margin-top:3px;float:left;"></div>
				<input id="officeIds" name="officeIds" type="hidden" value=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<textarea id="remarks" name="remarks" maxlength="200" class="input-xlarge" rows="3"></textarea>
			</div>
		</div>
		<div class="form-actions">
			
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>