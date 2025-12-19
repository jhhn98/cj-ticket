<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>게시판 카테고리 목록</title>
	<meta name="decorator" content="neo" />
	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="bbsCategory" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="bbsCategory">
		<script nonce="NEOCMSSCRIPT">
			<c:forEach items="${errors.allErrors}" var="error" varStatus="status">
			<c:if test="${status.first}">
			<c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
			alert("<c:out value="${errMsg}"/>");
			</c:if>
			</c:forEach>
		</script>
	</spring:hasBindErrors>
	<c:if test="${!empty message}">
		<script nonce="NEOCMSSCRIPT">
			function fn_check_message() {
				alert("<c:out value='${message}'/>");
				<c:if test="${!empty fieldName}">
				$("#<c:out value="${fieldName}"/>").focus();
				</c:if>
			}
			$(window).on("load", function() {
				fn_check_message();
			});
		</script>
	</c:if>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 카테고리 관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class="current"><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class=""><span>첨부파일필드 관리</span></a>
	<a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="contents is_tab">
    <div class="arrangementWrap marginBottom_5">
        <div class="arrLeft"></div>
        <div class="arrRight">
            <div class="table_search">
                <form:form modelAttribute="bbsCategory" name="bbsCategoryForm" action="addBbsCategory.do" onsubmit="return validateBbsCategory(this)">
                    <form:hidden path="bbsNo"/>
					<input type="hidden" name="pageUnit" value="<c:out value="${bbsCategory.pageUnit}"/>"/>
					<input type="hidden" name="searchCnd" value="<c:out value="${bbsCategory.searchCnd}"/>"/>
					<input type="hidden" name="searchKrwd" value="<c:out value="${bbsCategory.searchKrwd}"/>"/>
					<input type="hidden" name="pageIndex" value="<c:out value="${bbsCategory.pageIndex}"/>"/>
                    <span class="srch_element text">
                        <form:input path="ctgryNm" placeholder="카테고리명 입력하여 등록" cssClass="specWidth150px"/>
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="iconTextButton write"><span>추가</span></button>
                    </span>
                </form:form>
            </div>
        </div>
    </div>
	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col/>
						<col class="specWidth80px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">카테고리명</th>
                            <th scope="col">등록일</th>
                            <th scope="col">수정</th>
                            <th scope="col">삭제</th>
                        </tr>
					</thead>
					<tbody>
					<c:set var="sNumber" value="1" />
					<c:forEach var="result" items="${bbsCategoryList}" varStatus="status">
						<tr>
							<td class="textARight"><c:out value="${sNumber}"/></td>
							<td><c:out value="${result.ctgryNm}"/></td>
							<td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
							<td class="textACenter"><a href="./updateBbsCategoryView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;bbsCtgryNo=<c:out value="${result.bbsCtgryNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td class="textACenter"><a href="./deleteBbsCategory.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;bbsCtgryNo=<c:out value="${result.bbsCtgryNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="sNumber" value="${sNumber+1}" />
					</c:forEach>
					<c:if test="${fn:length(bbsCategoryList) == 0}">
						<tr>
							<td colspan="5" class="textACenter">등록된 카테고리가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<div class="arrangementWrap data_button">
		<div class="arrLeft"></div>
		<div class="arrRight">
			<a href="./updateBbsCategorySortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategory.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategory.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategory.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategory.pageIndex}"/>" class="iconTextButton write"><span>순서변경</span></a>
		</div>
	</div>
</div>
<style>
	.table_search .srch_element.submit button:before{content: '\f067'}
</style>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>