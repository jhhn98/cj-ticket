<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>배너 항목 순서변경</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
    function index_up() {
        var form = document.getElementById('bannerZoneItemVO');
        var SelectIndex = form.idx.selectedIndex;
        if( SelectIndex < 0 ) {
            alert('배너 항목을 선택하여 주세요.');
            return false;
        }
        if( SelectIndex ) {
            temp = form.idx.options[SelectIndex].text;
            form.idx.options[SelectIndex].text = form.idx.options[SelectIndex-1].text;
            form.idx.options[SelectIndex-1].text = temp;
            tempindex = form.idx.options[SelectIndex].value;
            form.idx.options[SelectIndex].value = form.idx.options[SelectIndex-1].value;
            form.idx.options[SelectIndex-1].value = tempindex;
            form.idx.selectedIndex = SelectIndex-1;
        }
    }
    function index_ups() {
        var form = document.getElementById('bannerZoneItemVO');
        var SelectIndex = form.idx.selectedIndex;
        if( SelectIndex < 0 ) {
            alert('배너 항목을 선택하여 주세요.');
            return false;
        }
        if( SelectIndex ) {
            temp = form.idx.options[SelectIndex].text;
            tempindex = form.idx.options[SelectIndex].value;
            for( var LoopI=SelectIndex-1; LoopI>=0; LoopI-- ) {
                form.idx.options[LoopI+1].text = form.idx.options[LoopI].text;
                form.idx.options[LoopI+1].value = form.idx.options[LoopI].value;
            }
            form.idx.options[0].text = temp;
            form.idx.options[0].value = tempindex;
            form.idx.selectedIndex = 0;
        }
    }
    function index_dn() {
        var form = document.getElementById('bannerZoneItemVO');
        var SelectIndex = form.idx.selectedIndex;
        if( SelectIndex < 0 ) {
            alert('배너 항목을 선택하여 주세요.');
            return false;
        }
        if( SelectIndex+1 < form.idx.length ) {
            temp = form.idx.options[SelectIndex+1].text;
            form.idx.options[SelectIndex+1].text = form.idx.options[SelectIndex].text;
            form.idx.options[SelectIndex].text = temp;
            tempindex = form.idx.options[SelectIndex+1].value;
            form.idx.options[SelectIndex+1].value = form.idx.options[SelectIndex].value;
            form.idx.options[SelectIndex].value = tempindex;
            form.idx.selectedIndex = SelectIndex+1;
        }
    }
    function index_dns() {
        var form = document.getElementById('bannerZoneItemVO');
        var SelectIndex = form.idx.selectedIndex;
        var SelectLength = form.idx.length-1;
        if( SelectIndex < 0 ) {
            alert('배너 항목을 선택하여 주세요.');
            return false;
        }
        if( SelectIndex < SelectLength ) {
            temp = form.idx.options[SelectIndex].text;
            tempindex = form.idx.options[SelectIndex].value;
            for( var LoopI=SelectIndex+1; LoopI<=SelectLength; LoopI++ ) {
                form.idx.options[LoopI-1].text = form.idx.options[LoopI].text;
                form.idx.options[LoopI-1].value = form.idx.options[LoopI].value;
            }
            form.idx.options[SelectLength].text = temp;
            form.idx.options[SelectLength].value = tempindex;
            form.idx.selectedIndex = SelectLength;
        }
    }
    function IdxSubmit( form ) {
        form.idxData.value = "";
        for(var i=0; i<form.idx.length; i++)
            form.idxData.value += form.idx.options[i].value + '^';
        fn_ajax_submit(form.id);
        return false;
    }
</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">배너존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red eng_text"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bannerZone.bannerZoneNm}"/> 순서변경</span>
</div>
<div class="contents">
    <p class="info_text">표시중인 항목만 순서변경이 가능하며 표시되지 않는 배너는 맨 마지막으로 자동 이동 됩니다.</p>
    <form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" action="sortBannerZoneItem.do" onsubmit="IdxSubmit(this)">
        <form:hidden path="siteId"/>
        <form:hidden path="bannerZoneNo"/>
        <form:hidden path="pageUnit"/>
        <form:hidden path="searchCnd"/>
        <form:hidden path="searchKrwd"/>
        <form:hidden path="searchShowSe"/>
        <form:hidden path="pageIndex"/>
        <form:hidden path="idxData"/>
        <div class="topMargin">
            <select name="idx" style="height:260px; width:100%; border:solid 1px #528ED8" size="16">
                <c:forEach var="result" items="${bannerZoneItemList}" varStatus="status">
                    <option value="<c:out value="${result.bannerZoneIemNo}"/>"><c:out value="${result.bannerZoneIemNm}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <button type="button" onclick="index_ups()" class="iconButton angle_double_up marginRight_5"><span>맨위로</span></button>
                <button type="button" onclick="index_up()" class="iconButton angle_up marginRight_5"><span>위로</span></button>
                <button type="button" onclick="index_dn()" class="iconButton angle_down marginRight_5"><span>아래로</span></button>
                <button type="button" onclick="index_dns()" class="iconButton angle_double_down"><span>맨아래로</span></button>
            </div>
            <div class="arrRight">
                <a href="./selectBannerZoneItemList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
                <button type="submit" class="iconTextButton sort marginLeft_5"><span>순서변경</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>