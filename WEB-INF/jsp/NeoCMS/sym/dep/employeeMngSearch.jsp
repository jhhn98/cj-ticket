<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%--
neo 관리자페이지에서 담당자 설정이 필요한 페이지들에서 불려지는 UI. 실제 기능은 이 페이지를 호출하는 페이지들에 정의되어있음.
 -- //allMenuAuthList.jsp
--%>
<div class="arrangementWrap marginBottom_5 data_info">
    <div class="arrLeft">
        <span class="table_text">조회된 직원 수 : ${paginationInfo.totalRecordCount}건</span>
    </div>
    <div class="arrRight">
        <div class="table_search">
            <form:form modelAttribute="employee" name="employee" method="get" onsubmit="return fn_ajax_search_submit(this.id);return false;">
                <input type="hidden" name="pageUnit" value="15" />
                <input type="hidden" name="searchCnd" value="all" />
                <span class="srch_element text"><form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력(성명)"/></span>
                <span class="srch_element submit"><button type="submit" class="search_button">검색</button></span>
            </form:form>
        </div>
    </div>
</div>
<table data-list="employeeList">
    <colgroup>
        <col/>
        <col/>
        <col class="specWidth80px"/>
        <col class="specWidth150px"/>
        <col class="specWidth80px"/>
    </colgroup>
    <thead>
    <tr>
        <%--<th scope="col">직원코드</th>--%>
        <th scope="col">부서</th>
        <th scope="col">성명</th>
        <th scope="col">직책</th>
        <th scope="col">아이디</th>
        <%--<th scope="col">연락처</th>--%>
        <th scope="col">선택</th>
    </tr>
    </thead>
    <tbody class="textACenter">
    <c:forEach var="result" items="${employeeList}" varStatus="status">
        <tr>
                <%--<td class="textACenter" class="em_red"><c:out value="${result.emplCode}"/></td>--%>
            <td><c:out value="${result.deptNm}"/></td>
            <td><c:out value="${result.emplNm}"/></td>
            <td><c:out value="${result.rspofc}"/></td>
            <td><c:out value="${result.userId}"/><c:if test="${not empty result.userNm}">(<c:out value="${result.userNm}"/>)</c:if></td>
        <%--<td class="textACenter"><c:out value="${result.emplTelno}"/></td>--%>
            <td><button type="button" onclick="selectEmployee(this);return false; " data-emplcode="<c:out value="${result.emplCode}"/>" data-deptcode="<c:out value="${result.deptCode}"/>" data-emplnm="<c:out value="${result.emplNm}"/>" data-empltelno="<c:out value="${result.emplTelno}"/>" data-deptnm="<c:out value="${result.deptNm}"/>" data-userid="<c:out value="${result.userId}"/>" data-usernm="<c:out value="${result.userNm}"/>" class="iconButton check"><span>선택</span></button></td>
        </tr>
    </c:forEach>
    <c:if test="${empty employeeList}">
        <tr>
            <td colspan="5" class="textACenter">소속 직원이 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
</table>
<div class="textACenter marginTop_15 pagingWrap">
    <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="neoTreePop" jsFunction="/neo/searchMngEmployeeList.do?pageUnit=${tsu:xssLinkFilter(employee.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(employee.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(employee.searchKrwd)}&amp;pageIndex=" />
</div>
<button type="button" onclick="closeEmployeeView()" class="layerCloseBtn">닫기</button>