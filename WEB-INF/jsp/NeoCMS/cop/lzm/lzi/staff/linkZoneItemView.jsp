<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>링크 항목 상세정보</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div class="p-wrap">

	<div class="col-20">
		<div>
			<span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>

		<table class="p-table" id="burialTable">
            <colgroup>
                <col class="w15p">
                <col/>
            </colgroup>
            <tbody>
			<tr>
				<th scope="row">링크이름</th>
				<td><c:out value="${linkZoneItem.linkZoneIemNm}"/></td>
			</tr>
			<tr>
				<th scope="row">표시구분</th>
				<td><c:out value="${showSeMap[linkZoneItem.showSe]}"/></td>
			</tr>
			<tr>
				<th scope="row">기간</th>
				<td><c:out value="${linkZoneItem.bgndeYMDHM}"/> ~ <c:out value="${linkZoneItem.enddeYMDHM}"/></td>
			</tr>
			<tr>
				<th scope="row">링크URL</th>
				<td><c:out value="${linkZoneItem.linkUrl}"/></td>
			</tr>
			<tr>
				<th scope="row">링크대상</th>
				<td><c:out value="${linkTrgetMap[linkZoneItem.linkTrget]}"/></td>
			</tr>
			</tbody>
		</table>
		
		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectLinkZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=${linkZoneItemVO.siteId}&amp;linkZoneNo=${linkZoneItemVO.linkZoneNo}&amp;pageUnit=${linkZoneItemVO.pageUnit}&amp;searchCnd=${linkZoneItemVO.searchCnd}&amp;searchKrwd=${linkZoneItemVO.searchKrwd}&amp;searchShowSe=${linkZoneItemVO.searchShowSe}&amp;pageIndex=${linkZoneItemVO.pageIndex}" class="p-button cancel">목록</a>
			</div>
			<div class="col-12 right">
				<a href="./updateLinkZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=${linkZoneItemVO.siteId}&amp;linkZoneNo=${linkZoneItemVO.linkZoneNo}&amp;linkZoneIemNo=${linkZoneItemVO.linkZoneIemNo}&amp;pageUnit=${linkZoneItemVO.pageUnit}&amp;searchCnd=${linkZoneItemVO.searchCnd}&amp;searchKrwd=${linkZoneItemVO.searchKrwd}&amp;showSe=${linkZoneItemVO.searchShowSe}&amp;pageIndex=${linkZoneItemVO.pageIndex}" class="p-button edit">수정</a>
				<a href="./deleteLinkZoneItem.do?key=<c:out value="${key}"/>&amp;siteId=${linkZoneItemVO.siteId}&amp;linkZoneNo=${linkZoneItemVO.linkZoneNo}&amp;linkZoneIemNo=${linkZoneItemVO.linkZoneIemNo}&amp;pageUnit=${linkZoneItemVO.pageUnit}&amp;searchCnd=${linkZoneItemVO.searchCnd}&amp;searchKrwd=${linkZoneItemVO.searchKrwd}&amp;showSe=${linkZoneItemVO.searchShowSe}&amp;pageIndex=${linkZoneItemVO.pageIndex}" onclick="fn_deleteLinkZoneItem(this.href); return false;" class="p-button delete">삭제</a>
			</div>
		</div>
	
    </div>

</div>
<script nonce="NEOCMSSCRIPT">
    function fn_deleteLinkZoneItem( url ) {
        if( confirm("삭제하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>
</body>
</html>