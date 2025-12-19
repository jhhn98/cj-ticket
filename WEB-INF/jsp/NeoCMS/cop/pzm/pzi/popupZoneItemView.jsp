<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팝업 항목 상세정보</title>
    <meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_program">컴포넌트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">팝업존항목관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${popupZone.popupZoneNm}"/> 상세정보</span>
</div>
<div class="dataWrap">
    <div class="form_wrap isTopBottom">
        <table>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">팝업이름</th>
                <td><c:out value="${popupZoneItem.popupZoneIemNm}"/></td>
            </tr>
            <tr>
                <th scope="row">표시구분</th>
                <td>${showSeMap[popupZoneItem.showSe]}"/></td>
            </tr>
            <tr>
                <th scope="row">기간</th>
                <td><span class="eng_text"><c:out value="${popupZoneItem.bgndeYMDHM}"/> ~ <c:out value="${popupZoneItem.enddeYMDHM}"/></span></td>
            </tr>
            <tr>
                <th scope="row">링크URL</th>
                <td><span class="eng_text"><c:out value="${popupZoneItem.linkUrl}"/></span></td>
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
                        <p class="em_gray marginLeft_25"><c:out value="${popupZoneItem.imageReplcText}"/></p>
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
                            <p class="em_gray marginLeft_25"><c:out value="${popupZoneItem.imageReplcTextMobile}"/></p>
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
                            <p class="em_gray marginLeft_25"><c:out value="${popupZoneItem.imageReplcTextEtc}"/></p>
                        </div>
                    </c:if>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="arrangementWrap data_button marginTop_20">
        <div class="arrLeft">
            <a href="./selectPopupZoneItemList.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./updatePopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${popupZoneItemVO.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
            <a href="./deletePopupZoneItem.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${popupZoneItemVO.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" onclick="fn_deletePopupZoneItem(this.href); return false;" class="iconTextButton delete marginLeft_5"><span>삭제</span></a>
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