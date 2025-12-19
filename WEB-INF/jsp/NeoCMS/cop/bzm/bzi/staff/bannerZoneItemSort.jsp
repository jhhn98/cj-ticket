<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>배너 항목 순서변경</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
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
<div class="p-wrap">

    <div class="col-20">

        <p class="info_text">표시중인 항목만 순서변경이 가능하며 표시되지 않는 팝업는 맨 마지막으로 자동 이동 됩니다.</p>
    <form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" action="sortBannerZoneItem.do" onsubmit="IdxSubmit(this)">
        <input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
        <form:hidden path="siteId"/>
        <form:hidden path="bannerZoneNo"/>
        <form:hidden path="pageUnit"/>
        <form:hidden path="searchCnd"/>
        <form:hidden path="searchKrwd"/>
        <form:hidden path="searchShowSe"/>
        <form:hidden path="pageIndex"/>
        <form:hidden path="idxData"/>
        <table class="p-table">
            <colgroup>
                <col class="w20p">
                <col/>
            </colgroup>
            <tr>
                <th colspan="2">순서변경</th>
            </tr>
            <tr>
                <td colspan="2">
                    <select name="idx" class="p-input p-input--auto" style="width:100%;" size="17">
                    <c:forEach var="result" items="${bannerZoneItemList}" varStatus="status">
                        <option value="<c:out value="${result.bannerZoneIemNo}"/>"><c:out value="${result.bannerZoneIemNm}"/></option>
                    </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
        <div class="row p-relative">
            <div class="col-15 margin_t_5">
                <a href="#n" onclick="index_ups()" class="p-button p-button--small">
                    <svg width="16" height="15" focusable="false"><title>맨위로</title><use xlink:href="/common/images/program/p-icon.svg#angle-double-up"></use></svg>맨위로
                </a>
                <a href="#n" onclick="index_up()" class="p-button p-button--small">
                    <svg width="16" height="15" focusable="false"><title>위로</title><use xlink:href="/common/images/program/p-icon.svg#angle-up"></use></svg>위로
                </a>
                <a href="#n" onclick="index_dn()" class="p-button p-button--small">
                    <svg width="16" height="15" focusable="false"><title>아래로</title><use xlink:href="/common/images/program/p-icon.svg#angle-down"></use></svg>아래로
                </a>
                <a href="#n" onclick="index_dns()" class="p-button p-button--small">
                    <svg width="16" height="15" focusable="false"><title>맨아래로</title><use xlink:href="/common/images/program/p-icon.svg#angle-double-down"></use></svg>맨아래로
                </a>
            </div>
            <div class="col-9 right">
                <a href="./selectBannerZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>"  class="p-button p-button--small">
                    <svg width="16" height="15" focusable="false"><title>목록</title><use xlink:href="/common/images/program/p-icon.svg#bars"></use></svg>목록
                </a>

                <input type="submit" value="순서변경" class="p-button p-button--small write restore">
            </div>
        </div>
    </form:form>

    </div>

</div>
</body>
</html>