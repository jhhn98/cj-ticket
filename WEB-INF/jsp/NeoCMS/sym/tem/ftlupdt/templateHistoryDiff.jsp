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
<%--<script nonce="NEOCMSSCRIPT">
    $(window).resize(sizeContent);
    function sizeContent() {
        var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#fileInfo").height() - 60) + "px";
        $("#contentsCn").css("height", newHeight);
    }
    $(document).ready(sizeContent);
</script>--%>
</head>
<body>
    <div class="page_location">
        <span class="depth1_title icon_template">템플릿설정</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth2_title"><c:out value="${template.tmplatNm}"/>(<span class="em_red"><c:out value="${template.tmplatId}"/></span>)</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth3_title">템플릿 버전별 비교</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth4_title"><c:out value="${item.tmplatIemNm}"/>(<span class="em_red">/template/<c:out value="${item.tmplatId}"/>/<c:out value="${item.tmplatIemSe}"/>/<c:out value="${item.tmplatIemFileNm}"/>.ftl</span>)</span>
    </div>
    <div class="tab_navigation" id="subMenu">
        <a href="./updateTemplateEditorView.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>"><span>템플릿 수정</span></a>
        <a href="./selectTemplateHistoryList.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>"><span>템플릿 수정 이력</span></a>
        <a href="./selectTemplateHistoryDiff.do?templateId=<c:out value="${templateHistory.templateId}"/>&tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="current"><span>템플릿 버전별 비교</span></a>
    </div>
    <div class="tab_navigation_lank">
        <c:forEach var="result" items="${tempItems}" varStatus="status">
            <a href="./selectTemplateHistoryDiff.do?templateId=<c:out value="${item.tmplatId}"/>&tmplatIemNo=<c:out value="${result.tmplatIemNo}"/>" class="<c:out value="${result.tmplatIemNo eq item.tmplatIemNo  ? 'current ' : ''}" />"><span><c:out value=" ${result.tmplatIemSe}"/>/<c:out value="${result.tmplatIemFileNm}"/>.ftl</span></a>
        </c:forEach>
    </div>
    <div class="contents is_tab_multi templateHistoryDiff">
        <script src="/common/js/difflib.js"></script>
        <script src="/common/js/diffview.js"></script>
        <link rel=stylesheet type=text/css href="/common/css/diffview.css">
        <form method="post" id="diffForm" name="diffForm">
            <div class="form_wrap">
                <div class="sourceDiffTitle">
                    <label for="srcTempHistNo">비교 원본</label>
                    <select name="srcTempHistNo" id="srcTempHistNo" onchange="reloadVersionDiff()">
                        <option value="-1" ${templateHistory.srcTempHistNo >= 1?'':'selected=\'selected\''}>LIVE</option>
                        <c:forEach var="result" items="${templateHistoryList}" varStatus="status">
                            <option value="<c:out value="${result.tempHistNo}"/>"  <c:out value="${templateHistory.srcTempHistNo eq result.tempHistNo?'selected=\\\'selected\\\'':''}"/>><c:out value="${result.frstRegisterPnttmYMDHMS}"/></option>
                        </c:forEach>
                    </select>
                    <label for="dstTempHistNo">비교 대상</label>
                    <select name="dstTempHistNo" id="dstTempHistNo" onchange="reloadVersionDiff()">
                        <option value="-1"  ${templateHistory.dstTempHistNo == -1?'selected=\'selected\'':""}>LIVE</option>
                        <c:forEach var="result" items="${templateHistoryList}" varStatus="status">
                            <option value="<c:out value="${result.tempHistNo}"/>"  <c:out value="${templateHistory.dstTempHistNo eq result.tempHistNo?'selected=\\\'selected\\\'':''}"/>><c:out value="${result.frstRegisterPnttmYMDHMS}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="arrangementWrap historyDiffTextarea">
                    <div class="arrLeft"><textarea id="baseText" name="baseText" disabled="disabled"  class="baseText"><c:out value="${srcHistCn}"/></textarea></div>
                    <div class="arrRight"><textarea id="newText" name="newText" disabled="disabled"  class="newText"><c:out value="${dstHistCn}"/></textarea></div>
                </div>
                <div id="diffoutput" name="diffoutput" class="diffOutput"></div>
            </div>
        </form>
        <script nonce="NEOCMSSCRIPT">
            function reloadVersionDiff(){
                $("#diffForm").submit();
            }
            function diffUsingJS() {
                // get the baseText and newText values from the two textboxes, and split them into lines

                var bastText = $("#baseText").val();
                var newText = $("#newText").val();

                bastText = bastText.replace(/&lt;/g,"<");
                bastText = bastText.replace(/&gt;/g,">");
                newText = newText.replace(/&lt;/g,"<");
                newText = newText.replace(/&gt;/g,">");
                var base = difflib.stringAsLines(bastText);
                var newtxt = difflib.stringAsLines(newText);

                // create a SequenceMatcher instance that diffs the two sets of lines
                var sm = new difflib.SequenceMatcher(base, newtxt);

                // get the opcodes from the SequenceMatcher instance
                // opcodes is a list of 3-tuples describing what changes should be made to the base text
                // in order to yield the new text
                var opcodes = sm.get_opcodes();
                var diffoutputdiv = $("#diffoutput");

                // build the diff view and add it to the current DOM
                diffoutputdiv.html(diffview.buildView({
                    baseTextLines: base,
                    newTextLines: newtxt,
                    opcodes: opcodes,
                    // set the display titles for each resource
                    baseTextName: "원본 내용",
                    newTextName: "비교 대상",
                    contextSize: 9999,
                    viewType: 0
                }));

                // scroll down to the diff view window.
                location = url + "#diff";
            }
            $(document).ready(function(){
                diffUsingJS();
            });
        </script>
    </div>
</body>
</html>