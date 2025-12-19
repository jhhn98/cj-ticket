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
<script nonce="NEOCMSSCRIPT">
    function fn_contentsSelect( menuNo,siteId) {
        $("#innerFile").val("/repository/" + siteId + "/contents/" + menuNo + ".html");
        $("#connectMenuNo").val(menuNo);
        closeSlideView();
    }
</script>
<%--
<div class="arrangementWrap data_info">
    <div class="arrLeft">
        <span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
            <span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
    </div>
</div>
--%>
<div class="textARight marginBottom_5">
    <div class="table_search">
        <form:form modelAttribute="menuVO" name="contentsForm" id="contentsForm" method="get" action="/neo/popupContentsSearch.do" onsubmit="return fn_ajax_search_submit('contentsForm');return false;">
            <span class="srch_element select">
                <form:select path="pageUnit" cssClass="select">
                    <form:option value="10">10 페이지</form:option>
                    <form:option value="20">20 페이지</form:option>
                    <form:option value="30">30 페이지</form:option>
                    <form:option value="40">40 페이지</form:option>
                    <form:option value="50">50 페이지</form:option>
                </form:select>
            </span>
            <span class="srch_element select">
                <form:select path="searchCnd" cssClass="select">
                    <form:option value="all">전체</form:option>
                    <form:option value="progrmNm">프로그래명</form:option>
                    <form:option value="progrmUrl">프로그램URL</form:option>
                </form:select>
            </span>
            <span class="srch_element text">
                <form:input path="searchKrwd" cssClass="txt"/>
            </span>

            <span class="srch_element submit"><button type="submit" class="search_button">검색</button></span>

        </form:form>
    </div>
</div>



<div class="table_fixed_wrap is_bottom_wrap">
    <div id="tableScroll" class="data_table">
        <div class="scroll_view">
            <table>
                <colgroup>
                    <col class="specWidth80px"/>
                    <col/>
                    <col class="specWidth100px"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">메뉴고유번호</th>
                    <th scope="col">메뉴 위치</th>
                    <th scope="col">선택</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td class="textARight"><c:out value="${result.menuNo}"/></td>
                        <td><c:out value="${fn:replace(result.menuCours,'&gt;','>')}"/></td>
                        <td class="textACenter"><a href="#fn_contentsSelect" onclick="fn_contentsSelect('<c:out value="${result.menuNo}"/>','<c:out value="${result.siteId}"/>')" class="iconTextButton small edit"><span>선택</span></a></td>
                    </tr>
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
                    <tr>
                        <td colspan="3" class="textACenter">검색된 메뉴가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="textACenter marginTop_20">
    <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="neoTreePop" jsFunction="./popupContentsSearch.do?pageUnit=${tsu:xssLinkFilter(menuVO.pageUnit)}&amp;searchKrwd=${tsu:xssLinkFilter(menuVO.searchKrwd)}&amp;pageIndex=" />
</div>
<button type="button" onclick="closeSlideView()" class="layerCloseBtn">닫기</button>

<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
