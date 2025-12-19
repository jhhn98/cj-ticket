<#ftl encoding="utf-8"/>
{
    "menuNo" : "${menu.menuNo?string("##0")}",
    "upperMenuNo" : "${menu.upperMenuNo?string("##0")}",
    "siteId" : "${menu.siteId}", 
    "menuNm" : "${menu.menuNm}", 
    "cntntsNm" : "${menu.cntntsNm!""}", 
    "menuTy" : "${menu.menuTy}",
    "innerFile" : "${menu.innerFile!""}",
    "iframeUrl" : "${menu.iframeUrl!""}",
    "iframeStyle" : "${menu.iframeStyle!""}",
    "linkTrget" : "${menu.linkTrget}", 
    "menuUrl" : "${menu.menuUrl!""}", 
    "tabMenuUseAt" : "${menu.tabMenuUseAt}", 
    "deptCode" : "${menu.deptCode!""}", 
    "deptNm" : "${menu.deptNm!""}", 
    "emplCode" : "${menu.emplCode!""}", 
    "emplNm" : "${menu.emplNm!""}", 
    "emplTelno" : "${menu.emplTelno!""}",
    "cntntsLastUpdusrPnttm" : "${menu.cntntsLastUpdusrPnttmYMD!""}",
    "naviList" : [
<#list menuNavi as navi>
        {
            "menuNo" : "${navi.menuNo?string("##0")}",
            "menuNm" : "${navi.menuNm}",
            "menuUrl" : "${navi.menuUrl!""}",
            "linkTrget" : "${navi.linkTrget}",
            "menuOrdr" : "${navi.menuOrdr}"
        }<#if navi_has_next>,</#if>
</#list>
    ],
    "cntntsEvlNo" : "${menu.cntntsEvlNo?string("##0")}",
    "koglUseAt" : "${menu.koglUseAt!""}",
    "koglTy" : "${menu.koglTy!""}",
    "menuShowAt" : "${menu.menuShowAt!""}"
}