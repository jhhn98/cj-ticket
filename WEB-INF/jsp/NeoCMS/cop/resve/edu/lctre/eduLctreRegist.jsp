<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>강좌관리 등록</title>
    <link rel="stylesheet" type="text/css" href="/common/js/jquery-ui-1.12.1/jquery-ui.css"/>
    <script type="text/javascript" src="/common/js/jquery-ui-1.12.1/jquery-ui.min.js" nonce="NEOCMSSCRIPT"></script>
</head>
<body>

<div class="p-wrap">
    <div class="row p-relative">
        <div class="col-12 margin_t_10">
            <span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
        </div>
        <div class="col-12 right margin_t_5">
            <a href="./selectEduLctreList.do?<c:out value="${eduLctreVO.params}"/>" class="p-button cancel">목록 </a>
        </div>
    </div>

    <form:form id="registForm" action="./addEduLctre.do" method="post" modelAttribute="eduLctreVO"
               onsubmit="return checkSubmit(this)" enctype="multipart/form-data">
        <fieldset>
            <legend>등록정보 작성</legend>
            <input type="hidden" name="key" value="${key}"/>
            <input type="hidden" name="prgSe" value="EDU"/>
            <c:if test="${not empty eduLctreVO.paramsMapOther}">
                <c:forEach var="map" items="${eduLctreVO.paramsMapOther}">
                    <input type="hidden" name="${map.key}" value="${map.value}"/>
                </c:forEach>
            </c:if>

            <table class="p-table">
                <colgroup>
                    <col class="w15p">
                    <col/>
                </colgroup>
                <tbody class="p-table--th-left">
                <!-- 기관명 선택 -->
                <tr>
                    <th scope="row"><label for="insttNo">기관명 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <select name="insttNo" id="insttNo" onchange="insttNoChange(this.value);" class="p-input p-input--auto">
                            <option value="">선택하세요</option>
                            <c:choose>
                                <c:when test="${not empty insttMap}">
                                    <%-- 기관담당자 또는 강사: 권한 있는 기관만 표시 --%>
                                    <c:forEach var="item" items="${insttMap}">
                                        <option value="${item.key}" <c:if test="${item.key eq eduLctreVO.insttNo}">selected</c:if>>
                                            ${item.value}
                                        </option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <%-- 최고관리자: 전체 기관 표시 --%>
                                    <c:forEach var="instt" items="${eduInsttList}">
                                        <option value="${instt.insttNo}" <c:if test="${instt.insttNo eq eduLctreVO.insttNo}">selected</c:if>>
                                            <c:out value="${instt.insttNm}"/>
                                        </option>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <form:errors path="insttNo" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 카테고리 선택 -->
                <tr>
                    <th scope="row"><label for="ctgryNo">카테고리 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="ctgryNo" id="ctgryNo" onchange="ctgryNoChange(this.value);"
                                     cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                        </form:select>
                        <form:errors path="ctgryNo" cssClass="form_error"/>
                        <span id="text_ctgryNo" class="text_red margin_l_20"></span>
                    </td>
                </tr>
                <!-- 과목 선택 -->
                <tr>
                    <th scope="row"><label for="subjectNo">과목 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="subjectNo" id="subjectNo" cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                        </form:select>
                        <form:errors path="subjectNo" cssClass="form_error"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="operYear">운영년도 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear"/>
                        <form:select path="operYear" id="operYear" cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <c:forEach var="i" begin="0" end="5">
                                <form:option value="${currentYear + i}">${currentYear + i}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="operYear" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 선발방식 -->
                <tr>
                    <th scope="row"><label for="slctMthdCd">선발방식</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <c:forEach var="result" items="${slctMthdList}" varStatus="status">
                            <span class="p-form-radio">
                                <form:radiobutton path="slctMthdCd"
                                                  id="slctMthdCd${status.count}"
                                                  cssClass="p-form-radio__input"
                                                  value="${result.code}"/>
                                <label for="slctMthdCd${status.count}" class="p-form-radio__label">
                                    <c:out value="${result.codeNm}"/>
                                </label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr id="tr_drwtDt">
                    <th scope="row"><label for="drwtDe">추첨일자</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td><c:set var="drwtDtHr" value="${fn:substring(eduLctreVO.drwtDt,8,10)}"/>
                        <c:set var="drwtDtMn" value="${fn:substring(eduLctreVO.drwtDt,10,12)}"/>
                        <c:set var="drwtDtDe" value="${fn:substring(eduLctreVO.drwtDt,0,8)}"/>
                        <c:if test="${not empty drwtDtDe}">
                            <c:set var="drwtDtDe" value="${fn:substring(drwtDtDe, 0, 4)}-${fn:substring(drwtDtDe, 4, 6)}-${fn:substring(drwtDtDe, 6, 8)}"/>
                        </c:if>

                        <div class="p-date-group" style="width:200px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="drwtDe" value="${drwtDtDe}" readonly
                                       placeholder="추첨일 선택" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                                </div>
                                <select id="drwtHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> 시
                            </div>
                            <input type="hidden" id="drwtDt" name="drwtDt" value="${eduLctreVO.drwtDt}"/>
                        </div>
                    </td>
                </tr>
                <!-- 접수방식 -->
                <tr>
                    <th scope="row"><label for="rcptMthdCd">접수방식</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <c:forEach var="item" items="${rcptMthdList}" varStatus="sts">
			<span class="p-form-checkbox">
				<form:checkbox path="rcptMthdCdList" id="rcptMthdCd${sts.index+1}" value="${item.code}"
                               cssClass="p-form-checkbox__input"/>
				<label for="rcptMthdCd${sts.index+1}" class="p-form-checkbox__label"><c:out
                        value="${item.codeNm}"/></label>
			</span>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 강좌명 -->
                <tr>
                    <th scope="row"><label for="lctreNm">교육명</label> <span class="p-form__required--icon">필수</span></th>
                    <td>
                        <form:input path="lctreNm" id="lctreNm" cssClass="p-input w70p" maxlength="100"/>
                        <form:errors path="lctreNm" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 서비스 유형 -->
                <tr>
                    <th scope="row"><label for="svcTyCd">서비스 유형</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="svcTyCd" id="svcTyCd" cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <form:options items="${svcTyCdList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                        <form:errors path="svcTyCd" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 지역 선택 -->
                <tr>
                    <th scope="row"><form:label path="areaGuCd">지역</form:label> <span
                            class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="areaGuCd" cssClass="p-input p-input--auto">
                            <form:option value="" label="지역(구) 선택"/>
                            <form:options items="${areaGuList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                        <form:select path="areaEmdCd" cssClass="p-input p-input--auto">
                            <form:option value="" label="지역(읍면동) 선택"/>
                            <form:options items="${sdguList}" itemValue="code" itemLabel="codeNm"
                                          cssClass="areaEmdList SDGU" cssStyle="display:none;"/>
                            <form:options items="${hdguList}" itemValue="code" itemLabel="codeNm"
                                          cssClass="areaEmdList HDGU" cssStyle="display:none;"/>
                            <form:options items="${cwguList}" itemValue="code" itemLabel="codeNm"
                                          cssClass="areaEmdList CWGU" cssStyle="display:none;"/>
                            <form:options items="${swguList}" itemValue="code" itemLabel="codeNm"
                                          cssClass="areaEmdList SWGU" cssStyle="display:none;"/>
                        </form:select>
                        <form:errors path="areaGuCd" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 수강대상 -->
                <tr>
                    <th scope="row"><label>수강대상</label> <span class="p-form__required--icon">필수</span></th>
                    <td>
                        <span class="p-form-checkbox">
                            <input type="checkbox" id="targetAll" class="p-form-checkbox__input" onclick="checkAllTarget(this)"/>
                            <label for="targetAll" class="p-form-checkbox__label">전체</label>
                        </span>
                        <c:forEach var="target" items="${trgetList}" varStatus="sts">
                            <span class="p-form-checkbox">
                                <form:checkbox path="targetCdList" id="target${sts.index}" value="${target.code}"
                                               cssClass="p-form-checkbox__input target-item"/>
                                <label for="target${sts.index}" class="p-form-checkbox__label"><c:out value="${target.codeNm}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 수료인정율 -->
                <tr>
                    <th scope="row"><label for="cmplApprRate">수료인정율</label> <span
                            class="p-form__required--icon">필수</span></th>
                    <td>
                        <span>전체 출석일 수의</span>
                        <form:input path="cmplApprRate" id="cmplApprRate" cssClass="p-input w5p numberonly"
                                    maxlength="3"/> %
                        <form:errors path="cmplApprRate" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 폐강기준인원 -->
                <tr>
                    <th scope="row"><label for="closeMinCnt">폐강(정원미달)</label></th>
                    <td>
                        <form:input path="closeMinCnt" id="closeMinCnt" cssClass="p-input w5p numberonly"
                                    maxlength="5"/> 명 미달 시
                    </td>
                </tr>

                <!-- 접수기간 -->
                <tr>
                    <th scope="row"><label for="rcptBgnDe">접수기간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <div class="p-date-group" style="width:600px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="rcptBgnDe" name="rcptBgnDe" value="" readonly placeholder="접수시작일"
                                       class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="rcptBgnHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="rcptBgnMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="rcptEndDe" name="rcptEndDe" value="" readonly placeholder="접수종료일"
                                       class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="rcptEndHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="rcptEndMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" id="rcptBgnDt" name="rcptBgnDt"/>
                        <input type="hidden" id="rcptEndDt" name="rcptEndDt"/>
                    </td>
                </tr>
                <!-- 추가접수기간 -->
                <tr>
                    <th scope="row"><label for="addRcptBgnDe">추가접수기간</label></th>
                    <td>
                        <span class="p-form-checkbox" style="margin-bottom:10px;display:block;">
                            <input type="checkbox" id="useAddRcptPeriod" class="p-form-checkbox__input" onclick="toggleAddRcptPeriod(this)"/>
                            <label for="useAddRcptPeriod" class="p-form-checkbox__label">추가접수기간 사용</label>
                        </span>
                        <div id="addRcptPeriodArea" style="display:none;">
                        <div class="p-date-group" style="width:600px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="addRcptBgnDe" name="addRcptBgnDe" value="" readonly
                                       placeholder="추가접수시작일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="addRcptBgnHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="addRcptBgnMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="addRcptEndDe" name="addRcptEndDe" value="" readonly
                                       placeholder="추가접수종료일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="addRcptEndHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="addRcptEndMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        </div>
                        <input type="hidden" id="addRcptBgnDt" name="addRcptBgnDt"/>
                        <input type="hidden" id="addRcptEndDt" name="addRcptEndDt"/>
                    </td>
                </tr>
                <!-- 교육기간 -->
                <tr>
                    <th scope="row"><label for="lctBgnDe">교육기간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <div class="p-date-group" style="width:400px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="lctBgnDe" name="lctBgnDe" value="" readonly placeholder="교육시작일"
                                       class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="lctEndDe" name="lctEndDe" value="" readonly placeholder="교육종료일"
                                       class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <!-- 교육시간 -->
                <tr>
                    <th scope="row"><label for="lctBgnHour">교육시간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <select id="lctBgnHour" class="p-input p-input--auto">
                            <c:forEach begin="0" end="23" var="h">
                                <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                            </c:forEach>
                        </select> :
                        <select id="lctBgnMin" class="p-input p-input--auto">
                            <c:forEach begin="0" end="59" var="i">
                                <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="lctBgnDt" name="lctBgnDt"/>
                        ~
                        <select id="lctEndHour" class="p-input p-input--auto">
                            <c:forEach begin="0" end="23" var="h">
                                <option value="${h < 10 ? '0' : ''}${h}">${h < 10 ? '0' : ''}${h}</option>
                            </c:forEach>
                        </select> :
                        <select id="lctEndMin" class="p-input p-input--auto">
                            <c:forEach begin="0" end="59" var="i">
                                <option value="${i < 10 ? '0' : ''}${i}">${i < 10 ? '0' : ''}${i}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="lctEndDt" name="lctEndDt"/>
                        <div style="margin-top:10px;">
				<span class="p-form-checkbox">
					<input type="checkbox" id="lctWeekAll" class="p-form-checkbox__input" onclick="checkAllWeek(this)"/>
					<label for="lctWeekAll" class="p-form-checkbox__label">전체</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek1" value="1"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek1" class="p-form-checkbox__label">일</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek2" value="2"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek2" class="p-form-checkbox__label">월</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek3" value="3"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek3" class="p-form-checkbox__label">화</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek4" value="4"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek4" class="p-form-checkbox__label">수</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek5" value="5"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek5" class="p-form-checkbox__label">목</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek6" value="6"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek6" class="p-form-checkbox__label">금</label>
				</span>
                            <span class="p-form-checkbox">
					<form:checkbox path="lctWeekList" id="lctWeek7" value="7"
                                   cssClass="p-form-checkbox__input lct-week-item"/>
					<label for="lctWeek7" class="p-form-checkbox__label">토</label>
				</span>
                        </div>
                    </td>
                </tr>
                <!-- 교육장소 -->
                <tr>
                    <th scope="row"><label for="placeNo">교육장소</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="placeNo" id="placeNo" cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <form:options items="${eduPlaceList}" itemValue="placeNo" itemLabel="placeNm"/>
                        </form:select>
                        <span id="text_placeNo" class="text_red margin_l_20"></span>
                        <form:errors path="placeNo" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 강사명 -->
                <tr>
                    <th scope="row"><label for="userId">강사명</label></th>
                    <td>
                        <form:select path="userId" id="userId" cssClass="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                        </form:select>
                        <span id="text_userId" class="text_red margin_l_20"></span>
                        <form:errors path="userId" cssClass="form_error"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="chrgeSe1">수강료 구분</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
			<span class="p-form-radio">
				<input type="radio" id="chrgeSe1" name="chrgeSe" value="F" onclick="chrgeSeChange(this.value);"
                       class="p-form-radio__input"/>
				<label for="chrgeSe1" class="p-form-radio__label">무료</label>
			</span> &nbsp;
                        <span class="p-form-radio margin_r_10">
				<input type="radio" id="chrgeSe2" name="chrgeSe" value="U" onclick="chrgeSeChange(this.value);"
                       class="p-form-radio__input" />
				<label for="chrgeSe2" class="p-form-radio__label">유료</label>
			</span>
                    </td>
                </tr>
                <tr class="tr_eduAmt" id="eduAmt_frm" style="display:none;">
                    <th scope="row"><label for="eduAmt">수강료 금액</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:input path="eduAmt" id="eduAmt" cssClass="p-input w10p" maxlength="10"/> 원
                        <form:errors path="eduAmt" cssClass="form_error"/>
                    </td>
                </tr>
                <!-- 결제방식 -->
                <tr id="payMthdArea" style="display:none;">
                    <th scope="row"><label for="payMthdCd">결제방식</label></th>
                    <td>
                        <c:forEach var="pay" items="${payMthdList}" varStatus="sts">
                            <span class="p-form-checkbox">
                                <form:checkbox path="payMthdCdList" id="pay${sts.index}" value="${pay.code}"
                                            cssClass="p-form-checkbox__input"/>
                                <label for="pay${sts.index}" class="p-form-checkbox__label"><c:out value="${pay.codeNm}"/></label>
                            </span>
                        </c:forEach>
                        <br/><svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black margin_t_5">유료 결제 사용을 위해서는 토스페이먼츠와 별도 계약 후 상점ID(MID)를 발급받아야 합니다.</em>
                    </td>
                </tr>
                <!-- 무통장입금 선택시 -->
                <tr id="bankInfo" style="display:none;">
                    <th scope="row"><label for="bankNm">은행정보</label></th>
                    <td>
                        <span>은행명 </span>
                        <form:input path="bankNm" id="bankNm" cssClass="p-input w20p" placeholder="은행명" maxlength="20"/><br/>
                        <span>계좌번호 </span>
                        <form:input path="acctNo" id="acctNo" cssClass="p-input w20p" placeholder="계좌번호"
                                    maxlength="20"/><br/>
                        <span>예금주명 </span>
                        <form:input path="dpstrNm" id="dpstrNm" cssClass="p-input w20p" placeholder="예금주명"
                                    maxlength="100"/>
                    </td>
                </tr>
                <!-- 모집인원/대기인원 -->
                <tr>
                    <th scope="row"><label for="onlineCnt">교육인원(대기인원)</label>
                        <span class="p-form__required--icon">필수</span></th>
                    <td>
                        <span>모집인원</span>&nbsp;
                        <form:input path="onlineCnt" id="onlineCnt" cssClass="p-input w5p numberonly" maxlength="10"/>
                        명
                        <form:errors path="onlineCnt" cssClass="form_error"/>
                        <div id="div_extperson" style="margin-top:8px;padding-top:8px;border-top:1px solid #ddd;">
                            <span>대기인원</span>&nbsp;
                            <form:input path="waitCnt" id="waitCnt" cssClass="p-input w5p numberonly" maxlength="10"/>
                            명<br/>
                            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                            <em class="em_black">"0"을 입력하시면 대기인원을 모집하지 않습니다.</em>
                            <form:errors path="waitCnt" cssClass="form_error"/>
                        </div>
                    </td>
                </tr>
                <!-- 재수강제한횟수 -->
                <tr>
                    <th scope="row"><label for="retakeNmtm">재수강제한횟수</label></th>
                    <td>
                        <form:input path="retakeNmtm" id="retakeNmtm" cssClass="p-input w5p numberonly" maxlength="3"/>
                        회<br/>
                        <svg width="20" height="20" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">"0"을 입력하시면 횟수제한 없이 설정됩니다.</em>
                    </td>
                </tr>
                <!-- 출석률미달 시 패널티 -->
                <tr>
                    <th scope="row"><label for="attendMinRate">출석률미달 시 패널티적용</label></th>
                    <td>
                        전체 출석일 수의 <form:input path="attendMinRate" id="attendMinRate" cssClass="p-input w5p numberonly"
                                              maxlength="3"/> %
                    </td>
                </tr>
                <!-- 감면사용 여부 -->
                <input type="hidden" name="dscntUseYn" value="N"/>
                <%--<tr>
                    <th scope="row"><label for="dscntUseYn1">감면사용 여부</label></th>
                    <td>
                        <span class="p-form-radio">
                            <form:radiobutton path="dscntUseYn" id="dscntUseYn1" value="Y" cssClass="p-form-radio__input"/>
                            <label for="dscntUseYn1" class="p-form-radio__label">사용</label>
                        </span>
                        <span class="p-form-radio">
                        <form:radiobutton path="dscntUseYn" id="dscntUseYn2" value="N" cssClass="p-form-radio__input"
                                          checked="checked"/>
                        <label for="dscntUseYn2" class="p-form-radio__label">미사용</label>
			            </span>
                    </td>
                </tr>--%>
                <!-- 거주지사용 여부 -->
                <tr>
                    <th scope="row"><label for="residenceUseYn1">거주지사용 여부</label></th>
                    <td>
			<span class="p-form-radio">
				<form:radiobutton path="residenceUseYn" id="residenceUseYn1" value="Y" cssClass="p-form-radio__input"/>
				<label for="residenceUseYn1" class="p-form-radio__label">사용</label>
			</span>
                        <span class="p-form-radio">
				<form:radiobutton path="residenceUseYn" id="residenceUseYn2" value="N" cssClass="p-form-radio__input"
                                  checked="checked"/>
				<label for="residenceUseYn2" class="p-form-radio__label">미사용</label>
			</span>
                    </td>
                </tr>
                <!-- 문의전화 -->
                <tr>
                    <th scope="row"><label for="telNo">문의전화 </label><span class="p-form__required--icon">필수</span></th>
                    <td>
                        <form:input path="telNo" id="telNo" cssClass="p-input w10p" maxlength="11"
                                    placeholder="숫자만 입력"/><br/>
                        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">알림 문자는 시스템 정책에 의해 발신자가 <em class="em_b_red">‘문의전화(대표번호)’</em>로 표기됩니다. 예시) 0432010000</em><br/>
                        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">휴대폰번호 입력시 추후 문자 발송<em class="em_b_red">(발신자 번호로 사용)</em>이 제한될 수 있습니다. </em>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="atchFile_1">첨부파일</label></th>
                    <td colspan="3">
                        <c:forEach var="i" begin="1" end="${cmmnAtchmnflInfoFile.fileMaxCo}">
                            <div class="p-upload">
                                <div class="p-form-group" style="width:400px;">
                                    <div class="p-form-group__upload">
                                        <input type="file" name="atchFile" id="atchFile_${i}"
                                               class="p-upload__file--hidden">
                                        <span id="atchFile_name_${i}" class="p-input disabled"></span>
                                        <button type="button" class="p-upload__clear clear">선택한 ${i}번 첨부 제거</button>
                                    </div>
                                    <div class="p-input__addon">
                                        <label for="atchFile_${i}" class="p-button p-button--small primary"
                                               data-button="upload" data-parent=".p-upload"
                                               data-original="#atchFile_${i}"
                                               data-showfilename="#atchFile_name_${i}"><span class="skip">${i}번째 </span>파일선택</label>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </td>
                </tr>

                <!-- 상세내용 -->
                <tr>
                    <th scope="row"><label for="detailCn">상세내용</label></th>
                    <td>
                        <form:textarea path="detailCn" id="detailCn" cssClass="p-input"
                                       cssStyle="width:100%;height:200px"/>
                    </td>
                </tr>
                <!-- 유의사항 -->
                <tr>
                    <th scope="row"><label for="noticeCn">유의사항</label></th>
                    <td>
                        <form:textarea path="noticeCn" id="noticeCn" cssClass="p-input"
                                       cssStyle="width:100%;height:200px"/>
                    </td>
                </tr>
                <!-- 환불정책 -->
                <tr>
                    <th scope="row"><label for="refundPlcyCn">환불정책</label></th>
                    <td>
                        <form:textarea path="refundPlcyCn" id="refundPlcyCn" cssClass="p-input"
                                       cssStyle="width:100%;height:200px"/>
                    </td>
                </tr>
                <!-- 이미지 등록 -->
                <tr>
                    <th scope="row"><label for="atchImg_1">이미지</label></th>
                    <td colspan="3">
                        <c:forEach var="i" begin="1" end="${cmmnAtchmnflInfoImg.fileMaxCo}">
                            <div class="p-upload">
                                <div class="p-form-group" style="width:400px;">
                                    <div class="p-form-group__upload">
                                        <input type="file" name="atchImg" id="atchImg_${i}"
                                               class="p-upload__file--hidden">
                                        <span id="atchImg_name_${i}" class="p-input disabled"></span>
                                        <button type="button" class="p-upload__clear clear">선택한 ${i}번 첨부 제거</button>
                                    </div>
                                    <div class="p-input__addon">
                                        <label for="atchImg_${i}" class="p-button p-button--small primary"
                                               data-button="upload" data-parent=".p-upload"
                                               data-original="#atchImg_${i}"
                                               data-showfilename="#atchImg_name_${i}"><span class="skip">${i}번째 </span>파일선택</label>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 운영여부 -->
                <tr>
                    <th scope="row"><label for="operYn1">운영여부</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
			<span class="p-form-radio">
				<form:radiobutton path="operYn" id="operYn1" value="Y" cssClass="p-form-radio__input"
                                  checked="checked"/>
				<label for="operYn1" class="p-form-radio__label">운영</label>
			</span>
                        <span class="p-form-radio">
				<form:radiobutton path="operYn" id="operYn2" value="N" cssClass="p-form-radio__input"/>
				<label for="operYn2" class="p-form-radio__label">미운영</label>
			</span>
                    </td>
                </tr>
                <!-- 폐강여부 -->
                <tr>
                    <th scope="row"><label for="closeYn1">폐강여부</label></th>
                    <td>
			<span class="p-form-radio">
				<form:radiobutton path="closeYn" id="closeYn1" value="N" cssClass="p-form-radio__input"
                                  checked="checked"/>
				<label for="closeYn1" class="p-form-radio__label">운영</label>
			</span>
                        <span class="p-form-radio">
				<form:radiobutton path="closeYn" id="closeYn2" value="Y" cssClass="p-form-radio__input"/>
				<label for="closeYn2" class="p-form-radio__label">폐강</label>
			</span>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="row margin_t_15">
                <div class="col-12">
                    <a href="./selectEduLctreList.do?<c:out value="${eduLctreVO.params}"/>" class="p-button cancel">취소</a>
                </div>
                <div class="col-12 right">
                    <button type="submit" class="p-button primary">등록</button>
                </div>
            </div>

        </fieldset>
    </form:form>
</div>

<script nonce="NEOCMSSCRIPT">
    // 과목 정보를 JavaScript 객체로 저장
    var subjectDataMap = {};
    <c:forEach var="subject" items="${eduSubjectList}">
    subjectDataMap[${subject.subjectNo}] = {
        targetCd: "${subject.targetCd}",
        targetCdList: [<c:forEach var="target" items="${subject.targetCdList}" varStatus="sts">"${target}"<c:if test="${!sts.last}">, </c:if></c:forEach>],
        svcTyCd: "${subject.svcTyCd}",
        eduBgnHm: "${subject.eduBgnHm}",
        eduEndHm: "${subject.eduEndHm}",
        eduAmt: "${subject.eduAmt}",
        chrgeSe: "${subject.chrgeSe}",
        retakeCnt: "${subject.retakeCnt}",
        attRate: "${subject.attRate}",
        detailCn: `<c:out value='${subject.detailCn}' escapeXml='false'/>`,
        noticeCn: `<c:out value='${subject.noticeCn}' escapeXml='false'/>`,
        refundPlcyCn: `<c:out value='${subject.refundPlcyCn}' escapeXml='false'/>`
    };
    </c:forEach>

    $(function () {
        // datepicker 초기화
        $(".datepicker").datepicker({
            dateFormat: "yy-mm-dd",
            showMonthAfterYear: true,
            yearSuffix: '년',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
        });

        // 숫자만 입력 가능
        $(".numberonly").on("input", function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });


        // 수강료 구분 기본값 설정 (무료)
        $("#chrgeSe1").prop('checked', true);
        chrgeSeChange('F');

        // 추첨일자 초기 표시/숨김 처리
        slctMthdCdChange();

        // 과목 선택 이벤트 연결
        $("#subjectNo").on("change", function () {
            autoFillSubjectData($(this).val());
        });

        var areaGu = $('select[name=areaGuCd]').val();
        if (areaGu != '') {
            $('#areaEmdCd option.' + areaGu).show();
        }

        $('select[name=areaGuCd]').on("change", function () {
            $('#areaEmdCd').val('');
            $('#areaEmdCd option.areaEmdList').hide();
            $('#areaEmdCd option.' + $(this).val()).show();
        });
    });

    // 자동입력 필드 초기화 함수
    function clearAutoFillFields() {
        // 서비스 유형 초기화
        $("#svcTyCd").val("");

        // 수강대상 체크박스 초기화
        $("input[name='targetCdList']").prop("checked", false);

        // 교육시간 초기화
        $("#lctBgnHour").val("00");
        $("#lctBgnMin").val("00");
        $("#lctEndHour").val("00");
        $("#lctEndMin").val("00");

        // 수강료 구분 및 금액 초기화 (무료, 금액 0)
        $("#chrgeSe1").prop('checked', true);
        $("#eduAmt").val('0');
        chrgeSeChange('F');

        // 재수강 제한횟수 초기화
        $("#retakeNmtm").val('');

        // 출석률 미달 시 패널티 초기화
        $("#attendMinRate").val('');

        // 상세내용 초기화
        $("#detailCn").val('');

        // 유의사항 초기화
        $("#noticeCn").val('');

        // 환불정책 초기화
        $("#refundPlcyCn").val('');
    }

    // 과목 선택 시 자동 입력 함수
    function autoFillSubjectData(subjectNo) {
        // 먼저 필드 초기화
        clearAutoFillFields();

        // 과목이 선택되지 않았거나 데이터가 없으면 종료
        if (!subjectNo || !subjectDataMap[subjectNo]) return;

        var data = subjectDataMap[subjectNo];

        // 서비스 유형
        if (data.svcTyCd) {
            $("#svcTyCd").val(data.svcTyCd);
        }

        // 수강대상 체크박스
        if (data.targetCdList && data.targetCdList.length > 0) {
            data.targetCdList.forEach(function (code) {
                $("input[name='targetCdList'][value='" + code + "']").prop("checked", true);
            });
        }

        // 교육시간 (HHmm 형식을 시/분으로 분리)
        if (data.eduBgnHm && data.eduBgnHm.length >= 4) {
            var bgnHour = data.eduBgnHm.substring(0, 2);
            var bgnMin = data.eduBgnHm.substring(2, 4);
            $("#lctBgnHour").val(bgnHour);
            $("#lctBgnMin").val(bgnMin);
        }
        if (data.eduEndHm && data.eduEndHm.length >= 4) {
            var endHour = data.eduEndHm.substring(0, 2);
            var endMin = data.eduEndHm.substring(2, 4);
            $("#lctEndHour").val(endHour);
            $("#lctEndMin").val(endMin);
        }

        // 수강료 구분 및 금액 (eduAmt 값에 따라 자동 설정)
        if (data.eduAmt && data.eduAmt != '0' && data.eduAmt != '') {
            // 유료
            $("#chrgeSe2").prop('checked', true);
            $("#eduAmt").val(data.eduAmt);
            chrgeSeChange('U');
        } else {
            // 무료
            $("#chrgeSe1").prop('checked', true);
            $("#eduAmt").val('0');
            chrgeSeChange('F');
        }

        // 재수강 제한횟수
/*        if (data.retakeCnt) {
            $("#retakeNmtm").val(data.retakeCnt);
        }*/

        // 출석률 미달 시 패널티
        if (data.attRate) {
            $("#attendMinRate").val(data.attRate);
        }

        // 상세내용
        if (data.detailCn) {
            $("#detailCn").val(data.detailCn);
        }

        // 유의사항
        if (data.noticeCn) {
            $("#noticeCn").val(data.noticeCn);
        }

        // 환불정책
        if (data.refundPlcyCn) {
            $("#refundPlcyCn").val(data.refundPlcyCn);
        }
    }

    // 선발방식 변경 시 추첨일자 표시/숨김 및 대기인원 활성화/비활성화
    function slctMthdCdChange() {
        var selectedValue = $("input[name='slctMthdCd']:checked").val();
        
        // 추첨일자 표시/숨김
        if (selectedValue === 'DRWLT') {
            $("#tr_drwtDt").show();
        } else {
            $("#tr_drwtDt").hide();
            $("#drwtDe").val('');
            $("#drwtHour").val('00');
            $("#drwtDt").val('');
        }
        
        // 대기인원 활성화/비활성화 (승인 또는 추첨일 경우 비활성화)
        if (selectedValue === 'CONFM' || selectedValue === 'DRWLT') {
            $("#waitCnt").attr('disabled', true);
            $("#waitCnt").val('0');
            $("#waitCnt").addClass('disabled');
        } else {
            $("#waitCnt").attr('disabled', false);
            $("#waitCnt").removeClass('disabled');
        }
    }

    // 선발방식 라디오 버튼 변경 이벤트
    $("input[name='slctMthdCd']").on("change", function () {
        slctMthdCdChange();
    });

    // 기관명 선택 이벤트
    function insttNoChange(val) {
        // 자동입력 필드 초기화
        clearAutoFillFields();

        // 카테고리 처리
        var isValCtgry = false;
        $('#ctgryNo').empty();
        $('#ctgryNo').append('<option value="">선택하세요</option>');
        <c:forEach var="result" items="${eduCategoryList}">
        if (val == "${result.insttNo}") {
            var option = $("<option value=\"${result.ctgryNo}\">${result.ctgryNm}</option>");
            $('#ctgryNo').append(option);
            isValCtgry = true;
        }
        </c:forEach>
        if (!isValCtgry) {
            $('#ctgryNo').append('<option value="">카테고리 없음</option>');
            $('#ctgryNo').attr("disabled", true);
            $('#text_ctgryNo').text("※ 연동된 카테고리가 없습니다.");
        } else {
            $('#ctgryNo').attr("disabled", false);
            $('#text_ctgryNo').text("");
        }

        // 과목 초기화
        $('#subjectNo').empty();
        $('#subjectNo').append('<option value="">선택하세요</option>');

        // 교육장소 처리
        var isValPlace = false;
        $('#placeNo').empty();
        $('#placeNo').append('<option value="">선택하세요</option>');
        <c:forEach var="place" items="${eduPlaceList}">
        if (val == "${place.insttNo}") {
            var option = $("<option value=\"${place.placeNo}\">${place.placeNm}</option>");
            $('#placeNo').append(option);
            isValPlace = true;
        }
        </c:forEach>
        if (!isValPlace) {
            $('#placeNo').append('<option value="">교육장소 없음</option>');
            $('#placeNo').attr("disabled", true);
            $('#text_placeNo').text("※ 기관과 연동된 교육장소가 없습니다.");
        } else {
            $('#placeNo').attr("disabled", false);
            $('#text_placeNo').text("");
        }

        // 강사 처리
        var isValInstr = false;
        $('#userId').empty();
        $('#userId').append('<option value="">선택하세요</option>');
        <c:forEach var="instr" items="${eduInstrList}">
        if (val == "${instr.insttNo}") {
            var option = $("<option value=\"${instr.userId}\">${instr.instrNm}</option>");
            $('#userId').append(option);
            isValInstr = true;
        }
        </c:forEach>
        if (!isValInstr) {
            $('#userId').append('<option value="">강사 없음</option>');
            $('#userId').attr("disabled", true);
            $('#text_userId').text("※ 연동된 강사가 없습니다.");
        } else {
            $('#userId').attr("disabled", false);
            $('#text_userId').text("");
        }
    }

    // 카테고리 선택 이벤트
    function ctgryNoChange(val) {
        // 자동입력 필드 초기화
        clearAutoFillFields();

        var isVal = false;
        $('#subjectNo').empty();
        $('#subjectNo').append('<option value="">선택하세요</option>');
        <c:forEach var="result" items="${eduSubjectList}">
        if (val == "${result.ctgryNo}") {
            var option = $("<option value=\"${result.subjectNo}\">${result.subjectNm}</option>");
            $('#subjectNo').append(option);
            isVal = true;
        }
        </c:forEach>
        if (!isVal) {
            $('#subjectNo').append('<option value="">과목 없음</option>');
            $('#subjectNo').attr("disabled", true);
        } else {
            $('#subjectNo').attr("disabled", false);
        }
    }

    // 수강대상 전체 체크박스
    function checkAllTarget(checkbox) {
        $(".target-item").prop("checked", checkbox.checked);
    }

    // 개별 수강대상 체크박스 클릭 시 전체 체크박스 상태 업데이트
    $(".target-item").on("change", function () {
        var total = $(".target-item").length;
        var checked = $(".target-item:checked").length;
        $("#targetAll").prop("checked", total === checked);
    });

    // 요일 전체 체크박스
    function checkAllWeek(checkbox) {
        $(".lct-week-item").prop("checked", checkbox.checked);
        if (!checkbox.checked) {
            $(".lct-week-item").prop("checked", false);
        }
    }

    // 개별 요일 체크박스 클릭 시 전체 체크박스 상태 업데이트
    $(".lct-week-item").on("change", function () {
        var total = $(".lct-week-item").length;
        var checked = $(".lct-week-item:checked").length;
        $("#lctWeekAll").prop("checked", total === checked);
    });

    //수강료 구분 선택 이벤트
    function chrgeSeChange(val) {
        if (val == 'U') {
            // 유료: 수강료 금액 및 결제방식 영역 표시
            $('#eduAmt').removeAttr("disabled");
            $('.tr_eduAmt').show();
            $('#payMthdArea').show();
            var eduAmtTy = $('input[name=eduAmtTy]:checked').val();
            if (typeof eduAmtTyChange === 'function') {
                eduAmtTyChange(eduAmtTy);
            }
        } else {
            // 무료: 수강료 금액 및 결제방식 영역 숨김, 모든 값 초기화
            $('#eduAmt').val("0");
            $('#eduAmt').attr("disabled", true);
            $("#chrgeSe1").prop('checked', true);
            $('.tr_eduAmt').hide();

            // 결제방식 영역 숨김 및 초기화
            $('#payMthdArea').hide();
            $("input[name='payMthdCdList']").prop('checked', false);

            // 은행정보 숨김 및 초기화
            $('#bankInfo').hide();
            $('#bankNm').val('');
            $('#acctNo').val('');
            $('#dpstrNm').val('');

            if (typeof eduAmtTyChange === 'function') {
                eduAmtTyChange("P");
            }
        }
    }

    // 결제방식에 따라 은행정보 표시/숨김
    $("input[name='payMthdCdList']").on("change", function () {
        var checked = $("input[name='payMthdCdList']:checked");
        var showBank = false;
        checked.each(function () {
            if ($(this).val().indexOf("무통장") >= 0 || $(this).val() == "NBKRCP") {
                showBank = true;
            }
        });

        if (showBank) {
            $("#bankInfo").show();
        } else {
            $("#bankInfo").hide();
        }
    });

    // 추가접수기간 사용 여부에 따라 표시/숨김
    function toggleAddRcptPeriod(checkbox) {
        if (checkbox.checked) {
            $("#addRcptPeriodArea").show();
        } else {
            $("#addRcptPeriodArea").hide();
            // 체크 해제 시 값 초기화
            $("#addRcptBgnDe").val('');
            $("#addRcptBgnHour").val('00');
            $("#addRcptBgnMin").val('00');
            $("#addRcptEndDe").val('');
            $("#addRcptEndHour").val('00');
            $("#addRcptEndMin").val('00');
            $("#addRcptBgnDt").val('');
            $("#addRcptEndDt").val('');
        }
    }

    // 폼 유효성 검사
    function checkSubmit(frm) {
        // 기관명 필수 체크
        if (!frm.insttNo.value) {
            alert("기관명을 선택해주세요.");
            frm.insttNo.focus();
            return false;
        }

        // 카테고리 필수 체크
        if (!frm.ctgryNo.value) {
            alert("카테고리를 선택해주세요.");
            frm.ctgryNo.focus();
            return false;
        }

        // 과목 필수 체크
        if (!frm.subjectNo.value) {
            alert("과목을 선택해주세요.");
            frm.subjectNo.focus();
            return false;
        }

        // 운영년도 필수 체크
        if (!frm.operYear.value) {
            alert("운영년도를 선택해주세요.");
            frm.operYear.focus();
            return false;
        }

        // 선발방식 필수 체크
        if (!$('input[name="slctMthdCd"]:checked').val()) {
            alert("선발방식을 선택해주세요.");
            $('#slctMthdCd1').focus();
            return false;
        }

        // 선발방식이 추첨일 경우 추첨일자 필수 체크
        if ($('input[name="slctMthdCd"]:checked').val() === 'DRWLT') {
            if (!$('#drwtDe').val()) {
                alert("추첨일자를 설정해주세요.");
                $('#drwtDe').focus();
                return false;
            }
        }

        // 접수방식 필수 체크
        if ($('input[name="rcptMthdCdList"]:checked').length == 0) {
            alert("접수방식을 선택해주세요.");
            $('#rcptMthdCd1').focus();
            return false;
        }

        // 교육명 필수 체크
        if (!frm.lctreNm.value.trim()) {
            alert("교육명을 입력해주세요.");
            frm.lctreNm.focus();
            return false;
        }

        // 서비스유형 필수 체크
        if (!frm.svcTyCd.value) {
            alert("서비스유형을 선택해주세요.");
            frm.svcTyCd.focus();
            return false;
        }

        // 지역 필수 체크
        if (!frm.areaGuCd.value) {
            alert("지역(구)을 선택해주세요.");
            frm.areaGuCd.focus();
            return false;
        }

        // 수강대상 필수 체크
        if ($('input[name="targetCdList"]:checked').length == 0) {
            alert("수강대상을 선택해주세요.");
            $('#target0').focus();
            return false;
        }

        // 수료인정율 필수 체크
        if (!frm.cmplApprRate.value.trim()) {
            alert("수료인정율을 입력해주세요.");
            frm.cmplApprRate.focus();
            return false;
        }
        if (isNaN(frm.cmplApprRate.value) || frm.cmplApprRate.value < 0 || frm.cmplApprRate.value > 100) {
            alert("수료인정율은 0~100 사이의 숫자를 입력해주세요.");
            frm.cmplApprRate.focus();
            return false;
        }

        // 접수기간 필수 체크
        if (!$('#rcptBgnDe').val()) {
            alert("접수시작일을 선택해주세요.");
            $('#rcptBgnDe').focus();
            return false;
        }
        if (!$('#rcptEndDe').val()) {
            alert("접수종료일을 선택해주세요.");
            $('#rcptEndDe').focus();
            return false;
        }

        // 접수기간 시작/종료일 순서 체크
        if ($('#rcptBgnDe').val() && $('#rcptEndDe').val()) {
            var rcptBgnDeVal = $('#rcptBgnDe').val().replace(/-/g, '');
            var rcptEndDeVal = $('#rcptEndDe').val().replace(/-/g, '');
            if (parseInt(rcptBgnDeVal, 10) > parseInt(rcptEndDeVal, 10)) {
                alert("접수종료일은 접수시작일보다 같거나 이후여야 합니다.");
                $('#rcptEndDe').focus();
                return false;
            }
        }

        // 교육기간 필수 체크
        if (!$('#lctBgnDe').val()) {
            alert("교육시작일을 선택해주세요.");
            $('#lctBgnDe').focus();
            return false;
        }
        if (!$('#lctEndDe').val()) {
            alert("교육종료일을 선택해주세요.");
            $('#lctEndDe').focus();
            return false;
        }

        // 교육기간 시작/종료일 순서 체크
        if ($('#lctBgnDe').val() && $('#lctEndDe').val()) {
            var lctBgnDeVal = $('#lctBgnDe').val().replace(/-/g, '');
            var lctEndDeVal = $('#lctEndDe').val().replace(/-/g, '');
            if (parseInt(lctBgnDeVal, 10) > parseInt(lctEndDeVal, 10)) {
                alert("교육종료일은 교육시작일보다 같거나 이후여야 합니다.");
                $('#lctEndDe').focus();
                return false;
            }
        }

        // 교육시간 필수 체크
        if (!$('#lctBgnHour').val() || !$('#lctBgnMin').val()) {
            alert("교육시작시간을 선택해주세요.");
            $('#lctBgnHour').focus();
            return false;
        }
        if (!$('#lctEndHour').val() || !$('#lctEndMin').val()) {
            alert("교육종료시간을 선택해주세요.");
            $('#lctEndHour').focus();
            return false;
        }

        // 요일 필수 체크
        if ($('input[name="lctWeekList"]:checked').length == 0) {
            alert("교육요일을 선택해주세요.");
            $('#lctWeek1').focus();
            return false;
        }

        // 교육장소 필수 체크
        if (!frm.placeNo.value) {
            alert("교육장소를 선택해주세요.");
            frm.placeNo.focus();
            return false;
        }

        // 강사명 필수 체크
        /*if (!frm.userId.value) {
            alert("강사명을 선택해주세요.");
            frm.userId.focus();
            return false;
        }*/

        // 수강료구분 필수 체크
        if (!$('input[name="chrgeSe"]:checked').val()) {
            alert("수강료구분을 선택해주세요.");
            $('#chrgeSe1').focus();
            return false;
        }

        // 유료 선택 시 수강료 금액 필수 체크
        if ($('input[name="chrgeSe"]:checked').val() == 'U') {
            if (!frm.eduAmt.value.trim()) {
                alert("수강료 금액을 입력해주세요.");
                frm.eduAmt.focus();
                return false;
            }

            // 무통장입금 선택 시 은행정보 필수 체크
            var isBankSelected = false;
            $('input[name="payMthdCdList"]:checked').each(function() {
                if ($(this).val().indexOf("무통장") >= 0 || $(this).val() == "NBKRCP") {
                    isBankSelected = true;
                }
            });

            if (isBankSelected) {
                if (!frm.bankNm.value.trim()) {
                    alert("은행명을 입력해주세요.");
                    frm.bankNm.focus();
                    return false;
                }
                if (!frm.acctNo.value.trim()) {
                    alert("계좌번호를 입력해주세요.");
                    frm.acctNo.focus();
                    return false;
                }
                if (!frm.dpstrNm.value.trim()) {
                    alert("예금주명을 입력해주세요.");
                    frm.dpstrNm.focus();
                    return false;
                }
            }
        }

        // 모집인원 필수 체크
        if (!frm.onlineCnt.value.trim()) {
            alert("모집인원을 입력해주세요.");
            frm.onlineCnt.focus();
            return false;
        }
        if (isNaN(frm.onlineCnt.value) || frm.onlineCnt.value < 0) {
            alert("모집인원은 0 이상의 숫자를 입력해주세요.");
            frm.onlineCnt.focus();
            return false;
        }

        // 대기인원 필수 체크
        if (!frm.waitCnt.value.trim()) {
            alert("대기인원을 입력해주세요.");
            frm.waitCnt.focus();
            return false;
        }
        if (isNaN(frm.waitCnt.value) || frm.waitCnt.value < 0) {
            alert("대기인원은 0 이상의 숫자를 입력해주세요.");
            frm.waitCnt.focus();
            return false;
        }

        // 운영여부 필수 체크
        if (!$('input[name="operYn"]:checked').val()) {
            alert("운영여부를 선택해주세요.");
            $('#operYn1').focus();
            return false;
        }

        // 날짜 형식 변환 및 시간 정보 합치기
        // 추첨일 - 날짜와 시간을 합쳐서 YYYYMMDDHHmm 형식으로 변환
        if ($("#drwtDe").val()) {
            var drwtDe = $("#drwtDe").val().replace(/-/g, '');
            var drwtHm = $("#drwtHour").val() + "00";
            $("#drwtDt").val(drwtDe + drwtHm);
        } else {
             $("#drwtDt").val("");
        }

        // 접수기간 - 날짜와 시간을 합쳐서 YYYYMMDDHHmm 형식으로 변환
        if ($("#rcptBgnDe").val()) {
            var rcptBgnDe = $("#rcptBgnDe").val().replace(/-/g, '');
            var rcptBgnHm = $("#rcptBgnHour").val() + $("#rcptBgnMin").val();
            $("#rcptBgnDt").val(rcptBgnDe + rcptBgnHm);
        }
        if ($("#rcptEndDe").val()) {
            var rcptEndDe = $("#rcptEndDe").val().replace(/-/g, '');
            var rcptEndHm = $("#rcptEndHour").val() + $("#rcptEndMin").val();
            $("#rcptEndDt").val(rcptEndDe + rcptEndHm);
        }

        // 추가접수기간 - 날짜와 시간을 합쳐서 YYYYMMDDHHmm 형식으로 변환
        if ($("#addRcptBgnDe").val()) {
            var addRcptBgnDe = $("#addRcptBgnDe").val().replace(/-/g, '');
            var addRcptBgnHm = $("#addRcptBgnHour").val() + $("#addRcptBgnMin").val();
            $("#addRcptBgnDt").val(addRcptBgnDe + addRcptBgnHm);
        }
        if ($("#addRcptEndDe").val()) {
            var addRcptEndDe = $("#addRcptEndDe").val().replace(/-/g, '');
            var addRcptEndHm = $("#addRcptEndHour").val() + $("#addRcptEndMin").val();
            $("#addRcptEndDt").val(addRcptEndDe + addRcptEndHm);
        }

        // 추가접수기간 체크박스가 체크된 경우 시작일/종료일 필수 체크
        if ($("#useAddRcptPeriod").is(":checked")) {
            if ($("#addRcptBgnDt").val() && !$("#addRcptEndDt").val()) {
                alert("추가접수종료일을 입력해주세요.");
                $("#addRcptEndDe").focus();
                return false;
            }
            if (!$("#addRcptBgnDt").val() && $("#addRcptEndDt").val()) {
                alert("추가접수시작일을 입력해주세요.");
                $("#addRcptBgnDe").focus();
                return false;
            }
        }

        // 추가접수기간 시작/종료 (날짜+시간) 순서 체크
        if ($("#addRcptBgnDt").val() && $("#addRcptEndDt").val()) {
            if (parseInt($("#addRcptBgnDt").val(), 10) > parseInt($("#addRcptEndDt").val(), 10)) {
                alert("추가접수종료일시는 추가접수시작일시보다 같거나 이후여야 합니다.");
                $("#addRcptEndDe").focus();
                return false;
            }
        }

        // 강좌기간 - 날짜와 시간을 합쳐서 YYYYMMDDHHmm 형식으로 변환
        if ($("#lctBgnDe").val()) {
            var lctBgnDe = $("#lctBgnDe").val().replace(/-/g, '');
            var lctBgnHm = $("#lctBgnHour").val() + $("#lctBgnMin").val();
            $("#lctBgnDt").val(lctBgnDe + lctBgnHm);
        }
        if ($("#lctEndDe").val()) {
            var lctEndDe = $("#lctEndDe").val().replace(/-/g, '');
            var lctEndHm = $("#lctEndHour").val() + $("#lctEndMin").val();
            $("#lctEndDt").val(lctEndDe + lctEndHm);
        }

        // 강좌기간 시작/종료 (날짜+시간) 순서 체크
        if ($("#lctBgnDt").val() && $("#lctEndDt").val()) {
            if (parseInt($("#lctBgnDt").val(), 10) > parseInt($("#lctEndDt").val(), 10)) {
                alert("강좌종료일시는 강좌시작일시보다 같거나 이후여야 합니다.");
                $("#lctEndDe").focus();
                return false;
            }
        }

        // 문의전화 필수 체크
        if (!frm.telNo.value.trim()) {
            alert("문의전화번호를 입력해주세요.");
            frm.telNo.focus();
            return false;
        }
        // 문의전화 형식 체크
        var telNo = frm.telNo.value.trim();
        var mobilePattern = /^(01[0-9])\d{7,8}$/;
        if (mobilePattern.test(telNo)) {
            alert("문의전화는 0431231234 형식으로 입력해주세요. 휴대폰번호는 추후 문자 발송(발신자 번호로 사용)이 제한될 수 있습니다.");
            frm.telNo.focus();
            return false;
        }
        var areaCodePattern = /^(0[2-9]{1,2})\d{7,9}$/;
        if (!areaCodePattern.test(telNo)) {
            alert("문의전화는 지역번호를 포함하여 입력해주세요. (예: 0431231234)");
            frm.telNo.focus();
            return false;
        }

        // 최종 등록 확인
        if (!confirm("등록하시겠습니까?")) {
            return false;
        }

        return true;
    }

    // 강사 검색 팝업
    // function openInstrSearch() {
    // 	window.open('./popupInstrSearch.do', 'instrSearch', 'width=800,height=600,scrollbars=yes');
    // }
</script>
</body>
</html>
