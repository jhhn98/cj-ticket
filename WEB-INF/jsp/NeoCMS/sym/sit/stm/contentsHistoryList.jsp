<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<script nonce="NEOCMSSCRIPT">
    <%--
	$(window).resize(sizeContent);
	function sizeContent() {
		var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#fileInfo").height() - 60) + "px";
		$("#contentsCn").css("height", newHeight);
	}
	$(document).ready(sizeContent);
	--%>
	function fn_restoreContents( url ) {
		if( confirm("선택한 콘텐츠로 복원하시겠습니까?") ) {
			moveTreeContents(url);
			//window.location = url;
		}
	}
</script>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap is_tabNaviStyle2">
    <div class="table_fixed_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth80px"/>
                        <col/>
                        <col class="specWidth160px"/>
                        <col class="specWidth120px"/>
                        <col class="specWidth120px"/>
                        <col class="specWidth80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">수정일</th>
                        <th scope="col">수정자</th>
                        <th scope="col">HTML보기</th>
                        <th scope="col">미리보기</th>
                        <th scope="col">복원</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="textACenter"><span class="basic_site check">현재적용중</span></td>
                        <td><c:out value="${menu.cntntsLastUpdusrPnttmYMDHMS}"/></td>
                        <td class="textACenter"><c:out value="${menu.cntntsWrterNm}"/>(<span class="em_red"><c:out value="${menu.cntntsWrterId}"/></span>)</td>
                        <td class="textACenter"><a onclick="moveTreeContents(this.href);return false;" href="./viewContentsHtml.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>" class="iconTextButton preview small"><span>HTML보기</span></a></td>
                        <td class="textACenter"><a href="/<c:out value="${menu.siteId}"/>/contents.do?key=<c:out value="${menu.menuNo}"/>" class="iconTextButton preview small" target="_blank"><span>미리보기</span></a></td>
                        <td class="textACenter">LIVE버전</td>
                    </tr>
                    <c:set var="sNumber" value="${contentsHistoryTotCnt}"/>
                    <c:forEach var="result" items="${contentsHistoryList}" varStatus="status">
                        <tr>
                            <td class="textARight"><c:out value="${sNumber}"/></td>
                            <td><c:out value="${tsu:toDateFormat(result.frstRegisterPnttm,'yyyyMMddHHmmss','yyyy년 MM월 dd일 HH시 mm분 ss초')}"/></td>
                            <td class="textACenter eng_text"><c:out value="${result.cntntsWrterNm}"/>(<span class="em_red"><c:out value="${result.cntntsWrterId}"/></span>)</td>
                            <td class="textACenter"><a onclick="moveTreeContents(this.href);return false;" href="./viewContentsHistoryHtml.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsHistNo=<c:out value="${result.cntntsHistNo}"/>" class="iconTextButton preview small"><span>HTML보기</span></a></td>
                            <td class="textACenter"><a href="/<c:out value="${menu.siteId}"/>/previewContentsHistory.do?menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsHistNo=<c:out value="${result.cntntsHistNo}"/>" class="iconTextButton preview small" target="_blank"><span>미리보기</span></a></td>
                            <td class="textACenter"><a href="./restoreContentsHistory.do?siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsHistNo=<c:out value="${result.cntntsHistNo}"/>" onclick="fn_restoreContents(this.href); return false;" class="iconTextButton history_back small"><span>복원</span></a></td>
                        </tr>
                        <c:set var="sNumber" value="${sNumber-1}"/>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>