<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- <h1 class="subHeader"><img src="./images/tree_mode.gif" width="16px" height="16px"/> <c:out value="${department.deptNm}"/>(<span class="em_red"><c:out value="${department.deptCode}"/></span>)</h1> --%>
<jsp:include page="./subMenu.jsp" />
<div class="dataWrap">
    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text">소속직원 수 : <c:out value="${fn:length(employeeList)}"/> 명</span>
        </div>
        <div class="arrRight">
            <a href="./sortEmployeeView.do?deptCode=<c:out value="${department.deptCode}"/>" onclick="moveTreeContents(this.href);return false;"  class="iconTextButton order_edit"><span>직원순서변경</span></a>
            <a href="./addEmployeeView.do?deptCode=<c:out value="${department.deptCode}"/>" onclick="moveTreeContents(this.href);return false;"  class="iconTextButton marginLeft_5 add_user"><span>직원 등록</span></a>
        </div>
    </div>
    <div class="form_wrap">
        <table>
            <colgroup>
                <col class="specWidth150px">
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
                    <td class="textACenter">
                        <c:if test="${not empty result.userId}"> <a href="/neo/updateUserInfoView.do?userId=<c:out value="${result.userId}"/>" class="iconTextButton user_code"></c:if>
                        <c:out value="${result.emplNm}"/>
                        <c:if test="${not empty result.userId}"></a></c:if>
                    </td>
                    <td class="textACenter"><c:out value="${result.rspofc}"/></td>
                    <td class="textACenter"><c:out value="${result.emplTelno}"/></td>
                    <td><c:out value="${result.emplJob}"/></td>
                    <td class="textACenter">
                        <c:choose>
                            <c:when test="${result.emplSttus eq 'NRMLT'}">
                                <span class="em_black_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
                            </c:when>
                            <c:when test="${result.emplSttus eq 'REST'}">
                                <span class="em_green_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
                            </c:when>
                            <c:when test="${result.emplSttus eq 'RETIRE'}">
                                <span class="em_red_bold"><c:out value="${emplSttusMap[result.emplSttus]}"/></span>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${emplSttusMap[result.emplSttus]}"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="textACenter"><a onclick="moveTreeContents(this.href);return false;"  href="./updateEmployeeView.do?deptCode=<c:out value="${department.deptCode}"/>&amp;emplCode=<c:out value="${result.emplCode}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
                    <td class="textACenter"><a href="./deleteEmployee.do?deptCode=<c:out value="${department.deptCode}"/>&amp;emplCode=<c:out value="${result.emplCode}"/>" onclick="fn_deleteEmployee(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
                </tr>
            </c:forEach>
            <c:if test="${empty employeeList}">
                <tr>
                    <td colspan="8" class="textACenter">소속 직원이 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>



        <c:if test="${fn:length(menuList) > 0}">
            <br /><br />
            <p class="info_text topMargin">권한이 부여된 메뉴 목록</p>
            <table>
                <colgroup>
                    <col class="specWidth120px"/>
                    <col/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">메뉴위치</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${menuList}" var="result" varStatus="status">
                    <tr>
                        <td class="textACenter"><c:out value="${status.index + 1}"/></td>
                        <td ><c:out value="${fn:replace(result.menuCours,'&gt;',' > ')}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>
<script nonce="NEOCMSSCRIPT">

    function fn_deleteEmployee(url) {
        if( confirm("선택한 직원을 삭제하시겠습니까?") ) {
            //window.location = url;
            moveTreeContents(url);
            return false;
        }
    }

</script>