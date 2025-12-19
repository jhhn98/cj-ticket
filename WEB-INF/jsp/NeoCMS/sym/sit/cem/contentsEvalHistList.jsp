<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap is_tabNaviStyle2">
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth200px"/>
                        <col class="specWidth100px"/>
                        <col/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">평가일시</th>
                        <th scope="col">평가</th>
                        <th scope="col">평가의견</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="result" items="${contentsEvalHistList}" varStatus="status">
                    <tr>
                        <td class="textACenter eng_text"><c:out value="${result.frstRegisterPnttmYMDHMS}"/></td>
                        <td class="textACenter"><c:out value="${cntntsEvlSeMap[result.cntntsEvlSe]}"/></td>
                        <td><c:out value="${result.cntntsOpinionCn}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${fn:length(contentsEvalHistList) == 0}">
                    <tr>
                        <td colspan="3" class="textACenter">등록된 평가 정보가 없습니다.</td>
                    </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">

        </div>
        <div class="arrRight">
            <a onclick="moveTreeContents(this.href);return false;"  href="./selectContentsEvalList.do?siteId=<c:out value="${menu.siteId}"/>&menuNo=<c:out value="${menu.menuNo}"/>" class="iconTextButton list"><span>평가 목록</span></a>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>