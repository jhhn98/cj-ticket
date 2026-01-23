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
    <title>${menuInfo.cntntsNm} > 체험 일정 수정</title>
</head>
<body>

<div class="p-wrap">

    <div>
        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
        <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
    </div>

    <table class="p-table">
        <caption>체험 일정 등록방법 선택</caption>
        <colgroup>
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">체험시간 등록방법 <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td>
                <div class="p-form-group w20p">
                    <%-- 체험 일정 등록방법 - PD:체험기간(규칙) / DE:일자별 선택(불규칙) --%>
                    <span class="p-form-radio">
                        <input type="radio" name="schdMthdRadio" id="schdMthd1" class="p-form-radio__input" value="PD"<c:if test="${exprnSchdVO.schdMthd == 'PD'}"> checked</c:if>>
                        <label for="schdMthd1" class="p-form-radio__label">체험기간(규칙 접수)</label>
                    </span>
                    <span class="p-form-radio">
                        <input type="radio" name="schdMthdRadio" id="schdMthd2" class="p-form-radio__input" value="DE"<c:if test="${exprnSchdVO.schdMthd == 'DE'}"> checked</c:if>>
                        <label for="schdMthd2" class="p-form-radio__label">일자별 선택(불규칙 접수)</label>
                    </span>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <form:form modelAttribute="exprnSchdVO" id="exprnSchdPdVO" name="exprnSchdPdVO" method="post" action="updateExprnSchdPd.do" onsubmit="return fn_updateExprnSchdPdCheck(this)" style="display:none;">
        <fieldset>
            <legend>체험 일정 수정</legend>
            <table class="p-table" id="exprnSchdPdTable">
                <caption>체험 일정 수정 - 체험기간(규칙 접수)</caption>
                <c:forEach var="result" items="${exprnSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <c:forEach var="result" items="${exprnSearchVO.paramsMapMng}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <input type="hidden" name="exprnNo" id="exprnNo" value="<c:out value="${exprnSchdVO.exprnNo}"/>"/>
                <input type="hidden" name="schdMthd" id="schdMthd" value="PD"/>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row">체험기간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <c:forEach var="result" items="${exprnDeListByPd}" varStatus="status">
                                <c:if test="${status.first}">
                                    <input type="text" name="exprnBgnDeFmt" value="<c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" />
                                    <span class="p-input__addon">
                                        <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnSchdPdVO.exprnBgnDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                            <svg width="14" height="16" fill="#888" focusable="false">
                                                <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                            </svg>
                                        </button>
                                    </span>
                                </c:if>
                                <c:if test="${status.last}">
                                    <span class="p-form__split">~</span>
                                    <input type="text" name="exprnEndDeFmt" value="<c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" />
                                    <span class="p-input__addon">
                                        <button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.exprnSchdPdVO.exprnEndDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                            <svg width="14" height="16" fill="#888" focusable="false">
                                                <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                            </svg>
                                        </button>
                                    </span>
                                </c:if>
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(exprnDeListByPd) == 0}">
                            <div class="p-form-group w20p">
                                <input type="text" name="exprnBgnDeFmt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" />
                                <span class="p-input__addon">
                                    <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnSchdPdVO.exprnBgnDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                        <svg width="14" height="16" fill="#888" focusable="false">
                                            <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                        </svg>
                                    </button>
                                </span>
                                <span class="p-form__split">~</span>
                                <input type="text" name="exprnEndDeFmt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" />
                                <span class="p-input__addon">
                                    <button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.exprnSchdPdVO.exprnEndDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                        <svg width="14" height="16" fill="#888" focusable="false">
                                            <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                        </svg>
                                    </button>
                                </span>
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row">기준시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w15p">
                            <form:select path="unitHour" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="i" begin="0" end="12">
                                    <form:option value="${i}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시간 </span>
                            <form:select path="unitMin" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="i" begin="0" end="59" step="30">
                                    <fmt:formatNumber var="mm" value="${i}" pattern="00"/>
                                    <form:option value="${i}" label="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">분 단위로 운영</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">기본체험시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <form:select path="baseBgnHh" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시 </span>
                            <form:select path="baseBgnMm" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="result" begin="0" end="59" step="10">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">분 </span>
                            <span class="p-form__split">~</span>
                            <form:select path="baseEndHh" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시 </span>
                            <form:select path="baseEndMm" class="p-input p-input--auto exprnTmPdInfo">
                                <c:forEach var="result" begin="0" end="59" step="10">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">분</span>
                            <span class="p-form__split"></span>
                            <span class="p-form__split">( </span>
                            <span class="p-form-checkbox p-form-checkbox--single">
                                <input type="checkbox" name="lunchYn" id="lunchYn" class="p-form-checkbox__input exprnTmPdInfo" value="Y"<c:if test="${!empty exprnSchdVO.lunchBgnHh && !empty exprnSchdVO.lunchEndHh}"> checked</c:if>>
                                <label for="lunchYn" class="p-form-checkbox__label">점심시간 사용여부</label>
                            </span>
                            <span class="p-form__split">점심시간</span>
                            <select name="lunchBgnHh" id="lunchBgnHh" class="p-input p-input--auto exprnTmPdInfo"<c:if test="${empty exprnSchdVO.lunchBgnHh}"> disabled</c:if>>
                                <option value="" label="선택"/>
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <option value="${hh}" label="${hh}"<c:if test="${exprnSchdVO.lunchBgnHh == hh}"> selected</c:if>/>
                                </c:forEach>
                            </select>
                            <span class="p-form__split">시</span>
                            <span class="p-form__split">~</span>
                            <select name="lunchEndHh" id="lunchEndHh" class="p-input p-input--auto exprnTmPdInfo"<c:if test="${empty exprnSchdVO.lunchEndHh}"> disabled</c:if>>
                                <option value="" label="선택"/>
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <option value="${hh}" label="${hh}"<c:if test="${exprnSchdVO.lunchEndHh == hh}"> selected</c:if>/>
                                </c:forEach>
                            </select>
                            <span class="p-form__split">시</span>
                            <span class="p-form__split">)</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">요일별 체험시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w15p">
                            <button type="button" class="p-button info" id="setTimeBtn" onclick="fn_setExprnTimeTalbe()">요일별 체험시간 설정</button>
                            <c:if test="${fn:length(exprnTmListByPd) > 0}">
                                <span class="p-form__split"></span>
                                <button type="button" class="p-button darken" id="resetTimeBtn" onclick="fn_resetExprnTimeTalbe()">초기화</button>
                            </c:if>
                        </div>
                        <div class="p-form-group w20p">
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">기준시간/기본체험시간을 선택 후 '요일별 체험시간 설정' 버튼을 클릭하시면 시간이 계산되어 표출됩니다.</em>
                            </span>
                            <c:if test="${fn:length(exprnTmListByPd) > 0}">
                                <br/>
                                <span class="p-table__content padding_l_10">
                                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                    <em class="em_black">'초기화'버튼을 클릭하시면  기준시간/기본체험시간/요일별 체험시간이 초기 상태로 되돌아갑니다.</em>
                                </span>
                            </c:if>
                        </div>
                        <table class="w55p">
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
                            <tbody class="text_center" id="exprnTimeTable">
                            <tr id="dayAllCheck" style="display:none;">
                                <td></td>
                                <td></td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="monAll" class="p-form-checkbox__input dayAll" value="mon" checked/>
                                        <label for="monAll" class="p-form-checkbox__label">월요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="tueAll" class="p-form-checkbox__input dayAll" value="tue" checked/>
                                        <label for="tueAll" class="p-form-checkbox__label">화요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="wedAll" class="p-form-checkbox__input dayAll" value="wed" checked/>
                                        <label for="wedAll" class="p-form-checkbox__label">수요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="thuAll" class="p-form-checkbox__input dayAll" value="thu" checked/>
                                        <label for="thuAll" class="p-form-checkbox__label">목요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="friAll" class="p-form-checkbox__input dayAll" value="fri" checked/>
                                        <label for="friAll" class="p-form-checkbox__label">금요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                    <span class="p-form-checkbox p-form-checkbox--single">
                                        <input type="checkbox" id="satAll" class="p-form-checkbox__input dayAll" value="sat" checked/>
                                        <label for="satAll" class="p-form-checkbox__label">토요일 전체선택</label>
                                    </span>
                                </td>
                                <td>
                                   <span class="p-form-checkbox p-form-checkbox--single">
                                       <input type="checkbox" id="sunAll" class="p-form-checkbox__input dayAll" value="sun" checked/>
                                       <label for="sunAll" class="p-form-checkbox__label">일요일 전체선택</label>
                                   </span>
                                </td>
                            </tr>
                            <c:forEach var="result" items="${exprnTmListByPd}" varStatus="status">
                                <c:set var="exprnTmList" value="exprnTmList[${status.index}]"/>
                                <c:set var="exprnBgnHh" value="${exprnTmList}.exprnBgnHh"/>
                                <c:set var="exprnBgnMm" value="${exprnTmList}.exprnBgnMm"/>
                                <c:set var="exprnEndHh" value="${exprnTmList}.exprnEndHh"/>
                                <c:set var="exprnEndMm" value="${exprnTmList}.exprnEndMm"/>
                                <c:set var="monYn"      value="${exprnTmList}.monYn"/>
                                <c:set var="tueYn"      value="${exprnTmList}.tueYn"/>
                                <c:set var="wedYn"      value="${exprnTmList}.wedYn"/>
                                <c:set var="thuYn"      value="${exprnTmList}.thuYn"/>
                                <c:set var="friYn"      value="${exprnTmList}.friYn"/>
                                <c:set var="satYn"      value="${exprnTmList}.satYn"/>
                                <c:set var="sunYn"      value="${exprnTmList}.sunYn"/>
                                <tr>
                                    <td><c:out value="${status.count}"/>회차</td>
                                    <td>
                                        <div class="p-form-group">
                                            <select name="<c:out value="${exprnBgnHh}"/>" id="<c:out value="${exprnBgnHh}"/>" class="p-input p-input--auto exprnTm exprnBgnHh" disabled>
                                                <c:forEach var="i" begin="0" end="23">
                                                    <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                                    <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.exprnBgnHh == hh}"> selected</c:if> />
                                                </c:forEach>
                                            </select>
                                            <span class="p-form__split">:</span>
                                            <select name="<c:out value="${exprnBgnMm}"/>" id="<c:out value="${exprnBgnMm}"/>" class="p-input p-input--auto exprnTm exprnBgnMm" disabled>
                                                <c:forEach var="i" begin="0" end="59" step="10">
                                                    <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                                    <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.exprnBgnMm == mm}"> selected</c:if>/>
                                                </c:forEach>
                                            </select>
                                            <span class="p-form__split">~</span>
                                            <select name="<c:out value="${exprnEndHh}"/>" id="<c:out value="${exprnEndHh}"/>" class="p-input p-input--auto exprnTm exprnEndHh" disabled>
                                                <c:forEach var="i" begin="0" end="23">
                                                    <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                                    <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.exprnEndHh == hh}"> selected</c:if>/>
                                                </c:forEach>
                                            </select>
                                            <span class="p-form__split">:</span>
                                            <select name="<c:out value="${exprnEndMm}"/>" id="<c:out value="${exprnEndMm}"/>" class="p-input p-input--auto exprnTm exprnEndMm" disabled>
                                                <c:forEach var="i" begin="0" end="59" step="10">
                                                    <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                                    <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.exprnEndMm == mm}"> selected</c:if>/>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${monYn}"/>" id="<c:out value="${monYn}"/>" class="p-form-checkbox__input useYn mon" value="Y"<c:if test="${result.monYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${monYn}"/>" class="p-form-checkbox__label"><c:out value="${monYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${tueYn}"/>" id="<c:out value="${tueYn}"/>" class="p-form-checkbox__input useYn tue" value="Y"<c:if test="${result.tueYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${tueYn}"/>" class="p-form-checkbox__label"><c:out value="${tueYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${wedYn}"/>" id="<c:out value="${wedYn}"/>" class="p-form-checkbox__input useYn wed" value="Y"<c:if test="${result.wedYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${wedYn}"/>" class="p-form-checkbox__label"><c:out value="${wedYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${thuYn}"/>" id="<c:out value="${thuYn}"/>" class="p-form-checkbox__input useYn thu" value="Y"<c:if test="${result.thuYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${thuYn}"/>" class="p-form-checkbox__label"><c:out value="${thuYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${friYn}"/>" id="<c:out value="${friYn}"/>" class="p-form-checkbox__input useYn fri" value="Y"<c:if test="${result.friYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${friYn}"/>" class="p-form-checkbox__label"><c:out value="${friYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${satYn}"/>" id="<c:out value="${satYn}"/>" class="p-form-checkbox__input useYn sat" value="Y"<c:if test="${result.satYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${satYn}"/>" class="p-form-checkbox__label"><c:out value="${satYn}"/></label>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="p-form-checkbox p-form-checkbox--single">
                                            <input type="checkbox" name="<c:out value="${sunYn}"/>" id="<c:out value="${sunYn}"/>" class="p-form-checkbox__input useYn sun" value="Y"<c:if test="${result.sunYn == 'Y'}"> checked</c:if>>
                                            <label for="<c:out value="${sunYn}"/>" class="p-form-checkbox__label"><c:out value="${sunYn}"/></label>
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(exprnTmListByPd) == 0}">
                                <tr><td colspan="9">회차가 없습니다.</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="row margin_t_20">
                <div class="col-12">
                    <a href="./selectExprnList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <c:choose>
                        <c:when test="${exprnSchdVO.resveCnt == 0}">
                            <input type="submit" class="p-button edit" value="수정">
                        </c:when>
                        <c:otherwise>
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">신청이력이 1건 이상 있는 경우 일정 수정이 불가합니다.</em>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </fieldset>
    </form:form>

    <form:form modelAttribute="exprnSchdVO" id="exprnSchdDeVO" name="exprnSchdDeVO" method="post" action="updateExprnSchdDe.do" onsubmit="return fn_updateExprnSchdDeCheck(this)" style="display:none;">
        <fieldset>
            <legend>체험 일정 수정</legend>
            <table class="p-table" id=exprnSchdDeTable">
                <caption>체험 일정 수정 - 일자별선택(불규칙 접수)</caption>
                <c:forEach var="result" items="${exprnSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <c:forEach var="result" items="${exprnSearchVO.paramsMapMng}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <input type="hidden" name="exprnNo" id="exprnNo" value="<c:out value="${exprnSchdVO.exprnNo}"/>"/>
                <input type="hidden" name="schdMthd" id="schdMthd" value="DE"/>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row">체험일자 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w10p">
                            <input type="text" id="exprnDeAdd" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled/>
                            <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnSchdDeVO.exprnDeAdd);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                            <span class="p-form__split"></span>
                            <button type="button" class="p-button" id="exprnDeAddBtn">추가</button>
                        </div>
                        <div class="p-form-group w20p" id="exprnDeWarning">
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">체험일자를 지정해주세요.</em>
                            </span>
                        </div>
                        <div id="exprnDeList">
                            <c:forEach var="result" items="${exprnDeListByDe}" varStatus="status">
                                <div class="p-form-group w5p" id="exprnDe<c:out value="${result.exprnDe}"/>">
                                    <input type="hidden" name="exprnDeArr" id="exprnDeArr<c:out value="${result.exprnDe}"/>" value="<c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" />
                                    <span class="p-input p-input--auto"><c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/></span>
                                    <span class="p-input__addon">
                                        <button type="button" class="p-button p-button--icon delete exprnDeDelBtn" data-delete-id="<c:out value="${result.exprnDe}"/>">삭제</button>
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">체험시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div id="exprnTmList">
                            <c:forEach var="result" items="${exprnTmListByDe}" varStatus="status">
                                <c:set var="exprnTmList" value="exprnTmList[${status.index}]"/>
                                <c:set var="useYn"      value="${exprnTmList}.useYn"/>
                                <c:set var="exprnBgnHh" value="${exprnTmList}.exprnBgnHh"/>
                                <c:set var="exprnBgnMm" value="${exprnTmList}.exprnBgnMm"/>
                                <c:set var="exprnEndHh" value="${exprnTmList}.exprnEndHh"/>
                                <c:set var="exprnEndMm" value="${exprnTmList}.exprnEndMm"/>
                                <div class="p-form-group w15p" id="exprnTm${status.index+1}">
                                    <span class="p-form-checkbox">
                                        <input type="checkbox" name="<c:out value="${useYn}"/>" id="useYn<c:out value="${status.index+1}"/>" class="p-form-checkbox__input useYn" value="Y" checked data-time-no="exprnTm<c:out value="${status.index+1}"/>">
                                        <label for="useYn<c:out value="${status.index+1}"/>" class="p-form-checkbox__label"><c:out value="${status.index+1}"/>회차</label>
                                    </span>
                                    <span class="p-form__split"></span>
                                    <select name="<c:out value="${exprnBgnHh}"/>" id="<c:out value="${exprnBgnHh}"/>" class="p-input p-input--auto exprnTm exprnBgnHh" >
                                        <c:forEach var="i" begin="0" end="23">
                                            <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.exprnBgnHh == hh}"> selected</c:if> />
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${exprnBgnMm}"/>" id="<c:out value="${exprnBgnMm}"/>" class="p-input p-input--auto exprnTm exprnBgnMm" >
                                        <c:forEach var="i" begin="0" end="59" step="5">
                                            <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.exprnBgnMm == mm}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분 </span>
                                    <span class="p-form__split">~</span>
                                    <select name="<c:out value="${exprnEndHh}"/>" id="<c:out value="${exprnEndHh}"/>" class="p-input p-input--auto exprnTm exprnEndHh" >
                                        <c:forEach var="i" begin="0" end="23">
                                            <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.exprnEndHh == hh}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${exprnEndMm}"/>" id="<c:out value="${exprnEndMm}"/>" class="p-input p-input--auto exprnTm exprnEndMm" >
                                        <c:forEach var="i" begin="0" end="59" step="5">
                                            <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.exprnEndMm == mm}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분</span>
                                </div>
                            </c:forEach>
                            <c:forEach var="i" begin="${fn:length(exprnTmListByDe)+1}" end="6">
                                <c:set var="exprnTmList" value="exprnTmList[${i-1}]"/>
                                <c:set var="useYn"      value="${exprnTmList}.useYn"/>
                                <c:set var="exprnBgnHh" value="${exprnTmList}.exprnBgnHh"/>
                                <c:set var="exprnBgnMm" value="${exprnTmList}.exprnBgnMm"/>
                                <c:set var="exprnEndHh" value="${exprnTmList}.exprnEndHh"/>
                                <c:set var="exprnEndMm" value="${exprnTmList}.exprnEndMm"/>
                                <div class="p-form-group w15p" id="exprnTmNew<c:out value="${i}"/>">
                                    <span class="p-form-checkbox">
                                        <input type="checkbox" name="<c:out value="${useYn}"/>" id="useYn<c:out value="${i}"/>" class="p-form-checkbox__input useYn" value="Y" data-time-no="exprnTmNew<c:out value="${i}"/>">
                                        <label for="useYn<c:out value="${i}"/>" class="p-form-checkbox__label"><c:out value="${i}"/>회차</label>
                                    </span>
                                    <span class="p-form__split"></span>
                                    <select name="<c:out value="${exprnBgnHh}"/>" id="<c:out value="${exprnBgnHh}"/>" class="p-input p-input--auto exprnTm exprnBgnHh" disabled>
                                        <c:forEach var="result" begin="0" end="23">
                                            <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${exprnBgnMm}"/>" id="<c:out value="${exprnBgnMm}"/>" class="p-input p-input--auto exprnTm exprnBgnMm" disabled>
                                        <c:forEach var="result" begin="0" end="59" step="10">
                                            <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분 </span>
                                    <span class="p-form__split">~</span>
                                    <select name="<c:out value="${exprnEndHh}"/>" id="<c:out value="${exprnEndHh}"/>" class="p-input p-input--auto exprnTm exprnEndHh" disabled>
                                        <c:forEach var="result" begin="0" end="23">
                                            <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${exprnEndMm}"/>" id="<c:out value="${exprnEndMm}"/>" class="p-input p-input--auto exprnTm exprnEndMm" disabled>
                                        <c:forEach var="result" begin="0" end="59" step="10">
                                            <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분</span>
                                </div>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="row margin_t_20">
                <div class="col-12">
                    <a href="./selectExprnList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <c:choose>
                        <c:when test="${exprnSchdVO.resveCnt == 0}">
                            <input type="submit" class="p-button edit" value="수정">
                        </c:when>
                        <c:otherwise>
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">신청이력이 1건 이상 있는 경우 일정 수정이 불가합니다.</em>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </fieldset>
    </form:form>

</div>

<script>
    $(document).ready(function() {

    // 등록방법에 따라 초기화면 set

    // 등록방법 PD 초기화면 set
    <c:if test="${exprnSchdVO.schdMthd == 'PD'}">

        // PD 화면 보임
        $('#exprnSchdPdVO').show();

        // PD dayAll checkbox
        <c:if test="${fn:length(exprnTmListByPd) > 0}">
            $('#exprnSchdPdVO').find('#dayAllCheck').show();
            var weekArr = [ 'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat' ];
            for (let i = 0; i < weekArr.length; i++) {
                var weekday = weekArr[i];
                if($('#exprnSchdPdVO .'+weekday+':checked').length == $('.'+weekday).length) {
                    $('#exprnSchdPdVO #'+weekday+'All').prop('checked', true);
                } else {
                    $('#exprnSchdPdVO #'+weekday+'All').prop('checked', false);
                }
            }
        </c:if>
    </c:if>

    // 등록방법 DE 초기화면 set
    <c:if test="${exprnSchdVO.schdMthd == 'DE'}">

        // DE 화면 보임
        $('#exprnSchdDeVO').show();

        if($('#exprnSchdDeVO #exprnDeList div').length > 0) {
            // 체험일자 있으면 등록 안내 문구 숨김
            $('#exprnSchdDeVO #exprnDeWarning').hide();
            $('#exprnSchdDeVO #exprnDeList').show();
        } else {
            // 체험일자 없으면 등록 안내 문구 표출('체험일자를 지정해주세요.')
            $('#exprnSchdDeVO #exprnDeWarning').show();
            $('#exprnSchdDeVO #exprnDeList').hide();
        }

        // 시간 등록되어있는 회차만 disalbed false
        $('#exprnSchdDeVO input.useYn:not(:checked)').closest('div').find('input:not(.useYn), select').prop('disabled', true);
    </c:if>

        // PD 점심시간 체크여부에 따른 disabled 설정
        $('#exprnSchdPdVO input[name=lunchYn]').on("change", function () {
            if ($('input[name=lunchYn]:checked').length > 0) {
                $('select[name=lunchBgnHh]').prop('disabled', false);
                $('select[name=lunchEndHh]').prop('disabled', false);
            } else {
                $('select[name=lunchBgnHh]').val('');
                $('select[name=lunchEndHh]').val('');
                $('select[name=lunchBgnHh]').prop('disabled', true);
                $('select[name=lunchEndHh]').prop('disabled', true);
            }
        });
    })

    // 등록방법 선택(라디오버튼)에 따른 화면 set
    $(document).on("change", 'input[name=schdMthdRadio]', function () {

        // 등록방법 PD 선택
        if ($(this).val() == 'PD') {

            // DE 화면 숨김
            $('#exprnSchdDeVO').hide();

            // PD 화면 보임
            $('#exprnSchdPdVO').show();
            if($('#exprnSchdPdVO #exprnTimeTable').find('input.useYn').length > 0) {
                $('#exprnSchdPdVO #dayAllCheck').show();
            }

            // PD 점심시간 여부에 따른 select disabled true
            if ($('#exprnSchdPdVO').find('input[name=lunchYn]:checked').length == 0) {
                $('#exprnSchdPdVO').find('select[name=lunchBgnHh]').prop('disabled', true);
                $('#exprnSchdPdVO').find('select[name=lunchEndHh]').prop('disabled', true);
            }
        }

        // 등록방법 DE 선택
        else if ($(this).val() == 'DE') {

            // PD 화면 숨김
            $('#exprnSchdPdVO').hide();
            $('#exprnSchdPdVO #dayAllCheck').hide();

            // DE 화면 보임
            $('#exprnSchdDeVO').show();
            $('#exprnSchdDeVO input.useYn:not(:checked)').closest('div').find('input:not(.useYn), select').prop('disabled', true);
        }

        // 등록방법 null이면 모두 숨김
        else {
            $('.exprnSchdPdVO').hide();
            $('.exprnSchdDeVO').hide();
        }
    });

    // PD 기준시간/기본정보/점심시간 변동시 회차 목록 삭제
    $(document).on("change", '#exprnSchdPdVO .exprnTmPdInfo', function () {
        $('#exprnSchdPdVO #dayAllCheck').hide();
        $("#exprnSchdPdVO #exprnTimeTable").find("tr:not(:first)").remove();
        $("#exprnSchdPdVO #exprnTimeTable").append(`<tr><td colspan="9">회차가 없습니다.</td></tr>`);
    });

    // PD 회차 목록에서 해당 요일에 해당하는 회차 전체선택
    $(document).on("change", '#exprnSchdPdVO .dayAll', function () {
        var checkVal = $(this).val();

        if ($(this).is(':checked')) {
            $('.'+checkVal).prop('checked', true);
        } else {
            $('.'+checkVal).prop('checked', false);
        }
    });

    // PD 회차 목록에서 각 회차 checkbox 선택 여부에 따라 전체선택 checkbox 변경
    $(document).on("change", '#exprnSchdPdVO #exprnTimeTable .useYn', function () {
        var checkVal = "";

        if ($(this).hasClass('mon')) {
            checkVal = 'mon';
        }
        if ($(this).hasClass('tue')) {
            checkVal = 'tue';
        }
        if ($(this).hasClass('wed')) {
            checkVal = 'wed';
        }
        if ($(this).hasClass('thu')) {
            checkVal = 'thu';
        }
        if ($(this).hasClass('fri')) {
            checkVal = 'fri';
        }
        if ($(this).hasClass('sat')) {
            checkVal = 'sat';
        }
        if ($(this).hasClass('sun')) {
            checkVal = 'sun';
        }

        if ($(this).is(':checked')) {
            if($('#exprnSchdPdVO .'+checkVal+':checked').length == $('.'+checkVal).length) {
                $('#exprnSchdPdVO #'+checkVal+'All').prop('checked', true);
            }
        } else {
            $('#exprnSchdPdVO #'+checkVal+'All').prop('checked', false);
        }
    });

    // DE 회차 목록에서 각 회차 checkbox 선택 여부에 따라 해당 회차 입력칸 disabled 변경
    $(document).on("change", '#exprnSchdDeVO #exprnTmList .useYn', function () {
        var checkVal = $(this).data('timeNo');

        if ($(this).is(':checked')) {
            $('#exprnSchdDeVO #exprnTmList #'+checkVal).find('.exprnTm').prop('disabled', false);
        } else {
            $('#exprnSchdDeVO #exprnTmList #'+checkVal).find('.exprnTm').prop('disabled', true).prop('selectedIndex', 0);
        }
    });

    // PD 회차 목록 생성
    function fn_setExprnTimeTalbe() {

        var form = document.getElementById("exprnSchdPdVO");

        // PD 기준시간/기본시간/점심시간 유효성 검사
        if(!fn_timeTableInfoCheck(form)) {
            return;
        }

        // PD 기준시간/기본시간에 따른 회차 목록 불러오기
        $.ajax({
            cache    : false,
            type     : "GET",
            url      : "./setExprnTimeAjax.do",
            dataType : 'json',
            data     : {
                unitHour:  $('#exprnSchdPdVO #unitHour').val(),
                unitMin:   $('#exprnSchdPdVO #unitMin').val(),
                baseBgnHh: $('#exprnSchdPdVO #baseBgnHh').val(),
                baseBgnMm: $('#exprnSchdPdVO #baseBgnMm').val(),
                baseEndHh: $('#exprnSchdPdVO #baseEndHh').val(),
                baseEndMm: $('#exprnSchdPdVO #baseEndMm').val(),
                lunchBgnHh: $('#exprnSchdPdVO #lunchBgnHh').val(),
                lunchEndHh: $('#exprnSchdPdVO #lunchEndHh').val()
            },
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('요일별 체험시간 조회 중 오류가 발생했습니다.');
                }
            },
            success  : function (result) {
                fn_renderTimeTable(result);
            }
        });
    }

    // PD 초기화 버튼 클릭시 기존에 등록된 회차정보/목록 불러오기
    function fn_resetExprnTimeTalbe() {

        $.ajax({
            cache    : false,
            type     : "GET",
            url      : "./resetExprnTimeAjax.do",
            dataType : 'json',
            data     : {
                exprnNo :  $('#exprnNo').val()
            },
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('초기화 중 오류가 발생했습니다.');
                }
            },
            success  : function (result) {
                var exprnSchdVO = result.exprnSchdVO;
                $('#exprnSchdPdVO #unitHour').val(exprnSchdVO.unitHour);
                $('#exprnSchdPdVO #unitMin').val(exprnSchdVO.unitMin);
                $('#exprnSchdPdVO #baseBgnHh').val(exprnSchdVO.baseBgnHh);
                $('#exprnSchdPdVO #baseBgnMm').val(exprnSchdVO.baseBgnMm);
                $('#exprnSchdPdVO #baseEndHh').val(exprnSchdVO.baseEndHh);
                $('#exprnSchdPdVO #baseEndMm').val(exprnSchdVO.baseEndMm);
                $('#exprnSchdPdVO #lunchBgnHh').val(exprnSchdVO.lunchBgnHh);
                $('#exprnSchdPdVO #lunchEndHh').val(exprnSchdVO.lunchEndHh);
                fn_renderTimeTable(result.exprnTmList);
            }
        });
    }

    // PD 불러온 회차 목록으로 timeTable 생성
    function fn_renderTimeTable(exprnTmList) {

        const $tbody = $("#exprnSchdPdVO #exprnTimeTable");
        if (!exprnTmList || exprnTmList.length === 0) {
            $('#exprnSchdPdVO #dayAllCheck').hide();
            $tbody.find("tr:not(:first)").remove();
            $tbody.append(`<tr><td colspan="9">회차가 없습니다.</td></tr>`);
            return;
        }

        var html = '';

        for (var i=0; i<exprnTmList.length; i++) {
            var row = exprnTmList[i];
            var name = 'exprnTmList['+i+']';

            html += '<tr class="exprnTmList">';
            html += '<td>'+ (i+1) +'회차</td>';
            html += '<td>';
            html += '<div class="p-form-group">';
            html += createHhSelect(row.exprnBgnHh, name + '.exprnBgnHh', name + '.exprnBgnHh');
            html += '<span class="p-form__split">:</span>'
            html += createMmSelect(row.exprnBgnMm, name + '.exprnBgnMm', name + '.exprnBgnMm');
            html += '<span class="p-form__split">~</span>'
            html += createHhSelect(row.exprnEndHh, name + '.exprnEndHh', name + '.exprnEndHh');
            html += '<span class="p-form__split">:</span>'
            html += createMmSelect(row.exprnEndMm, name + '.exprnEndMm', name + '.exprnEndMm');
            html += '</div>';
            html += '</td>';

            html += tdTimeList(name, row.monYn, '2');
            html += tdTimeList(name, row.tueYn, '3');
            html += tdTimeList(name, row.wedYn, '4');
            html += tdTimeList(name, row.thuYn, '5');
            html += tdTimeList(name, row.friYn, '6');
            html += tdTimeList(name, row.satYn, '7');
            html += tdTimeList(name, row.sunYn, '1');

            html += '</tr>';
        }

        $tbody.find("tr:not(:first)").remove();
        $tbody.append(html);

        $('#exprnSchdPdVO #dayAllCheck').show();
        var weekArr = [ 'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat' ];
        for (let i = 0; i < weekArr.length; i++) {
            var weekday = weekArr[i];
            if($('#exprnSchdPdVO .'+weekday+':checked').length == $('.'+weekday).length) {
                $('#exprnSchdPdVO #'+weekday+'All').prop('checked', true);
            } else {
                $('#exprnSchdPdVO #'+weekday+'All').prop('checked', false);
            }
        }

    }

    // PD 불러온 회차 목록으로 회차별 시간(시) select box 생성
    function createHhSelect(hhVal, selectId, selectNm) {
        var html = "";

        // ----- 시(select) 생성 -----
        html += '<select name="' + selectNm + '" id="' + selectId + '" class="p-input p-input--auto">';
        html += '<option value="">시</option>';

        for (let h = 0; h < 24; h++) {
            const val = h.toString().padStart(2, '0');
            const selected = (hhVal === val) ? ' selected' : '';
            html += '<option value="' + val + '"' + selected + '>' + val + '</option>';
        }
        html += '</select>';

        return html;
    }

    // PD 불러온 회차 목록으로 회차별 시간(분) select box 생성
    function createMmSelect(mmVal, selectId, selectNm) {
        var html = "";

        // ----- 분(select) 생성 -----
        html += '<select name="' + selectNm + '" id="' + selectId + '" class="p-input p-input--auto">';
        html += '<option value="">분</option>';

        for (let m = 0; m < 60; m += 5) {
            const val = m.toString().padStart(2, '0');
            const selected = (mmVal === val) ? ' selected' : '';
            html += '<option value="' + val + '"' + selected + '>' + val + '</option>';
        }
        html += '</select>';

        return html;
    }

    // PD 불러온 회차 목록으로 회차별 요일 사용여부 체크박스 생성
    function tdTimeList(name, useYn, weekday) {
        var weekMap = { '1':'sun', '2':'mon', '3':'tue', '4':'wed', '5':'thu', '6':'fri', '7':'sat' };
        var yoil = weekMap[weekday];
        var yoilName = name+'.'+yoil;

        var isChecked = '';
        if (useYn == 'Y') {
            isChecked = ' checked';
        }

        var html = '<td>'
            + ' <span class="p-form-checkbox p-form-checkbox--single">'
            + ' <input type="checkbox" '
            + '        name="'+ yoilName +'Yn" '
            + '        id="'+ yoilName +'Yn" '
            + '        class="p-form-checkbox__input useYn '+yoil+'" '
            + '        value="Y"' + isChecked
            + ' />'
            + ' <label for="'+ yoilName +'Yn" class="p-form-checkbox__label">'+ yoilName +'Yn</label>'
            + ' </span>'
            + '</td>';

        return html;
    }

    // DE 체험일자 추가 : exprnDeAddBtn 클릭 이벤트
    $(document).on("click", '#exprnSchdDeVO #exprnDeAddBtn', function () {
        var exprnDe = $('#exprnSchdDeVO #exprnDeAdd');
        if(!exprnDe.val()) {
            alert("추가하실 날짜를 선택해주세요.");
            exprnDe.focus();
            return false;
        }
        if(!fn_exprnDeCheck(exprnDe)) {
            return false;
        }
        if(!fn_exprnDeDuplCheck(exprnDe)){
            return false;
        }
        renderDeList(exprnDe);
        $('#exprnSchdDeVO #exprnDeWarning').hide();
        $('#exprnSchdDeVO #exprnDeList').show();
        exprnDe.val("");
    });

    // DE 체험일자 중복확인
    function fn_exprnDeDuplCheck(exprnDe) {
        var exprnDeVal = exprnDe.val();
        var id = exprnDeVal.replaceAll('-', '');
        if($('#exprnSchdDeVO #exprnDeArr'+id).length > 0) {
            alert("이미 추가된 날짜입니다.");
            exprnDe.val("");
            exprnDe.focus();
            return false;
        }
        return true;
    }

    // DE 체험일자 추가 시 html 수정
    function renderDeList(exprnDe) {
        var exprnDeVal = exprnDe.val();
        var id = exprnDeVal.replaceAll('-', '');
        var html = '<div class="p-form-group w5p" id="exprnDe'+id+'">'
                + '     <input type="hidden" name="exprnDeArr" id="exprnDeArr'+id+'" value="'+exprnDeVal+'" />'
                + '     <span class="p-input p-input--auto">'+exprnDeVal+'</span>'
                + '     <span class="p-input__addon">'
                + '         <button type="button" class="p-button p-button--icon delete exprnDeDelBtn" data-delete-id="'+id+'">삭제</button>'
                + '     </span>'
                + '</div>'

        $("#exprnSchdDeVO #exprnDeList").append(html);
    }

    // DE 체험일자 삭제 : exprnDeDelBtn 클릭 이벤트
    $(document).on("click", '#exprnSchdDeVO .exprnDeDelBtn', function () {
        var deleteId = $(this).data('deleteId');
        $('#exprnSchdDeVO #exprnDe'+deleteId).remove();

        if($('#exprnSchdDeVO #exprnDeList div').length > 0) {
            $('#exprnSchdDeVO #exprnDeWarning').hide();
            $('#exprnSchdDeVO #exprnDeList').show();
        } else {
            $('#exprnSchdDeVO #exprnDeWarning').show();
            $('#exprnSchdDeVO #exprnDeList').hide();
        }
    });

    // PD 기준시간/기본시간/점심시간 유효성 검사
    function fn_timeTableInfoCheck(form) {

        if(!form.unitHour.value || !form.unitMin.value) {

            alert("기준시간을 확인해주세요.");

            if(!form.unitHour.value) {
                form.unitHour.focus();
                return false;
            }

            if(!form.unitMin.value) {
                form.unitMin.focus();
                return false;
            }
        } else {
            if (parseInt(form.unitHour.value) * 60 + parseInt(form.unitMin.value) < 30) {
                alert("기준시간은 30분 이상이어야합니다.");
                form.unitHour.focus();
                return false;
            }
        }

        if (!form.baseBgnHh.value || !form.baseBgnMm.value ||
            !form.baseEndHh.value || !form.baseEndMm.value) {

            alert("기본체험시간을 확인해주세요.");

            if (!form.baseBgnHh.value) {
                form.baseBgnHh.focus();
                return false;
            }

            if (!form.baseBgnMm.value) {
                form.baseBgnMm.focus();
                return false;
            }

            if (!form.baseEndHh.value) {
                form.baseEndHh.focus();
                return false;
            }

            if (!form.baseEndMm.value) {
                form.baseEndMm.focus();
                return false;
            }
        } else {

            var baseBgnTm = parseInt(form.baseBgnHh.value, 10) * 60 + parseInt(form.baseBgnMm.value, 10);
            var baseEndTm = parseInt(form.baseEndHh.value, 10) * 60 + parseInt(form.baseEndMm.value, 10);

            if (baseEndTm - baseBgnTm < 0) {
                alert('기본체험시작시간(시/분)이 기본체험종료시간(시/분)보다 클 수 없습니다.');
                form.baseBgnHh.focus();
                return false;
            }
            else if (baseEndTm - baseBgnTm < 60) {
                alert('기본체험시간은 1시간 이상이어야합니다.');
                form.baseBgnHh.focus();
                return false;
            }
        }

        if ($('input[name=lunchYn][value="Y"]').is(':checked')) {

            if(!form.lunchBgnHh.value || !form.lunchEndHh.value) {

                alert("점심시간을 사용하시는 경우, 점심시간을 선택해주세요.");

                if (!form.lunchBgnHh.value) {
                    form.lunchBgnHh.focus();
                    return false;
                }

                if (!form.lunchEndHh.value) {
                    form.lunchEndHh.focus();
                    return false;
                }
            } else {

                var baseBgnTm = parseInt(form.baseBgnHh.value, 10) * 60 + parseInt(form.baseBgnMm.value, 10);
                var baseEndTm = parseInt(form.baseEndHh.value, 10) * 60 + parseInt(form.baseEndMm.value, 10);

                var lunchBgnTm = parseInt(form.lunchBgnHh.value, 10) * 60;
                var lunchEndTm = parseInt(form.lunchEndHh.value, 10) * 60;

                if (lunchEndTm - lunchBgnTm < 0) {
                    alert("점심시작시간이 점심종료시간보다 클 수 없습니다.");
                    form.lunchBgnHh.focus();
                    return false;
                }
                else if (lunchEndTm - lunchBgnTm < 60) {
                    alert("점심시간은 1시간 이상이어야합니다.");
                    form.lunchBgnHh.focus();
                    return false;
                }

                if (lunchBgnTm < baseBgnTm || baseEndTm < lunchBgnTm ||
                    lunchEndTm < baseBgnTm || baseEndTm < lunchEndTm) {
                    alert("점심시간은 기본체험시간 안에 포함되어야합니다.");
                    form.lunchBgnHh.focus();
                    return false;
                }
            }
        }
        return true;
    }

    // 날짜 Format 유효성 체크
    function fn_exprnDeCheck(exprnDe) {
        var regexDate = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
        if(!regexDate.test(exprnDe.val())) {
            alert("날짜는 yyyy-MM-dd 형식으로 입력해주세요.");
            exprnDe.focus();
            return false;
        }
        return true;
    }

    // PD 유효성 체크
    function fn_updateExprnSchdPdCheck(form){

        if (!form.schdMthd.value) {
            alert("체험시간 등록방법을 선택해주세요.");
            $('#schdMthd1').focus();
            return false;
        }

        var exprnBgnDeFmt = $('#exprnSchdPdVO input[name="exprnBgnDeFmt"]');
        var exprnEndDeFmt = $('#exprnSchdPdVO input[name="exprnEndDeFmt"]');

        if (!exprnBgnDeFmt.val() || !exprnEndDeFmt.val()) {

            alert("체험기간을 확인해주세요.");

            if(!exprnBgnDeFmt.val()) {
                exprnBgnDeFmt.focus();
                return false;
            }

            if(!exprnEndDeFmt.val()) {
                exprnEndDeFmt.focus();
                return false;
            }
        } else {

            if(!fn_exprnDeCheck(exprnBgnDeFmt)) {
                return false;
            }

            if(!fn_exprnDeCheck(exprnEndDeFmt)) {
                return false;
            }

            var exprnBgnDe = exprnBgnDeFmt.val();
            var exprnEndDe = exprnEndDeFmt.val();

            if (exprnBgnDe > exprnEndDe) {
                alert('체험시작일자가 체험종료일자보다 클 수 없습니다.');
                exprnBgnDeFmt.focus();
                return false;
            }
        }

        if(!fn_timeTableInfoCheck(form)) {
            return false;
        }

        if ($('#exprnTimeTable').find('input.useYn').length > 0) {
            if ($('input.useYn:checked').length < 1) {
                alert("요일별 체험시간이 체크되지 않았습니다.");
                return false;
            }
        } else {
            alert("요일별 체험시간을 설정해주세요.");
            return false;
        }

        $('#exprnSchdPdVO').find('.exprnTmPdInfo').prop('disabled', false);
        !fn_exprnSchdTimeDuplCheck(form);

        return false;
    }

    // DE 유효성 체크
    function fn_updateExprnSchdDeCheck(form){

        if (!form.schdMthd.value) {
            alert("체험시간 등록방법을 선택해주세요.");
            $('#schdMthd2').focus();
            return false;
        }

        if ($('#exprnSchdDeVO #exprnDeList div').length > 0) {
            $('#exprnSchdDeVO #exprnDeList div input').each(function() {
                if($.trim($(this).val()) === '') {
                    alert("체험일자를 지정해주세요.");
                    $('#exprnSchdDeVO #exprnDeAdd').focus();
                    return false;
                }
                if(!fn_exprnDeCheck($(this))){
                    return false;
                }
            });
        } else {
            alert("체험일자를 지정해주세요.");
            $('#exprnSchdDeVO #exprnDeAdd').focus();
            return false;
        }

        if ($('#exprnSchdDeVO #exprnTmList').find('input.useYn:checked').length > 0) {

            var tmValid = true;
            $('#exprnSchdDeVO #exprnTmList').find('input.useYn:checked').each(function() {

                var id = $(this).data("timeNo");
                $('#exprnSchdDeVO #exprnTmList').find('#'+id).each(function(index) {
                    var exprnBgnHh = $(this).find('.exprnBgnHh');
                    var exprnBgnMm = $(this).find('.exprnBgnMm');
                    var exprnEndHh = $(this).find('.exprnEndHh');
                    var exprnEndMm = $(this).find('.exprnEndMm');

                    if(!exprnBgnHh.val() || !exprnBgnMm.val() || !exprnEndHh.val() || !exprnEndMm.val()) {
                        alert("체험시간을 선택해주세요.");
                        if(!exprnBgnHh.val()) {
                            exprnBgnHh.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!exprnBgnMm.val()) {
                            exprnBgnMm.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!exprnEndHh.val()) {
                            exprnEndHh.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!exprnEndMm.val()) {
                            exprnEndMm.focus();
                            tmValid = false;
                            return false;
                        }
                    }

                    if(!tmValid) {
                        return false;
                    }

                    var exprnBgnHm = parseInt(exprnBgnHh.val(), 10) * 60 + parseInt(exprnBgnMm.val(), 10);
                    var exprnEndHm = parseInt(exprnEndHh.val(), 10) * 60 + parseInt(exprnEndMm.val(), 10);

                    if (exprnEndHm <= exprnBgnHm) {
                        alert('종료시간은 시작시간보다 커야 합니다.');
                        exprnBgnHh.focus();
                        tmValid = false;
                        return false;
                    }
                });

                if(!tmValid) {
                    return false;
                }
            });

            if(!tmValid) {
                return false;
            }

            !fn_exprnSchdTimeDuplCheck(form);

        } else {
            alert("회차는 1개 이상 사용하셔야합니다.");
            return false;
        }

        return false;
    }

    // 시간(분) --> 문자열 변환
    function toTimeStr(totalMin) {
        const h = String(Math.floor(totalMin / 60)).padStart(2, '0');
        const m = String(totalMin % 60).padStart(2, '0');
        return h+':'+m;
    }

    // 시간대 중복 여부 체크 후 form 전송
    function fn_exprnSchdTimeDuplCheck(form) {

        $.ajax({
            cache    : false,
            type     : "POST",
            url      : "./exprnSchdTimeDuplCheck.do",
            dataType : 'json',
            data     : $(form).serialize(),
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('체험시간 유효성 검사 중 오류가 발생했습니다.');
                    console.log("code:",request.status);
                    console.log("message:",request.responseText);
                    console.log("error:"+error)
                }
            },
            success  : function (result) {
                var status = result['status'];
                if(status == 'LIST_TRUE') {
                    if(confirm("수정하시겠습니까?")) {
                        form.submit();
                    }
                } else if(status == 'LIST_FALSE') {
                    alert(result['message']);
                    console.log("exprnTmList", result['exprnTmList']);
                } else {
                    alert("체험시간 유효성 검사 중 오류가 발생했습니다.");
                    console.log("exprnTmList", result['exprnTmList']);
                }
            }
        });
    }

</script>

</body>
</html>
