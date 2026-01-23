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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} > 체험 상세보기</title>
</head>
<body>

<div class="p-wrap">

    <h3>체험 기본 정보</h3>
    <table class="p-table">
        <caption>체험 상세보기</caption>
        <colgroup>
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">운영기관</th>
            <td>
                <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                <c:out value="${expInsttMap[insttNo]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">운영년도</th>
            <td>
                <c:out value="${exprnVO.operYear}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">선발방식</th>
            <td>
                <%-- 선발방식 공통코드 - FIRST : 선착순 / CONFM : 승인 / DRWLT : 추첨 --%>
                <c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/>
                <c:if test="${exprnVO.slctMthdCd == 'DRWLT'}">
                    / 추첨일시 : <c:out value="${tsu:toDateFormat(exprnVO.drwtDt, 'yyyyMMddHHmm', 'yyyy-MM-dd HH:mm')}"/>
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">접수방식</th>
            <td>
                <%-- 접수방식 공통코드 - ONLIN : 온라인 / TLPHN : 전화 / VISIT : 방문 --%>
                <c:forEach var="result" items="${exprnVO.rcptMthdCdArr}" varStatus="status">
                    <c:out value="${rcptMthdMap[result]}"/>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">체험명 / 운영상태</th>
            <td>
                <c:out value="${exprnVO.exprnNm}"/> / <c:out value="${operSttusMap[exprnVO.operSttus]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">서비스유형</th>
            <td>
                <%-- 서비스유형 공통코드 - EXPSVC01 : 관람 / EXPSVC02 : 체험/레포츠 / EXPSVC03 : 관광/견학 / EXPSVC04 : 캠핑장 / EXPSVC05 : 기타 --%>
                <c:out value="${svcTyMap[exprnVO.svcTyCd]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">지역</th>
            <td>
                <c:out value="${areaGuMap[exprnVO.areaGuCd]}"/>
                <c:if test="${exprnVO.areaGuCd == 'SDGU'}">
                    <c:out value="${sdguMap[exprnVO.areaEmdCd]}"/>
                </c:if>
                <c:if test="${exprnVO.areaGuCd == 'HDGU'}">
                    <c:out value="${hdguMap[exprnVO.areaEmdCd]}"/>
                </c:if>
                <c:if test="${exprnVO.areaGuCd == 'CWGU'}">
                    <c:out value="${cwguMap[exprnVO.areaEmdCd]}"/>
                </c:if>
                <c:if test="${exprnVO.areaGuCd == 'SWGU'}">
                    <c:out value="${swguMap[exprnVO.areaEmdCd]}"/>
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">대상</th>
            <td>
                <%-- 대상 공통코드 - TRGET01 : 영유아 / TRGET02 : 아동 / TRGET03 : 초등학생 / TRGET04 : 청소년 / TRGET05 : 성인 / TRGET06 : 어르신 / TRGET07 : 장애인 / TRGET08 : 기타 --%>
                <c:forEach var="result" items="${exprnVO.targetCdArr}" varStatus="status">
                    <c:out value="${targetMap[result]}"/>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">인원구분</th>
            <td>
                <%-- 인원구분 공통코드 - IND : 개인 / GRP : 단체 --%>
                <c:forEach var="result" items="${exprnVO.nmprSeCdArr}" varStatus="status">
                    <c:out value="${nmprSeMap[result]}"/>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">접수기간</th>
            <td>
                <c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/> ~
                <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">체험장소</th>
            <td>
                <c:set var="placeNo" value="place${exprnVO.placeNo}"/>
                <c:out value="${expPlaceMap[placeNo]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">체험료</th>
            <td>
                <c:choose>
                    <c:when test="${exprnVO.exprnAmt > 0}">
                        <fmt:formatNumber value="${tsu:xssNumberFilter(exprnVO.exprnAmt)}" pattern="#,###"/> 원
                    </c:when>
                    <c:otherwise>
                        무료
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th scope="row">결제방식</th>
            <td>
                <%-- 결제방식 공통코드 - ELCTRN : 전자결제 / NBKRCP : 무통장입금 / DIRECT : 현장결제 --%>
                <c:forEach var="result" items="${exprnVO.payMthdCdArr}" varStatus="status">
                    <c:out value="${payMthdMap[result]}"/>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">무통장입금 정보</th>
            <td>
                <c:if test="${fn:contains(exprnVO.payMthdCd, 'NBKRCP')}">
                    <c:out value="${exprnVO.bankNm}"/> <c:out value="${exprnVO.acctNo}"/> (예금주:<c:out value="${exprnVO.dpstrNm}"/>)
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">결제기한</th>
            <td>
                <c:choose>
                    <c:when test="${exprnVO.exprnAmt > 0}">
                        예약일/추첨일/승인일로부터  <em class="em_black"><c:out value="${exprnVO.payTmlmtCnt}"/></em>일 이내 <em class="em_black"><c:out value="${exprnVO.payTmlmtCnt}"/></em>시 까지<br/>
                        <span class="p-table__content padding_l_10">
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">신청자가 예약완료 후 설정된 시간(분)이내에 결제하지 않으면 예약이 자동으로 취소됩니다.</em>
                        </span>
                        <br/>
                        <span class="p-table__content padding_l_10">
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">해당 항목은 이용료가 유료인 경우에만 적용됩니다.</em>
                        </span>
                    </c:when>
                    <c:otherwise>
                        해당없음
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th scope="row">신청마감일수</th>
            <td>
                이용일 <em class="em_black"><c:out value="${exprnVO.reqstClosCnt}"/></em>일 전까지 신청가능
                <span class="p-table__content padding_l_10">
                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                    <em class="em_black">이용일 7일 전까지 신청가능한 경우 9월 8일은 9월 1일까지 신청가능, 9월 2일부터는 신청불가 ('0'인 경우 당일 신청 가능)</em>
                </span>
            </td>
        </tr>
        <tr>
            <th scope="row">취소마감일수</th>
            <td>
                이용일 <em class="em_black"><c:out value="${exprnVO.canclClosCnt}"/></em>일 전까지 취소가능
                <span class="p-table__content padding_l_10">
                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                    <em class="em_black">이용일 7일 전까지 취소가능한 경우 9월 8일은 9월 1일까지 취소가능, 9월 2일부터는 취소불가 ('0'인 경우 당일 취소 가능)</em>
                </span>
            </td>
        </tr>
        <tr>
            <th scope="row">정기 휴관일(요일)</th>
            <td>
                <c:if test="${empty exprnVO.fdrmCloseDayArr}">없음</c:if>
                <c:forEach var="result" items="${exprnVO.fdrmCloseDayArr}" varStatus="status">
                    <c:if test="${result == '2'}">월</c:if>
                    <c:if test="${result == '3'}">화</c:if>
                    <c:if test="${result == '4'}">수</c:if>
                    <c:if test="${result == '5'}">목</c:if>
                    <c:if test="${result == '6'}">금</c:if>
                    <c:if test="${result == '7'}">토</c:if>
                    <c:if test="${result == '1'}">일</c:if>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">모집수</th>
            <td>
                <c:out value="${exprnVO.rcritCnt}"/>  <c:out value="${exprnVO.rcritUnit}"/>
                <c:if test="${exprnVO.rcritUnit == '명'}">
                    / 세부인원(성인, 청소년, 초등학생, 아동, 영유아)
                    <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
                        사용함
                    </c:if>
                    <c:if test="${exprnVO.detailNmprUseYn == 'N'}">
                        사용안함
                    </c:if>
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">월 이용 제한시간</th>
            <td>
                <c:out value="${exprnVO.mtLmttTime}"/> 시간
                <span class="p-table__content padding_l_10">
                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                    <em class="em_black">'0'인 경우 제한없음</em>
                </span>
            </td>
        </tr>
        <tr>
            <th scope="row">인원 제약 조건</th>
            <td>
                최소 : <c:out value="${exprnVO.nmprMinCnt}"/> 명, 최대 : <c:out value="${exprnVO.nmprMaxCnt}"/> 명
                <span class="p-table__content padding_l_10">
                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                    <em class="em_black">'0'인 경우 제한없음</em>
                </span>
            </td>
        </tr>
        <tr>
            <th scope="row">상세내용</th>
            <td>
                <pre><c:out value="${exprnVO.detailCn}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">유의사항</th>
            <td>
                <pre><c:out value="${exprnVO.noticeCn}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">환불정책</th>
            <td>
                <pre><c:out value="${exprnVO.refundPlcyCn}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">이미지</th>
            <td colspan="3">
                <ul class="attach">
                    <c:forEach var="cmmnAtchFile" items="${cmmnAtchImgList}" varStatus="idx">
                        <li>
                            <a href="./downloadExprnFile.do?key=<c:out value="${param.key}"/>&amp;exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>&amp;fileSe=img"><span class="p-icon p-icon__<c:out value="${cmmnAtchFile.fileExtsn}"/>"><c:out value="${cmmnAtchFile.fileExtsn}"/> 문서</span><span><c:out value="${cmmnAtchFile.fileNm}"/></span></a>
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th scope="row">첨부파일</th>
            <td colspan="3">
                <ul class="attach">
                    <c:forEach var="cmmnAtchFile" items="${cmmnAtchFileList}" varStatus="idx">
                        <li>
                            <a href="./downloadExprnFile.do?key=<c:out value="${param.key}"/>&amp;exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>"><span class="p-icon p-icon__<c:out value="${cmmnAtchFile.fileExtsn}"/>"><c:out value="${cmmnAtchFile.fileExtsn}"/> 문서</span><span><c:out value="${cmmnAtchFile.fileNm}"/></span></a>
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th scope="row">신청자 추가 입력 항목</th>
            <td>
                <c:out value="${exprnVO.aditIem1}"/><br/>
                <c:out value="${exprnVO.aditIem2}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">거주지조회 사용여부</th>
            <td>
                <c:if test="${exprnVO.resInqUseYn == 'Y'}">
                    거주지조회 사용
                </c:if>
                <c:if test="${exprnVO.resInqUseYn == 'N'}">
                    거주지조회 사용안함
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">감면 사용여부</th>
            <td>
                <c:if test="${exprnVO.dscntUseYn == 'Y'}">
                    감면 사용
                </c:if>
                <c:if test="${exprnVO.dscntUseYn == 'N'}">
                    감면 사용안함
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">문의전화</th>
            <td>
                <c:out value="${exprnVO.telNoFmt}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">운영여부</th>
            <td>
                <c:if test="${exprnVO.useYn == 'Y'}">
                    운영
                </c:if>
                <c:if test="${exprnVO.useYn == 'N'}">
                    미운영
                </c:if>
            </td>
        </tr>
        </tbody>
    </table>
    <div class="row margin_t_20 margin_b_20">
        <div class="col-12">
        </div>
        <div class="col-12 right">
            <td><a href="./updateExprnView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small edit">기본 정보 수정</a></td>
            <td><a href="./deleteExprn.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small delete" onclick="return fn_delete();">삭제</a></td>
        </div>
    </div>

    <div class="h3">체험 일정 정보</div>
    <table class="p-table">
        <caption>체험 일정 상세보기</caption>
        <colgroup>
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">체험시간 등록방법</th>
            <td>
                <%-- 체험 일정 등록방법 - PD:체험기간(규칙) / DE:일자별 선택(불규칙) --%>
                <c:if test="${exprnSchdVO.schdMthd == 'PD'}">체험기간(규칙 접수)</c:if>
                <c:if test="${exprnSchdVO.schdMthd == 'DE'}">일자별 선택(불규칙 접수)</c:if>
            </td>
        </tr>
        <c:if test="${exprnSchdVO.schdMthd == 'PD'}">
        <tr>
            <th scope="row">체험기간</th>
            <td>
                <c:forEach var="result" items="${exprnDeList}" varStatus="status">
                    <c:if test="${status.first}">
                        <c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    </c:if>
                    <c:if test="${status.last}">
                         ~ <c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">기준시간</th>
            <td><c:out value="${exprnSchdVO.unitHour}"/>시간<c:if test="${exprnSchdVO.unitMin > 0}"> <c:out value="${exprnSchdVO.unitMin}"/>분</c:if> 단위로 운영</td>
        </tr>
        <tr>
            <th scope="row">기본체험시간</th>
            <td>
                <c:out value="${tsu:toDateFormat(exprnSchdVO.baseBgnHm,'HHmm','HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(exprnSchdVO.baseEndHm,'HHmm','HH:mm')}"/>
                <c:choose>
                    <c:when test="${!empty exprnSchdVO.lunchBgnHh && !empty exprnSchdVO.lunchEndHh}">
                        (점심시간 : <c:out value="${exprnSchdVO.lunchBgnHh}:00"/> ~ <c:out value="${exprnSchdVO.lunchEndHh}:00"/>)
                    </c:when>
                    <c:otherwise>
                        (점심시간 없음)
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th scope="row">요일별 체험시간</th>
            <td>
                <table class="w50p">
                    <thead>
                    <tr>
                        <th style="text-align: center;">회차</th>
                        <th style="text-align: center;">체험시간</th>
                        <th style="text-align: center;">월</th>
                        <th style="text-align: center;">화</th>
                        <th style="text-align: center;">수</th>
                        <th style="text-align: center;">목</th>
                        <th style="text-align: center;">금</th>
                        <th style="text-align: center;"><em class="em_b_blue">토</em></th>
                        <th style="text-align: center;"><em class="em_red">일</em></th>
                    </tr>
                    </thead>
                    <tbody class="text_center">
                    <c:forEach var="result" items="${exprnTmList}" varStatus="status">
                        <tr>
                            <td><c:out value="${status.count}"/>회차</td>
                            <td>
                                <c:out value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                            </td>
                            <td><c:if test="${result.monYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.tueYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.wedYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.thuYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.friYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.satYn == 'Y'}">Y</c:if>
                            <td><c:if test="${result.sunYn == 'Y'}">Y</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(exprnTmList) == 0}">
                        <tr><td colspan="9">회차가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </td>
        </tr>
        </c:if>

        <c:if test="${exprnSchdVO.schdMthd == 'DE'}">
        <tr>
            <th scope="row">체험일자</th>
            <td>
                <c:forEach var="result" items="${exprnDeList}" varStatus="status">
                    <c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    <c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th scope="row">체험시간</th>
            <td>
                <c:forEach var="result" items="${exprnTmList}" varStatus="status">
                    <div class="p-form-group w15p">
                        <c:out value="${status.count}"/>회차
                        <c:out value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                    </div>
                </c:forEach>
            </td>
        </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_t_20">
        <div class="col-12">
            <a href="./selectExprnList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
        </div>
        <div class="col-12 right">
            <a href="./updateExprnSchdView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small edit">일정 수정</a>
        </div>
    </div>

</div>

<script>

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }

</script>

</body>
</html>
