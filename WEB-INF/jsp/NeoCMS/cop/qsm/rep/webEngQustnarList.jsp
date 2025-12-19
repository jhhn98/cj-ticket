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
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
<div id="board">
	<div class="board_srch">
		<div>
			<form:form modelAttribute="searchVO" name="searchForm" method="get">
				<input type="hidden" name="key" value="${key}" />
				<fieldset>
				<legend>survey</legend>
				<label for="searchCnd" class="skip">Title</label>
				<form:select path="searchCnd" title="Title">
				   <form:option value="">Title</form:option>
				</form:select>
				<label for="searchKrwd" class="skip">enter search words</label>
				<form:input path="searchKrwd" class="txt" />
				<span class="btn_srch"><input type="submit" value="SEARCH" /></span>
				</fieldset>
			</form:form>
		</div>
	</div>
	<div class="board_top clearfix">
        <div class="total">
            <span>a total of :&nbsp;<em>${paginationInfo.totalRecordCount}</em></span>&nbsp;|
            <span>Currently page on :&nbsp;<em>${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount}</span>
        </div>
    </div>
    <!-- //board_top -->
	<div class="tableA">
		<table class="bbs_default_list" border="0" summary="survey posts and ,Title, Period, Explanation providing information of etc">
			<caption>survey</caption>
			<colgroup>
			<col width="10%" />
			<col width="" />
			<col width="10%" />
			<col width="15%" />
			</colgroup>
			<thead class="th list">
				<tr>
					<th scope="col">No</th>
					<th scope="col">Title</th>
					<th scope="col">State</th>
					<th scope="col">Result</th>
				</tr>
			</thead>
			<tbody class="tb">
				<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr <c:if test="@@{currentPageStartNo%2 eq 0}">class="odd"</c:if><c:if test="@@{currentPageStartNo%2 ne 0}">class="even"</c:if>>
						<td data-cell-header="No : ">${currentPageStartNo}</td>  
						<td data-cell-header="Title : " class="subject">${result.qestnarSj}</td>	
						<td data-cell-header="State : ">
							<c:if test="${codeMapQest3[result.sttus] eq '대기'}">
								stand by
							</c:if>
							<c:if test="${codeMapQest3[result.sttus] eq '진행'}">
								progress
							</c:if>
							<c:if test="${codeMapQest3[result.sttus] eq '종료'}">
								end
							</c:if>
						</td>	
						<td data-cell-header="Result : ">
							<c:if test="${result.sttus eq 'QESST03'}">
							<a href="./selectQestnarResult.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;pageUnit=${searchVO.pageUnit}&amp;pageIndex=${searchVO.pageIndex}&amp;searchCnd=${searchVO.searchCnd}<%//${searchVO.params}%>" class="btnE">Result</a> 
							</c:if>
							<c:if test="${result.sttus eq 'QESST02'}">
							<a href="./addQestnarRspnsView.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;pageUnit=${searchVO.pageUnit}&amp;pageIndex=${searchVO.pageIndex}&amp;searchCnd=${searchVO.searchCnd}" class="btnC">participation</a> 
							</c:if>
						</td>
					</tr>
				<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="4" align="center">no registered survey.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<div class="paging_bar">
		<ui:pagination paginationInfo = "${paginationInfo}" type="web" jsFunction="./selectQestnarList.do?key=${key}&amp;${searchVO.paramsExclPi}&amp;pageIndex=" />     
	</div>
</div>

</body>
</html>