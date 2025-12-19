<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>게시판 정보 수정</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
<c:if test="${!empty message}">
 	function fn_check_message() {
 		alert("<c:out value='${message}'/>");
    <c:if test="${!empty fieldName}">
	    $("#<c:out value="${fieldName}"/>").focus();
    </c:if>
 	}
$(window).on("load", function() {
		fn_check_message();
	});
</c:if>
	function fn_validateBbsInfoVO( frm ) {
		return true;
	}
</script>
 </head>
<body>

<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 권한관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">관리자 등록</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class="current"><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class=""><span>첨부파일필드 관리</span></a>
	<a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="contents">
	<script src="/neo/js/calendar.js"></script>


	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 명</span>
		</div>
		<div class="arrRight">
            <div class="table_search">
				<form:form modelAttribute="bbsMngr" name="bbsMngr" method="get" action="./addBbsMngrView.do">
					<form:hidden path="bbsNo"/>
					<span class="srch_element text">
						<form:input path="searchKrwd" cssClass="txt" placeholder="아이디/이름으로 검색" title="검색어 입력"/>
					</span>
					<span class="srch_element submit">
						<button type="submit" class="search_button">검색</button>
					</span>
				</form:form>
			</div>
		</div>
	</div>

	<table>
	<colgroup>
		<col class="specWidth80px"/>
		<col class="specWidth150px"/>
		<col/>
		<col class="specWidth100px"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">이름</th>
			<th scope="col">등록</th>
		</tr>
	</thead>
	<tbody>
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${userInfoList}" varStatus="status">
		<tr>
			<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
			<td class="textACenter"><c:out value="${result.userId}"/></td>
			<td><c:out value="${result.userNm}"/></td>
			<td class="textACenter"><a href="./addBbsMngr.do?bbsNo=<c:out value="${bbsVO.bbsNo}"/>&userId=<c:out value="${result.userId}"/>" class="iconTextButton small write"><span>등록</span></a></td>
		</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(userInfoList) == 0}">
		<tr>
			<td colspan="4">검색된 회원정보가 없습니다.</td>
		</tr>
	</c:if>
	</tbody>
	</table>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./addBbsMngrView.do?siteId=${tsu:xssLinkFilter(bbsVO.siteId)}&amp;bbsNo=${tsu:xssLinkFilter(bbsVO.bbsNo)}&amp;pageUnit=${tsu:xssLinkFilter(bbsMngr.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bbsMngr.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bbsMngr.searchKrwd)}&amp;pageIndex=" />
        </div>
        <div class="arrRight">
            <a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>" class="iconTextButton list"><span>권한 목록</span></a>
        </div>
    </div>
</div>
</body>
</html>