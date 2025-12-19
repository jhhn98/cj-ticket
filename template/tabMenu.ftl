<#ftl encoding="utf-8"/>
[
<#list lwprtMenuList as lwprtMenu>
		{
			"menuNo" : "${lwprtMenu.menuNo?string("##0")}",
			"menuNm" : "${lwprtMenu.menuNm}",
			"menuUrl" : "${lwprtMenu.menuUrl!""}",
			"linkTrget" : "${lwprtMenu.linkTrget}"
		}<#if lwprtMenu_has_next>,</#if>
</#list>
]