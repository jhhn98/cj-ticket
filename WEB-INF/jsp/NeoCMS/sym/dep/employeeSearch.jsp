<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<script nonce="NEOCMSSCRIPT">

	function fn_deleteEmployee(url) {
		if( confirm("선택한 직원을 삭제하시겠습니까?") ) {
			moveTreeContents(url);
			return false;
			//window.location = url;

		}
		return false;
	}

</script>

<div class="dataWrap">

	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">조회된 직원 수 : ${paginationInfo.totalRecordCount} 명</span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="employee" name="employee" method="get" onsubmit="fn_ajax_search_submit(this.id);return false;">
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
				<form:select path="searchCnd">
					<form:option value="all">검색단어 전체</form:option>
					<form:option value="bannerZoneIemNm">게시판명</form:option>
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
	<div class="form_wrap">

		<table>
			<colgroup>
				<col class="specWidth80px">
				<col class="specWidth120px"/>
				<col class="specWidth120px"/>
				<col class="specWidth180px"/>
				<col/>
				<col class="specWidth80px"/>
				<col class="specWidth80px"/>
				<col class="specWidth80px"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">직원코드</th>
				<th scope="col">성명</th>
				<th scope="col">직책</th>
				<th scope="col">연락처</th>
				<th scope="col">업무</th>
				<th scope="col">상태</th>
				<th scope="col">수정</th>
				<th scope="col">삭제</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${employeeList}" varStatus="status">
				<tr>
					<td class="textACenter" class="em_red"><c:out value="${result.emplCode}"/></td>
					<td class="textACenter"><c:out value="${result.emplNm}"/></td>
					<td class="textACenter"><c:out value="${result.rspofc}"/></td>
					<td class="textACenter"><c:out value="${result.emplTelno}"/></td>
					<td><c:out value="${result.emplJob}"/></td>
					<td class="textACenter">
						<c:if test="${result.emplSttus eq 'NRMLT'}">
							<span class="em_black_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
						</c:if>
						<c:if test="${result.emplSttus eq 'REST'}">
							<span class="em_green_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
						</c:if>
						<c:if test="${result.emplSttus eq 'RETIRE'}">
							<span class="em_red_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
						</c:if>
					</td>
					<td class="textACenter"><a onclick="moveTreeContents(this.href);return false;"  href="./updateEmployeeView.do?deptCode=<c:out value="${result.deptCode}"/>&amp;emplCode=<c:out value="${result.emplCode}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
					<td class="textACenter"><a href="./deleteSearchEmployee.do?deptCode=<c:out value="${result.deptCode}"/>&amp;emplCode=<c:out value="${result.emplCode}"/>&amp;pageUnit=<c:out value="${employee.pageUnit}" />&amp;searchCnd=<c:out value="${employee.searchCnd}" />&amp;searchKrwd=<c:out value="${employee.searchKrwd}" />&amp;pageIndex=<c:out value="${employee.pageIndex}" />" onclick="fn_deleteEmployee(this.href); return false;"  class="iconTextButton delete small"><span>삭제</span></a></td>
				</tr>
			</c:forEach>
			<c:if test="${empty employeeList}">
				<tr>
					<td colspan="8" class="textACenter">소속 직원이 없습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="neoAjax" jsFunction="./searchEmployeeList.do?pageUnit=${tsu:xssLinkFilter(employee.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(employee.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(employee.searchKrwd)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
		</div>
	</div>
</div>