<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_9" scope="request"/>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>에러로그조회</title>
    <meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_log">접속로그</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title">에러로그 상세보기</span>
</div>
<div class="contents not_etc">
    <div class="scroll_view not_etc">
        <table>
            <caption>에러로그</caption>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <thead>
            <tr>
                <th scope="col">항목</th>
                <th scope="col">내용</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">일련번호</th>
                <td>${errorHist.errorHistNo}</td>
            </tr>
            <tr>
                <th scope="row">발생시점</th>
                <td>${errorHist.occrrncPnttmYMDHM}</td>
            </tr>
            <tr>
                <th scope="row">패키지이름</th>
                <td>${fn:replace(errorHist.pckageNm, newLineChar, "<br/>")}</td>
            </tr>
            <tr>
                <th scope="row">메소드명</th>
                <td>${fn:replace(errorHist.methodNm, newLineChar, "<br/>")}</td>
            </tr>
            <tr>
                <th scope="row">에러메시지</th>
                <td>${fn:replace(errorHist.mssage, newLineChar, "<br/>")}</td>
            </tr>
            <tr>
                <th scope="row">에러사유</th>
                <td>${fn:replace(errorHist.causePckageNm, newLineChar, "<br/>")}</td>
            </tr>
            <tr>
                <th scope="row">발생메시지</th>
                <td>${fn:replace(errorHist.causeMssage, newLineChar, "<br/>")}</td>
            </tr>

            <tr>
                <td colspan="2" class="textACenter"><a href="/neo/selectErrorHist.do?pageUnit=${errorHistVO.pageUnit}&searchCnd=${errorHistVO.searchCnd}&searchKrwd=${errorHistVO.searchKrwd}&pageIndex=${errorHistVO.pageIndex}" class="textButton small search"><span>목록</span></a></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>