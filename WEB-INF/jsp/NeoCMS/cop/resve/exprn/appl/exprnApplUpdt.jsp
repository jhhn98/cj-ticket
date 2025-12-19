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
    <title>${menuInfo.cntntsNm} 수정</title>
</head>
<body>

<div class="p-wrap">

    <div class="card card--line margin_b_30">
        <h3>체험 정보</h3>
        <table class="p-table margin_b_20">
            <caption>체험 정보 - 제목, 기관명, 접수기간, 체험기간, 내용, 첨부파일 정보 제공</caption>
            <colgroup>
                <col class="w15p" />
                <col />
                <col class="w15p" />
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr class="p-table__subject">
                <th scope="row">체험명</th>
                <td colspan="3">
                    <span class="p-table__subject_text"><c:out value="${exprnVO.exprnNm}"/></span>
                </td>
            </tr>
            <tr>
                <th scope="row">운영기관</th>
                <td colspan="3">
                    <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">모집상태</th>
                <td><c:out value="${operSttusMap[exprnVO.operSttus]}"/></td>
                <th scope="row">신청/모집정원</th>
                <td colspan="3">
                </td>
            </tr>
            <tr>
                <th scope="row">접수기간</th>
                <td><c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/>
                    ~
                    <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
                </td>
                <th scope="row">체험기간</th>
                <td>
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    ~
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">선발방식</th>
                <td><c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/></td>
                <th scope="row">체험료 / 결제방식</th>
                <td>
                    <c:choose>
                        <c:when test="${exprnVO.exprnAmt > 0}">
                            <fmt:formatNumber value="${tsu:xssNumberFilter(exprnVO.exprnAmt)}" pattern="#,###"/> 원
                        </c:when>
                        <c:otherwise>
                            무료
                        </c:otherwise>
                    </c:choose>
                    /
                    <c:forEach var="result" items="${exprnVO.payMthdCdArr}" varStatus="status">
                        <c:out value="${payMthdMap[result]}"/>
                        <c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
            </tr>
            </tbody>
        </table>
    </div>

    <form:form modelAttribute="exprnApplVO" name="exprnApplVO" method="post" action="updateExprnAppl.do" onsubmit="return fn_updateExprnApplCheck(this)">
        <c:forEach var="result" items="${exprnApplSearchVO.paramsMap}">
            <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
        </c:forEach>
        <c:forEach var="result" items="${exprnApplSearchVO.paramsMapMng}">
            <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
        </c:forEach>
        <form:hidden path="exprnApplNo"/>

        <h3 class="col-12">신청자 정보</h3>

        <table class="p-table">
            <caption>신청자 정보 수정</caption>
            <colgroup>
                <col class="w10p">
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr>
                <th scope="row">신청자명</th>
                <td>
                    <c:out value="${exprnApplVO.applNm}"/>
                    <c:if test="${exprnApplVO.genderSe == 'M'}"> (남)</c:if>
                    <c:if test="${exprnApplVO.genderSe == 'F'}"> (여)</c:if>
                </td>
            </tr>
            <tr>
                <th scope="row">생년월일</th>
                <td>
                    <c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="mobileNo2">연락처 <span class="p-form__required--icon">필수</span></label></th>
                <td>
                    <div class="p-form-inline">
                        <select name="mobileNo1" id="mobileNo1" class="p-input p-input--auto" value="<c:out value="${exprnApplVO.mobileNo1}"/>">
                            <option value="010">010</option>
                        </select>
                        <span class="p-form__split">-</span>
                        <input type="text" name="mobileNo2" id="mobileNo2" class="p-input w5p" value="<c:out value="${exprnApplVO.mobileNo2}"/>" placeholder="" />
                        <span class="p-form__split">-</span>
                        <input type="text" name="mobileNo3" id="mobileNo3" class="p-input w5p" value="<c:out value="${exprnApplVO.mobileNo3}"/>" placeholder="" />
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="addrBtn">주소 <span class="p-form__required--icon">필수</span></label></th>
                <td>
                    <div class="p-form-group w10p">
                        <form:input path="zip" style="width:100px" class="p-input" placeholder="(우편번호)" readonly="true"/>
                        <span class="p-input__addon">
                            <button type="button" id="addrBtn" class="p-button primary" onclick="openDaumZipAddress();">주소검색</button>
                        </span>
                    </div>
                    <div class="p-form-group w25p">
                        <form:input path="addr" style="width:300px" class="p-input" placeholder="주소" readonly="true"/>
                    </div>
                    <div class="p-form-group w25p">
                        <form:input path="detailAddr" style="width:300px" class="p-input" placeholder="상세주소"/>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">개인 / 단체</th>
                <td>
                    <c:if test="${empty exprnApplVO.grpNm}">개인</c:if>
                    <c:if test="${!empty exprnApplVO.grpNm}"><c:out value="${exprnApplVO.grpNm}"/></c:if>
                </td>
            </tr>
            <tr>
                <th scope="row">신청인원</th>
                <td>
                    <c:out value="${exprnApplVO.totalCnt}"/> 명
                    <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
                        ( 세부인원 :
                        성인 <c:out value="${exprnApplVO.adltCnt}"/>명,
                        청소년 <c:out value="${exprnApplVO.teenCnt}"/>명,
                        초등학생 <c:out value="${exprnApplVO.elmntCnt}"/>명,
                        아동 <c:out value="${exprnApplVO.childCnt}"/>명,
                        영유아 <c:out value="${exprnApplVO.infantCnt}"/>명
                        )
                    </c:if>
                </td>
            </tr>
            <tr>
                <th scope="row">이메일</th>
                <td>
                    <div class="p-form-group w30p">
                        <input type="text" name="email1" id="email1" class="p-input p-input--auto" value="<c:out value="${exprnApplVO.email1}"/>" placeholder="">
                        <span class="p-form__split">@</span>
                        <input type="text" name="email2" id="email2" class="p-input p-input--auto" value="<c:out value="${exprnApplVO.email2}"/>" placeholder="">
                        <span class="p-form__split"> </span>
                        <select id="emailDomainSelect" class="p-input p-input--auto">
                            <option value="direct">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="kakao.com">kakao.com</option>
                        </select>
                    </div>
                </td>
            </tr>
            <%--<tr>
                <th scope="row">감면혜택</th>
                <td>
                </td>
            </tr>--%>
            </tbody>
        </table>

        <div class="h3">예약 정보</div>
        <table class="p-table">
            <caption>예약 정보 상세보기</caption>
            <colgroup>
                <col class="w10p">
                <col />
                <col class="w10p">
                <col />
                <col class="w10p">
                <col />
                <col class="w10p">
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr>
                <th scope="row">체험명</th>
                <td colspan="7">
                    <c:out value="${exprnVO.exprnNm}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">예약번호</th>
                <td colspan="7">
                    <c:out value="${exprnApplVO.exprnApplId}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">신청일시</th>
                <td colspan="7">
                    <c:out value="${tsu:toDateFormat(exprnApplVO.applDtMs, 'yyyyMMddHHmmssSS', 'yyyy-MM-dd HH:mm:ss:SS')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">체험일자</th>
                <td colspan="7">
                    <c:out value="${tsu:toDateFormat(exprnApplVO.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    <c:out value="${tsu:toDateFormat(exprnApplVO.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~
                    <c:out value="${tsu:toDateFormat(exprnApplVO.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">예약상태</th>
                <td colspan="3">
                    <select name="rsvSttusCd" id="rsvSttusCd" class="p-input p-input--auto">
                        <option value="">예약상태</option>
                        <c:forEach var="result" items="${rsvSttusList}">
                            <option value="<c:out value="${result.code}"/>"<c:if test="${result.code == exprnApplVO.rsvSttusCd}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                        </c:forEach>
                    </select>
                </td>
                <th scope="row">결제상태</th>
                <td colspan="3">
                    <select name="paySttusCd" id="paySttusCd" class="p-input p-input--auto">
                        <option value="">결제상태</option>
                        <c:forEach var="result" items="${paySttusList}">
                            <option value="<c:out value="${result.code}"/>"<c:if test="${result.code == exprnApplVO.paySttusCd}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th scope="row">신청완료(승인)일시</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.applCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
                <th scope="row">총결제금액</th>
                <td>
                    <fmt:formatNumber value="${exprnApplVO.totalPayAmt}" pattern="#,##0"/> 원
                </td>
                <th scope="row">결제방법</th>
                <td>
                    <c:out value="${payMthdMap[exprnApplVO.payMthdCd]}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">취소일시</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.canclClosDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <c:out value="${tsu:toDateFormat(exprnApplVO.cancelDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
                <th scope="row">감면금액</th>
                <td>
                    <%--TODOSDB: 감면코드 같이 표출--%>
                    <fmt:formatNumber value="${exprnApplVO.dscntAmt}" pattern="#,##0"/> 원
                </td>
                <th scope="row">체험료</th>
                <td>
                    <fmt:formatNumber value="${exprnApplVO.totalPayAmt}" pattern="#,##0"/> 원
                </td>
            </tr>
            <tr>
                <th scope="row">취소사유</th>
                <td colspan="3">
                    <pre><c:out value="${exprnApplVO.cancelReason}"/></pre>
                </td>
                <th scope="row">결제기한</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">환불요청일시</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.rfndReqDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
                <th scope="row">결제일시</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">환불계좌</th>
                <td colspan="3">
                    <pre><c:out value="${exprnApplVO.rfndAcctNo}"/></pre>
                </td>
                <th scope="row" rowspan="3">메모</th>
                <td colspan="3" rowspan="3">
                    <textarea name="memo" id="memo" class="p-input p-input--auto" cols="100" style=";height:100px;"><c:out value="${exprnApplVO.memo}"/></textarea>
                </td>
            </tr>
            <tr>
                <th scope="row">환불사유</th>
                <td colspan="3">
                        <c:out value="${exprnApplVO.rfndReason}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">환불처리일시</th>
                <td colspan="3">
                    <div class="p-form-group w20p">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        <%--<form:input path="payDeadlineDt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                        <span class="p-input__addon">
                            <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                <svg width="14" height="16" fill="#888" focusable="false">
                                    <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                </svg>
                            </button>
                        </span>
                        <span class="p-form__split"></span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="23">
                                <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                <form:option value="${hh}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>
                        <span class="p-form__split">:</span>
                        <form:select path="payDeadlineDt" class="p-input p-input--auto">
                            <c:forEach var="result" begin="0" end="59">
                                <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                <form:option value="${mm}"/>
                            </c:forEach>
                        </form:select>--%>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="row margin_t_20">
            <div class="col-12">
                <c:set var="applListUrl" value="./selectExprnApplList.do?"/>
                <c:if test="${isExprnList == 'Y'}">
                    <c:set var="applListUrl" value="./selectExprnApplListByExprn.do?"/>
                </c:if>
                <c:set var="applListParam" value="${exprnApplSearchVO.params}${exprnApplSearchVO.paramsMng}"/>
                <c:if test="${isExprnList == 'Y'}">
                    <c:set var="applListParam" value="${applListParam}&${exprnSearchVO.exprnParamsMng}&exprnNo=${exprnApplVO.exprnNo}"/>
                </c:if>
                <a href="<c:out value="${applListUrl}"/><c:out value="${applListParam}"/>" class="p-button cancel">목록 </a>
            </div>
            <div class="col-12 right">
                <input type="submit" class="p-button edit" value="수정">
            </div>
        </div>
    </form:form>

</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

    $(document).ready(function () {

        $('#emailDomainSelect').change(function () {
            if ($('#emailDomainSelect').val() == 'direct') {
                $('input[name=emailDomainSelect]').prop('readonly', false);
                $('input[name=email2]').val('');
            } else {
                $('input[name=email2]').prop('readonly', true);
                $('input[name=email2]').val($('#emailDomainSelect').val());
            }
        });
    });

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("input[name=zip]").val(data.zonecode);
                $("input[name=addr]").val(data.address);
                $("input[name=detailAddr]").focus();
            }
        }).open();
    }

    function fn_updateExprnApplCheck(form) {

        var regPhone = /^010-\d{4}-\d{4}$/;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

        if (!form.mobileNo1.value || !form.mobileNo2.value || !form.mobileNo3.value) {
            alert("연락처를 입력해주세요.");
            if (!form.mobileNo1.value) {
                form.mobileNo1.focus();
            } else if (!form.mobileNo2.value) {
                form.mobileNo2.focus();
            } else {
                form.mobileNo3.focus();
            }
            return false;
        } else {
            var mobileNo = form.mobileNo1.value + '-' + form.mobileNo2.value + '-' + form.mobileNo3.value;
            if (!regPhone.test(mobileNo)) {
                alert("연락처는 010-0000-0000 형식으로 입력해주세요.");
                form.mobileNo1.focus();
                return false;
            }
        }

        if (!form.zip.value || !form.addr.value) {
            alert("주소를 검색해주세요.");
            $('.addressSearchButton').focus();
            return false;
        }

        if (!form.detailAddr.value) {
            alert("상세주소를 입력해주세요.");
            form.detailAddr.focus();
            return false;
        }

        if ((form.email1.value && !form.email2.value) || (!form.email1.value && form.email2.value)) {
            alert("올바른 형식의 이메일을 입력해주세요.");
            form.email1.focus();
            return false;
        } else if (form.email1.value && form.email2.value) {
            var email = form.email1.value + '@' + form.email2.value;
            if (!regEmail.test(email)) {
                alert("올바른 형식의 이메일을 입력해주세요.");
                form.email1.focus();
                return false;
            }
        }

        if( !confirm("수정하시겠습니까?") ) {
            return false;
        }
        return true;
    }

</script>

</body>
</html>
