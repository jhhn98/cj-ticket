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
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 일정관리 <c:out value="${not empty fcltySchdVO.schdMthd ? '수정' : '등록'}"/> </title>
</head>
<body>

<div class="p-wrap">

    <div>
        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
        <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
    </div>

    <table class="p-table">
        <caption>시설 일정 등록방법 선택</caption>
        <colgroup>
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">시설시간 등록방법 <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td>
                <div class="p-form-group w20p">
                    <%-- 시설 일정 등록방법 - PD:시설기간(규칙) / DE:일자별 선택(불규칙) --%>
                    <span class="p-form-radio">
                        <input type="radio" name="schdMthdRadio" id="schdMthd1" class="p-form-radio__input" value="PD"<c:if test="${fcltySchdVO.schdMthd == 'PD'}"> checked</c:if>>
                        <label for="schdMthd1" class="p-form-radio__label">시설기간(규칙 접수)</label>
                    </span>
<%--                    <span class="p-form-radio">--%>
<%--                        <input type="radio" name="schdMthdRadio" id="schdMthd2" class="p-form-radio__input" value="DE"<c:if test="${fcltySchdVO.schdMthd == 'DE'}"> checked</c:if>>--%>
<%--                        <label for="schdMthd2" class="p-form-radio__label">일자별 선택(불규칙 접수)</label>--%>
<%--                    </span>--%>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <form:form modelAttribute="fcltySchdVO" id="fcltySchdPdVO" name="fcltySchdPdVO" method="post" action="updateFcltySchdPd.do" onsubmit="return fn_updateFcltySchdPdCheck(this)" style="display:none;">
        <fieldset>
            <legend>시설 일정 수정</legend>
            <table class="p-table" id="fcltySchdPdTable">
                <caption>시설 일정 수정 - 시설기간(규칙 접수)</caption>
                <c:forEach var="result" items="${fcltySearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <c:forEach var="result" items="${fcltySearchVO.paramsMapMng}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <input type="hidden" name="fcltyNo" id="fcltyNo" value="<c:out value="${fcltySchdVO.fcltyNo}"/>"/>
                <input type="hidden" name="schdMthd" id="schdMthd" value="PD"/>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row">시설기간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <c:forEach var="result" items="${fcltyDeListByPd}" varStatus="status">
                                <c:if test="${status.first}">
                                    <input type="text" name="fcltyBgnDeFmt" value="<c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled />
                                    <span class="p-input__addon">
                                        <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.fcltySchdPdVO.fcltyBgnDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                            <svg width="14" height="16" fill="#888" focusable="false">
                                                <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                            </svg>
                                        </button>
                                    </span>
                                </c:if>
                                <c:if test="${status.last}">
                                    <span class="p-form__split">~</span>
                                    <input type="text" name="fcltyEndDeFmt" value="<c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled />
                                    <span class="p-input__addon">
                                        <button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.fcltySchdPdVO.fcltyEndDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                            <svg width="14" height="16" fill="#888" focusable="false">
                                                <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                            </svg>
                                        </button>
                                    </span>
                                </c:if>
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(fcltyDeListByPd) == 0}">
                            <div class="p-form-group w20p">
                                <input type="text" name="fcltyBgnDeFmt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled />
                                <span class="p-input__addon">
                                    <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.fcltySchdPdVO.fcltyBgnDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                        <svg width="14" height="16" fill="#888" focusable="false">
                                            <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                        </svg>
                                    </button>
                                </span>
                                <span class="p-form__split">~</span>
                                <input type="text" name="fcltyEndDeFmt" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled />
                                <span class="p-input__addon">
                                    <button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.fcltySchdPdVO.fcltyEndDeFmt);"> <!--getCalendar(document.bbsNttForm.start_date);-->
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
                            <form:select path="unitHour" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
                                <c:forEach var="i" begin="1" end="12">
                                    <form:option value="${i}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시간 </span>
                            <form:select path="unitMin" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
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
                    <th scope="row">기본시설시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <form:select path="baseBgnHh" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시 </span>
                            <form:select path="baseBgnMm" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
                                <c:forEach var="result" begin="0" end="59" step="10">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">분 </span>
                            <span class="p-form__split">~</span>
                            <form:select path="baseEndHh" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시 </span>
                            <form:select path="baseEndMm" class="p-input p-input--auto fcltyTmPdInfo" disabled="true">
                                <c:forEach var="result" begin="0" end="59" step="10">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">분</span>
                            <span class="p-form__split"></span>
                            <span class="p-form__split">( </span>
                            <span class="p-form-checkbox p-form-checkbox--single">
                                <input type="checkbox" name="lunchYn" id="lunchYn" class="p-form-checkbox__input fcltyTmPdInfo" value="Y"<c:if test="${!empty fcltySchdVO.lunchBgnHh && !empty fcltySchdVO.lunchEndHh}"> checked</c:if> disabled>
                                <label for="lunchYn" class="p-form-checkbox__label">점심시간 사용여부</label>
                            </span>
                            <span class="p-form__split">점심시간</span>
                            <select name="lunchBgnHh" id="lunchBgnHh" class="p-input p-input--auto fcltyTmPdInfo"<c:if test="${empty fcltySchdVO.lunchBgnHh}"> disabled</c:if>>
                                <option value="" label="선택"/>
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <option value="${hh}" label="${hh}"<c:if test="${fcltySchdVO.lunchBgnHh == hh}"> selected</c:if>/>
                                </c:forEach>
                            </select>
                            <span class="p-form__split">시</span>
                            <span class="p-form__split">~</span>
                            <select name="lunchEndHh" id="lunchEndHh" class="p-input p-input--auto fcltyTmPdInfo"<c:if test="${empty fcltySchdVO.lunchEndHh}"> disabled</c:if>>
                                <option value="" label="선택"/>
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <option value="${hh}" label="${hh}"<c:if test="${fcltySchdVO.lunchEndHh == hh}"> selected</c:if>/>
                                </c:forEach>
                            </select>
                            <span class="p-form__split">시</span>
                            <span class="p-form__split">)</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">요일별 시설시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w15p">
                            <button type="button" class="p-button info" id="setTimeBtn" onclick="fn_setFcltyTimeTalbe()">요일별 시설시간 설정</button>
                            <span class="p-form__split"></span>
                            <button type="button" class="p-button restore" id="cleanTimeBtn" onclick="fn_cleanFcltyTimeTalbe()">재설정</button>
                            <c:if test="${fn:length(fcltyTmListByPd) > 0}">
                                <span class="p-form__split"></span>
                                <button type="button" class="p-button darken" id="resetTimeBtn" onclick="fn_resetFcltyTimeTalbe()">초기화</button>
                            </c:if>
                        </div>
                        <div class="p-form-group w20p">
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">기준시간/기본시설시간을 선택 후 '요일별 시설시간 설정' 버튼을 클릭하시면 시간이 계산되어 표출됩니다.</em>
                            </span>
                            <br/>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">기준시간/기본시설시간을 수정하시려면 '재설정'버튼을 클릭해주세요.</em>
                            </span>
                            <c:if test="${fn:length(fcltyTmListByPd) > 0}">
                                <br/>
                                <span class="p-table__content padding_l_10">
                                    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                    <em class="em_black">'초기화'버튼을 클릭하시면  기준시간/기본시설시간/요일별 시설시간이 초기 상태로 되돌아갑니다.</em>
                                </span>
                            </c:if>
                        </div>
                        <table class="w50p">
                            <thead>
                            <tr>
                                <th style="text-align: center;">회차</th>
                                <th style="text-align: center;">시설시간</th>
                                <th style="text-align: center;">월</th>
                                <th style="text-align: center;">화</th>
                                <th style="text-align: center;">수</th>
                                <th style="text-align: center;">목</th>
                                <th style="text-align: center;">금</th>
                                <th style="text-align: center;"><em class="em_b_blue">토</em></th>
                                <th style="text-align: center;"><em class="em_red">일</em></th>
                            </tr>
                            </thead>
                            <tbody class="text_center" id="fcltyTimeTable">
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
                            <c:forEach var="result" items="${fcltyTmListByPd}" varStatus="status">
                                <c:set var="fcltyTmList" value="fcltyTmList[${status.index}]"/>
                                <c:set var="fcltyBgnHh" value="${fcltyTmList}.fcltyBgnHh"/>
                                <c:set var="fcltyBgnMm" value="${fcltyTmList}.fcltyBgnMm"/>
                                <c:set var="fcltyEndHh" value="${fcltyTmList}.fcltyEndHh"/>
                                <c:set var="fcltyEndMm" value="${fcltyTmList}.fcltyEndMm"/>
                                <c:set var="monYn"      value="${fcltyTmList}.monYn"/>
                                <c:set var="tueYn"      value="${fcltyTmList}.tueYn"/>
                                <c:set var="wedYn"      value="${fcltyTmList}.wedYn"/>
                                <c:set var="thuYn"      value="${fcltyTmList}.thuYn"/>
                                <c:set var="friYn"      value="${fcltyTmList}.friYn"/>
                                <c:set var="satYn"      value="${fcltyTmList}.satYn"/>
                                <c:set var="sunYn"      value="${fcltyTmList}.sunYn"/>
                                <tr>
                                    <td><c:out value="${status.count}"/>회차</td>
                                    <td>
                                        <input type="hidden" name="<c:out value="${fcltyBgnHh}"/>" value="<c:out value="${result.fcltyBgnHh}"/>" />
                                        <input type="hidden" name="<c:out value="${fcltyBgnMm}"/>" value="<c:out value="${result.fcltyBgnMm}"/>" />
                                        <input type="hidden" name="<c:out value="${fcltyEndHh}"/>" value="<c:out value="${result.fcltyEndHh}"/>" />
                                        <input type="hidden" name="<c:out value="${fcltyEndMm}"/>" value="<c:out value="${result.fcltyEndMm}"/>" />
                                        <c:set var="fcltyBgnHm" value="${tsu:toDateFormat(result.fcltyBgnHm, 'HHmm', 'HH:mm')}"/>
                                        <c:set var="fcltyEndHm" value="${tsu:toDateFormat(result.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                                        <c:out value="${fcltyBgnHm}"/> ~ <c:out value="${fcltyEndHm}"/>
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
                            <c:if test="${fn:length(fcltyTmListByPd) == 0}">
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
                    <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <input type="submit" class="p-button edit" value="수정">
                </div>
            </div>
        </fieldset>
    </form:form>

    <form:form modelAttribute="fcltySchdVO" id="fcltySchdDeVO" name="fcltySchdDeVO" method="post" action="updateFcltySchdDe.do" onsubmit="return fn_updateFcltySchdDeCheck(this)" style="display:none;">
        <fieldset>
            <legend>시설 일정 수정</legend>
            <table class="p-table" id=fcltySchdDeTable">
                <caption>시설 일정 수정 - 일자별선택(불규칙 접수)</caption>
                <c:forEach var="result" items="${fcltySearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <c:forEach var="result" items="${fcltySearchVO.paramsMapMng}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <input type="hidden" name="fcltyNo" id="fcltyNo" value="<c:out value="${fcltySchdVO.fcltyNo}"/>"/>
                <input type="hidden" name="schdMthd" id="schdMthd" value="DE"/>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row">시설일자 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w10p">
                            <input type="text" id="fcltyDeAdd" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled/>
                            <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.fcltySchdDeVO.fcltyDeAdd);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                            <span class="p-form__split"></span>
                            <button type="button" class="p-button" id="fcltyDeAddBtn">추가</button>
                        </div>
                        <div class="p-form-group w20p" id="fcltyDeWarning">
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">시설일자를 지정해주세요.</em>
                            </span>
                        </div>
                        <div id="fcltyDeList">
                            <c:forEach var="result" items="${fcltyDeListByDe}" varStatus="status">
                                <div class="p-form-group w5p" id="fcltyDe<c:out value="${result.fcltyDe}"/>">
                                    <input type="hidden" name="fcltyDeArr" id="fcltyDeArr<c:out value="${result.fcltyDe}"/>" value="<c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" />
                                    <span class="p-input p-input--auto"><c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/></span>
                                    <span class="p-input__addon">
                                        <button type="button" class="p-button p-button--icon delete fcltyDeDelBtn" data-delete-id="<c:out value="${result.fcltyDe}"/>">삭제</button>
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">시설시간 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div id="fcltyTmList">
                            <c:forEach var="result" items="${fcltyTmListByDe}" varStatus="status">
                                <c:set var="fcltyTmList" value="fcltyTmList[${status.index}]"/>
                                <c:set var="fcltyBgnHh" value="${fcltyTmList}.fcltyBgnHh"/>
                                <c:set var="fcltyBgnMm" value="${fcltyTmList}.fcltyBgnMm"/>
                                <c:set var="fcltyEndHh" value="${fcltyTmList}.fcltyEndHh"/>
                                <c:set var="fcltyEndMm" value="${fcltyTmList}.fcltyEndMm"/>
                                <div class="p-form-group w15p" id="fcltyTm${status.index+1}">
                                    <span class="p-form-checkbox">
                                        <input type="checkbox" id="useYn<c:out value="${status.index+1}"/>" class="p-form-checkbox__input useYn" value="Y" checked data-time-no="fcltyTm<c:out value="${status.index+1}"/>">
                                        <label for="useYn<c:out value="${status.index+1}"/>" class="p-form-checkbox__label"><c:out value="${status.index+1}"/>회차</label>
                                    </span>
                                    <span class="p-form__split"></span>
                                    <select name="<c:out value="${fcltyBgnHh}"/>" id="<c:out value="${fcltyBgnHh}"/>" class="p-input p-input--auto fcltyTm fcltyBgnHh" disabled>
                                        <c:forEach var="i" begin="0" end="23">
                                            <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.fcltyBgnHh == hh}"> selected</c:if> />
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${fcltyBgnMm}"/>" id="<c:out value="${fcltyBgnMm}"/>" class="p-input p-input--auto fcltyTm fcltyBgnMm" disabled>
                                        <c:forEach var="i" begin="0" end="59" step="10">
                                            <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.fcltyBgnMm == mm}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분 </span>
                                    <span class="p-form__split">~</span>
                                    <select name="<c:out value="${fcltyEndHh}"/>" id="<c:out value="${fcltyEndHh}"/>" class="p-input p-input--auto fcltyTm fcltyEndHh" disabled>
                                        <c:forEach var="i" begin="0" end="23">
                                            <c:set var="hh" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"<c:if test="${result.fcltyEndHh == hh}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${fcltyEndMm}"/>" id="<c:out value="${fcltyEndMm}"/>" class="p-input p-input--auto fcltyTm fcltyEndMm" disabled>
                                        <c:forEach var="i" begin="0" end="59" step="10">
                                            <c:set var="mm" value="${tsu:zerofill(i, 2, '0')}"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"<c:if test="${result.fcltyEndMm == mm}"> selected</c:if>/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분</span>
                                </div>
                            </c:forEach>
                            <c:forEach var="i" begin="${fn:length(fcltyTmListByDe)+1}" end="6">
                                <c:set var="fcltyTmList" value="fcltyTmList[${i-1}]"/>
                                <c:set var="useYn"      value="${fcltyTmList}.useYn"/>
                                <c:set var="fcltyBgnHh" value="${fcltyTmList}.fcltyBgnHh"/>
                                <c:set var="fcltyBgnMm" value="${fcltyTmList}.fcltyBgnMm"/>
                                <c:set var="fcltyEndHh" value="${fcltyTmList}.fcltyEndHh"/>
                                <c:set var="fcltyEndMm" value="${fcltyTmList}.fcltyEndMm"/>
                                <div class="p-form-group w15p" id="fcltyTmNew<c:out value="${i}"/>">
                                    <span class="p-form-checkbox">
                                        <input type="checkbox" id="useYn<c:out value="${i}"/>" class="p-form-checkbox__input useYn" value="Y" data-time-no="fcltyTmNew<c:out value="${i}"/>">
                                        <label for="useYn<c:out value="${i}"/>" class="p-form-checkbox__label"><c:out value="${i}"/>회차</label>
                                    </span>
                                    <span class="p-form__split"></span>
                                    <select name="<c:out value="${fcltyBgnHh}"/>" id="<c:out value="${fcltyBgnHh}"/>" class="p-input p-input--auto fcltyTm fcltyBgnHh" disabled>
                                        <c:forEach var="result" begin="0" end="23">
                                            <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${fcltyBgnMm}"/>" id="<c:out value="${fcltyBgnMm}"/>" class="p-input p-input--auto fcltyTm fcltyBgnMm" disabled>
                                        <c:forEach var="result" begin="0" end="59" step="10">
                                            <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${mm}"/>" label="<c:out value="${mm}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">분 </span>
                                    <span class="p-form__split">~</span>
                                    <select name="<c:out value="${fcltyEndHh}"/>" id="<c:out value="${fcltyEndHh}"/>" class="p-input p-input--auto fcltyTm fcltyEndHh" disabled>
                                        <c:forEach var="result" begin="0" end="23">
                                            <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                            <option value="<c:out value="${hh}"/>" label="<c:out value="${hh}"/>"/>
                                        </c:forEach>
                                    </select>
                                    <span class="p-form__split">시 </span>
                                    <select name="<c:out value="${fcltyEndMm}"/>" id="<c:out value="${fcltyEndMm}"/>" class="p-input p-input--auto fcltyTm fcltyEndMm" disabled>
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
                    <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <input type="submit" class="p-button edit" value="수정">
                </div>
            </div>
        </fieldset>
    </form:form>

</div>

<script>
    $(document).ready(function() {

    <%-- 등록방법에 따라 화면 set --%>

    <%-- 등록방법 PD 화면 set --%>
    <c:if test="${fcltySchdVO.schdMthd == 'PD'}">
        <%-- PD disabled false --%>
        $('#fcltySchdPdVO').show();
        $('#fcltySchdPdVO').find('input, select').prop('disabled', false);
        $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', true);

        <%-- PD dayAll checkbox --%>
        <c:if test="${fn:length(fcltyTmListByPd) > 0}">
            $('#fcltySchdPdVO').find('#dayAllCheck').show();
            var weekArr = [ 'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat' ];
            for (let i = 0; i < weekArr.length; i++) {
                var weekday = weekArr[i];
                if($('#fcltySchdPdVO .'+weekday+':checked').length == $('.'+weekday).length) {
                    $('#fcltySchdPdVO #'+weekday+'All').prop('checked', true);
                } else {
                    $('#fcltySchdPdVO #'+weekday+'All').prop('checked', false);
                }
            }
        </c:if>
    </c:if>

    <%-- 등록방법 DE 화면 set --%>
    <c:if test="${fcltySchdVO.schdMthd == 'DE'}">
        <%-- DE disabled false --%>
        $('#fcltySchdDeVO').show();
        $('#fcltySchdDeVO').find('input, select').prop('disabled', false);
        if($('#fcltySchdDeVO #fcltyDeList div').length > 0) {
            $('#fcltySchdDeVO #fcltyDeWarning').hide();
            $('#fcltySchdDeVO #fcltyDeList').show();
        } else {
            $('#fcltySchdDeVO #fcltyDeWarning').show();
            $('#fcltySchdDeVO #fcltyDeList').hide();
        }
        $('#fcltySchdDeVO input.useYn:not(:checked)').closest('div').find('input:not(.useYn), select').prop('disabled', true);
    </c:if>

        <%-- PD 점심시간 등록여부에 따른 disabled 설정 --%>
        $('#fcltySchdPdVO input[name=lunchYn]').on("change", function () {
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

    <%-- 등록방법 선택(라디오버튼)에 따른 화면 set --%>
    $(document).on("change", 'input[name=schdMthdRadio]', function () {

        <%-- 등록방법 PD 선택 --%>
        if ($(this).val() == 'PD') {

            <%-- DE schdMthd value --%>
            $('#fcltySchdDeVO').find('input, select').prop('disabled', true);

            <%-- DE 화면 숨김 / disabled true --%>
            $('#fcltySchdDeVO').hide();
            $('#fcltySchdDeVO').find('input, select').prop('disabled', true);

            <%-- PD 화면 보임 / disabled false --%>
            $('#fcltySchdPdVO').show();
            $('#fcltySchdPdVO').find('input, select').prop('disabled', false);
            if($('#fcltySchdPdVO #fcltyTimeTable').find('input.useYn').length > 0) {
                $('#fcltySchdPdVO #dayAllCheck').show();
            }

            <%-- PD 회차시간 설정되어 있으면 기준시간/기본정보 disabled true --%>
            if ($('#fcltySchdPdVO #fcltyTimeTable').find('input.useYn').length > 0) {
                $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', true);
            } else {
                $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', false);
            }

            <%-- PD 점심시간 여부에 따른 select disabled true --%>
            if ($('#fcltySchdPdVO').find('input[name=lunchYn]:checked').length == 0) {
                $('#fcltySchdPdVO').find('select[name=lunchBgnHh]').prop('disabled', true);
                $('#fcltySchdPdVO').find('select[name=lunchEndHh]').prop('disabled', true);
            }
        }

        <%-- 등록방법 DE 선택 --%>
        else if ($(this).val() == 'DE') {

            <%-- PD 화면 숨김 / disabled true --%>
            $('#fcltySchdPdVO').hide();
            $('#fcltySchdPdVO').find('input, select').prop('disabled', true);
            $('#fcltySchdPdVO #dayAllCheck').hide();

            <%-- DE 화면 보임 / disabled false --%>
            $('#fcltySchdDeVO').show();
            $('#fcltySchdDeVO').find('input, select').prop('disabled', false);
            $('#fcltySchdDeVO input.useYn:not(:checked)').closest('div').find('input:not(.useYn), select').prop('disabled', true);
        }

        <%-- 등록방법 null이면 모두 숨김 --%>
        else {
            $('.fcltySchdPdVO').hide();
            $('#fcltySchdPdVO').find('input, select').prop('disabled', true);

            $('.fcltySchdDeVO').hide();
            $('#fcltySchdDeVO').find('input, select').prop('disabled', true);
        }
    });

    <%-- PD 기준시간/기본정보/점심시간 변동시 회차 목록 삭제 --%>
    $(document).on("change", '#fcltySchdPdVO .fcltyTmPdInfo', function () {
        $('#fcltySchdPdVO #dayAllCheck').hide();
        $("#fcltySchdPdVO #fcltyTimeTable").find("tr:not(:first)").remove();
        $("#fcltySchdPdVO #fcltyTimeTable").append(`<tr><td colspan="9">회차가 없습니다.</td></tr>`);
    });

    <%-- PD 회차 목록에서 해당 요일에 해당하는 회차 전체선택 --%>
    $(document).on("change", '#fcltySchdPdVO .dayAll', function () {
        var checkVal = $(this).val();

        if ($(this).is(':checked')) {
            $('.'+checkVal).prop('checked', true);
        } else {
            $('.'+checkVal).prop('checked', false);
        }
    });

    <%-- PD 회차 목록에서 각 회차 checkbox 선택 여부에 따라 전체선택 checkbox 변경 --%>
    $(document).on("change", '#fcltySchdPdVO #fcltyTimeTable .useYn', function () {
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
            if($('#fcltySchdPdVO .'+checkVal+':checked').length == $('.'+checkVal).length) {
                $('#fcltySchdPdVO #'+checkVal+'All').prop('checked', true);
            }
        } else {
            $('#fcltySchdPdVO #'+checkVal+'All').prop('checked', false);
        }
    });

    <%-- DE 회차 목록에서 각 회차 checkbox 선택 여부에 따라 해당 회차 입력칸 disabled 변경 --%>
    $(document).on("change", '#fcltySchdDeVO #fcltyTmList .useYn', function () {
        var checkVal = $(this).data('timeNo');

        if ($(this).is(':checked')) {
            $('#fcltySchdDeVO #fcltyTmList #'+checkVal).find('.fcltyTm').prop('disabled', false);
        } else {
            $('#fcltySchdDeVO #fcltyTmList #'+checkVal).find('.fcltyTm').prop('disabled', true).prop('selectedIndex', 0);
        }
    });

    <%-- PD 기준시간/기본시간/점심시간 정보에 따라 회차 목록 생성 --%>
    function fn_setFcltyTimeTalbe() {

        var form = document.getElementById("fcltySchdPdVO");

        <%-- PD 기준시간/기본시간/점심시간 유효성 검사 --%>
        if(!fn_timeTableInfoCheck(form)) {
            return;
        }

        <%-- PD 기준시간/기본시간에 따른 회차 목록 불러오기 --%>
        $.ajax({
            cache    : false,
            type     : "GET",
            url      : "./setFcltyTimeAjax.do",
            dataType : 'json',
            data     : {
                unitHour:  $('#fcltySchdPdVO #unitHour').val(),
                unitMin:   $('#fcltySchdPdVO #unitMin').val(),
                baseBgnHh: $('#fcltySchdPdVO #baseBgnHh').val(),
                baseBgnMm: $('#fcltySchdPdVO #baseBgnMm').val(),
                baseEndHh: $('#fcltySchdPdVO #baseEndHh').val(),
                baseEndMm: $('#fcltySchdPdVO #baseEndMm').val(),
                lunchBgnHh: $('#fcltySchdPdVO #lunchBgnHh').val(),
                lunchEndHh: $('#fcltySchdPdVO #lunchEndHh').val()
            },
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('요일별 시설시간 조회 중 오류가 발생했습니다.');
                }
            },
            success  : function (result) {
                $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', true);
                fn_renderTimeTable(result);
            }
        });
    }

    <%-- PD 재설정 버튼 클릭시 기준시간/기본시간/점심시간 diabled false 및 회차목록 삭제 --%>
    function fn_cleanFcltyTimeTalbe() {

        $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', false);
        if (!$('#fcltySchdPdVO input[name=lunchYn]').is(':checked')) {
            $('#fcltySchdPdVO select[name=lunchBgnHh]').prop('disabled', true);
            $('#fcltySchdPdVO select[name=lunchEndHh]').prop('disabled', true);
        }
        $('#fcltySchdPdVO #dayAllCheck').hide();
        const $tbody = $("#fcltySchdPdVO #fcltyTimeTable");
        $tbody.find("tr:not(:first)").remove();
        $tbody.append(`<tr><td colspan="9">회차가 없습니다.</td></tr>`);
    }

    <%-- PD 초기화 버튼 클릭시 기존에 등록된 회차정보/목록 불러오기 --%>
    function fn_resetFcltyTimeTalbe() {

        $.ajax({
            cache    : false,
            type     : "GET",
            url      : "./resetFcltyTimeAjax.do",
            dataType : 'json',
            data     : {
                fcltyNo :  $('#fcltyNo').val()
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
                var fcltySchdVO = result.fcltySchdVO;
                $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', true);
                $('#fcltySchdPdVO #unitHour').val(fcltySchdVO.unitHour);
                $('#fcltySchdPdVO #unitMin').val(fcltySchdVO.unitMin);
                $('#fcltySchdPdVO #baseBgnHh').val(fcltySchdVO.baseBgnHh);
                $('#fcltySchdPdVO #baseBgnMm').val(fcltySchdVO.baseBgnMm);
                $('#fcltySchdPdVO #baseEndHh').val(fcltySchdVO.baseEndHh);
                $('#fcltySchdPdVO #baseEndMm').val(fcltySchdVO.baseEndMm);
                $('#fcltySchdPdVO #lunchBgnHh').val(fcltySchdVO.lunchBgnHh);
                $('#fcltySchdPdVO #lunchEndHh').val(fcltySchdVO.lunchEndHh);
                fn_renderTimeTable(result.fcltyTmList);
            }
        });
    }

    <%-- PD 불러온 회차 목록으로 timeTable 생성 --%>
    function fn_renderTimeTable(fcltyTmList) {

        const $tbody = $("#fcltySchdPdVO #fcltyTimeTable");
        if (!fcltyTmList || fcltyTmList.length === 0) {
            $('#fcltySchdPdVO #dayAllCheck').hide();
            $tbody.find("tr:not(:first)").remove();
            $tbody.append(`<tr><td colspan="9">회차가 없습니다.</td></tr>`);
            return;
        }

        var html = '';

        for (var i=0; i<fcltyTmList.length; i++) {
            var row = fcltyTmList[i];
            var name = 'fcltyTmList['+i+']';
            var fcltyBgnHm = row.fcltyBgnHh + ':' + row.fcltyBgnMm;
            var fcltyEndHm = row.fcltyEndHh + ':' + row.fcltyEndMm;

            html += '<tr class="fcltyTmList">';
            html += '<td>'+ (i+1) +'회차</td>';
            html += '<td>'+  fcltyBgnHm + ' ~ ' + fcltyEndHm + '</td>';
            html += '<input type="hidden" name="'+ name +'.fcltyBgnHm" id="'+ name +'.fcltyBgnHm" value="'+ row.fcltyBgnHm +'">';
            html += '<input type="hidden" name="'+ name +'.fcltyEndHm" id="'+ name +'.fcltyBgnHm" value="'+ row.fcltyEndHm +'">';

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

        $('#fcltySchdPdVO #dayAllCheck').show();
        var weekArr = [ 'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat' ];
        for (let i = 0; i < weekArr.length; i++) {
            var weekday = weekArr[i];
            if($('#fcltySchdPdVO .'+weekday+':checked').length == $('.'+weekday).length) {
                $('#fcltySchdPdVO #'+weekday+'All').prop('checked', true);
            } else {
                $('#fcltySchdPdVO #'+weekday+'All').prop('checked', false);
            }
        }

    }

    <%-- PD 불러온 회차 목록으로 timeTable 생성 --%>
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

    <%-- DE 시설일자 추가 : fcltyDeAddBtn 클릭 이벤트 --%>
    $(document).on("click", '#fcltySchdDeVO #fcltyDeAddBtn', function () {
        var fcltyDe = $('#fcltySchdDeVO #fcltyDeAdd');
        if(!fcltyDe.val()) {
            alert("추가하실 날짜를 선택해주세요.");
            fcltyDe.focus();
            return false;
        }
        if(!fn_fcltyDeCheck(fcltyDe)) {
            return false;
        }
        if(!fn_fcltyDeDuplCheck(fcltyDe)){
            return false;
        }
        renderDeList(fcltyDe);
        $('#fcltySchdDeVO #fcltyDeWarning').hide();
        $('#fcltySchdDeVO #fcltyDeList').show();
        fcltyDe.val("");
    });

    <%-- DE 시설일자 중복확인 --%>
    function fn_fcltyDeDuplCheck(fcltyDe) {
        var fcltyDeVal = fcltyDe.val();
        var id = fcltyDeVal.replaceAll('-', '');
        if($('#fcltySchdDeVO #fcltyDeArr'+id).length > 0) {
            alert("이미 추가된 날짜입니다.");
            fcltyDe.val("");
            fcltyDe.focus();
            return false;
        }
        return true;
    }

    <%-- DE 시설일자 추가 시 html 수정 --%>
    function renderDeList(fcltyDe) {
        var fcltyDeVal = fcltyDe.val();
        var id = fcltyDeVal.replaceAll('-', '');
        var html = '<div class="p-form-group w5p" id="fcltyDe'+id+'">'
                + '     <input type="hidden" name="fcltyDeArr" id="fcltyDeArr'+id+'" value="'+fcltyDeVal+'" />'
                + '     <span class="p-input p-input--auto">'+fcltyDeVal+'</span>'
                + '     <span class="p-input__addon">'
                + '         <button type="button" class="p-button p-button--icon delete fcltyDeDelBtn" data-delete-id="'+id+'">삭제</button>'
                + '     </span>'
                + '</div>'

        $("#fcltySchdDeVO #fcltyDeList").append(html);
    }

    <%-- DE 시설일자 삭제 : fcltyDeDelBtn 클릭 이벤트 --%>
    $(document).on("click", '#fcltySchdDeVO .fcltyDeDelBtn', function () {
        var deleteId = $(this).data('deleteId');
        $('#fcltySchdDeVO #fcltyDe'+deleteId).remove();

        if($('#fcltySchdDeVO #fcltyDeList div').length > 0) {
            $('#fcltySchdDeVO #fcltyDeWarning').hide();
            $('#fcltySchdDeVO #fcltyDeList').show();
        } else {
            $('#fcltySchdDeVO #fcltyDeWarning').show();
            $('#fcltySchdDeVO #fcltyDeList').hide();
        }
    });

    <%-- PD 기준시간/기본시간/점심시간 유효성 검사 --%>
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
            if (parseInt(form.unitHour.value) * 60 + parseInt(form.unitMin.value) < 60) {
                alert("기준시간은 1시간 이상이어야합니다.");
                form.unitHour.focus();
                return false;
            }
        }

        if (!form.baseBgnHh.value || !form.baseBgnMm.value ||
            !form.baseEndHh.value || !form.baseEndMm.value) {

            alert("기본시설시간을 확인해주세요.");

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
                alert('기본시설시작시간(시/분)이 기본시설종료시간(시/분)보다 클 수 없습니다.');
                form.baseBgnHh.focus();
                return false;
            }
            else if (baseEndTm - baseBgnTm < 60) {
                alert('기본시설시간은 1시간 이상이어야합니다.');
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
                    alert("점심시간은 기본시설시간 안에 포함되어야합니다.");
                    form.lunchBgnHh.focus();
                    return false;
                }
            }
        }
        return true;
    }

    var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);

    <%-- 날짜 Format 유효성 체크 --%>
    function fn_fcltyDeCheck(fcltyDe) {
        if(!regex.test(fcltyDe.val())) {
            alert("날짜는 yyyy-MM-dd 형식으로 입력해주세요.");
            fcltyDe.focus();
            return false;
        }
        return true;
    }

    <%-- PD 입력된 항목 유효성 체크 --%>
    function fn_updateFcltySchdPdCheck(form){

        if (!form.schdMthd.value) {
            alert("시설시간 등록방법을 선택해주세요.");
            $('#schdMthd1').focus();
            return false;
        }

        var fcltyBgnDeFmt = $('#fcltySchdPdVO input[name="fcltyBgnDeFmt"]');
        var fcltyEndDeFmt = $('#fcltySchdPdVO input[name="fcltyEndDeFmt"]');

        if (!fcltyBgnDeFmt.val() || !fcltyEndDeFmt.val()) {

            alert("시설기간을 확인해주세요.");

            if(!fcltyBgnDeFmt.val()) {
                fcltyBgnDeFmt.focus();
                return false;
            }

            if(!fcltyEndDeFmt.val()) {
                fcltyEndDeFmt.focus();
                return false;
            }
        } else {

            if(!fn_fcltyDeCheck(fcltyBgnDeFmt)) {
                return false;
            }

            if(!fn_fcltyDeCheck(fcltyEndDeFmt)) {
                return false;
            }

            var fcltyBgnDe = fcltyBgnDeFmt.val();
            var fcltyEndDe = fcltyEndDeFmt.val();

            if (fcltyBgnDe > fcltyEndDe) {
                alert('시설시작일자가 시설종료일자보다 클 수 없습니다.');
                fcltyBgnDeFmt.focus();
                return false;
            }
        }

        if(!fn_timeTableInfoCheck(form)) {
            return false;
        }

        if ($('#fcltyTimeTable').find('input.useYn').length > 0) {
            if ($('input.useYn:checked').length < 1) {
                alert("요일별 시설시간이 체크되지 않았습니다.");
                return false;
            }
        } else {
            alert("요일별 시설시간을 설정해주세요.");
            return false;
        }

        $('#fcltySchdPdVO').find('.fcltyTmPdInfo').prop('disabled', false);
        !fn_fcltySchdPdTimeCheck(form);

        return false;
    }

    <%-- DE 입력된 항목 유효성 체크 --%>
    function fn_updateFcltySchdDeCheck(form){

        if (!form.schdMthd.value) {
            alert("시설시간 등록방법을 선택해주세요.");
            $('#schdMthd2').focus();
            return false;
        }

        if ($('#fcltySchdDeVO #fcltyDeList div').length > 0) {
            $('#fcltySchdDeVO #fcltyDeList div input').each(function() {
                if($.trim($(this).val()) === '') {
                    alert("시설일자를 지정해주세요.");
                    $('#fcltySchdDeVO #fcltyDeAdd').focus();
                    return false;
                }
                if(!fn_fcltyDeCheck($(this))){
                    return false;
                }
            });
        } else {
            alert("시설일자를 지정해주세요.");
            $('#fcltySchdDeVO #fcltyDeAdd').focus();
            return false;
        }

        if ($('#fcltySchdDeVO #fcltyTmList').find('input.useYn:checked').length > 0) {

            var tmValid = true;
            $('#fcltySchdDeVO #fcltyTmList').find('input.useYn:checked').each(function() {

                var id = $(this).data("timeNo");
                $('#fcltySchdDeVO #fcltyTmList').find('#'+id).each(function(index) {
                    var fcltyBgnHh = $(this).find('.fcltyBgnHh');
                    var fcltyBgnMm = $(this).find('.fcltyBgnMm');
                    var fcltyEndHh = $(this).find('.fcltyEndHh');
                    var fcltyEndMm = $(this).find('.fcltyEndMm');

                    if(!fcltyBgnHh.val() || !fcltyBgnMm.val() || !fcltyEndHh.val() || !fcltyEndMm.val()) {
                        alert("시설시간을 선택해주세요.");
                        if(!fcltyBgnHh.val()) {
                            fcltyBgnHh.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!fcltyBgnMm.val()) {
                            fcltyBgnMm.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!fcltyEndHh.val()) {
                            fcltyEndHh.focus();
                            tmValid = false;
                            return false;
                        }
                        if(!fcltyEndMm.val()) {
                            fcltyEndMm.focus();
                            tmValid = false;
                            return false;
                        }
                    }

                    if(!tmValid) {
                        return false;
                    }

                    var fcltyBgnHm = parseInt(fcltyBgnHh.val(), 10) * 60 + parseInt(fcltyBgnMm.val(), 10);
                    var fcltyEndHm = parseInt(fcltyEndHh.val(), 10) * 60 + parseInt(fcltyEndMm.val(), 10);

                    if (fcltyEndHm <= fcltyBgnHm) {
                        alert('종료시간은 시작시간보다 커야 합니다.');
                        fcltyBgnHh.focus();
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

            !fn_fcltySchdDeTimeCheck(form);

        } else {
            alert("회차는 1개 이상 사용하셔야합니다.");
            return false;
        }

        return false;
    }

    <%-- 시간(분) → 문자열 변환 --%>
    function toTimeStr(totalMin) {
        const h = String(Math.floor(totalMin / 60)).padStart(2, '0');
        const m = String(totalMin % 60).padStart(2, '0');
        return h+':'+m;
    }

    <%-- PD 기준시간/기본시간/점심시간에 따른 회차항목 일치 여부 체크 후 form 전송 --%>
    function fn_fcltySchdPdTimeCheck(form) {

        $.ajax({
            cache    : false,
            type     : "POST",
            url      : "./fcltySchdPdTimeCheckAjax.do",
            dataType : 'json',
            data     : $(form).serialize(),
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('시설시간 유효성 검사 중 오류가 발생했습니다.');
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
                    console.log("fcltyTmList", result['fcltyTmList']);
                } else {
                    alert("시설시간 유효성 검사 중 오류가 발생했습니다.");
                    console.log("fcltyTmList", result['fcltyTmList']);
                }
            }
        });
    }

    <%-- DE 회차항목 시간대 중복 여부 체크 후 form 전송 --%>
    function fn_fcltySchdDeTimeCheck(form) {

        $.ajax({
            cache    : false,
            type     : "POST",
            url      : "./fcltySchdDeTimeCheckAjax.do",
            dataType : 'json',
            data     : $(form).serialize(),
            error    : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    alert('시설시간 유효성 검사 중 오류가 발생했습니다.');
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
                    console.log("fcltyTmList", result['fcltyTmList']);
                } else {
                    alert("시설시간 유효성 검사 중 오류가 발생했습니다.");
                    console.log("fcltyTmList", result['fcltyTmList']);
                }
            }
        });
    }

</script>

</body>
</html>
