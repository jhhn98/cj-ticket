<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>템플릿 &gt; 수정 내역 리스트</title>
    <meta name="decorator" content="neo" />
    <script nonce="NEOCMSSCRIPT">
        <%--
        $(window).resize(sizeContent);
        function sizeContent() {
            var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#fileInfo").height() - 60) + "px";
            $("#contentsCn").css("height", newHeight);
        }
        $(document).ready(sizeContent);
        --%>
        function fn_restoreContents( url ) {
            if( confirm("선택한 콘텐츠로 복원하시겠습니까?") ) {
                window.location = url;
            }
        }
    </script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_template">템플릿설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title"><c:out value="${template.tmplatNm}"/>(<span class="em_red"><c:out value="${template.tmplatId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title">템플릿 수정 이력</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${item.tmplatIemNm}"/>(<span class="em_red">/template/<c:out value="${item.tmplatId}"/>/<c:out value="${item.tmplatIemSe}"/>/<c:out value="${item.tmplatIemFileNm}"/>.ftl</span>)</span>
</div>
<div class="tab_navigation" id="subMenu">
    <a href="./updateTemplateEditorView.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>"><span>템플릿 수정</span></a>
    <a href="./selectTemplateHistoryList.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="current"><span>템플릿 수정 이력</span></a>
    <a href="./selectTemplateHistoryDiff.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>"><span>템플릿 버전별 비교</span></a>
</div>
<div class="tab_navigation_lank">
    <c:forEach var="result" items="${tempItems}" varStatus="status">
        <a href="./selectTemplateHistoryList.do?templateId=<c:out value="${item.tmplatId}"/>&tmplatIemNo=<c:out value="${result.tmplatIemNo}"/>" class="<c:out value="${result.tmplatIemNo eq item.tmplatIemNo  ? 'current ' : ''}" />"><span><c:out value=" ${result.tmplatIemSe}"/>/<c:out value="${result.tmplatIemFileNm}"/>.ftl</span></a>
    </c:forEach>
</div>
<div class="contents is_tab_multi">
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth70px"/>
                        <col/>
                        <col class="specWidth100px"/>
                        <col class="specWidth100px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">수정일</th>
                        <th scope="col">수정자</th>
                        <th scope="col">복원</th>
                    </tr>

                    </thead>
                    <tbody>
                    <tr>
                        <td class="textACenter"><span class="basic_site check">현재적용중</span></td>
                        <td><c:out value="${lastUpdtDate}"/></td>
                        <td class="textACenter">LIVE버전</td>
                        <td class="textACenter"></td>
                    </tr>
                    <% /*
            <tr>
                <td class="textACenter"><img src="./images/check.png"/></td>
                <td>${menu.cntntsLastUpdusrPnttmYMDHMS}</td>
                <td class="textACenter">${menu.cntntsWrterNm}(<span class="em_red">${menu.cntntsWrterId}</span>)</td>
                <td class="textACenter"><a href="./viewContentsHtml.do?siteId=${menu.siteId}&amp;menuNo=${menu.menuNo}" class="button"><span>HTML보기</span></a></td>
                <td class="textACenter"><a href="/${menu.siteId}/contents.do?key=${menu.menuNo}" class="button blue" target="_blank"><span>미리보기</span></a></td>
                <td class="textACenter"></td>
            </tr> */ %>
                    <c:set var="sNumber" value="${templateHistoryTotCnt}"/>
                    <c:forEach var="result" items="${templateHistoryList}" varStatus="status">
                        <tr>
                            <td class="textARight"><c:out value="${sNumber}"/></td>
                            <td><c:out value="${result.tempLastUpdusrPnttmYMDHMS}"/></td>
                            <td class="textACenter"><c:out value="${not empty result.lastUpdusrId ? result.lastUpdusrId : result.frstRegisterId}"/></td>
                            <td class="textACenter"><a href="restoreTemplateHistory.do?templateId=<c:out value="${item.tmplatId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>&tempHistNo=<c:out value="${result.tempHistNo}"/>" onclick="fn_restoreContents(this.href); return false;" class="iconTextButton history_back small"><span>복원</span></a></td>
                        </tr>
                        <c:set var="sNumber" value="${sNumber-1}"/>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <p class="info_text">복원을 진행할 경우 현재 FTL파일은 백업본으로 DB에저장되며 선택한 버전을 FTL파일에 덮어씁니다.</p>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>