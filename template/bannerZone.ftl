<#ftl encoding="utf-8"/>
<ul>
<#list bannerItemList as item>
    <li><a href="${item.linkUrl}" target="${item.linkTrget}" title="새창" rel="noopener noreferrer"><img src="/DATA/banner/${item.imageFileNm}" alt="${item.bannerZoneIemNm}"></a></li>
</#list>
</ul>