<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팝업 항목 상세정보</title>
    <meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div class="p-wrap">

	<div class="col-20">
		<div>
			<span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>
		
		<table class="p-table">
            <colgroup>
                <col class="w15p">
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">팝업이름</th>
                <td>${popupZoneItem.popupZoneIemNm}</td>
            </tr>
            <tr>
                <th scope="row">표시구분</th>
                <td>${showSeMap[popupZoneItem.showSe]}</td>
            </tr>
            <tr>
                <th scope="row">기간</th>
                <td><span class="eng_text">${popupZoneItem.bgndeYMDHM} ~ ${popupZoneItem.enddeYMDHM}</span></td>
            </tr>
            <tr>
                <th scope="row">링크URL</th>
                <td><span class="eng_text">${popupZoneItem.linkUrl}</span></td>
            </tr>
            <tr>
                <th scope="row">링크대상</th>
                <td>${linkTrgetMap[popupZoneItem.linkTrget]}</td>
            </tr>
            <tr>
                <th scope="row">PC 이미지</th>
                <td>
                    <img src="/DATA/popup/<c:out value="${popupZoneItem.imageFileNm}"/>" width="<c:out value="${popupZone.imageWidthSize}"/>" height="<c:out value="${popupZone.imageHeightSize}"/>"/>
                    <div class="marginTop_5">
                        <div class="info_text">대체 텍스트</div>
                        <p class="em_gray marginLeft_25">${popupZoneItem.imageReplcText}</p>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">이미지 Mobile</th>
                <td>
                    <c:if test="${not empty popupZoneItem.imageFileNmMobile}">
                        <img src="/DATA/popup/<c:out value="${popupZoneItem.imageFileNmMobile}"/>" width="<c:out value="${popupZone.imageWidthSizeMobile}"/>" height="<c:out value="${popupZone.imageHeightSizeMobile}"/>"/>
                        <div class="marginTop_5">
                            <div class="info_text">대체 텍스트</div>
                            <p class="em_gray marginLeft_25">${popupZoneItem.imageReplcTextMobile}</p>
                        </div>
                    </c:if>

                </td>
            </tr>
            <tr>
                <th scope="row">ETC 이미지</th>
                <td>
                    <c:if test="${not empty popupZoneItem.imageFileNmEtc}">
                        <img src="/DATA/popup/<c:out value="${popupZoneItem.imageFileNmEtc}"/>" width="<c:out value="${popupZone.imageWidthSizeEtc}"/>" height="<c:out value="${popupZone.imageHeightSizeEtc}"/>"/>
                        <div class="marginTop_5">
                            <div class="info_text">대체 텍스트</div>
                            <p class="em_gray marginLeft_25">${popupZoneItem.imageReplcTextEtc}</p>
                        </div>
                    </c:if>
                </td>
            </tr>
            </tbody>
        </table>
		
		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectPopupZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=${popupZoneItemVO.siteId}&amp;popupZoneNo=${popupZoneItemVO.popupZoneNo}&amp;pageUnit=${popupZoneItemVO.pageUnit}&amp;searchCnd=${popupZoneItemVO.searchCnd}&amp;searchKrwd=${popupZoneItemVO.searchKrwd}&amp;searchShowSe=${popupZoneItemVO.searchShowSe}&amp;pageIndex=${popupZoneItemVO.pageIndex}" class="p-button cancel">목록</a>
			</div>
			<div class="col-12 right">
				<a href="./updatePopupZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=${popupZoneItemVO.siteId}&amp;popupZoneNo=${popupZoneItemVO.popupZoneNo}&amp;popupZoneIemNo=${popupZoneItemVO.popupZoneIemNo}&amp;pageUnit=${popupZoneItemVO.pageUnit}&amp;searchCnd=${popupZoneItemVO.searchCnd}&amp;searchKrwd=${popupZoneItemVO.searchKrwd}&amp;showSe=${popupZoneItemVO.searchShowSe}&amp;pageIndex=${popupZoneItemVO.pageIndex}" class="p-button edit">수정</a>
				<a href="./deletePopupZoneItem.do?key=<c:out value="${key}"/>&amp;siteId=${popupZoneItemVO.siteId}&amp;popupZoneNo=${popupZoneItemVO.popupZoneNo}&amp;popupZoneIemNo=${popupZoneItemVO.popupZoneIemNo}&amp;pageUnit=${popupZoneItemVO.pageUnit}&amp;searchCnd=${popupZoneItemVO.searchCnd}&amp;searchKrwd=${popupZoneItemVO.searchKrwd}&amp;showSe=${popupZoneItemVO.searchShowSe}&amp;pageIndex=${popupZoneItemVO.pageIndex}" onclick="fn_deletePopupZoneItem(this.href); return false;" class="p-button delete">삭제</a>
			</div>
		</div>
		
	</div>

</div>

<script nonce="NEOCMSSCRIPT">
    function fn_deletePopupZoneItem( url ) {
        if( confirm("삭제하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>

</body>
</html>