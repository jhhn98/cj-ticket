<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>링크 항목 상세정보</title>
<meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">링크존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">링크존항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${linkZone.linkZoneNm}"/> </span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">상세정보</span>
</div>
<div class="dataWrap">
    <table>
        <colgroup>
            <col class="specWidth200px"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row">링크이름</th>
            <td><c:out value="${linkZoneItem.linkZoneIemNm}"/></td>
        </tr>
        <tr>
            <th scope="row">표시구분</th>
            <td>${showSeMap[linkZoneItem.showSe]}</td>
        </tr>
        <tr>
            <th scope="row">기간</th>
            <td><span class="eng_text"><c:out value="${linkZoneItem.bgndeYMDHM}"/> ~ <c:out value="${linkZoneItem.enddeYMDHM}"/></span></td>
        </tr>
        <tr>
            <th scope="row">링크URL</th>
            <td><span class="eng_text"><c:out value="${linkZoneItem.linkUrl}"/></span></td>
        </tr>
        <tr>
            <th scope="row">링크대상</th>
            <td>${linkTrgetMap[linkZoneItem.linkTrget]}</td>
        </tr>
        </tbody>
    </table>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectLinkZoneItemList.do?siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./updateLinkZoneItemView.do?siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;linkZoneIemNo=<c:out value="${linkZoneItemVO.linkZoneIemNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
            <a href="./deleteLinkZoneItem.do?siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;linkZoneIemNo=<c:out value="${linkZoneItemVO.linkZoneIemNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;showSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" onclick="fn_deleteLinkZoneItem(this.href); return false;" class="iconTextButton delete marginLeft_5"><span>삭제</span></a>
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