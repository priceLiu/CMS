/// <reference path="../jQuery/jquery-1.4.2.js"/>
/// <reference path="we7.loader.dev.js"/>



/*
注意：此文件仅供内部单元测试使用，发布时可不发布此文件
*/


function castTmpl(str) {
	return str
			.replace(/\$\{([^\}]*)\}/g, "{{html $1}}")
			.replace(/\{\{\/if\}\}/g, "<?}?>")
			.replace(/\{\{if\s+(?:\(?((?:[^\}]|\}(?!\}))*?)\)?)\s*\}\}/g, "<?if($1){?>")
			.replace(/\{\{else\s*\}\}/g, "<?}else{?>")
			.replace(/\{\{else\s+(?:\(?((?:[^\}]|\}(?!\}))*?)\)?)\s*\}\}/g, "<?}else if($1){?>")
			.replace(/\{\{(?:html|=)\s+(?:\(?((?:[^\}]|\}(?!\}))*)\)?)\s*\}\}/g, "<?=$1?>");
}


var orgs = [
	'<tr><td header="名称"><img src="/admin/images/icon_User.gif" style="border-width:0px;"><a href="AccountEdit.aspx?id=${ID}">${LoginName}</a></td><td header="所属部门">${Department}</td><td editable="select" header="类型" editkey="UserType">{{if UserType==0}}管理用户{{else}}普通用户 {{/if}}</td><td header="注册日期">{{html Created.substr(0,10)}}</td><td header="操作"><a href="AccountEdit.aspx?id=${ID}&tab=2">角色设置</a>  <a href="AccountEdit.aspx?id=${ID}&tab=6">模块权限</a></td></tr>'
	, '<tr><td header="名称"><img src="/admin/images/icon_Department.gif" style="border-width:0px;"><a href="DepartmentDetail.aspx?id=${ID}">${Title}</a></td><td header="描述" editable="text">${Description}</td><td header="添加日期" editable="date" editkey="Created">{{= Created.substr(0,10)}}</td></tr>'
	, '<tr><td header="名称"><a href="Permissions/RoleEdit.aspx?id=${ID}">${Title}</a></td><td header="描述" editable="text">${Description}</td><td header="类型" editable="select" editkey="RoleType" sortkey="RoleType">{{if RoleType==0}}管理员角色{{else}}普通用户角色{{/if}}</td><td header="操作"><a href="Permissions/RoleEdit.aspx?id=${ID}&tab=2">所属用户</a> <a href="Permissions/RoleEdit.aspx?id=${ID}&tab=3">模块权限</a></td></tr>'
	, '<tr><td header="名称"><a href="AccountEdit.aspx?id=${ID}">${LoginName}</a></td><td header="Email">${Email}</td><td header="注册时间">{{html Created.substr(0,10)}}</td><td header="Email验证">{{if (EmailValidate==0)}}<font style=\'color:red\'>未验证</font>{{else (EmailValidate=1)}}<font style=\'color:green\'>通过</font>{{/if}}</td><td header="类型">{{if UserType==0}}管理用户{{else}}普通用户{{/if}}</td><td header="状态" editable="select" editkey="State">{{if State==0}}<font style=\'color:red\'>禁用</font>{{else}}<font style=\'color:green\'>启用</font>{{/if}}</td></tr>'
];

var results = [
	'<tr><td header="名称"><img src="/admin/images/icon_User.gif" style="border-width:0px;"><a href="AccountEdit.aspx?id=<?=ID?>"><?=LoginName?></a></td><td header="所属部门"><?=Department?></td><td editable="select" header="类型" editkey="UserType"><?if(UserType==0){?>管理用户<?}else{?>普通用户 <?}?></td><td header="注册日期"><?=Created.substr(0,10)?></td><td header="操作"><a href="AccountEdit.aspx?id=<?=ID?>&tab=2">角色设置</a>  <a href="AccountEdit.aspx?id=<?=ID?>&tab=6">模块权限</a></td></tr>'
	, '<tr><td header="名称"><img src="/admin/images/icon_Department.gif" style="border-width:0px;"><a href="DepartmentDetail.aspx?id=<?=ID?>"><?=Title?></a></td><td header="描述" editable="text"><?=Description?></td><td header="添加日期" editable="date" editkey="Created"><?=Created.substr(0,10)?></td></tr>'
	, '<tr><td header="名称"><a href="Permissions/RoleEdit.aspx?id=<?=ID?>"><?=Title?></a></td><td header="描述" editable="text"><?=Description?></td><td header="类型" editable="select" editkey="RoleType" sortkey="RoleType"><?if(RoleType==0){?>管理员角色<?}else{?>普通用户角色<?}?></td><td header="操作"><a href="Permissions/RoleEdit.aspx?id=<?=ID?>&tab=2">所属用户</a> <a href="Permissions/RoleEdit.aspx?id=<?=ID?>&tab=3">模块权限</a></td></tr>'
	, '<tr><td header="名称"><a href="AccountEdit.aspx?id=<?=ID?>"><?=LoginName?></a></td><td header="Email"><?=Email?></td><td header="注册时间"><?=Created.substr(0,10)?></td><td header="Email验证"><?if(EmailValidate==0){?><font style=\'color:red\'>未验证</font><?}else if(EmailValidate=1){?><font style=\'color:green\'>通过</font><?}?></td><td header="类型"><?if(UserType==0){?>管理用户<?}else{?>普通用户<?}?></td><td header="状态" editable="select" editkey="State"><?if(State==0){?><font style=\'color:red\'>禁用</font><?}else{?><font style=\'color:green\'>启用</font><?}?></td></tr>'
];

test("hello test", function () {
	equals(castTmpl(orgs[0]), results[0], "1st cast");
	equals(castTmpl(orgs[1]), results[1], "2nd cast");
	equals(castTmpl(orgs[2]), results[2], "3rd cast");
	equals(castTmpl(orgs[3]), results[3], "4th cast");
});