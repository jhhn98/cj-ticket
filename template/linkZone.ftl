<#ftl encoding="utf-8"/>
<ul>
    <#list linkItemList as item>
        <li><a href="${item.linkUrl}" target="${item.linkTrget}" title="새창" rel="noopener noreferrer"><span>${item.linkZoneIemNm}</span></a></li>
    </#list>
</ul>

