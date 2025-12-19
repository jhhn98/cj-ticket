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
<meta name="decorator" content="neo"/>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">메뉴별 접속로그</span>
</div>
<div class="tab_navigation type2">
    <a href="/neo/selectConectLog.do?siteId=<c:out value="${siteInfo.siteId}"/>" ><span>기간별 접속로그</span></a>
    <a href="/neo/selectConectLogOs.do?siteId=<c:out value="${siteInfo.siteId}"/>" ><span>운영체제별 접속로그</span></a>
    <a href="/neo/selectConectLogBrwsr.do?siteId=<c:out value="${siteInfo.siteId}"/>"><span>브라우저별 접속로그</span></a>
    <a href="/neo/selectConectLogMenuList.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="current"><span>메뉴별 접속로그</span></a>
</div>
<div class="contents is_tab scrollY">
    <div class="filterSearch marginBottom_5">
        <div class="filterButton divergence">
            <div class="filter_button all">
                <strong class="filter_title">전체</strong>
                <div class="filter_list">
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=01-12"<c:if test="${'01-12' eq conectLogVO.range}"> class="set"</c:if>><span>전체</span></a>
                </div>
            </div>
            <div class="filter_button branch1">
                <strong class="filter_title">반기별</strong>
                <div class="filter_list">
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=01-06" class="branch1_1<c:if test="${'01-06' eq conectLogVO.range}"> set</c:if>"><span>상</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=07-12" class="branch1_2<c:if test="${'07-12' eq conectLogVO.range}"> set</c:if>"><span>하</span></a>
                </div>
            </div>
            <div class="filter_button branch2">
                <strong class="filter_title">분기별</strong>
                <div class="filter_list">
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=01-03" class="branch2_1 <c:if test="${'01-03' eq conectLogVO.range}"> set</c:if>"><span>1/4</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=04-06" class="branch2_2 <c:if test="${'04-06' eq conectLogVO.range}"> set</c:if>"><span>2/4</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=07-09" class="branch2_3 <c:if test="${'07-09' eq conectLogVO.range}"> set</c:if>"><span>3/4</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=10-12" class="branch2_4 <c:if test="${'10-12' eq conectLogVO.range}"> set</c:if>"><span>4/4</span></a>
                </div>
            </div>
            <div class="filter_button month">
                <strong class="filter_title">월별</strong>
                <div class="filter_list">
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=01-01"<c:if test="${'01-01' eq conectLogVO.range}"> class="set"</c:if>><span>1</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=02-02"<c:if test="${'02-02' eq conectLogVO.range}"> class="set"</c:if>><span>2</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=03-03"<c:if test="${'03-03' eq conectLogVO.range}"> class="set"</c:if>><span>3</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=04-04"<c:if test="${'04-04' eq conectLogVO.range}"> class="set"</c:if>><span>4</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=05-05"<c:if test="${'05-05' eq conectLogVO.range}"> class="set"</c:if>><span>5</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=06-06"<c:if test="${'06-06' eq conectLogVO.range}"> class="set"</c:if>><span>6</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=07-07"<c:if test="${'07-07' eq conectLogVO.range}"> class="set"</c:if>><span>7</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=08-08"<c:if test="${'08-08' eq conectLogVO.range}"> class="set"</c:if>><span>8</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=09-09"<c:if test="${'09-09' eq conectLogVO.range}"> class="set"</c:if>><span>9</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=10-10"<c:if test="${'10-10' eq conectLogVO.range}"> class="set"</c:if>><span>10</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=11-11"<c:if test="${'11-11' eq conectLogVO.range}"> class="set"</c:if>><span>11</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=<c:out value="${conectLogVO.orderCntYn}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=12-12"<c:if test="${'12-12' eq conectLogVO.range}"> class="set"</c:if>><span>12</span></a>
                </div>
            </div>
            <div class="filter_button branch1">
                <strong class="filter_title">정렬순서</strong>
                <div class="filter_list">
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=N&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=<c:out value="${conectLogVO.range}"/>" class="branch1_1<c:if test="${conectLogVO.orderCntYn eq 'N'  or empty conectLogVO.orderCntYn}"> set</c:if>"><span>메뉴기준</span></a>
                    <a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&orderCntYn=Y&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=<c:out value="${conectLogVO.range}"/>" class="branch1_2<c:if test="${conectLogVO.orderCntYn eq 'Y' }"> set</c:if>"><span>접속자기준</span></a>
                </div>
            </div>
        </div>
        <div class="table_search">
            <form name="conectLogMenu" id="conectLogMenu" method="post" action="./selectConectLogMenuList.do">
                <input type="hidden" name="siteId" id="siteId" value="<c:out value="${conectLogVO.siteId}"/>"/>
                <span class="srch_element select">
                    <select name="year" id="year">
                        <option value="">년도 선택</option>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy" var="yearMax"/>
                        <c:forEach begin="${yearMin}" end="${yearMax}" varStatus="idx">
                            <option value="<c:out value="${idx.index}"/>" <c:if test="${conectLogVO.year eq idx.index}">selected</c:if>><c:out value="${idx.index}"/> 년도</option>
                        </c:forEach>
                    </select>
                </span>
                <span class="srch_element select">
                    <select name="deptCode" id="deptCode">
                        <option value="">부서 선택</option>
                        <c:forEach var="departmentFirst" items="${departmentFirstList}">
                            <option value="<c:out value="${departmentFirst.deptCode}"/>" <c:if test="${conectLogVO.deptCode eq departmentFirst.deptCode}">selected="selected"</c:if>><c:out value="${departmentFirst.deptNm}"/></option>
                            <c:forEach var="departmentSecond" items="${departmentSecondList}"><c:if test="${departmentFirst.deptCode eq departmentSecond.upperDeptCode}"><option value="<c:out value="${departmentSecond.deptCode}"/>" <c:if test="${conectLogVO.deptCode eq departmentSecond.deptCode}">selected="selected"</c:if>>&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${departmentSecond.deptNm}"/></option></c:if></c:forEach></c:forEach>
                    </select>
                </span>
                <span class="srch_element select">
                    <select name="range" id="range">
                        <option value="">범위 지정</option>
                        <option value="01-12" <c:if test="${'01-12' eq conectLogVO.range}">selected="selected"</c:if>>전체</option>
                        <optgroup label="반기별">
                            <option value="01-06" <c:if test="${'01-06' eq conectLogVO.range}">selected="selected"</c:if>>상반기</option>
                            <option value="07-12" <c:if test="${'07-12' eq conectLogVO.range}">selected="selected"</c:if>>하반기</option>
                        </optgroup>
                        <optgroup label="분기별">
                            <option value="01-03" <c:if test="${'01-03' eq conectLogVO.range}">selected="selected"</c:if>>1/4분기</option>
                            <option value="04-06" <c:if test="${'04-06' eq conectLogVO.range}">selected="selected"</c:if>>2/4분기</option>
                            <option value="07-09" <c:if test="${'07-09' eq conectLogVO.range}">selected="selected"</c:if>>3/4분기</option>
                            <option value="10-12" <c:if test="${'10-12' eq conectLogVO.range}">selected="selected"</c:if>>4/4분기</option>
                        </optgroup>
                        <optgroup label="월별">
                            <option value="01-01" <c:if test="${'01-01' eq conectLogVO.range}">selected="selected"</c:if>>1월</option>
                            <option value="02-02" <c:if test="${'02-02' eq conectLogVO.range}">selected="selected"</c:if>>2월</option>
                            <option value="03-03" <c:if test="${'03-03' eq conectLogVO.range}">selected="selected"</c:if>>3월</option>
                            <option value="04-04" <c:if test="${'04-04' eq conectLogVO.range}">selected="selected"</c:if>>4월</option>
                            <option value="05-05" <c:if test="${'05-05' eq conectLogVO.range}">selected="selected"</c:if>>5월</option>
                            <option value="06-06" <c:if test="${'06-06' eq conectLogVO.range}">selected="selected"</c:if>>6월</option>
                            <option value="07-07" <c:if test="${'07-07' eq conectLogVO.range}">selected="selected"</c:if>>7월</option>
                            <option value="08-08" <c:if test="${'08-08' eq conectLogVO.range}">selected="selected"</c:if>>8월</option>
                            <option value="09-09" <c:if test="${'09-09' eq conectLogVO.range}">selected="selected"</c:if>>9월</option>
                            <option value="10-10" <c:if test="${'10-10' eq conectLogVO.range}">selected="selected"</c:if>>10월</option>
                            <option value="11-11" <c:if test="${'11-11' eq conectLogVO.range}">selected="selected"</c:if>>11월</option>
                            <option value="12-12" <c:if test="${'12-12' eq conectLogVO.range}">selected="selected"</c:if>>12월</option>
                        </optgroup>
                    </select>
                </span>
                <span class="srch_element submit">
                    <button type="submit" class="search_button">조회</button>
                </span>
            </form>
        </div>
    </div>
    <div class="table_fixed_wrap menuLogList">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth240px"/>
                        <col />
                        <col class="specWidth120px"/>
                        <col class="specWidth80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">메뉴명</th>
                        <th scope="col" <c:if test="${conectLogVO.orderCntYn eq 'N'  or empty conectLogVO.orderCntYn}">style="color:blue;"</c:if>><a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=<c:out value="${conectLogVO.range}"/>&orderCntYn=N">메뉴 경로</a></th>
                        <th scope="col">부서명</th>
                        <th scope="col" <c:if test="${conectLogVO.orderCntYn eq 'Y'}">style="color:blue;"</c:if>><a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>&year=<c:out value="${conectLogVO.year}"/>&deptCode=<c:out value="${conectLogVO.deptCode}"/>&range=<c:out value="${conectLogVO.range}"/>&orderCntYn=Y">접속 수</a></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="conectLogMenu" items="${conectLogMenuList}">
                        <tr>
                            <td class="textARight"><c:out value="${conectLogMenu.menuNm}"/></td>
                            <td><a href="/<c:out value="${conectLogVO.siteId}"/>/sub.do?key=<c:out value="${conectLogMenu.menuNo}"/>" target="_blank" class="iconTextLink"><c:out value="${fn:replace(conectLogMenu.path,'&gt;','>')}"/></a></td>
                            <td class="textACenter"><c:out value="${conectLogMenu.deptNm}"/></td>
                            <td class="textARight"><c:out value="${conectLogMenu.cnt}"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(conectLogMenuList) == 0}">
                        <tr>
                            <td colspan="4" class="textACenter">로그가 없습니다.</td>
                        </tr>
                    </c:if>
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
</body>
</html>
