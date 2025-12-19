<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="PRG_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - ProgramManage</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">

    function fn_checkAuthorCode( code, url ) {

        if(code==""){
            alert("프로그램 권한코드를 설정해주세요.");
            return;
        }else{
            window.location = url;
        }
    }

</script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_program">컴포넌트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">컴포넌트 목록</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
			<span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="programVO" name="searchForm" method="get">
					<span class="srch_element select">
						<form:select path="pageUnit" class="select">
							<form:option value="10">10 페이지</form:option>
							<form:option value="20">20 페이지</form:option>
							<form:option value="30">30 페이지</form:option>
							<form:option value="40">40 페이지</form:option>
							<form:option value="50">50 페이지</form:option>
						</form:select>
					</span>

					<span class="srch_element select">
						<form:select path="searchCnd" class="select">
							<form:option value="all">전체</form:option>
							<form:option value="progrmNm">프로그래명</form:option>
							<form:option value="progrmUrl">프로그램URL</form:option>
						</form:select>
					</span>
					<span class="srch_element text">
						<form:input path="searchKrwd" cssClass="txt" style="width:auto;"/>
					</span>

					<span class="srch_element submit">
						<button type="submit" class="search_button">검색</button>
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
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col/>
						<col class="specWidth100px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">프로그램명</th>
						<th scope="col">관리기능유무</th>
						<th scope="col">프로그램설명</th>
						<th scope="col">권한설정</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
							<td><a href="./selectProgramView.do?progrmNo=<c:out value="${result.progrmNo}"/>&amp;pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.progrmNm}"/></a></td>
							<td class="textACenter"><c:out value="${manageFnctEnncMap[result.manageFnctEnnc]}"/></td>
							<td><c:out value="${result.progrmDc}"/></td>
							<td class="textACenter"><a href="./selectProgrmAuthorList.do?progrmNo=<c:out value="${result.progrmNo}"/>" onclick="fn_checkAuthorCode('<c:out value="${result.progrmNo}"/>',this.href); return false;"  class="iconTextButton small auth_set"><span>권한설정</span></a></td>
							<td class="textACenter"><a href="./updateProgramView.do?progrmNo=<c:out value="${result.progrmNo}"/>&amp;pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td class="textACenter"><a href="./deleteProgram.do?progrmNo=<c:out value="${result.progrmNo}"/>&amp;pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="7" class="textACenter">검색된 프로그램이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectProgramList.do?pageUnit=${tsu:xssLinkFilter(programVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(programVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(programVO.searchKrwd)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
			<a href="./addProgramView.do?pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>" class="iconTextButton write"><span>등록</span></a>
		</div>
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
