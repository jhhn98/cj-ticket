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
	<span class="depth4_title">운영체제별 접속로그</span>
</div>

<div class="tab_navigation type2">
    <a href="/neo/selectConectLog.do?siteId=<c:out value="${siteInfo.siteId}"/>" ><span>기간별 접속로그</span></a>
    <a href="/neo/selectConectLogOs.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="current"><span>운영체제별 접속로그</span></a>
    <a href="/neo/selectConectLogBrwsr.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>브라우저별 접속로그</span></a>
    <a href="/neo/selectConectLogMenuList.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>메뉴별 접속로그</span></a>
</div>
<div class="contents is_tab scrollY">
    <div class="dataParagraph double">
        <div class="data_wrap">
            <div class="arrangementWrap data_info">
                <div class="arrLeft"><strong class="data_title">월별 접속로그</strong></div>
                <div class="arrRight">
                    <div class="table_search">
                            <span class="srch_element select">
                                <select name="sy" id="syM" class="select">
                                <jsp:useBean id="now" class="java.util.Date"/>
                                <fmt:formatDate value="${now}" pattern="yyyy" var="yearMax"/>
                                <c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx">
                                    <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sy eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element select">
                                <select name="sm" id="smM" class="select">
                                <c:forEach begin="1" end="12" varStatus="idx">
                                    <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sm eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element submit"><button type="button" class="search_button" onclick="reloadMonth()">보기</button></span>
                    </div>
                </div>
            </div>
            <div class="graph_area double_element">
                <div class="pie"><div><canvas id="monthLogChart" height="220"></canvas></div></div>
                <div class="bar">
                    <ul class="bar_data" id="monthBar">
                        <c:forEach var="log" items="${conectLogList}" varStatus="status">
                            <li>
                                <span class="title"><c:out value="${log.itemNm}"/></span>
                                <div class="data_bar"><div class="barFill" style='width:<c:out value="${log.rate}"/>%;'><span class="barData"><c:out value="${log.cnt}"/></span></div></div>
                                <span class="percent"><c:out value="${log.rate}"/>%</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="data_wrap">
            <div class="arrangementWrap data_info">
                <div class="arrLeft"><strong class="data_title">년도별 접속로그</strong></div>
                <div class="arrRight">
                    <div class="table_search">
                            <span class="srch_element select">
                                <select name="sy" id="syY" class="select">
                                    <c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx">
                                        <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.sy eq idx.index}">selected</c:if>><c:out value="${idx.index}"/></option>
                                    </c:forEach>
                                </select>
                            </span>
                            <span class="srch_element submit"><button type="button" class="search_button" onclick="reloadYear()">보기</button></span>
                    </div>
                </div>
            </div>
            <div class="graph_area double_element">
                <div class="pie"><div><canvas id="yearLogChart" height="220"></canvas></div></div>
                <div class="bar">
                    <ul class="bar_data" id="yearBar">
                        <c:forEach var="log" items="${conectLogYearList}" varStatus="status">
                            <li>
                                <span class="title"><c:out value="${log.itemNm}"/></span>
                                <div class="data_bar"><div class="barFill" style='width:<c:out value="${log.rate}"/>%;'><span class="barData"><c:out value="${log.cnt}"/></span></div></div>
                                <span class="percent"><c:out value="${log.rate}"/>%</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="/neo/js/Chart.min.js"></script>
<script src="/neo/js/logChart.js"></script>
<script nonce="NEOCMSSCRIPT">
    var monthData = {
            graphContext: 'monthLogChart',
            labels: [<c:forEach var="log" items="${conectLogList}" varStatus="status">
                <c:if test="${!status.first}">, </c:if>'<c:out value="${log.itemNm}"/>'
                </c:forEach>],
            data: [<c:forEach var="log" items="${conectLogList}" varStatus="status">
                <c:if test="${!status.first}">, </c:if>'<c:out value="${log.rate}"/>'
                </c:forEach>]
        },
        yearData = {
            graphContext: 'yearLogChart',
            labels: [<c:forEach var="log" items="${conectLogYearList}" varStatus="status">
                <c:if test="${!status.first}">, </c:if>'<c:out value="${log.itemNm}"/>'
                </c:forEach>],
            data: [<c:forEach var="log" items="${conectLogYearList}" varStatus="status">
                <c:if test="${!status.first}">, </c:if>'<c:out value="${log.rate}"/>'
                </c:forEach>]
        };


    var monthChart = null;
    var yearChart = null;
    $(document).ready(function(){
        monthChart = logPieChart(monthData);
        yearChart = logPieChart(yearData);
    });
    function reloadYear(){
        $.ajax({
            type : "GET",
            url : "/neo/jsonConectOSLogYearList.do",
            contentType: "application/json",
            data: {"siteId":"<c:out value="${siteInfo.siteId}"/>","sy":$("#syY").val()},
            success : function(data){
                yearChart.data.labels = data.listNm;
                yearChart.data.datasets[0].data = data.listRate;
                yearChart.update();	//차트 업데이트

                var barHtml = "";
                for(i=0;i<data.listNm.length;i++) {
                    barHtml += '<li><span class="title">'+data.listNm[i]+'</span><div class="data_bar"><div class="barFill" style="width:'+data.listRate[i]+'%;"><span class="barData">'+data.listCnt[i]+'</span></div></div>\n' +
                        '<span class="percent">'+data.listRate[i]+'%</span></li>';
                }
                $("#yearBar").html(barHtml);
            }
        });

    }
    function reloadMonth(){
        $.ajax({
            type : "GET",
            url : "/neo/jsonConectOSLogMnthList.do",
            contentType: "application/json",
            data: {"siteId":"<c:out value="${siteInfo.siteId}"/>","sy":$("#syM").val(),"sm":$("#smM").val()},
            success : function(data){
                monthChart.data.labels = data.listNm;
                monthChart.data.datasets[0].data = data.listRate;
                monthChart.update();	//차트 업데이트


                var barHtml = "";
                for(i=0;i<data.listNm.length;i++) {
                    barHtml += '<li><span class="title">'+data.listNm[i]+'</span><div class="data_bar"><div class="barFill" style="width:'+data.listRate[i]+'%;"><span class="barData">'+data.listCnt[i]+'</span></div></div>\n' +
                        '<span class="percent">'+data.listRate[i]+'%</span></li>';
                }
                $("#monthBar").html(barHtml);
            }
        });
    }
</script>
</body>
</html>
