<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>배너 항목 상세정보</title>
<meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">배너존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red eng_text"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bannerZone.bannerZoneNm}"/> 상세정보</span>
</div>
<div class="dataWrap">
    <table>
        <colgroup>
            <col class="specWidth200px"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row">배너이름</th>
            <td><c:out value="${bannerZoneItem.bannerZoneIemNm}"/></td>
        </tr>
        <tr>
            <th scope="row">표시구분</th>
            <td>${showSeMap[bannerZoneItem.showSe]}</td>
        </tr>
        <tr>
            <th scope="row">기간</th>
            <td><span class="eng_text"><c:out value="${bannerZoneItem.bgndeYMDHM}"/> ~ <c:out value="${bannerZoneItem.enddeYMDHM}"/></span></td>
        </tr>
        <tr>
            <th scope="row">링크URL</th>
            <td><span class="eng_text"><c:out value="${bannerZoneItem.linkUrl}"/></span></td>
        </tr>
        <tr>
            <th scope="row">링크대상</th>
            <td>${linkTrgetMap[bannerZoneItem.linkTrget]}</td>
        </tr>
        <tr>
            <th scope="row">대체텍스트</th>
            <td><c:out value="${bannerZoneItem.imageReplcText}"/></td>
        </tr>
        </tbody>
    </table>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectBannerZoneItemList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./updateBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${bannerZoneItemVO.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
            <a href="./deleteBannerZoneItem.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${bannerZoneItemVO.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" onclick="fn_deleteBannerZoneItem(this.href); return false;" class="iconTextButton delete marginLeft_5"><span>삭제</span></a>
        </div>
    </div>
</div>
<script nonce="NEOCMSSCRIPT">
    function fn_deleteBannerZoneItem( url ) {
        if( confirm("삭제하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>
</body>
</html>