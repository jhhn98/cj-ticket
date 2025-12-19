<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>접속로그</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">일별접속로그</span>
</div>
<div class="tab_navigation type2">
    <a href="/neo/selectConectLog.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="current"><span>기간별 접속로그</span></a>
    <a href="/neo/selectConectLogOs.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>운영체제별 접속로그</span></a>
    <a href="/neo/selectConectLogBrwsr.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>브라우저별 접속로그</span></a>
    <a href="/neo/selectConectLogMenuList.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>메뉴별 접속로그</span></a>
</div>
<div class="contents is_tab scrollY">
    <div class="dataParagraph single">
        <div class="data_wrap">
            <div class="arrangementWrap data_info">
                <div class="arrLeft"><strong class="data_title">일별 접속로그</strong></div>
                <div class="arrRight">
                    <div class="table_search">
                        <form name="conectLog" id="conectLogD" method="post" action="./selectConectLogDalyList.do">
                            <input type="hidden" name="siteId" id="siteIdD" value="<c:out value="${conectLogVO.siteId}"/>"/>
                            <span class="srch_element select">
                                <select name="sy" id="syD" class="select">
                                <jsp:useBean id="now" class="java.util.Date"/>
                                <fmt:formatDate value="${now}" pattern="yyyy" var="yearMax"/>
                                <c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx">
                                    <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sy eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element select">
                                <select name="sm" id="smD" class="select">
                                <c:forEach begin="1" end="12" varStatus="idx">
                                    <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sm eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element submit"><button type="button" class="search_button" onclick="reloadDay()">보기</button></span>
                        </form>
                    </div>
                </div>
            </div>
            <div class="graph_area"><canvas id="dayLogChart"></canvas></div>
        </div>
    </div>
    <div class="dataParagraph double">
        <div class="data_wrap">
            <div class="arrangementWrap data_info">
                <div class="arrLeft"><strong class="data_title">월별 접속로그</strong></div>
                <div class="arrRight">
                    <div class="table_search">
                        <form name="conectLog" id="conectLogM" method="post" action="./selectConectLogMnbyList.do">
                            <input type="hidden" name="siteId" id="siteIdM" value="${conectLogVO.siteId}"/>
                            <span class="srch_element select">
                                <select name="sy" id="syM" class="select">
                                    <fmt:formatDate value="${now}" pattern="yyyy" var="yearMax"/>
                                    <c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx">
                                        <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sy eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                    </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element submit"><button type="button" class="search_button" onclick="reloadMonth()">보기</button></span>
                        </form>
                    </div>
                </div>
            </div>
            <div class="graph_area">
                <canvas id="monthLogChart"></canvas>
            </div>
        </div>
        <div class="data_wrap">
            <div class="arrangementWrap data_info">
                <div class="arrLeft"><strong class="data_title">년도별 접속로그</strong></div>
                <div class="arrRight"></div>
            </div>
            <div class="graph_area">
                <canvas id="yearLogChart"></canvas>
            </div>
        </div>
    </div>
</div>
<p>
=========
<!-- ${conectLogList} -->
---=-=-=-=-=-=-=-
</p>
<script src="/neo/js/Chart.min.js"></script>
<script src="/neo/js/logChart.js"></script>
<fmt:formatDate value="${now}" pattern="yyyy" var="yearMax"/>
<script nonce="NEOCMSSCRIPT">
    var dayData = {
            graphContext: 'dayLogChart',
            labels: [<c:forEach var="log" items="${conectLogList}" varStatus="status">
                        <c:if test="${!status.first}">, </c:if>'<c:out value="${fn:substring(log.itemNm,6,8)}"/>'

                        /*<c:forEach var="day" items="${dayList}" varStatus="status"><c:if test="${!status.first}">, </c:if>'${fn:substring(day,6,8)}'</c:forEach>*/
                    </c:forEach>],
            data1: {
                label: '일일 접속데이터',
                data: [
                    <c:forEach var="log" items="${conectLogList}" varStatus="status">
                        <c:if test="${!status.first}">, </c:if>'${log.cnt}'
                    </c:forEach>
                ]
            }
        },
        monthData = {
            graphContext: 'monthLogChart',
            labels: [<c:forEach var="log" items="${conectLogMnthList}" varStatus="status">
                <c:if test="${!status.first}">, </c:if>'<c:out value="${fn:substring(log.itemNm,4,6)}"/>'
                </c:forEach>],
            data1: {
                label: '월별 접속데이터',
                data: [<c:forEach var="log" items="${conectLogMnthList}" varStatus="status">
                    <c:if test="${!status.first}">, </c:if>'<c:out value="${log.cnt}"/>'
                    </c:forEach>]
            }
        },
        yearData = {
            graphContext: 'yearLogChart',
            labels: [<c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx"><c:if test="${!idx.first}">,</c:if>'<c:out value="${idx.index}"/>'</c:forEach>],
            data1: {
                label: '년도별 접속데이터',
                data: [<c:forEach var="log" items="${conectLogYearList}" varStatus="status">
                    <c:if test="${!status.first}">, </c:if>'<c:out value="${log.cnt}"/>'
                    </c:forEach>]
            }
        };
    var dayChart = null;
    var monthChart = null;
    var yearChart = null;
    $(document).ready(function(){
        dayChart = logLineChart(dayData);
        monthChart = logLineChart(monthData);
        logLineChart(yearData);
    })
    function reloadDay(){
        $.ajax({
            type : "GET",
            url : "/neo/jsonConectLogDalyList.do",
            contentType: "application/json",
            data: {"siteId":"<c:out value="${siteInfo.siteId}"/>","sy":$("#syD").val(),"sm":$("#smD").val()},
            success : function(data){
                dayChart.data.labels = data.listNm;
                dayChart.data.datasets[0].data = data.listCnt;
                dayChart.update();	//차트 업데이트
            }
        });

    }
    function reloadMonth(){

        $.ajax({
            type : "GET",
            url : "/neo/jsonConectLogMnthList.do",
            contentType: "application/json",
            data: {"siteId":"<c:out value="${siteInfo.siteId}"/>","sy":$("#syM").val()},
            success : function(data){
                monthChart.data.labels = data.listNm;
                monthChart.data.datasets[0].data = data.listCnt;
                monthChart.update();	//차트 업데이트
            }
        });

    }
</script>
</body>
</html>
