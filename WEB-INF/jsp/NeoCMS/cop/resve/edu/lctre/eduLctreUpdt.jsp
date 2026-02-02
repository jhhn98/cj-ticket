<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>강좌관리 수정</title>
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
            <a href="/${menuInfo.siteId}/selectEduLctreList.do?<c:out value="${eduLctreSearchVO.params}"/>"
               class="p-button cancel">목록 </a>
        </div>
    </div>

    <form:form id="updtForm" action="./updateEduLctre.do" method="post" modelAttribute="eduLctreVO"
               enctype="multipart/form-data">
        <fieldset>
            <legend>수정정보 작성</legend>
            <input type="hidden" name="key" value="${key}"/>
            <input type="hidden" name="prgSe" value="EDU"/>
            <input type="hidden" name="lctreNo" value="${eduLctreVO.lctreNo}"/>
            <c:if test="${not empty eduLctreSearchVO.paramsMapOther}">
                <c:forEach var="map" items="${eduLctreSearchVO.paramsMapOther}">
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
                        <span id="error_insttNo" class="form_error"></span>
                    </td>
                </tr>
                <!-- 카테고리 선택 -->
                <tr>
                    <th scope="row"><label for="ctgryNo">카테고리 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="ctgryNo" id="ctgryNo" onchange="ctgryNoChange(this.value);"
                                     class="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <form:options items="${eduCategoryList}" itemValue="ctgryNo" itemLabel="ctgryNm"/>
                        </form:select>
                        <span id="error_ctgryNo" class="form_error"></span>
                        <span id="text_ctgryNo" class="text_red margin_l_20"></span>
                    </td>
                </tr>
                <!-- 과목 선택 -->
                <tr>
                    <th scope="row"><label for="subjectNo">과목 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <form:select path="subjectNo" id="subjectNo" class="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <form:options items="${eduSubjectList}" itemValue="subjectNo" itemLabel="subjectNm"/>
                        </form:select>
                        <span id="error_subjectNo" class="form_error"></span>
                    </td>
                </tr>
                <!-- 운영년도 선택 -->
                <tr>
                    <th scope="row"><label for="operYear">운영년도 선택</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear"/>
                        <form:select path="operYear" id="operYear" class="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <c:forEach var="i" begin="0" end="5">
                                <form:option value="${currentYear + i}">${currentYear + i}</form:option>
                            </c:forEach>
                        </form:select>
                        <span id="error_operYear" class="form_error"></span>
                    </td>
                </tr>
                <!-- 강좌명 -->
                <tr>
                    <th scope="row"><label for="lctreNm">강좌명</label> <span class="p-form__required--icon">필수</span></th>
                    <td>
                        <input type="text" id="lctreNm" name="lctreNm" value="<c:out value='${eduLctreVO.lctreNm}'/>"
                               class="p-input w70p" maxlength="100"/>
                        <span id="error_lctreNm" class="form_error"></span>
                    </td>
                </tr>
                <!-- 선발방식 -->
                <tr>
                    <th scope="row"><label for="slctMthdCd">선발방식</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <c:forEach var="result" items="${slctMthdList}" varStatus="status">
                            <%-- 추첨은 우선 숨김처리 --%>
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
                    <th scope="row"><label for="drwtDt">추첨일자</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <c:set var="drwtDtHr" value="${fn:substring(eduLctreVO.drwtDt,8,10)}"/>
                        <c:set var="drwtDtMn" value="${fn:substring(eduLctreVO.drwtDt,10,12)}"/>
                        <c:if test="${not empty eduLctreVO.drwtDt && fn:length(eduLctreVO.drwtDt) >= 8}">
                            <c:set var="drwtDtFormat"
                                   value="${fn:substring(eduLctreVO.drwtDt, 0, 4)}-${fn:substring(eduLctreVO.drwtDt, 4, 6)}-${fn:substring(eduLctreVO.drwtDt, 6, 8)}"/>
                        </c:if>
                        <div class="p-date-group" style="width:200px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="drwtDe" value="${drwtDtFormat}" readonly
                                       placeholder="추첨일 선택" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="drwtHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <c:set var="hh" value="${h < 10 ? '0' : ''}${h}"/>
                                        <option value="${hh}" <c:if test="${drwtDtHr eq hh}">selected</c:if>>${hh}</option>
                                    </c:forEach>
                                </select> 시
                            </div>
                            <input type="hidden" id="drwtDt" name="drwtDt" value="${eduLctreVO.drwtDt}"/>
                        </div>
                    </td>
                </tr>
                <!-- 접수방식 -->
                <tr>
                    <th scope="row"><label for="rcptMthdCd">접수방식</label></th>
                    <td>
                        <c:forEach var="item" items="${rcptMthdList}" varStatus="sts">
							<span class="p-form-checkbox">
								<c:set var="isChecked" value="false"/>
								<c:if test="${eduLctreVO.rcptMthdCdList != null}">
									<c:forEach var="selected" items="${eduLctreVO.rcptMthdCdList}">
										<c:if test="${selected eq item.code}">
											<c:set var="isChecked" value="true"/>
										</c:if>
									</c:forEach>
								</c:if>
								<input type="checkbox" id="rcptMthdCd${sts.index+1}" name="rcptMthdCdList"
									   value="${item.code}"${isChecked ? ' checked':''} class="p-form-checkbox__input"/>
								<label for="rcptMthdCd${sts.index+1}" class="p-form-checkbox__label">
									<c:out value="${item.codeNm}"/></label>
							</span>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 서비스 유형 -->
                <tr>
                    <th scope="row"><label for="svcTyCd">서비스 유형 선택</label></th>
                    <td>
                        <form:select path="svcTyCd" id="svcTyCd" class="p-input p-input--auto">
                            <form:option value="">선택하세요</form:option>
                            <form:options items="${svcTyCdList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                    </td>
                </tr>
                <!-- 지역 선택 -->
                <tr>
                    <th scope="row"><form:label path="areaGuCd">지역</form:label> <span
                            class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select path="areaGuCd" class="p-input p-input--auto">
                            <form:option value="" label="지역(구) 선택"/>
                            <form:options items="${areaGuList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                        <form:select path="areaEmdCd" class="p-input p-input--auto">
                            <form:option value="" label="지역(읍면동) 선택"/>
                            <form:options items="${sdguList}" itemValue="code" itemLabel="codeNm"
                                          class="areaEmdList SDGU" style="display:none;"/>
                            <form:options items="${hdguList}" itemValue="code" itemLabel="codeNm"
                                          class="areaEmdList HDGU" style="display:none;"/>
                            <form:options items="${cwguList}" itemValue="code" itemLabel="codeNm"
                                          class="areaEmdList CWGU" style="display:none;"/>
                            <form:options items="${swguList}" itemValue="code" itemLabel="codeNm"
                                          class="areaEmdList SWGU" style="display:none;"/>
                        </form:select>
                    </td>
                </tr>
                <!-- 교육장소 -->
                <tr>
                    <th scope="row"><label for="placeNo">교육장소</label></th>
                    <td>
                        <select id="placeNo" name="placeNo" class="p-input p-input--auto">
                            <option value="">선택하세요</option>
                            <c:forEach var="item" items="${eduPlaceList}">
                                <option value="${item.placeNo}"${item.placeNo eq eduLctreVO.placeNo ? ' selected':''}>
                                    <c:out value="${item.placeNm}"/></option>
                            </c:forEach>
                        </select>
                        <span id="error_placeNo" class="form_error"></span>
                        <span id="text_placeNo" class="text_red margin_l_20"></span>
                    </td>
                </tr>
                <!-- 수강대상 -->
                <tr>
                    <th scope="row"><label>대상</label></th>
                    <td>
                        <span class="p-form-checkbox">
                            <input type="checkbox" id="targetAll" class="p-form-checkbox__input" onclick="checkAllTarget(this)"/>
                            <label for="targetAll" class="p-form-checkbox__label">전체</label>
                        </span>
                        <c:forEach var="target" items="${trgetList}" varStatus="status">
							<span class="p-form-checkbox">
								<input type="checkbox"
									   id="target${status.index}"
									   name="targetCdList"
									   value="${target.code}"
									   class="p-form-checkbox__input target-item"
									   <c:if test="${not empty eduLctreVO.targetCd and fn:contains(eduLctreVO.targetCd, target.code)}">checked="checked"</c:if>>
								<label for="target${status.index}" class="p-form-checkbox__label">
									<c:out value="${target.codeNm}"/></label>
							</span>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 수료인정율 -->
                <tr>
                    <th scope="row"><label for="cmplApprRate">수료인정율</label></th>
                    <td>
                        <span>전체 출석일 수의</span>
                        <input type="text" id="cmplApprRate" name="cmplApprRate"
                               value="<c:out value='${eduLctreVO.cmplApprRate}'/>" class="p-input w5p numberonly"
                               maxlength="3"/> %
                    </td>
                </tr>
                <!-- 폐강기준인원 -->
                <tr>
                    <th scope="row"><label for="closeMinCnt">폐강기준인원</label></th>
                    <td>
                        <input type="text" id="closeMinCnt" name="closeMinCnt"
                               value="<c:out value='${eduLctreVO.closeMinCnt}'/>" class="p-input w5p numberonly"
                               maxlength="5"/> 명 미달시
                    </td>
                </tr>
                <!-- 접수기간 -->
                <c:if test="${not empty eduLctreVO.rcptBgnDt && fn:length(eduLctreVO.rcptBgnDt) >= 12}">
                    <c:set var="rcptBgnDe" value="${fn:substring(eduLctreVO.rcptBgnDt, 0, 8)}"/>
                    <c:set var="rcptBgnHour" value="${fn:substring(eduLctreVO.rcptBgnDt, 8, 10)}"/>
                    <c:set var="rcptBgnMin" value="${fn:substring(eduLctreVO.rcptBgnDt, 10, 12)}"/>
                    <c:set var="rcptBgnDeFormat"
                           value="${fn:substring(rcptBgnDe, 0, 4)}-${fn:substring(rcptBgnDe, 4, 6)}-${fn:substring(rcptBgnDe, 6, 8)}"/>
                </c:if>
                <c:if test="${not empty eduLctreVO.rcptEndDt && fn:length(eduLctreVO.rcptEndDt) >= 12}">
                    <c:set var="rcptEndDe" value="${fn:substring(eduLctreVO.rcptEndDt, 0, 8)}"/>
                    <c:set var="rcptEndHour" value="${fn:substring(eduLctreVO.rcptEndDt, 8, 10)}"/>
                    <c:set var="rcptEndMin" value="${fn:substring(eduLctreVO.rcptEndDt, 10, 12)}"/>
                    <c:set var="rcptEndDeFormat"
                           value="${fn:substring(rcptEndDe, 0, 4)}-${fn:substring(rcptEndDe, 4, 6)}-${fn:substring(rcptEndDe, 6, 8)}"/>
                </c:if>
                <tr>
                    <th scope="row"><label for="rcptBgnDe">접수기간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <div class="p-date-group" style="width:600px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="rcptBgnDe" name="rcptBgnDe" value="${rcptBgnDeFormat}" readonly
                                       placeholder="접수시작일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="rcptBgnHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}"${rcptBgnHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="rcptBgnMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                        <option value="${minuteStr}"${rcptBgnMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="rcptEndDe" name="rcptEndDe" value="${rcptEndDeFormat}" readonly
                                       placeholder="접수종료일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="rcptEndHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}"${rcptEndHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="rcptEndMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                        <option value="${minuteStr}"${rcptEndMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" id="rcptBgnDt" name="rcptBgnDt"/>
                        <input type="hidden" id="rcptEndDt" name="rcptEndDt"/>
                    </td>
                </tr>
                <!-- 추가접수기간 -->
                <c:set var="hasAddRcptPeriod" value="false"/>
                <c:if test="${not empty eduLctreVO.addRcptBgnDt && fn:length(eduLctreVO.addRcptBgnDt) >= 12}">
                    <c:set var="addRcptBgnDe" value="${fn:substring(eduLctreVO.addRcptBgnDt, 0, 8)}"/>
                    <c:set var="addRcptBgnHour" value="${fn:substring(eduLctreVO.addRcptBgnDt, 8, 10)}"/>
                    <c:set var="addRcptBgnMin" value="${fn:substring(eduLctreVO.addRcptBgnDt, 10, 12)}"/>
                    <c:set var="addRcptBgnDeFormat"
                           value="${fn:substring(addRcptBgnDe, 0, 4)}-${fn:substring(addRcptBgnDe, 4, 6)}-${fn:substring(addRcptBgnDe, 6, 8)}"/>
                    <c:set var="hasAddRcptPeriod" value="true"/>
                </c:if>
                <c:if test="${not empty eduLctreVO.addRcptEndDt && fn:length(eduLctreVO.addRcptEndDt) >= 12}">
                    <c:set var="addRcptEndDe" value="${fn:substring(eduLctreVO.addRcptEndDt, 0, 8)}"/>
                    <c:set var="addRcptEndHour" value="${fn:substring(eduLctreVO.addRcptEndDt, 8, 10)}"/>
                    <c:set var="addRcptEndMin" value="${fn:substring(eduLctreVO.addRcptEndDt, 10, 12)}"/>
                    <c:set var="addRcptEndDeFormat"
                           value="${fn:substring(addRcptEndDe, 0, 4)}-${fn:substring(addRcptEndDe, 4, 6)}-${fn:substring(addRcptEndDe, 6, 8)}"/>
                    <c:set var="hasAddRcptPeriod" value="true"/>
                </c:if>
                <tr>
                    <th scope="row"><label for="addRcptBgnDe">추가접수기간</label></th>
                    <td>
                        <span class="p-form-checkbox" style="margin-bottom:10px;display:block;">
                            <input type="checkbox" id="useAddRcptPeriod" class="p-form-checkbox__input" onclick="toggleAddRcptPeriod(this)"${(not empty eduLctreVO.addRcptBgnDt && fn:length(eduLctreVO.addRcptBgnDt) >= 12) || (not empty eduLctreVO.addRcptEndDt && fn:length(eduLctreVO.addRcptEndDt) >= 12) ? ' checked':''}/>
                            <label for="useAddRcptPeriod" class="p-form-checkbox__label">추가접수기간 사용</label>
                        </span>
                        <div id="addRcptPeriodArea"${(not empty eduLctreVO.addRcptBgnDt && fn:length(eduLctreVO.addRcptBgnDt) >= 12) || (not empty eduLctreVO.addRcptEndDt && fn:length(eduLctreVO.addRcptEndDt) >= 12) ? '' : ' style="display:none;"'}>
                        <div class="p-date-group" style="width:600px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="addRcptBgnDe" name="addRcptBgnDe" value="${addRcptBgnDeFormat}"
                                       readonly placeholder="추가접수시작일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="addRcptBgnHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}"${addRcptBgnHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="addRcptBgnMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                        <option value="${minuteStr}"${addRcptBgnMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="addRcptEndDe" name="addRcptEndDe" value="${addRcptEndDeFormat}"
                                       readonly placeholder="추가접수종료일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                                <select id="addRcptEndHour" class="p-input p-input--auto" style="margin-left:3px">
                                    <c:forEach begin="0" end="23" var="h">
                                        <option value="${h < 10 ? '0' : ''}${h}"${addRcptEndHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                                    </c:forEach>
                                </select> :
                                <select id="addRcptEndMin" class="p-input p-input--auto">
                                    <c:forEach begin="0" end="59" var="i">
                                        <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                        <option value="${minuteStr}"${addRcptEndMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        </div>
                        <input type="hidden" id="addRcptBgnDt" name="addRcptBgnDt"/>
                        <input type="hidden" id="addRcptEndDt" name="addRcptEndDt"/>
                    </td>
                </tr>
                <!-- 강좌기간 -->
                <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                    <c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
                    <c:set var="lctBgnHour" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 10)}"/>
                    <c:set var="lctBgnMin" value="${fn:substring(eduLctreVO.lctBgnDt, 10, 12)}"/>
                    <c:set var="lctBgnDeFormat"
                           value="${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}"/>
                </c:if>
                <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                    <c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
                    <c:set var="lctEndHour" value="${fn:substring(eduLctreVO.lctEndDt, 8, 10)}"/>
                    <c:set var="lctEndMin" value="${fn:substring(eduLctreVO.lctEndDt, 10, 12)}"/>
                    <c:set var="lctEndDeFormat"
                           value="${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}"/>
                </c:if>
                <tr>
                    <th scope="row"><label for="lctBgnDe">강좌기간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <div class="p-date-group" style="width:400px">
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="lctBgnDe" name="lctBgnDe" value="${lctBgnDeFormat}" readonly
                                       placeholder="강좌시작일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                            </div>
                            <span class="p-form__split">~</span>
                            <div class="p-form-group p-date" data-date="datepicker">
                                <input type="text" id="lctEndDe" name="lctEndDe" value="${lctEndDeFormat}" readonly
                                       placeholder="강좌종료일" class="p-input bg-none"/>
                                <div class="p-input__split">
                                    <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <!-- 강좌시간 -->
                <tr>
                    <th scope="row"><label for="lctBgnHour">강좌시간</label> <span class="p-form__required--icon">필수</span>
                    </th>
                    <td>
                        <select id="lctBgnHour" class="p-input p-input--auto">
                            <c:forEach begin="0" end="23" var="h">
                                <option value="${h < 10 ? '0' : ''}${h}"${lctBgnHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                            </c:forEach>
                        </select> :
                        <select id="lctBgnMin" class="p-input p-input--auto">
                            <c:forEach begin="0" end="59" var="i">
                                <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                <option value="${minuteStr}"${lctBgnMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="lctBgnDt" name="lctBgnDt"/>
                        ~
                        <select id="lctEndHour" class="p-input p-input--auto">
                            <c:forEach begin="0" end="23" var="h">
                                <option value="${h < 10 ? '0' : ''}${h}"${lctEndHour eq (h < 10 ? '0' : '').concat(h) ? ' selected':''}>${h < 10 ? '0' : ''}${h}</option>
                            </c:forEach>
                        </select> :
                        <select id="lctEndMin" class="p-input p-input--auto">
                            <c:forEach begin="0" end="59" var="i">
                                <c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}"/>
                                <option value="${minuteStr}"${lctEndMin eq minuteStr ? ' selected':''}>${minuteStr}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="lctEndDt" name="lctEndDt"/>
                        <div style="margin-top:10px;">
					<span class="p-form-checkbox">
						<input type="checkbox" id="lctWeekAll" class="p-form-checkbox__input"
                               onclick="checkAllWeek(this)"/>
						<label for="lctWeekAll" class="p-form-checkbox__label">전체</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek1" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '1'}"><c:set var="isWeek1" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek1" name="lctWeekList" value="1"${isWeek1 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek1" class="p-form-checkbox__label">일</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek2" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '2'}"><c:set var="isWeek2" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek2" name="lctWeekList" value="2"${isWeek2 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek2" class="p-form-checkbox__label">월</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek3" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '3'}"><c:set var="isWeek3" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek3" name="lctWeekList" value="3"${isWeek3 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek3" class="p-form-checkbox__label">화</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek4" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '4'}"><c:set var="isWeek4" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek4" name="lctWeekList" value="4"${isWeek4 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek4" class="p-form-checkbox__label">수</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek5" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '5'}"><c:set var="isWeek5" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek5" name="lctWeekList" value="5"${isWeek5 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek5" class="p-form-checkbox__label">목</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek6" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '6'}"><c:set var="isWeek6" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek6" name="lctWeekList" value="6"${isWeek6 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek6" class="p-form-checkbox__label">금</label>
					</span>
                            <span class="p-form-checkbox">
						<c:set var="isWeek7" value="false"/>
						<c:if test="${eduLctreVO.lctWeekList != null}">
                            <c:forEach var="week" items="${eduLctreVO.lctWeekList}">
                                <c:if test="${week eq '7'}"><c:set var="isWeek7" value="true"/></c:if>
                            </c:forEach>
                        </c:if>
						<input type="checkbox" id="lctWeek7" name="lctWeekList" value="7"${isWeek7 ? ' checked':''}
                               class="p-form-checkbox__input lct-week-item"/>
						<label for="lctWeek7" class="p-form-checkbox__label">토</label>
					</span>
                        </div>
                    </td>
                </tr>
                <!-- 강사명 -->
                <tr>
                    <th scope="row"><label for="userId">강사명</label> <%--<span class="p-form__required--icon">필수</span>--%></th>
                    <td>
                        <select id="userId" name="userId" class="p-input p-input--auto">
                            <option value="">선택하세요</option>
                            <c:forEach var="instr" items="${eduInstrList}">
                                <option value="${instr.userId}"${instr.userId eq eduLctreVO.userId ? ' selected':''}>
                                    <c:out value="${instr.instrNm}"/></option>
                            </c:forEach>
                        </select>
                        <span id="text_userId" class="text_red margin_l_20"></span>
                        <span id="error_userId" class="form_error"></span>
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
                <tr id="payMthdArea"${empty eduLctreVO.eduAmt or eduLctreVO.eduAmt eq '0' ? ' style="display:none;"' : ''}>
                    <th scope="row"><label for="payMthdCd">결제방식</label></th>
                    <td>
                        <c:forEach var="pay" items="${payMthdList}" varStatus="sts">
                            <span class="p-form-checkbox">
                                <c:set var="isPayChecked" value="false"/>
                                <c:if test="${eduLctreVO.payMthdCdList != null}">
                                    <c:forEach var="selected" items="${eduLctreVO.payMthdCdList}">
                                        <c:if test="${selected eq pay.code}">
                                            <c:set var="isPayChecked" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <input type="checkbox" name="payMthdCdList" id="pay${sts.index}"
                                       value="${pay.code}"${isPayChecked ? ' checked':''} class="p-form-checkbox__input"/>
                                <label for="pay${sts.index}" class="p-form-checkbox__label"><c:out value="${pay.codeNm}"/></label>
                            </span>
                        </c:forEach>

                        <br/><svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black margin_t_5">유료 결제 사용을 위해서는 토스페이먼츠와 별도 계약 후 상점ID(MID)를 발급받아야 합니다.</em>
                    </td>
                </tr>
                <!-- 무통장입금 선택시 -->
                <tr id="bankInfo"${not empty eduLctreVO.bankNm ? '' : ' style="display:none;"'}>
                    <th scope="row"><label for="bankNm">은행정보</label></th>
                    <td>
                        <span>은행명 </span>
                        <input type="text" id="bankNm" name="bankNm" value="<c:out value='${eduLctreVO.bankNm}'/>"
                               class="p-input w20p" placeholder="은행명" maxlength="40"/><br/>
                        <span>계좌번호 </span>
                        <input type="text" id="acctNo" name="acctNo" value="<c:out value='${eduLctreVO.acctNo}'/>"
                               class="p-input w20p" placeholder="계좌번호" maxlength="20"/><br/>
                        <span>예금주명 </span>
                        <input type="text" id="dpstrNm" name="dpstrNm" value="<c:out value='${eduLctreVO.dpstrNm}'/>"
                               class="p-input w20p" placeholder="예금주명" maxlength="100"/>
                    </td>
                </tr>
                <!-- 모집인원/대기인원 -->
                <tr>
                    <th scope="row"><label for="onlineCnt">교육인원</label></th>
                    <td>
                        <span>모집인원</span>&nbsp;
                        <input type="text" id="onlineCnt" name="onlineCnt" value="${eduLctreVO.onlineCnt}"
                               class="p-input w10p numberonly" maxlength="10"/> 명
                        <span id="error_onlineCnt" class="form_error"></span>
                        <div id="div_extperson" style="margin-top:8px;padding-top:8px;border-top:1px solid #ddd;">
                            <span>대기인원</span>&nbsp;
                            <input type="text" id="waitCnt" name="waitCnt" value="${eduLctreVO.waitCnt}"
                                   class="p-input w10p numberonly" maxlength="10"/> 명
                            <span class="guide-gray margin_l_20">※ "0"을 입력하시면 대기인원 모집하지 않습니다.</span>
                            <span id="error_waitCnt" class="form_error"></span>
                        </div>
                    </td>
                </tr>
                <!-- 재수강제한횟수 -->
                <tr>
                    <th scope="row"><label for="retakeNmtm">재수강제한횟수</label></th>
                    <td>
                        <input type="text" id="retakeNmtm" name="retakeNmtm"
                               value="<c:out value='${eduLctreVO.retakeNmtm}'/>" class="p-input w5p numberonly"
                               maxlength="3"/> 회
                        <span class="text_red margin_l_20">※ "0"을 입력하시면 횟수제한 없습니다.</span>
                    </td>
                </tr>
                <!-- 출석률미달 시 패널티 -->
                <tr>
                    <th scope="row"><label for="attendMinRate">출석률미달 시 패널티적용</label></th>
                    <td>
                        전체 출석일 수의 <input type="text" id="attendMinRate" name="attendMinRate"
                                         value="<c:out value='${eduLctreVO.attendMinRate}'/>"
                                         class="p-input w5p numberonly" maxlength="3"/> %
                    </td>
                </tr>
                <!-- 감면사용 여부 -->
                <input type="hidden" name="dscntUseYn" value="N"/>
                <%--<tr>
                    <th scope="row"><label for="dscntUseYn1">감면사용 여부</label></th>
                    <td>
				<span class="p-form-radio">
					<input type="radio" id="dscntUseYn1" name="dscntUseYn"
                           value="Y"${eduLctreVO.dscntUseYn eq 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="dscntUseYn1" class="p-form-radio__label">사용</label>
				</span>
                        <span class="p-form-radio">
					<input type="radio" id="dscntUseYn2" name="dscntUseYn"
                           value="N"${eduLctreVO.dscntUseYn ne 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="dscntUseYn2" class="p-form-radio__label">미사용</label>
				</span>
                    </td>
                </tr>--%>
                <!-- 거주지사용 여부 -->
                <tr>
                    <th scope="row"><label for="residenceUseYn1">거주지사용 여부</label></th>
                    <td>
				<span class="p-form-radio">
					<input type="radio" id="residenceUseYn1" name="residenceUseYn"
                           value="Y"${eduLctreVO.residenceUseYn eq 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="residenceUseYn1" class="p-form-radio__label">사용</label>
				</span>
                        <span class="p-form-radio">
					<input type="radio" id="residenceUseYn2" name="residenceUseYn"
                           value="N"${eduLctreVO.residenceUseYn ne 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="residenceUseYn2" class="p-form-radio__label">미사용</label>
				</span>
                    </td>
                </tr>
                <!-- 문의전화 -->
                <tr>
                    <th scope="row"><label for="telNo">문의전화</label><span class="p-form__required--icon">필수</span></th>
                    <td>
                        <input type="text" id="telNo" name="telNo" value="<c:out value='${eduLctreVO.telNo}'/>"
                               class="p-input w10p" maxlength="11" placeholder="숫자만 입력"/><br/>
                        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">알림 문자는 시스템 정책에 의해 발신자가 <em class="em_b_red">‘문의전화(대표번호)’</em>로 표기됩니다. 예시) 0432010000</em><br/>
                        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                        <em class="em_black">휴대폰번호 입력시 추후 문자 발송<em class="em_b_red">(발신자 번호로 사용)</em>이 제한될 수 있습니다.</em>
                    </td>
                </tr>
                <!-- 첨부파일 -->
                <tr>
                    <th scope="row"><label for="atchFile_1">첨부파일</label></th>
                    <td colspan="3">
                        <ul class="attach">
                            <c:set var="atchFileCnt" value="0"/>
                            <c:forEach var="cmmnAtchFile" items="${cmmnAtchFileList}" varStatus="idx">
                                <li>
							<span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_M"
                                       class="p-form-radio__input" value="M" checked>
								<label for="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_M"
                                       class="p-form-radio__label">유지</label>
							</span>
                                    <span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_U"
                                       class="p-form-radio__input" value="U">
								<label for="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_U"
                                       class="p-form-radio__label">변경</label>
							</span>
                                    <span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_D"
                                       class="p-form-radio__input" value="D">
								<label for="fileStatusFile_<c:out value="${cmmnAtchFile.fileNo}"/>_D"
                                       class="p-form-radio__label">삭제</label>
							</span>
                                    <span class="file_input"><input type="file"
                                                                    name="atchFile_<c:out value="${cmmnAtchFile.fileNo}"/>"
                                                                    class="file"/></span>
                                    <span>
                                        <a href="./downloadLctreFile.do?key=<c:out value="${param.key}"/>&amp;lctreNo=<c:out value="${eduLctreVO.lctreNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>">
                                            <span class="p-icon p-icon__<c:out value="${cmmnAtchFile.fileExtsn}"/>">
                                                <c:out value="${cmmnAtchFile.fileExtsn}"/> 문서
                                            </span>
                                            <span>
                                                <c:out value="${cmmnAtchFile.fileNm}"/>
                                            </span>
                                        </a>
                                    </span>
                                </li>
                                <c:set var="atchFileCnt" value="${atchFileCnt + 1}"/>
                            </c:forEach>
                            <c:forEach begin="${atchFileCnt+1}" end="${cmmnAtchmnflInfoFile.fileMaxCo}" step="1"
                                       varStatus="i">
                                <li class="p-upload">
                                    <div class="p-form-group" style="width:400px;">
                                        <div class="p-form-group__upload">
                                            <input type="file" name="atchFile" id="atchFile_${i.index}"
                                                   class="p-upload__file--hidden">
                                            <span id="atchFile_name_${i.index}" class="p-input disabled"></span>
                                            <button type="button" class="p-upload__clear clear">선택한 ${i.index}번 첨부 제거
                                            </button>
                                        </div>
                                        <div class="p-input__addon">
                                            <label for="atchFile_${i.index}" class="p-button p-button--small primary"
                                                   data-button="upload" data-parent=".p-upload"
                                                   data-original="#atchFile_${i.index}"
                                                   data-showfilename="#atchFile_name_${i.index}"><span
                                                    class="skip">${i.index}번째 </span>파일선택</label>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                <!-- 상세내용 -->
                <tr>
                    <th scope="row"><label for="detailCn">상세내용</label></th>
                    <td>
                        <textarea id="detailCn" name="detailCn" class="p-input" style="width:100%;height:200px;"><c:out
                                value="${eduLctreVO.detailCn}" escapeXml="false"/></textarea>
                    </td>
                </tr>
                <!-- 유의사항 -->
                <tr>
                    <th scope="row"><label for="noticeCn">유의사항</label></th>
                    <td>
                        <textarea id="noticeCn" name="noticeCn" class="p-input" style="width:100%;height:200px;"><c:out
                                value="${eduLctreVO.noticeCn}" escapeXml="false"/></textarea>
                    </td>
                </tr>
                <!-- 환불정책 -->
                <tr>
                    <th scope="row"><label for="refundPlcyCn">환불정책</label></th>
                    <td>
                        <textarea id="refundPlcyCn" name="refundPlcyCn" class="p-input"
                                  style="width:100%;height:200px;"><c:out value="${eduLctreVO.refundPlcyCn}"
                                                                          escapeXml="false"/></textarea>
                    </td>
                </tr>
                <!-- 이미지 등록 -->
                <tr>
                    <th scope="row"><label for="atchImg_1">이미지</label></th>
                    <td colspan="3">
                        <ul class="attach">
                            <c:set var="imgFileCnt" value="0"/>
                            <c:forEach var="cmmnAtchFile" items="${cmmnAtchImgList}" varStatus="idx">
                                <li>
							<span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_M"
                                       class="p-form-radio__input" value="M" checked>
								<label for="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_M"
                                       class="p-form-radio__label">유지</label>
							</span>
                                    <span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_U"
                                       class="p-form-radio__input" value="U">
								<label for="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_U"
                                       class="p-form-radio__label">변경</label>
							</span>
                                    <span class="p-form-radio">
								<input type="radio" name="fileStatus<c:out value="${cmmnAtchFile.fileNo}"/>"
                                       id="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_D"
                                       class="p-form-radio__input" value="D">
								<label for="fileStatus_<c:out value="${cmmnAtchFile.fileNo}"/>_D"
                                       class="p-form-radio__label">삭제</label>
							</span>
                                    <span class="file_input"><input type="file"
                                                                    name="atchImg_<c:out value="${cmmnAtchFile.fileNo}"/>"
                                                                    class="file"/></span>
                                    <span><a
                                            href="./downloadLctreImg.do?key=<c:out value="${param.key}"/>&amp;lctreNo=<c:out value="${eduLctreVO.lctreNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>"><span
                                            class="p-icon p-icon__<c:out value="${cmmnAtchFile.fileExtsn}"/>"><c:out
                                            value="${cmmnAtchFile.fileExtsn}"/> 문서</span><span><c:out
                                            value="${cmmnAtchFile.fileNm}"/></span></a></span>
                                </li>
                                <c:set var="imgFileCnt" value="${imgFileCnt + 1}"/>
                            </c:forEach>
                            <c:forEach begin="${imgFileCnt+1}" end="${cmmnAtchmnflInfoImg.fileMaxCo}" step="1"
                                       varStatus="i">
                                <li class="p-upload">
                                    <div class="p-form-group" style="width:400px;">
                                        <div class="p-form-group__upload">
                                            <input type="file" name="atchImg" id="atchImg_${i.index}"
                                                   class="p-upload__file--hidden">
                                            <span id="atchImg_name_${i.index}" class="p-input disabled"></span>
                                            <button type="button" class="p-upload__clear clear">선택한 ${i.index}번 첨부 제거
                                            </button>
                                        </div>
                                        <div class="p-input__addon">
                                            <label for="atchImg_${i.index}" class="p-button p-button--small primary"
                                                   data-button="upload" data-parent=".p-upload"
                                                   data-original="#atchImg_${i.index}"
                                                   data-showfilename="#atchImg_name_${i.index}"><span
                                                    class="skip">${i.index}번째 </span>파일선택</label>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                <!-- 운영여부 -->
                <tr>
                    <th scope="row"><label for="operYn1">운영여부</label></th>
                    <td>
				<span class="p-form-radio">
					<input type="radio" id="operYn1" name="operYn" value="Y"${eduLctreVO.operYn eq 'Y' ? ' checked':''}
                           class="p-form-radio__input"/>
					<label for="operYn1" class="p-form-radio__label">운영</label>
				</span>
                        <span class="p-form-radio">
					<input type="radio" id="operYn2" name="operYn" value="N"${eduLctreVO.operYn ne 'Y' ? ' checked':''}
                           class="p-form-radio__input"/>
					<label for="operYn2" class="p-form-radio__label">미운영</label>
				</span>
                    </td>
                </tr>
                <!-- 폐강여부 -->
                <tr>
                    <th scope="row"><label for="closeYn1">폐강여부</label></th>
                    <td>
				<span class="p-form-radio">
					<input type="radio" id="closeYn1" name="closeYn"
                           value="N"${eduLctreVO.closeYn ne 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="closeYn1" class="p-form-radio__label">운영</label>
				</span>
                        <span class="p-form-radio">
					<input type="radio" id="closeYn2" name="closeYn"
                           value="Y"${eduLctreVO.closeYn eq 'Y' ? ' checked':''} class="p-form-radio__input"/>
					<label for="closeYn2" class="p-form-radio__label">폐강</label>
				</span>

                    </td>
                </tr>
                </tbody>
            </table>
            <div class="row margin_t_15">
                <div class="col-12">
                    <a href="./selectEduLctreList.do?<c:out value="${eduLctreSearchVO.params}"/>" class="p-button cancel">취소</a>
                </div>
                <div class="col-12 right">
                    <button type="submit" class="p-button primary">수정</button>
                </div>
            </div>
            <div class="row margin_t_10 center">
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
        <%--targetCdList: [<c:forEach var="target" items="${subject.targetCdList}" varStatus="sts">"${target}"<c:if test="${!sts.last}">,</c:if></c:forEach>],--%>
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

        // eduAmt 값에 따라 chrgeSe 자동 설정 (무료/유료 구분)
        var eduAmt = $("#eduAmt").val();
        if (eduAmt && eduAmt != '0' && eduAmt != '') {
            // 유료
            $("#chrgeSe2").prop('checked', true);
            chrgeSeChange('U');
        } else {
            // 무료 (0 또는 빈 값)
            $("#chrgeSe1").prop('checked', true);
            chrgeSeChange('F');
        }

        // 수강료 금액이 있는 경우 수강료 금액 입력란 및 결제방식 영역 표시 (기존 로직 유지)
        if (eduAmt && eduAmt != '0') {
            $('.tr_eduAmt').show();
            $('#payMthdArea').show();
        }

        // 추첨일자 초기 표시/숨김 처리
        slctMthdCdChange();

        // 과목 선택 이벤트 연결
        $("#subjectNo").on("change", function () {
            autoFillSubjectData($(this).val());
        });

        // 지역 선택 이벤트
        var areaGu = $('select[name=areaGuCd]').val();
        if (areaGu != '') {
            $('#areaEmdCd option.' + areaGu).show();
        }

        $('select[name=areaGuCd]').on("change", function () {
            $('#areaEmdCd').val('');
            $('#areaEmdCd option.areaEmdList').hide();
            $('#areaEmdCd option.' + $(this).val()).show();
        });

        // 페이지 로드 시 수강대상 전체 체크박스 상태 초기화
        var totalTarget = $(".target-item").length;
        var checkedTarget = $(".target-item:checked").length;
        $("#targetAll").prop("checked", totalTarget === checkedTarget && totalTarget > 0);

        // 페이지 로드 시 기존 선택된 기관번호로 하위 데이터 필터링
        var selectedInsttNo = $('#insttNo').val();
        if (selectedInsttNo) {
            insttNoChange(selectedInsttNo);
        }
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

        // 수강료 구분 및 금액 초기화
        $("#chrgeSe1").prop('checked', true);
        $("#eduAmt").val('');
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
        if (data.targetCd) {
            var targetCdList = data.targetCd.split(',');
            targetCdList.forEach(function (code) {
                if (code.trim()) {
                    $("input[name='targetCdList'][value='" + code.trim() + "']").prop("checked", true);
                }
            });

            // 전체 체크박스 상태 업데이트
            var total = $(".target-item").length;
            var checked = $(".target-item:checked").length;
            $("#targetAll").prop("checked", total === checked && total > 0);
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

        // 수강료 구분 및 금액
        if (data.eduAmt && data.eduAmt != '0' && data.eduAmt != '') {
            $("#chrgeSe2").prop('checked', true);
            $("#eduAmt").val(data.eduAmt);
            chrgeSeChange('U');
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
        // clearAutoFillFields();

        // 카테고리 처리
        var isValCtgry = false;
        var selectedCtgryNo = $('#ctgryNo').val(); // 기존 선택된 카테고리 번호 저장
        $('#ctgryNo').empty();
        $('#ctgryNo').append('<option value="">선택하세요</option>');
        <c:forEach var="result" items="${eduCategoryList}">
        if (val == "${result.insttNo}") {
            var isSelected = (selectedCtgryNo == "${result.ctgryNo}") ? ' selected' : '';
            var option = $("<option value=\"${result.ctgryNo}\"" + isSelected + ">${result.ctgryNm}</option>");
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

        // 교육장소 처리
        var isValPlace = false;
        var selectedPlaceNo = $('#placeNo').val(); // 기존 선택된 교육장소 번호 저장
        $('#placeNo').empty();
        $('#placeNo').append('<option value="">선택하세요</option>');
        <c:forEach var="place" items="${eduPlaceList}">
        if (val == "${place.insttNo}") {
            var isSelected = (selectedPlaceNo == "${place.placeNo}") ? ' selected' : '';
            var option = $("<option value=\"${place.placeNo}\"" + isSelected + ">${place.placeNm}</option>");
            $('#placeNo').append(option);
            isValPlace = true;
        }
        </c:forEach>
        if (!isValPlace) {
            $('#placeNo').append('<option value="">교육장소 없음</option>');
            $('#placeNo').attr("disabled", true);
            $('#text_placeNo').text("※ 연동된 교육장소가 없습니다.");
        } else {
            $('#placeNo').attr("disabled", false);
            $('#text_placeNo').text("");
        }

        // 강사 처리
        var isValInstr = false;
        var selectedUserId = $('#userId').val(); // 기존 선택된 강사 아이디 저장
        $('#userId').empty();
        $('#userId').append('<option value="">선택하세요</option>');
        <c:forEach var="instr" items="${eduInstrList}">
        if (val == "${instr.insttNo}") {
            var isSelected = (selectedUserId == "${instr.userId}") ? ' selected' : '';
            var option = $("<option value=\"${instr.userId}\"" + isSelected + ">${instr.instrNm}</option>");
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

        // 카테고리가 선택되어 있으면 과목도 자동으로 필터링
        var selectedCtgryNo = $('#ctgryNo').val();
        if (selectedCtgryNo) {
            ctgryNoChange(selectedCtgryNo);
        }
    }

    // 카테고리 선택 이벤트
    function ctgryNoChange(val) {
        // 자동입력 필드 초기화
        // clearAutoFillFields();

        var isVal = false;
        var selectedSubjectNo = $('#subjectNo').val(); // 기존 선택된 과목 번호 저장
        $('#subjectNo').empty();
        $('#subjectNo').append('<option value="">선택하세요</option>');
        <c:forEach var="result" items="${eduSubjectList}">
        if (val == "${result.ctgryNo}") {
            var isSelected = (selectedSubjectNo == "${result.subjectNo}") ? ' selected' : '';
            var option = $("<option value=\"${result.subjectNo}\"" + isSelected + ">${result.subjectNm}</option>");
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

    // 폼 제출 시 유효성 검사 + 날짜 형식 변환 및 시간 정보 합치기
    $("#updtForm").on("submit", function () {
        var frm = this;

        // 기관명
        if (!frm.insttNo.value) {
            alert("기관명을 선택해주세요.");
            frm.insttNo.focus();
            return false;
        }

        // 카테고리
        if (!frm.ctgryNo.value) {
            alert("카테고리를 선택해주세요.");
            frm.ctgryNo.focus();
            return false;
        }

        // 과목
        if (!frm.subjectNo.value) {
            alert("과목을 선택해주세요.");
            frm.subjectNo.focus();
            return false;
        }

        // 운영년도
        if (!frm.operYear.value) {
            alert("운영년도를 선택해주세요.");
            frm.operYear.focus();
            return false;
        }

        // 강좌명
        if (!frm.lctreNm.value || !frm.lctreNm.value.trim()) {
            alert("강좌명을 입력해주세요.");
            frm.lctreNm.focus();
            return false;
        }

        // 선발방식
        if (!$("input[name='slctMthdCd']:checked").val()) {
            alert("선발방식을 선택해주세요.");
            $("#slctMthdCd1").focus();
            return false;
        }

        // 선발방식이 추첨일 경우 추첨일자 필수 체크
        if ($("input[name='slctMthdCd']:checked").val() === 'DRWLT') {
            if (!$("#drwtDe").val()) {
                alert("추첨일자를 설정해주세요.");
                $("#drwtDe").focus();
                return false;
            }
        }

        // 접수방식
        if ($("input[name='rcptMthdCdList']:checked").length === 0) {
            alert("접수방식을 선택해주세요.");
            $("#rcptMthdCd1").focus();
            return false;
        }

        // 지역(구)
        if (!frm.areaGuCd.value) {
            alert("지역(구)을 선택해주세요.");
            frm.areaGuCd.focus();
            return false;
        }

        // 수강대상
        if ($("input[name='targetCdList']:checked").length === 0) {
            alert("수강대상을 선택해주세요.");
            $("#target0").focus();
            return false;
        }

        // 수료인정율 (있으면 0~100 숫자)
        if (frm.cmplApprRate.value && frm.cmplApprRate.value.trim()) {
            var cmpl = frm.cmplApprRate.value;
            if (isNaN(cmpl) || cmpl < 0 || cmpl > 100) {
                alert("수료인정율은 0~100 사이의 숫자를 입력해주세요.");
                frm.cmplApprRate.focus();
                return false;
            }
        }

        // 접수기간 (필수)
        if (!$("#rcptBgnDe").val()) {
            alert("접수시작일을 선택해주세요.");
            $("#rcptBgnDe").focus();
            return false;
        }
        if (!$("#rcptEndDe").val()) {
            alert("접수종료일을 선택해주세요.");
            $("#rcptEndDe").focus();
            return false;
        }

        // 접수기간 시작/종료일 순서 체크
        if ($("#rcptBgnDe").val() && $("#rcptEndDe").val()) {
            var rcptBgnDeVal = $("#rcptBgnDe").val().replace(/-/g, "");
            var rcptEndDeVal = $("#rcptEndDe").val().replace(/-/g, "");
            if (parseInt(rcptBgnDeVal, 10) > parseInt(rcptEndDeVal, 10)) {
                alert("접수종료일은 접수시작일보다 같거나 이후여야 합니다.");
                $("#rcptEndDe").focus();
                return false;
            }
        }

        // 강좌기간 (필수)
        if (!$("#lctBgnDe").val()) {
            alert("강좌시작일을 선택해주세요.");
            $("#lctBgnDe").focus();
            return false;
        }
        if (!$("#lctEndDe").val()) {
            alert("강좌종료일을 선택해주세요.");
            $("#lctEndDe").focus();
            return false;
        }

        // 강좌기간 시작/종료일 순서 체크
        if ($("#lctBgnDe").val() && $("#lctEndDe").val()) {
            var lctBgnDeVal = $("#lctBgnDe").val().replace(/-/g, "");
            var lctEndDeVal = $("#lctEndDe").val().replace(/-/g, "");
            if (parseInt(lctBgnDeVal, 10) > parseInt(lctEndDeVal, 10)) {
                alert("강좌종료일은 강좌시작일보다 같거나 이후여야 합니다.");
                $("#lctEndDe").focus();
                return false;
            }
        }

        // 강좌시간
        if (!$("#lctBgnHour").val() || !$("#lctBgnMin").val()) {
            alert("강좌 시작시간을 선택해주세요.");
            $("#lctBgnHour").focus();
            return false;
        }
        if (!$("#lctEndHour").val() || !$("#lctEndMin").val()) {
            alert("강좌 종료시간을 선택해주세요.");
            $("#lctEndHour").focus();
            return false;
        }

        // 시작/종료 시각 관계
        var sTime = $("#lctBgnHour").val() + $("#lctBgnMin").val();
        var eTime = $("#lctEndHour").val() + $("#lctEndMin").val();
        if (sTime && eTime && parseInt(sTime, 10) >= parseInt(eTime, 10)) {
            alert("강좌 종료시간은 시작시간보다 커야 합니다.");
            $("#lctEndHour").focus();
            return false;
        }

        // 요일
        if ($("input[name='lctWeekList']:checked").length === 0) {
            alert("강좌 요일을 한 개 이상 선택해주세요.");
            $("#lctWeek1").focus();
            return false;
        }

        // 교육장소
        if (!frm.placeNo.value) {
            alert("교육장소를 선택해주세요.");
            frm.placeNo.focus();
            return false;
        }

        // 강사명
        /*if (!frm.userId.value) {
            alert("강사명을 선택해주세요.");
            frm.userId.focus();
            return false;
        }*/

        // 수강료 구분
        var chrgeSeVal = $("input[name='chrgeSe']:checked").val();
        if (!chrgeSeVal) {
            alert("수강료 구분을 선택해주세요.");
            $("#chrgeSe1").focus();
            return false;
        }

        // 유료일 때 수강료 금액
        if (chrgeSeVal === "U") {
            if (!frm.eduAmt.value || !frm.eduAmt.value.trim()) {
                alert("수강료 금액을 입력해주세요.");
                frm.eduAmt.focus();
                return false;
            }
            if (isNaN(frm.eduAmt.value) || Number(frm.eduAmt.value) < 0) {
                alert("수강료 금액은 0 이상 숫자로 입력해주세요.");
                frm.eduAmt.focus();
                return false;
            }
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

        // 교육인원
        if (!frm.onlineCnt.value.trim()) {
            alert("모집인원을 입력해주세요.");
            frm.onlineCnt.focus();
            return false;
        }
        if (isNaN(frm.onlineCnt.value) || Number(frm.onlineCnt.value) < 0) {
            alert("모집인원은 0 이상 숫자로 입력해주세요.");
            frm.onlineCnt.focus();
            return false;
        }

        // 대기인원
        if (!frm.waitCnt.value.trim()) {
            alert("대기인원을 입력해주세요.");
            frm.waitCnt.focus();
            return false;
        }
        if (isNaN(frm.waitCnt.value) || Number(frm.waitCnt.value) < 0) {
            alert("대기인원은 0 이상 숫자로 입력해주세요.");
            frm.waitCnt.focus();
            return false;
        }

        // 운영여부
        if (!$("input[name='operYn']:checked").val()) {
            alert("운영여부를 선택해주세요.");
            $("#operYn1").focus();
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

        // 접수기간 시작/종료 (날짜+시간) 순서 체크
        if ($("#rcptBgnDt").val() && $("#rcptEndDt").val()) {
            if (parseInt($("#rcptBgnDt").val(), 10) > parseInt($("#rcptEndDt").val(), 10)) {
                alert("접수종료일시는 접수시작일시보다 같거나 이후여야 합니다.");
                $("#rcptEndDe").focus();
                return false;
            }
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

        // 최종 확인
        if (!confirm("수정하시겠습니까?")) {
            return false;
        }

        return true;
    });
</script>
</body>
</html>

