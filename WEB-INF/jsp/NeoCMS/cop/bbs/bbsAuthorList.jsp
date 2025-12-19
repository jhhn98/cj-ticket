<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 권한 목록</title>
<link rel="stylesheet" href="./css/neo.css" />
<link rel="stylesheet" href="./css/subheader.css" />
<script nonce="NEOCMSSCRIPT">
	function fn_changeSite( val ) {
		window.location = "./selectBbsList.do?siteId=" + val;
	}
</script>
</head>
<body>

<h1 class="subHeader">게시판 권한 목록</h1>

<div class="clearfix topMargin">
	<div class="floatLeft">
	</div>
	<div class="floatRight">

<form:form modelAttribute="bbsAuthorSearchVO" name="bbsAuthorSearchVOForm" method="get">

	<form:hidden path="searchCnd" value="ALL" />

	<form:select path="pageUnit">
		<form:option value="10">10 페이지</form:option>
		<form:option value="20">20 페이지</form:option>
		<form:option value="30">30 페이지</form:option>
		<form:option value="40">40 페이지</form:option>
		<form:option value="50">50 페이지</form:option>
	</form:select>

    <form:select path="searchSiteId">
        <form:option value="">사이트 전체</form:option>
        <c:forEach var="siteInfo" items="${siteInfoList}">
            <form:option value="${siteInfo.siteId}">${siteInfo.siteNm}</form:option>
        </c:forEach>
    </form:select>
    
    <form:select path="searchSkinId">
        <form:option value="">스킨 전체</form:option>
        <c:forEach var="bbsSkin" items="${bbsSkinList}">
            <form:option value="${bbsSkin.skinId}">${bbsSkin.skinNm}</form:option>
        </c:forEach>
    </form:select>

	<form:input path="searchKrwd" cssClass="txt" placeholder="게시판명 입력"/>

	<span class="button black"><input type="submit" value="검색" /></span>

</form:form>		
	</div>
</div>

<table class="table_t1 topMargin" width="100%"> 
	<tr>
		<th>번호</th>
		<th>사이트명</th>
		<th>스킨명</th>
		<th>게시판명</th>
		<th>읽기그룹</th>
		<th>글쓰기그룹</th>
		<th>답변(계층)그룹</th>
		<th>답변(보기형)그룹</th>
		<th>댓글그룹</th>
		<th>글쓰기</th>
		<th>관리자</th>
	</tr>
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${bbsAuthorList}" varStatus="status">
	<tr>
		<td align="center">${currentPageStartNo}</td>
		<td align="center"><c:out value="${result.siteNm}"/></td>
		<td align="center"><c:out value="${result.skinNm}"/></td>
		<td><c:out value="${result.bbsNm}"/></td>
		<td align="center">
		<c:set var="arrRedngAuthor" value="${fn:split(result.redngAuthor,',')}"/>
        <c:forEach var="redngAuthor" items="${arrRedngAuthor}" varStatus="idx">
            ${authorMap[redngAuthor].codeNm}<c:if test="${!idx.last}">,</c:if>
        </c:forEach>
		</td>
		<td align="center">
        <c:set var="arrRritngAuthor" value="${fn:split(result.writngAuthor,',')}"/>
        <c:forEach var="writngAuthor" items="${arrRritngAuthor}" varStatus="idx">
            ${authorMap[writngAuthor].codeNm}<c:if test="${!idx.last}">,</c:if>
        </c:forEach>
		</td>
        <td align="center">
        <c:set var="arrReplyAuthor" value="${fn:split(result.replyAuthor,',')}"/>
        <c:forEach var="replyAuthor" items="${arrReplyAuthor}" varStatus="idx">
            ${authorMap[replyAuthor].codeNm}<c:if test="${!idx.last}">,</c:if>
        </c:forEach>
        </td>
        <td align="center">
        <c:set var="arrAnswerAuthor" value="${fn:split(result.answerAuthor,',')}"/>
        <c:forEach var="answerAuthor" items="${arrAnswerAuthor}" varStatus="idx">
            ${authorMap[answerAuthor].codeNm}<c:if test="${!idx.last}">,</c:if>
        </c:forEach>
        </td>
        <td align="center">
        <c:set var="arrCommentAuthor" value="${fn:split(result.commentAuthor,',')}"/>
        <c:forEach var="commentAuthor" items="${arrCommentAuthor}" varStatus="idx">
            ${authorMap[commentAuthor].codeNm}<c:if test="${!idx.last}">,</c:if>
        </c:forEach>
        </td>
		<td align="center">
	<c:choose>
    <c:when test="${result.writeCnt > 1}">
            ${result.writeUserId}(${result.writeUserNm}) 외 ${result.writeCnt-1}명
    </c:when>
    <c:when test="${result.writeCnt eq 1}">
            ${result.writeUserId}(${result.writeUserNm})
    </c:when>
    </c:choose>
		</td>
        <td align="center">
    <c:choose>
    <c:when test="${result.mngrCnt > 1}">
            ${result.mngrUserId}(${result.mngrUserNm}) 외 ${result.mngrCnt-1}명
    </c:when>
    <c:when test="${result.mngrCnt eq 1}">
            ${result.mngrUserId}(${result.mngrUserNm})
    </c:when>
    </c:choose>
        </td>
	</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(bbsAuthorList) == 0}">
	<tr>
		<td colspan="11" align="center">등록된 게시판이 없습니다.</td>
	</tr>
	</c:if>
</table>

<div class="clearfix topMargin">
	<div class="floatLeft">
		<ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="./selectBbsAuthorMngrList.do?${tsu:xssLinkFilter(bbsAuthorSearchVO.paramsExclPi)}&amp;pageIndex=" />
	</div>
	<div class="floatRight">
		<a href="./downloadBbsAuthorMngrXls.do" class="button green"><span>전체 엑셀 다운로드</span></a>
	</div>
</div>

</body>
</html>