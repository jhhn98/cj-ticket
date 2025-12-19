<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<jsp:include page="../mnu/subMenu.jsp" />
<div class="contents is_tab_multi templateHistoryDiff">
    <script src="/common/js/difflib.js"></script>
    <script src="/common/js/diffview.js"></script>
    <link rel=stylesheet type=text/css href="/common/css/diffview.css">
    <form method="post" id="diffForm" name="diffForm" action="./selectContentsHistoryDiff.do">
        <input type="hidden" name="siteId" value="<c:out value="${param.siteId}" />" />
        <input type="hidden" name="menuNo" value="<c:out value="${param.menuNo}" />" />
        <div class="form_wrap">
            <div class="sourceDiffTitle">
                <label for="srcHistNo">비교 원본</label>
                <select name="srcHistNo" id="srcHistNo" onchange="reloadVersionDiff()">
                    <option value="-1" <c:out value="${contentsHistory.srcHistNo >= 1?'':'selected=true'}"/>>LIVE</option>
                    <c:forEach var="result" items="${contentsHistoryList}" varStatus="status">
                        <option value="<c:out value="${result.cntntsHistNo}"/>"  <c:out value="${contentsHistory.srcHistNo eq result.cntntsHistNo?'selected=\\\'selected\\\'':''}"/>><c:out value="${result.frstRegisterPnttmYMDHMS}"/></option>
                    </c:forEach>
                </select>
                <label for="dstHistNo">비교 대상</label>
                <select name="dstHistNo" id="dstHistNo" onchange="reloadVersionDiff()">
                    <option value="-1"  <c:out value="${contentsHistory.dstHistNo == -1?'selected=true':''}"/>>LIVE</option>
                    <c:forEach var="result" items="${contentsHistoryList}" varStatus="status">
                        <option value="<c:out value="${result.cntntsHistNo}"/>"  <c:out value="${contentsHistory.dstHistNo eq result.cntntsHistNo?'selected=\\\'selected\\\'':''}"/>><c:out value="${result.frstRegisterPnttmYMDHMS}"/></option>
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
</div>
<script nonce="NEOCMSSCRIPT">
    function reloadVersionDiff(){
        fn_ajax_submit("diffForm");
        //$("#diffForm").submit();
    }
    function diffUsingJS() {
        // get the baseText and newText values from the two textboxes, and split them into lines
        var base = difflib.stringAsLines($("#baseText").val());
        var newtxt = difflib.stringAsLines($("#newText").val());

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
        //location = url + "#diff";
    }
    $(document).ready(function(){
        diffUsingJS();
    });
</script>