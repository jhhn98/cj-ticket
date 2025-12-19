<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>NEO Administrator</title>
    <meta name="decorator" content="neo"/>
    <link rel="stylesheet" type="text/css" href="/neo/css/dashboard.css"/>
</head>
<body>
<div class="dashboardWrap">
    <h2>NeoCMS Dashboard</h2>
    <section class="sectionCard systemInfo">
        <h3>시스템 정보</h3>
        <ul>
            <li><span class="label">호스트명</span><span class="data"><c:out value="${hostName}"/></span></li>
            <li><span class="label">OS</span><span class="data"><c:out value="${osName}"/></span></li>
            <li><span class="label">프로세서ID</span><span class="data"><c:out value="${pidNumber}"/></span></li>
            <li><span class="label">IP</span><span class="data"><c:out value="${serverIp}"/></span></li>
        </ul>
        <span class="cmsVersion"><spring:eval expression="@prop['cms.version']"/></span>
    </section>
    <div class="colgroup">
        <section class="sectionCard connectionTrendTerm">
            <h3>기간별 접속추이</h3>
            <ul class="dashboard-tab">
                <li><button type="button" data-element="tabButton" data-name="dayLog" class="active"><span>일별 접속</span></button></li>
                <li><button type="button" data-element="tabButton" data-name="monthLog"><span>월별 접속</span></button></li>
            </ul>
            <section class="tab-area" data-area>
                <div>
                    <canvas id="termChart" height="85"></canvas>
                </div>
            </section>
        </section>
        <section class="sectionCard connectionTrendSystem">
            <h3>운영체제 접속추이</h3>
            <ul class="dashboard-tab">
                <li><button type="button" data-element="tabButton" data-name="os" class="active"><span>OS</span></button></li>
                <li><button type="button" data-element="tabButton" data-name="browser"><span>브라우저</span></button></li>
            </ul>
            <section class="tab-area" data-area>
                <div><canvas id="osChart" height="220"></canvas></div>
            </section>
        </section>
    </div>
    <div class="colgroup">
        <section class="sectionCard monitoring">
            <h3>시스템 모니터링</h3>
            <!--<button type="button" class="setting_button"><span>시스템 설정</span></button>-->
            <div class="gauge_chart">
                <div class="chart_element">
                    <!--<div class="chart_label"><span>CPU</span></div>-->
                    <div class="chart_area">
                        <canvas id="cpuGauge"></canvas>
                        <strong class="chart_label">CPU<span id="cpuGaugeValue"></span> %</strong>
                    </div>
                </div>
                <div class="chart_element">
                    <!--<div class="chart_label"><span>MEMORY</span></div>-->
                    <div class="chart_area">
                        <canvas id="memoryGauge"></canvas>
                        <strong class="chart_label">MEMORY<span id="memoryGaugeValue"></span> %</strong>
                    </div>
                </div>
                <div class="chart_element">
                    <!--<div class="chart_label"><span>DISK</span></div>-->
                    <div class="chart_area">
                        <canvas id="diskGauge"></canvas>
                        <strong class="chart_label">DISK<span id="diskGaugeValue"></span> %</strong>
                    </div>
                </div>
            </div>
        </section>
        <section class="sectionCard contentsDistribution">
            <h3>콘텐츠 분포</h3>
            <div><canvas id="contentsChart" height="200"></canvas></div>
        </section>
        <section class="sectionCard userLogin">
            <h3>로그인 이력</h3>
            <c:choose>
                <c:when test="${fn:length(menuTypeList) > 0}">
                    <ul>
                        <c:forEach var="usrs" items="${loginList}" varStatus="status">
                            <li>
                                <span class="name"><c:out value="${usrs.userNm}"/></span>
                                <span class="date"><c:out value="${usrs.loginTime}"/></span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="empty">현재 로그인된 사용자가 없습니다.</div>
                </c:otherwise>
            </c:choose>

        </section>
    </div>
    <div class="colgroup">
        <section class="sectionCard latelyBoard">
            <h3>최근 게시물</h3>
            <div class="table_fixed_wrap">
                <div id="tableScroll1" class="data_table">
                    <div class="scroll_view">
                        <table>
                            <colgroup>
                                <col/>
                                <col class="specWidth200px"/>
                                <col class="specWidth120px"/>
                                <col class="specWidth80px"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">메뉴경로</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">작성일</th>
                            </tr>
                            </thead>
                            <tbody class="textACenter">
                            <c:choose>
                                <c:when test="${fn:length(bbsNttList) > 0 }">
                                    <c:forEach items="${bbsNttList}" var="ntt">
                                        <tr data-display="true">
                                            <td><a href='<c:out value="${ntt.menuUrl}"/>' target='_blank' rel="noreferrer noopener" class="link"><c:out value="${fn:replace(ntt.menuCourse,'&gt;','>')}" /></a></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${fn:length(ntt.nttSj) > 19}">
                                                        <span title='<c:out value="${ntt.nttSj}"/>'><c:out value="${fn:substring(ntt.nttSj,0,19)}"/>...</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span><c:out value="${ntt.nttSj}"/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><c:out value="${ntt.writerNm}" /></td>
                                            <td><c:out value="${ntt.frstRegisterPnttmYMD}" /></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td class="empty">최근 등록된 게시물이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <section class="sectionCard latelyException">
            <h3>최근 예외 내역</h3>
            <div class="table_fixed_wrap">
                <div id="tableScroll2" class="data_table">
                    <div class="scroll_view">
                        <table>
                            <colgroup>
                                <col class="specWidth200px"/>
<%--                                <col class="specWidth200px"/>--%>
                                <col class="specWidth200px"/>
                                <col class="specWidth60px"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">발생 클래스</th>
<%--                                <th scope="col">발생 라인</th>--%>
                                <th scope="col">사유</th>
                                <th scope="col">발생시간</th>
                            </tr>
                            </thead>
                            <tbody class="textALeft">
                            <c:choose>
                                <c:when test="${fn:length(errorHistList) > 0 }">
                                    <c:forEach items="${errorHistList}" var="hist">
                                        <tr data-display="true">
                                            <td><a href='./errorHistView.do?errorHistNo=<c:out value="${hist.errorHistNo}"/>' target='_blank' rel="noreferrer noopener" class="link bug eng_text"><c:out value="${hist.pckageNm}" /></a></td>
<%--                                            <td><span class="eng_text"><c:out value="${hist.methodNm}" /></span></td>--%>
                                            <td><span class="eng_text"><c:out value="${hist.causePckageNm}" /></span></td>
                                            <td><span class="eng_text"><c:out value="${hist.occrrncPnttmYMDHM}" /></span></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td class="empty">최근 등록된 게시물이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<p>
=========
<!-- ${dayList} -->
---=-=-=-=-=-=-=-
</p>
<script src="/neo/js/common.js"></script>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script src="/neo/js/Chart.min.js"></script>
<script src="/neo/js/gauge-chart.min.js"></script>
<script src="/neo/js/dashboard.js"></script>
<script nonce="NEOCMSSCRIPT">
    <jsp:useBean id="now" class="java.util.Date"/>
    <fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today"/>
    var dayLabel = [], latelyDayData = [], oldDayData = [], monthLabel = [], latelyMonthData = [], oldMonthData = [], osLogLabel = [], osLogData = [], browserLogLabel = [], browserLogData = [], contentsLabel = [], contentsData = [];

    dayLabel = [
        <c:forEach var="day" items="${dayList}" varStatus="status"><c:if test="${!status.first}">, </c:if>'${fn:substring(day,6,8)}'</c:forEach>
    ];
    latelyDayData = [
        <c:forEach var="day" items="${dayList}" varStatus="status"><%--
            --%><c:if test="${today >= day}"><%--
            --%><c:set var="isPrinted" value="0" /><%--
            --%><c:forEach var="conectLog" items="${conectLogDalyList}" ><%--
                    --%><c:if test="${day eq conectLog.itemNm}"><c:if test="${!status.first}">, </c:if>'<c:out value="${conectLog.rate}"/>'<c:set var="isPrinted" value="1" /></c:if><%--
                --%></c:forEach><%--
                --%><c:if test="${isPrinted eq 0}"><c:if test="${!status.first}">,</c:if> '0'</c:if><%--
            --%></c:if><%--
        --%></c:forEach>
    ];
    oldDayData = [<!-- 전월 월별 -->
        <c:forEach var="dayConectLog" items="${conectLogDalyPrevList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${dayConectLog.rate}'
        </c:forEach>
    ];
    monthLabel = [<!-- 올해 월별 -->
        <c:forEach var="monthConectLog" items="${conectLogMnbyList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${fn:substring(monthConectLog.itemNm,4,6)}'
        </c:forEach>
    ];
    latelyMonthData = [
        <c:forEach var="monthConectLog" items="${conectLogMnbyList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${monthConectLog.rate}'
        </c:forEach>
    ];
    oldMonthData = [
        <c:forEach var="monthConectLog" items="${conectLogMnbyPrevList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${monthConectLog.rate}'
        </c:forEach>
    ];
    osLogLabel = [
        <c:forEach var="osLog" items="${conectLogList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${osLog.itemNm}'
        </c:forEach>
    ];
    osLogData = [
        <c:forEach var="osLog" items="${conectLogList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'${osLog.rate}'
        </c:forEach>
    ];
    browserLogLabel = [
        <c:forEach var="browserLog" items="${conectBrwLogList}" varStatus="status">
        <c:if test="${status.index < 5}"><c:if test="${!status.first}">, </c:if>'<c:out value="${browserLog.itemNm}"/>'</c:if>
        <c:if test="${status.index >= 5 && status.last}">,'기타'</c:if>
        </c:forEach>
    ];
    browserLogData = [
        <c:set var="otherRate" value="0"/>
        <c:forEach var="browserLog" items="${conectBrwLogList}" varStatus="status">
        <c:if test="${status.index < 5}"><c:if test="${!status.first}">, </c:if>'<c:out value="${browserLog.rate}"/>'</c:if>
        <c:if test="${status.index >= 5}"><c:set var="otherRate" value="${otherRate + browserLog.rate}" /></c:if>
        <c:if test="${status.index >= 5 && status.last}">,'<c:out value="${otherRate}"/>'</c:if>
        </c:forEach>
    ];

    contentsLabel = [
        <c:forEach var="menuTy" items="${menuTypeList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'<c:out value="${menuTyCode[menuTy.menuTy]}"/>'
        </c:forEach>
    ];
    contentsData = [
        <c:forEach var="menuTy" items="${menuTypeList}" varStatus="status">
        <c:if test="${!status.first}">, </c:if>'<c:out value="${menuTy.rate}"/>'
        </c:forEach>
    ];

    var cpuChart, memChart, diskChart,
        firstMonitor = false, firstDisk = false;

    $(document).ready(function(){
        reloadMonitor();
        reloadDisk();
        setInterval(reloadMonitor, 3000);
        setInterval(reloadDisk, 60000);
        termLogChart(dayLabel, latelyDayData, oldDayData, monthLabel, latelyMonthData, oldMonthData);
        operateLogChart(osLogLabel, osLogData, browserLogLabel, browserLogData);
        semiDoughnutChart(contentsLabel, contentsData);
    });

    var dataTable1 = new fixedTableHead({
            target: "#tableScroll1"
        }),
        dataTable2 = new fixedTableHead({
            target: "#tableScroll2"
        });

</script>
</body>
</html>

