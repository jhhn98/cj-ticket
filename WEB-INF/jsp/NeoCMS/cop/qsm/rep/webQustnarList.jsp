<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${menuInfo.cntntsNm} 목록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
<div class="p-wrap bbs">
	<div class="">
		<form:form modelAttribute="searchVO" name="searchForm" method="get">
			<fieldset>
				<legend>게시물 검색</legend>
				<input type="hidden" name="key" value="${param.key }" />
				<div class="card card--bgcolor p-search">
					<div class="p-form-group">
						<form:select path="searchCnd" title="검색영역선택" class="p-input" >
							<form:option value="">설문조사명</form:option>
						</form:select>
						<span class="p-form__split"></span>
						<form:input path="searchKrwd" class="p-input p-input--beside" title="검색단어 입력" placeholder="검색단어 입력"/>
						<span class="p-form-group__button">
							<button type="submit" class="p-button black">검색</button>
						</span>
					</div>
				</div>
			</fieldset>
		</form:form>
	</div>
	<table class="p-table simple" data-table="rwd" data-tabletype="simple" data-breakpoint="760">
		<caption>설문조사의 번호별 제목, 상태, 결과보기의 정보를 제공합니다.</caption>
		<colgroup>
			<col style="width:10%" />
			<col />
			<col style="width:10%" />
			<col style="width:15%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">설문명</th>
				<th scope="col">상태</th>
				<th scope="col">결과</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr <c:if test="@@{currentPageStartNo%2 eq 0}">class="odd"</c:if><c:if test="@@{currentPageStartNo%2 ne 0}">class="even"</c:if>>
					<td data-cell-header="번호 : ">${currentPageStartNo}</td>  
					<td data-cell-header="설문명 : " class="subject">${result.qestnarSj}</td>	
					<td data-cell-header="상태 : ">${codeMapQest3[result.sttus]}</td>	
					<td data-cell-header="결과 : ">
						<c:if test="${result.sttus eq 'QESST03'}">
						<a href="./selectQestnarResult.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;pageUnit=${searchVO.pageUnit}&amp;pageIndex=${searchVO.pageIndex}&amp;searchCnd=${searchVO.searchCnd}<%//${searchVO.params}%>" class="btn type3 small">결과보기</a>
						</c:if>
						<c:if test="${result.sttus eq 'QESST02'}">
						<a href="./addQestnarRspnsView.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;pageUnit=${searchVO.pageUnit}&amp;pageIndex=${searchVO.pageIndex}&amp;searchCnd=${searchVO.searchCnd}" class="btn small">참여하기</a>
						</c:if>
					</td>
				</tr>
			<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="4" class="empty">등록된 게시물이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="p-pagination">
		<ui:pagination paginationInfo = "${paginationInfo}" type="web" jsFunction="./selectQestnarList.do?key=${key}&amp;${searchVO.paramsExclPi}&amp;pageIndex=" />
	</div>
</div>

</body>
</html>