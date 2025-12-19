<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_8" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - ProgramManage</title>
<meta name="decorator" content="neo" />
</head>
<body>


<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건(<c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>)</span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="cmmLogVO" name="searchForm" method="post" action="selectCmmLogList.do">
					<span class="srch_element select">
                        <form:select path="pageUnit">
							<form:option value="10">10 페이지</form:option>
							<form:option value="20">20 페이지</form:option>
							<form:option value="30">30 페이지</form:option>
							<form:option value="40">40 페이지</form:option>
							<form:option value="50">50 페이지</form:option>
						</form:select>
                    </span>
					<span class="srch_element select">
						<form:select path="logSe">
							<form:option value="">-- 로그구분 --</form:option>
							<form:option value="LOGIN">로그인</form:option>
							<form:option value="MBER">회원</form:option>
							<form:option value="BBS">게시판</form:option>
							<form:option value="PROGRM">프로그램</form:option>
							<form:option value="CNTNTS">콘텐츠</form:option>
						</form:select>
                    </span>

					<span class="srch_element select">
						<form:select path="logAction">
							<form:option value="">-- 작업구분 --</form:option>
							<form:option value="SUCCES">로그인</form:option>
							<form:option value="FAILR">로그인실패</form:option>
							<form:option value="LOGOUT">로그아웃</form:option>
							<form:option value="INSERT">등록</form:option>
							<form:option value="UPDATE">수정</form:option>
							<form:option value="DELETE">삭제</form:option>
						</form:select>
                    </span>
					<span class="srch_element text">
                        <form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력"/>
                    </span>
					<span class="srch_element submit">
                        <button type="submit" class="search_button">검색</button>
                    </span>
				</form:form>
			</div>
		</div>
	</div>
	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">

				<table>
					<colgroup>
						<col class="specWidth50px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
						<col class="specWidth80px"/>
						<col class="specWidth70px"/>
						<col/>
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col class="specWidth85px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">로그구분</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">작업구분</th>
						<th scope="col">내용</th>
						<th scope="col">이전URL</th>
						<th scope="col">IP</th>
						<th scope="col">등록일</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${cmmLogList}" varStatus="status">
						<fmt:parseDate value="${tsu:xssLinkFilter(result.frstRegisterPnttm)}" var="frstRegisterPnttm" pattern="yyyyMMddHHmmss"/>
						<tr data-display="true">
							<td class="textACenter" ><c:out value="${currentPageStartNo}" /></td>
							<td class="textACenter" >
								<c:choose>
									<c:when test="${result.logSe eq 'LOGIN'}">로그인</c:when>
									<c:when test="${result.logSe eq 'MBER'}">회원정보</c:when>
									<c:when test="${result.logSe eq 'BBS'}">게시판</c:when>
									<c:when test="${result.logSe eq 'PROGRM'}">프로그램</c:when>
									<c:when test="${result.logSe eq 'CNTNTS'}">콘텐츠</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose>
							</td>
							<td class="textACenter" ><c:out value="${result.userId}" /></td>
							<td class="textACenter" ><c:out value="${result.userNm}" /></td>
							<td class="textACenter" ><c:out value="${result.logAction}" /></td>
							<td><c:out value="${result.logCn}" /></td>
                            <td><span class="eng_text"><c:out value="${result.logReferer}"/></span></td>
							<td class="textACenter" ><c:out value="${result.logIp}" /></td>
							<td class="textACenter" ><c:out value="${result.frstRegisterPnttmYMDHMS}" /></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(cmmLogList) == 0}">
						<tr>
							<td colspan="9" class="textACenter">검색된 정보가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectCmmLogList.do?pageUnit=${tsu:xssLinkFilter(cmmLogVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(cmmLogVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(cmmLogVO.searchKrwd)}&amp;logSe=${tsu:xssLinkFilter(cmmLogVO.logSe)}&amp;logAction=${tsu:xssLinkFilter(cmmLogVO.logAction)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
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

