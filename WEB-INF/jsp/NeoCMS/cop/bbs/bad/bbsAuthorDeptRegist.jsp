<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="arrangementWrap marginBottom_5 data_info">
	<div class="arrLeft">
		<span class="table_text">조회된 부서 수 : ${paginationInfo.totalRecordCount}건</span>
	</div>
	<div class="arrRight">
		<div class="table_search">
			<form:form modelAttribute="bbsAuthorDept" name="bbsAuthorDept" method="get" action="./addBbsAuthorDeptView.do" onsubmit="return fn_ajax_search_submit(this.id);return false;">
				<span class="srch_element text"><form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력(부서명)"/></span>
				<span class="srch_element submit"><button type="submit" class="search_button">검색</button></span>
			</form:form>
		</div>
	</div>
</div>


<table data-list="employeeList">
	<colgroup>
		<col class="specWidth80px"/>
		<col class="specWidth80px"/>
		<col/>
		<col class="specWidth80px"/>
	</colgroup>
	<thead>
	<tr>
		<th scope="col">번호</th>
		<th scope="col">부서코드</th>
		<th scope="col">부서명</th>
		<th scope="col">등록</th>
	</tr>
</thead>
	<tbody class="textACenter">
<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
<c:forEach var="result" items="${departmentList}" varStatus="status">
	<tr>
		<td align="right">${currentPageStartNo}</td>
		<td align="center"><c:out value="${result.deptCode}"/></td>
		<td><c:out value="${result.deptNm}"/></td>
		<td align="center"><button type="button" onclick="selectDepart(this);return false; " data-deptcode="<c:out value="${result.deptCode}"/>" data-deptnm="<c:out value="${result.deptNm}"/>"" class="iconButton check"><span>선택</span></button>
		</td>
	</tr>
	<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
</c:forEach>
<c:if test="${fn:length(departmentList) == 0}">
	<tr>
		<td colspan="4">검색된 부서정보가 없습니다.</td>
	</tr>
</c:if>
</tbody>
</table>

<div>
	<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="neoTreePop" jsFunction="./addBbsAuthorDeptView.do?siteId=${tsu:xssLinkFilter(bbsVO.siteId)}&amp;pageUnit=${tsu:xssLinkFilter(bbsAuthorDept.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bbsAuthorDept.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bbsAuthorDept.searchKrwd)}&amp;pageIndex=" />
</div>

<button type="button" onclick="closeEmployeeView()" class="layerCloseBtn">닫기</button>