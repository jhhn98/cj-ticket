<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script nonce="NEOCMSSCRIPT">
    function fn_deleteContentsEval( url ) {
        if( confirm("평가정보를 삭제하시겠습니까?") ) {
            moveTreeContents(url);
            return false;
            //window.location = url;
        }
    }
</script>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap is_tabNaviStyle2">
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth70px"/>
                        <col class="specWidth140px"/>
                        <col class="specWidth80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">평가시작일시</th>
                        <th scope="col">매우만족 수</th>
                        <th scope="col">만족 수</th>
                        <th scope="col">보통 수</th>
                        <th scope="col">불만족 수</th>
                        <th scope="col">매우불만족 수</th>
                        <th scope="col">의견 수</th>
                        <th scope="col">점수</th>
                        <th scope="col">상세평가보기</th>
                        <th scope="col">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="result" items="${contentsEvalList}" varStatus="status">
                    <tr>
                        <td class="eng_text"><c:out value="${result.frstRegisterPnttmYMDHMS}"/></td>
                        <td class="textARight"><c:out value="${result.verySatsfcCo}"/></td>
                        <td class="textARight"><c:out value="${result.satsfcCo}"/></td>
                        <td class="textARight"><c:out value="${result.nrmltyCo}"/></td>
                        <td class="textARight"><c:out value="${result.dscnttCo}"/></td>
                        <td class="textARight"><c:out value="${result.veryDscnttCo}"/></td>
                        <td class="textARight"><c:out value="${result.opinionCo}"/></td>
                        <td class="textARight"><c:out value="${result.evlScore}"/></td>
                        <td class="textACenter"><a onclick="moveTreeContents(this.href);return false;" href="./selectContentsEvalHistList.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsEvlNo=<c:out value="${result.cntntsEvlNo}"/>" class="iconTextButton preview"><span>상세의견보기</span></a></td>
                        <td class="textACenter">
                            <c:if test="${menu.cntntsEvlNo ne result.cntntsEvlNo}">
                                <a href="./deleteContentsEval.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsEvlNo=<c:out value="${result.cntntsEvlNo}"/>" onclick="fn_deleteContentsEval(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a>
                            </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${fn:length(contentsEvalList) == 0}">
                    <tr>
                        <td colspan="10" class="textACenter">등록된 평가 정보가 없습니다.</td>
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
            <a onclick="moveTreeContents(this.href);return false;" href="./addContentsEval.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>" class="iconTextButton new_eval"><span>새평가 시작</span></a>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>