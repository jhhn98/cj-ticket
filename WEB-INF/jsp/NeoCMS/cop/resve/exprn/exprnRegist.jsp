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
    <title>${menuInfo.cntntsNm} 등록</title>
</head>
<body>

<div class="p-wrap">

    <div class="row">
        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
        <em class="em_b_red">체험 정보 등록 후 일자/시간 등록 화면으로 이동합니다.</em>
    </div>

    <div class="row">
        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
        <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
    </div>

    <form:form modelAttribute="exprnVO" name="exprnVO" method="post" action="addExprn.do" onsubmit="return fn_addExprnCheck(this)" enctype="multipart/form-data">
        <fieldset>
            <legend>체험 등록</legend>
            <c:forEach var="result" items="${exprnSearchVO.paramsMap}">
                <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
            </c:forEach>
            <c:forEach var="result" items="${exprnSearchVO.paramsMapMng}">
                <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
            </c:forEach>
            <table class="p-table">
                <caption>체험 등록</caption>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row"><form:label path="insttNo">운영기관</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="insttNo" class="p-input p-input--auto">
                            <form:option value="" label="운영기관 선택"/>
                            <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="operYear">운영년도</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="operYear" class="p-input p-input--auto">
                            <form:option value="" label="연도 선택"/>
                            <c:set var="year" value="${fn:substring(exprnVO.today,0,4)}"/>
                            <c:forEach var="i" begin="0" end="2">
                                <form:option value="${year + i}" label="${year + i}"/>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="slctMthdCd">선발방식</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <%-- 선발방식 공통코드 - FIRST : 선착순 / CONFM : 승인 / DRWLT : 추첨 --%>
                            <c:forEach var="result" items="${slctMthdList}" varStatus="status">
                            <span class="p-form-radio">
                                <input type="radio" name="slctMthdCd" id="slctMthdCd<c:out value="${status.count}"/>" class="p-form-radio__input" value="<c:out value="${result.code}"/>"<c:if test="${status.first}"> checked</c:if>>
                                <label for="slctMthdCd<c:out value="${status.count}"/>" class="p-form-radio__label"><c:out value="${result.codeNm}"/></label>
                            </span>
                            </c:forEach>
                            <span class="p-form__split">: 추첨일자</span>
                            <form:input path="drwtDe" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" disabled="true"/>
                            <span class="p-input__addon">
                                <button type="button" class="p-input__item" id="drwtDeBtn" title="추첨일 선택" onclick="getCalendar(document.exprnVO.drwtDe);" disabled> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                            <span class="p-form__split"></span>
                            <form:select path="drwtHm" class="p-input p-input--auto text_center" disabled="true">
                                <c:forEach var="i" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${i}" pattern="00"/>
                                    <form:option value="${hh}00" label="${i}시"/>
                                </c:forEach>
                            </form:select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="rcptMthdCdArr">접수방식</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <%-- 접수방식 공통코드 - ONLIN : 온라인 / TLPHN : 전화 / VISIT : 방문 --%>
                        <c:forEach var="result" items="${rcptMthdList}" varStatus="status">
                            <span class="p-form-checkbox">
                                <input type="checkbox" name="rcptMthdCdArr" id="rcptMthdCd<c:out value="${status.count}"/>" class="p-form-checkbox__input" value="<c:out value="${result.code}"/>"<c:if test="${fn:indexOf(exprnVO.rcptMthdCd, result.code) > -1}"> checked</c:if>>
                                <label for="rcptMthdCd<c:out value="${status.count}"/>" class="p-form-checkbox__label"><c:out value="${result.codeNm}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="exprnNm">체험명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:input path="exprnNm" style="width:700px" class="p-input"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="svcTyCd">서비스유형</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <%-- 서비스유형 공통코드 - EXPSVC01 : 관람 / EXPSVC02 : 체험/레포츠 / EXPSVC03 : 관광/견학 / EXPSVC04 : 캠핑장 / EXPSVC05 : 기타 --%>
                        <form:select path="svcTyCd" class="p-input p-input--auto">
                            <form:option value="" label="서비스유형 선택"/>
                            <form:options items="${svcTyList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="areaGuCd">지역</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="areaGuCd" class="p-input p-input--auto">
                            <form:option value="" label="지역(구) 선택"/>
                            <form:options items="${areaGuList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                        <form:select path="areaEmdCd" class="p-input p-input--auto">
                            <form:option value="" label="지역(읍면동) 선택"/>
                            <form:options items="${sdguList}" itemValue="code" itemLabel="codeNm" class="areaEmdList SDGU" style="display:none;"/>
                            <form:options items="${hdguList}" itemValue="code" itemLabel="codeNm" class="areaEmdList HDGU" style="display:none;"/>
                            <form:options items="${cwguList}" itemValue="code" itemLabel="codeNm" class="areaEmdList CWGU" style="display:none;"/>
                            <form:options items="${swguList}" itemValue="code" itemLabel="codeNm" class="areaEmdList SWGU" style="display:none;"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="targetCdArr">대상</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="" id="targetCdAll" class="p-form-checkbox__input" value=""<c:if test="${fn:length(exprnVO.targetCdArr) == fn:length(targetList)}"> checked</c:if>>
                            <label for="targetCdAll" class="p-form-checkbox__label">전체</label>
                        </span>
                        <%-- 대상 공통코드 - TARGET01 : 영유아 / TARGET02 : 아동 / TARGET03 : 초등학생 / TARGET04 : 청소년 / TARGET05 : 성인 / TARGET06 : 어르신 / TARGET07 : 장애인 / TARGET08 : 기타 --%>
                        <c:forEach var="result" items="${targetList}" varStatus="status">
                            <span class="p-form-checkbox">
                                <input type="checkbox" name="targetCdArr" id="targetCd<c:out value="${status.count}"/>" class="p-form-checkbox__input" value="<c:out value="${result.code}"/>"<c:if test="${fn:indexOf(exprnVO.targetCd, result.code) > -1}"> checked</c:if>>
                                <label for="targetCd<c:out value="${status.count}"/>" class="p-form-checkbox__label"><c:out value="${result.codeNm}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="nmprSeCd">인원구분</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <%-- 인원구분 공통코드 - IND : 개인 / GRP : 단체 --%>
                        <c:forEach var="result" items="${nmprSeList}" varStatus="status">
                            <span class="p-form-checkbox">
                                <input type="checkbox" name="nmprSeCdArr" id="nmprSeCd<c:out value="${status.count}"/>" class="p-form-checkbox__input" value="<c:out value="${result.code}"/>">
                                <label for="nmprSeCd<c:out value="${status.count}"/>" class="p-form-checkbox__label"><c:out value="${result.codeNm}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="rcptBgnDt">접수기간</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <form:input path="rcptBgnDe" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                            <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.exprnVO.rcptBgnDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                            <span class="p-form__split"></span>
                            <form:select path="rcptBgnHh" class="p-input p-input--auto">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split"></span>
                            <form:select path="rcptBgnMm" class="p-input p-input--auto">
                                <c:forEach var="result" begin="0" end="59">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">~</span>
                            <form:input path="rcptEndDe" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd"/>
                            <span class="p-input__addon">
                                <button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.exprnVO.rcptEndDe);"> <!--getCalendar(document.bbsNttForm.start_date);-->
                                    <svg width="14" height="16" fill="#888" focusable="false">
                                        <use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use>
                                    </svg>
                                </button>
                            </span>
                            <span class="p-form__split"></span>
                            <form:select path="rcptEndHh" class="p-input p-input--auto">
                                <c:forEach var="result" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${result}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split"></span>
                            <form:select path="rcptEndMm" class="p-input p-input--auto">
                                <c:forEach var="result" begin="0" end="59">
                                    <fmt:formatNumber var="mm" value="${result}" pattern="00"/>
                                    <form:option value="${mm}"/>
                                </c:forEach>
                            </form:select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="placeNo">체험장소</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="placeNo" class="p-input p-input--auto">
                            <form:option value="" label="체험장소 선택"/>
                            <form:options items="${expPlaceList}" itemValue="placeNo" itemLabel="placeNm"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="exprnAmt">체험료</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-radio">
                            <input type="radio" name="exprnAmtYn" id="exprnAmtN" class="p-form-radio__input" value="N" checked>
                            <label for="exprnAmtN" class="p-form-radio__label">무료</label>
                        </span>
                        <span class="p-form-radio">
                            <input type="radio" name="exprnAmtYn" id="exprnAmtY" class="p-form-radio__input" value="Y">
                            <label for="exprnAmtY" class="p-form-radio__label">유료</label>
                        </span>
                        <input type="text" name="exprnAmtFmt" value="<c:if test="${exprnVO.exprnAmt > 0}"><c:out value="${exprnVO.exprnAmt}"/></c:if>" style="width:100px;" class="p-input p-input--auto text_right" data-mask="#,##0" data-mask-reverse="true" disabled/> 원
                        <input type="hidden" name="exprnAmt" value="<c:out value="${exprnVO.exprnAmt}"/>" disabled/>
                        <span class="p-table__content padding_l_10" id="exprnAmtWarning" style="display:none;">
                            <svg width="20" height="25" fill="#ff2a00" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle-solid"></use></svg>
                            <em class="em_b_red">체험료가 유료인 경우 결제방식, 무통장입금 정보(결제방식이 '무통장입금'인 경우 기재), 결제기한 항목을 확인해주세요.</em>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="payMthdCdArr">결제방식</form:label></th>
                    <td>
                        <%-- 결제방식 공통코드 - ELCTRN : 전자결제 / NBKRCP : 무통장입금 / DIRECT : 현장결제 --%>
                        <c:forEach var="result" items="${payMthdList}" varStatus="status">
                            <span class="p-form-checkbox">
                                <input type="checkbox" name="payMthdCdArr" id="payMthdCd<c:out value="${status.count}"/>" class="p-form-checkbox__input" value="<c:out value="${result.code}"/>" disabled>
                                <label for="payMthdCd<c:out value="${status.count}"/>" class="p-form-checkbox__label"><c:out value="${result.codeNm}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="bankNm">무통장입금 정보</form:label></th>
                    <td>
                        <div class="p-form-group w30p">
                            <span class="p-form__split">은행</span>
                            <form:input path="bankNm" class="p-input p-input--auto" disabled="true"/>
                            <span class="p-form__split"></span>
                            <span class="p-form__split">계좌번호</span>
                            <form:input path="acctNo" class="p-input p-input--auto" disabled="true"/>
                            <span class="p-form__split"></span>
                            <span class="p-form__split">예금주</span>
                            <form:input path="dpstrNm" class="p-input p-input--auto" disabled="true"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="payTmlmtCnt">결제기한</form:label></th>
                    <td>
                        <div class="p-form-group w20p">
                            <span class="p-form__split">예약일/추첨일/승인일로부터 </span>
                            <form:select path="payTmlmtCnt" class="p-input p-input--auto text_center" disabled="true">
                                <c:forEach var="i" begin="3" end="30">
                                    <form:option value="${i}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">일 이내 </span>
                            <form:select path="payTmlmtHh" class="p-input p-input--auto text_center" disabled="true">
                                <c:forEach var="i" begin="0" end="23">
                                    <fmt:formatNumber var="hh" value="${i}" pattern="00"/>
                                    <form:option value="${hh}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시 까지</span>
                        </div>
                        <span class="p-table__content padding_l_10">
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">신청자가 예약완료 후 설정된 시간(분)이내에 결제하지 않으면 예약이 자동으로 취소됩니다.</em>
                        </span>
                        <br/>
                        <span class="p-table__content padding_l_10">
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">해당 항목은 이용료가 유료인 경우에만 적용됩니다.</em>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="reqstClosCnt">신청마감일수</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w30p">
                            <span class="p-form__split">이용일 </span>
                            <form:input path="reqstClosCnt" style="width:40px;" class="p-input p-input--auto text_center"/>
                            <span class="p-form__split">일 전까지 신청가능</span>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">이용일 7일 전까지 신청가능한 경우 9월 8일은 9월 1일까지 신청가능, 9월 2일부터는 신청불가 ('0'인 경우 당일 신청 가능)</em>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="canclClosCnt">취소마감일수</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w30p">
                            <span class="p-form__split">이용일 </span>
                            <form:input path="canclClosCnt" style="width:40px;" class="p-input p-input--auto text_center"/>
                            <span class="p-form__split">일 전까지 취소가능</span>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">이용일 7일 전까지 취소가능한 경우 9월 8일은 9월 1일까지 취소가능, 9월 2일부터는 취소불가 ('0'인 경우 당일 취소 가능)</em>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="fdrmCloseDayArr">정기 휴관일(요일)</form:label></th>
                    <td>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay2" class="p-form-checkbox__input" value="2"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '2') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay2" class="p-form-checkbox__label">월</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay3" class="p-form-checkbox__input" value="3"><c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '3') > -1}"> checked</c:if>
                            <label for="fdrmCloseDay3" class="p-form-checkbox__label">화</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay4" class="p-form-checkbox__input" value="4"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '4') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay4" class="p-form-checkbox__label">수</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay5" class="p-form-checkbox__input" value="5"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '5') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay5" class="p-form-checkbox__label">목</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay6" class="p-form-checkbox__input" value="6"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '6') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay6" class="p-form-checkbox__label">금</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay7" class="p-form-checkbox__input" value="7"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '7') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay7" class="p-form-checkbox__label">토</label>
                        </span>
                        <span class="p-form-checkbox">
                            <input type="checkbox" name="fdrmCloseDayArr" id="fdrmCloseDay1" class="p-form-checkbox__input" value="1"<c:if test="${fn:indexOf(exprnVO.fdrmCloseDay, '1') > -1}"> checked</c:if>>
                            <label for="fdrmCloseDay1" class="p-form-checkbox__label">일</label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="rcritCnt">모집인원</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w30p">
                            <form:input path="rcritCnt" style="width:50px;" class="p-input p-input--auto text_center"/>
                            <span class="p-form__split">명</span>
                            <span class="p-form__split"></span>
                            <span class="p-form-checkbox">
                                <input type="checkbox" name="detailNmprUseYn" id="detailNmprUseYn" class="p-form-checkbox__input" value="Y"<c:if test="${exprnVO.detailNmprUseYn == 'Y'}"> checked</c:if>>
                                <label for="detailNmprUseYn" class="p-form-checkbox__label">세부인원 사용(성인, 청소년, 초등학생, 아동, 영유아)</label>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="nmprMinCnt">인원 제약 조건</form:label></th>
                    <td>
                        <div class="p-form-group col-2">
                            <span class="p-form__split">최소 : </span>
                            <form:input path="nmprMinCnt" style="width:50px;" class="p-input p-input--auto text_center"/>
                            <span class="p-form__split">명, </span>
                            <span class="p-form__split"></span>
                            <span class="p-form__split">최대 : </span>
                            <form:input path="nmprMaxCnt" style="width:50px;" class="p-input p-input--auto text_center"/>
                            <span class="p-form__split">명</span>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">'0'인 경우 제한없음</em>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="mtLmttTime">월 이용 제한시간</form:label></th>
                    <td>
                        <div class="p-form-group col-1">
                            <form:select path="mtLmttTime" class="p-input p-input--auto text_center">
                                <form:option value="0" label="선택"/>
                                <c:forEach var="i" begin="1" end="20">
                                    <form:option value="${i}" label="${i}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-form__split">시간</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="detailCn">상세내용</form:label></th>
                    <td>
                        <form:textarea path="detailCn" class="p-input" cols="30" rows="6"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="noticeCn">유의사항</form:label></th>
                    <td>
                        <form:textarea path="noticeCn" class="p-input" cols="30" rows="6"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="refundPlcyCn">환불정책</form:label></th>
                    <td>
                        <form:textarea path="refundPlcyCn" class="p-input" cols="30" rows="6"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="atchImg_1">이미지</label></th>
                    <td colspan="3">
                        <c:forEach var="i" begin="1" end="${cmmnAtchmnflInfoImg.fileMaxCo}">
                            <div class="p-upload">
                                <div class="p-form-group" style="width:400px;">
                                    <div class="p-form-group__upload">
                                        <input type="file" name="atchImg" id="atchImg_${i}" class="p-upload__file--hidden">
                                        <span id="atchImg_name_${i}" class="p-input disabled"></span>
                                        <button type="button" class="p-upload__clear clear">선택한 ${i}번 첨부 제거</button>
                                    </div>
                                    <div class="p-input__addon">
                                        <label for="atchImg_${i}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchImg_${i}" data-showfilename="#atchImg_name_${i}"><span class="skip">${i}번째 </span>파일선택</label>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="atchFile_1">첨부파일</label></th>
                    <td colspan="3">
                        <c:forEach var="i" begin="1" end="${cmmnAtchmnflInfoFile.fileMaxCo}">
                        <div class="p-upload">
                            <div class="p-form-group" style="width:400px;">
                                <div class="p-form-group__upload">
                                    <input type="file" name="atchFile" id="atchFile_${i}" class="p-upload__file--hidden">
                                    <span id="atchFile_name_${i}" class="p-input disabled"></span>
                                    <button type="button" class="p-upload__clear clear">선택한 ${i}번 첨부 제거</button>
                                </div>
                                <div class="p-input__addon">
                                    <label for="atchFile_${i}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchFile_${i}" data-showfilename="#atchFile_name_${i}"><span class="skip">${i}번째 </span>파일선택</label>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="aditIem1">신청자 추가 입력 항목</form:label></th>
                    <td>
                        <form:input path="aditIem1" class="p-input p-input--auto"/><br/>
                        <form:input path="aditIem2" class="p-input p-input--auto"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="resInqUseYn">거주지 조회 사용여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-radio">
                            <input type="radio" name="resInqUseYn" id="resInqUseY" class="p-form-radio__input" value="Y">
                            <label for="resInqUseY" class="p-form-radio__label">사용</label>
                        </span>
                        <span class="p-form-radio">
                            <input type="radio" name="resInqUseYn" id="resInqUseN" class="p-form-radio__input" value="N" checked>
                            <label for="resInqUseN" class="p-form-radio__label">미사용</label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="dscntUseYn">감면 사용여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <%--TODOSDB: 감면 개발 진행 중으로 사용 못하도록 비활성화 처리--%>
                        <span class="p-form-radio">
                            <input type="radio" name="dscntUseYn" id="dscntUseY" class="p-form-radio__input" value="Y" disabled>
                            <label for="dscntUseY" class="p-form-radio__label">사용</label>
                        </span>
                        <span class="p-form-radio">
                            <input type="radio" name="dscntUseYn" id="dscntUseN" class="p-form-radio__input" value="N" checked disabled>
                            <label for="dscntUseN" class="p-form-radio__label">미사용</label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="telNoFmt">문의전화</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:input path="telNoFmt" class="p-input p-input--auto" placeholder="043-123-1234"/><br/>
                        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">알림 문자는 시스템 정책에 의해 발신자가 ‘문의전화(대표번호)’로 표기됩니다.</em>
                        <em class="em_black">휴대폰번호 입력시 추후 문자 발송<em class="em_b_red">(발신자 번호로 사용)</em>이 제한될 수 있습니다.</em>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="useYn">운영여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-radio">
                            <input type="radio" name="useYn" id="useY" class="p-form-radio__input" value="Y" checked>
                            <label for="useY" class="p-form-radio__label">운영</label>
                        </span>
                            <span class="p-form-radio">
                            <input type="radio" name="useYn" id="useN" class="p-form-radio__input" value="N">
                            <label for="useN" class="p-form-radio__label">미운영</label>
                        </span>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="row margin_t_20">
                <div class="col-12">
                    <a href="./selectExprnList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <input type="submit" class="p-button write" value="등록">
                </div>
            </div>
        </fieldset>
    </form:form>

</div>

<script>

    $(document).ready(function(){

        $('#targetCdAll').on("change",function() {
            if ($(this).is(":checked")) {
                $('input[type=checkbox][name=targetCdArr]').prop('checked', true);
            } else {
                $('input[type=checkbox][name=targetCdArr]').prop('checked', false);
            }
        });

        var areaGu = $('select[name=areaGuCd]').val();
        if(areaGu != '') {
            $('#areaEmdCd option.' + areaGu).show();
        }

        $('input[name=slctMthdCd]').on("change",function() {
            if ($(this).val() == 'DRWLT') {
                $('input[name=drwtDe]').prop('disabled', false);
                $('select[name=drwtHm]').prop('disabled', false);
                $('#drwtDeBtn').prop('disabled', false);
            } else {
                $('input[name=drwtDe]').prop('disabled', true);
                $('select[name=drwtHm]').prop('disabled', true);
                $('#drwtDeBtn').prop('disabled', true);
            }
        });

        $('select[name=areaGuCd]').on("change",function(){
            $('#areaEmdCd').val('');
            $('#areaEmdCd option.areaEmdList').hide();
            $('#areaEmdCd option.' + $(this).val()).show();
        });

        $('input[name=exprnAmtYn]').on("change",function(){
            if ($(this).val() == 'Y') {
                $('#exprnAmtWarning').show();
                $('input[name=exprnAmtFmt]').prop('disabled', false);
                $('input[name=exprnAmt]').prop('disabled', false);
                $('input[name=payMthdCdArr]').prop('disabled', false);
                $('select[name=payTmlmtCnt]').prop('disabled', false);
                $('select[name=payTmlmtHh]').prop('disabled', false);
            } else {
                $('#exprnAmtWarning').hide();
                $('input[name=exprnAmtFmt]').prop('disabled', true);
                $('input[name=exprnAmt]').prop('disabled', true);
                $('input[name=payMthdCdArr]').prop('disabled', true);
                $('input[name=bankNm]').prop('disabled', true);
                $('input[name=acctNo]').prop('disabled', true);
                $('input[name=dpstrNm]').prop('disabled', true);
                $('select[name=payTmlmtCnt]').prop('disabled', true);
                $('select[name=payTmlmtHh]').prop('disabled', true);
            }
        });

        $('input[name=exprnAmtFmt]').on('input', function() {
            var original = $(this).val().replace(/\D/g, ''); // 숫자만 추출
            $('input[name=exprnAmt]').val(original); // hidden에 동기화
        });

        $('input[name=payMthdCdArr][value="NBKRCP"]').on('change', function() {
            if ($(this).is(':checked')) {
                $('input[name=bankNm]').prop('disabled', false);
                $('input[name=acctNo]').prop('disabled', false);
                $('input[name=dpstrNm]').prop('disabled', false);
            } else {
                $('input[name=bankNm]').prop('disabled', true);
                $('input[name=acctNo]').prop('disabled', true);
                $('input[name=dpstrNm]').prop('disabled', true);
            }
        });
    })

    function fn_addExprnCheck(form){

        var regexDate = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
        var regexTel1 = RegExp(/^02-\d{3,4}-\d{4}$/);
        var regexTel2 = RegExp(/^0\d{2}-\d{3,4}-\d{4}$/);

        if (!form.insttNo.value) {
            alert("운영기관을 선택해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.operYear.value) {
            alert("운영년도를 선택해주세요.");
            form.operYear.focus();
            return false;
        }

        if (!form.slctMthdCd.value) {
            alert("선발방식을 선택해주세요.");
            $('#slctMthdCd1').focus();
            return false;
        }

        if (form.slctMthdCd.value == 'DRWLT') {
            if (!form.drwtDe.value || !form.drwtHm.value) {
                alert("선발방식이 추첨인 경우 추첨일시를 입력해주세요.");

                if (!form.drwtDe.value) {
                    form.drwtDe.focus();
                    return false;
                }
                if (!form.drwtHm.value) {
                    form.drwtHm.focus();
                    return false;
                }
            }
            if(!regexDate.test(form.drwtDe.value)) {
                alert("추첨일자는 yyyy-MM-dd 형식으로 입력해주세요.");
                form.drwtDe.focus();
                return false;
            }
        }

        if ($('input[name=rcptMthdCdArr]:checked').length < 1) {
            alert("접수방식을 선택해주세요.");
            $('#rcptMthdCd1').focus();
            return false;
        }

        if (!form.exprnNm.value) {
            alert("체험명을 입력해주세요.");
            form.exprnNm.focus();
            return false;
        }

        if (!form.svcTyCd.value) {
            alert("서비스유형을 선택해주세요.");
            form.svcTyCd.focus();
            return false;
        }


        if (!form.areaGuCd.value) {
            alert("지역(구)을 선택해주세요.");
            form.areaGuCd.focus();
            return false;
        }

        if (!form.areaEmdCd.value) {
            alert("지역(읍면동)을 입력해주세요.");
            form.areaEmdCd.focus();
            return false;
        }

        if ($('input[name=targetCdArr]:checked').length < 1) {
            alert("대상을 선택해주세요.");
            $('#targetCd1').focus();
            return false;
        }

        if ($('input[name=nmprSeCdArr]:checked').length < 1) {
            alert("인원구분을 선택해주세요.");
            $('#nmprSeCd1').focus();
            return false;
        }

        if (!form.rcptBgnDe.value || !form.rcptBgnHh.value || !form.rcptBgnMm.value ||
            !form.rcptEndDe.value || !form.rcptEndHh.value || !form.rcptEndMm.value) {

            alert("접수기간을 확인해주세요.");

            if (!form.rcptBgnDe.value) {
                form.rcptBgnDe.focus();
                return false;
            }

            if (!form.rcptBgnHh.value) {
                form.rcptBgnHh.focus();
                return false;
            }

            if (!form.rcptBgnMm.value) {
                form.rcptBgnMm.focus();
                return false;
            }

            if (!form.rcptEndDe.value) {
                form.rcptEndDe.focus();
                return false;
            }

            if (!form.rcptEndHh.value) {
                form.rcptEndHh.focus();
                return false;
            }

            if (!form.rcptEndMm.value) {
                form.rcptEndHh.focus();
                return false;
            }
        } else {

            if(!regexDate.test(form.rcptBgnDe.value)) {
                alert("접수시작일은 yyyy-MM-dd 형식으로 입력해주세요.");
                form.rcptBgnDe.focus();

                return false;
            }

            if(!regexDate.test(form.rcptEndDe.value)) {
                alert("접수종료일은 yyyy-MM-dd 형식으로 입력해주세요.");
                form.rcptEndDe.focus();
                return false;
            }

            var rcptBgnDt = form.rcptBgnDe.value + form.rcptBgnHh.value + form.rcptBgnMm.value;
            var rcptEndDt = form.rcptEndDe.value + form.rcptEndHh.value + form.rcptEndMm.value;

            if (rcptBgnDt > rcptEndDt) {
                alert('접수시작일(일/시/분)이 접수종료일(일/시/분)보다 클 수 없습니다.');
                form.rcptBgnDe.focus();
                return false;
            }
        }

        if (!form.placeNo.value) {
            alert("체험장소를 선택해주세요.");
            form.placeNo.focus();
            return false;
        }

        if (!form.exprnAmtYn.value) {
            alert("체험료를 확인해주세요.");
            $('#exprnAmtN').focus();
            return false;
        }

        if (form.exprnAmtYn.value == 'Y') {

            if (!form.exprnAmt.value || form.exprnAmt.value == 0) {
                alert("체험료가 유료인 경우 금액을 입력해주세요.");
                form.exprnAmtFmt.focus();
                return false;
            }

            if ($('input[name=payMthdCdArr]:checked').length < 1) {
                alert("체험료가 유료인 경우 결제방식을 선택해주세요.");
                $('#payMthdCd1').focus();
                return false;
            }

            if ($('input[name=payMthdCdArr][value="NBKRCP"]').is(':checked')) {

                if (!form.bankNm.value) {
                    alert("결제방식이 무통장입금인 경우 무통장입금 정보(은행, 계좌번호, 예금주)를 모두 입력해주세요.");
                    form.bankNm.focus();
                    return false;
                }

                if (!form.acctNo.value) {
                    alert("결제방식이 무통장입금인 경우 무통장입금 정보(은행, 계좌번호, 예금주)를 모두 입력해주세요.");
                    form.acctNo.focus();
                    return false;
                }

                if (!form.dpstrNm.value) {
                    alert("결제방식이 무통장입금인 경우 무통장입금 정보(은행, 계좌번호, 예금주)를 모두 입력해주세요.");
                    form.dpstrNm.focus();
                    return false;
                }
            }

            if (!form.payTmlmtCnt.value) {
                alert("결제기한(일시)을 선택해주세요.");
                form.payTmlmtCnt.focus();
                return false;
            }

            if (!form.payTmlmtHh.value) {
                alert("결제기한(일시)을 선택해주세요.");
                form.payTmlmtHh.focus();
                return false;
            }
        }

        if (!form.reqstClosCnt.value) {
            alert("신청마감일수를 선택해주세요.");
            form.reqstClosCnt.focus();
            return false;
        }

        if (!form.canclClosCnt.value) {
            alert("취소마감일수를 선택해주세요.");
            form.canclClosCnt.focus();
            return false;
        }

        var rcritCnt = parseInt(form.rcritCnt.value);
        var nmprMinCnt = parseInt(form.nmprMinCnt.value);
        var nmprMaxCnt = parseInt(form.nmprMaxCnt.value);

        if (!form.rcritCnt.value || rcritCnt <= 0) {
            alert("모집인원을 입력해주세요.");
            form.rcritCnt.focus();
            return false;
        }

        if (nmprMinCnt < 0 || nmprMaxCnt < 0) {
            alert("최소인원/최대인원을 확인해주세요.");
            form.nmprMinCnt.focus();
            return false;
        }

        if (nmprMinCnt > 0 && nmprMaxCnt > 0) {
            if (nmprMinCnt > nmprMaxCnt) {
                alert("인원 제약 조건에서 최소인원이 최대인원보다 클 수 없습니다.");
                form.nmprMinCnt.focus();
                return false;
            }
        }

        if (nmprMinCnt > 0) {
            if (nmprMinCnt > rcritCnt) {
                alert("인원 제약 조건에서 최소인원이 모집인원보다 클 수 없습니다.");
                form.nmprMinCnt.focus();
                return false;
            }
        }

        if (nmprMaxCnt > 0) {
            if (nmprMaxCnt > rcritCnt) {
                alert("인원 제약 조건에서 최대인원이 모집인원보다 클 수 없습니다.");
                form.nmprMaxCnt.focus();
                return false;
            }
        }

        if (!form.dscntUseYn.value) {
            alert("감면사용여부를 확인해주세요.");
            $('#dscntUseY').focus();
            return false;
        }

        if (!form.telNoFmt.value) {
            alert("문의전화를 입력해주세요.");
            form.telNoFmt.focus();
            return false;
        }
        if (form.telNoFmt.value) {
            if(!regexTel1.test(form.telNoFmt.value) && !regexTel2.test(form.telNoFmt.value)) {
                alert("문의전화는 043-123-1234 형식으로 입력해주세요. 휴대폰번호는 추후 문자 발송(발신자 번호로 사용)이 제한될 수 있습니다.");
                form.telNoFmt.focus();
                return false;
            }
        }

        if (!form.useYn.value) {
            alert("운영여부를 확인해주세요.");
            $('#useY').focus();
            return false;
        }

        return confirm("등록하시겠습니까?");
    }

</script>

</body>
</html>
