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
    <title>${menuInfo.cntntsNm} > 신청자 정보 등록</title>
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
                <th scope="row">신청/모집</th>
                <td colspan="3">
                    <c:out value="${exprnVO.totResveCnt}/${exprnVO.totRcritCnt}"/>
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

    <h3>신청 정보입력</h3>
    <div class="row">
        <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
        <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
    </div>

    <form:form modelAttribute="exprnApplVO" name="exprnApplVO" method="post" action="addExprnAppl.do" onsubmit="return fn_addExprnCheck(this)" enctype="multipart/form-data">
        <fieldset>
            <legend>체험 신청 관리자 등록</legend>
            <c:forEach var="result" items="${exprnApplSearchVO.paramsMap}">
                <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
            </c:forEach>
            <c:forEach var="result" items="${exprnApplSearchVO.paramsMapMng}">
                <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
            </c:forEach>
            <input type="hidden" name="exprnNo" value="<c:out value="${exprnApplVO.exprnNo}"/>" />
            <table class="p-table">
                <caption>체험 신청 관리자 등록</caption>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">
                <tr>
                    <th scope="row"><form:label path="nmprSeCd">인원구분</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <c:forEach var="result" items="${exprnVO.nmprSeCdArr}" varStatus="status">
                            <span class="p-form-radio">
                                <input type="radio" name="nmprSeCd" id="nmprSeCd_<c:out value="${result}"/>" class="p-form-radio__input" value="<c:out value="${result}"/>"<c:if test="${fn:length(exprnVO.nmprSeCdArr) == 1}"> checked</c:if>>
                                <label for="nmprSeCd_<c:out value="${result}"/>" class="p-form-radio__label"><c:out value="${nmprSeMap[result]}"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
                    <tr id="grpNmInput"<c:if test="${fn:length(exprnVO.nmprSeCdArr) > 1}"> style="display: none;"</c:if>>
                        <th scope="row"><form:label path="grpNm">단체명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="grpNm" class="p-input p-input--auto" />
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <th scope="row"><form:label path="applNm">신청자명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:input path="applNm" class="p-input p-input--auto" />
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="birthDe">생년월일</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group p-date w10p" data-date="datepicker" data-date-start-view="3">
                            <input type="text" name="birthDe" id="birthDe" value="<c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>" class="p-input" placeholder="yyyy-MM-dd"/>
                            <span class="p-input__split">
                                <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="genderSe">성별</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-radio">
                            <input type="radio" name="genderSe" id="genderSeM" class="p-form-radio__input" value="M"<c:if test="${exprnApplVO.genderSe == 'M'}"> checked</c:if>>
                            <label for="genderSeM" class="p-form-radio__label">남</label>
                        </span>
                        <span class="p-form-radio">
                            <input type="radio" name="genderSe" id="genderSeF" class="p-form-radio__input" value="F"<c:if test="${exprnApplVO.genderSe == 'F'}"> checked</c:if>>
                            <label for="genderSeF" class="p-form-radio__label">여</label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="mobileNo">연락처</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-inline">
                            <form:select path="mobileNo1" class="p-input w10p">
                                <form:option value="010"/>
                            </form:select>
                            -
                            <form:input path="mobileNo2" class="p-input w10p" />
                            -
                            <form:input path="mobileNo3" class="p-input w10p" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="zip">주소</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w10p">
                            <form:input path="zip" style="width:100px" class="p-input" placeholder="(우편번호)" readonly="true"/>
                            <span class="p-input__addon">
                                    <button type="button" class="p-button primary addressSearchButton" onclick="openDaumZipAddress();">주소검색</button>
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
                    <th scope="row"><form:label path="email1">이메일</form:label></th>
                    <td>
                        <div class="p-form-group w30p">
                            <form:input path="email1" class="p-input p-inpu--auto" />
                            <span class="p-form__split">@</span>
                            <form:input path="email2" class="p-input p-inpu--auto" />
                            <span class="p-form__split"> </span>
                            <select id="email3" class="p-input p-input--auto">
                                <option value="direct">직접입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="email1">신청인원</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <c:set var="nmprMinCnt" value="1"/>
                        <c:set var="nmprMaxCnt" value="${exprnVO.rcritCnt}"/>
                        <c:if test="${exprnVO.nmprMinCnt > 0}">
                            <c:set var="nmprMinCnt" value="${exprnVO.nmprMinCnt}"/>
                        </c:if>
                        <c:if test="${exprnVO.nmprMaxCnt > 0}">
                            <c:set var="nmprMaxCnt" value="${exprnVO.nmprMaxCnt}"/>
                        </c:if>
                        <div class="p-form-group col-2">
                            <span class="p-form__split">총</span>
                            <form:select path="totalCnt" class="p-input p-input--auto">
                                <form:option value="0" label="선택"/>
                                <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                    <form:option value="${i}" label="${i}명"/>
                                </c:forEach>
                            </form:select>
                            <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
                                <span class="p-form__split">( 성인</span>
                                <form:select path="adltCnt" class="p-input p-input--auto">
                                    <form:option value="0" label="선택"/>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <form:option value="${i}" label="${i}명"/>
                                    </c:forEach>
                                </form:select>
                                <span class="p-form__split">청소년, </span>
                                <form:select path="teenCnt" class="p-input p-input--auto">
                                    <form:option value="0" label="선택"/>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <form:option value="${i}" label="${i}명"/>
                                    </c:forEach>
                                </form:select>
                                <span class="p-form__split">초등학생, </span>
                                <form:select path="elmntCnt" class="p-input p-input--auto">
                                    <form:option value="0" label="선택"/>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <form:option value="${i}" label="${i}명"/>
                                    </c:forEach>
                                </form:select>
                                <span class="p-form__split">아동, </span>
                                <form:select path="childCnt" class="p-input p-input--auto">
                                    <form:option value="0" label="선택"/>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <form:option value="${i}" label="${i}명"/>
                                    </c:forEach>
                                </form:select>
                                <span class="p-form__split">, 영유아</span>
                                <form:select path="infantCnt" class="p-input p-input--auto">
                                    <form:option value="0" label="선택"/>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <form:option value="${i}" label="${i}명"/>
                                    </c:forEach>
                                </form:select>
                                <span class="p-form__split">)</span>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">체험일자 선택 <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td colspan="2" id="exprnCalendar">
                        <jsp:include page="../schd/web/exprnApplCalendarMng.jsp" />
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="row margin_t_20">
                <div class="col-12">
                    <c:set var="applListParam" value="${exprnApplSearchVO.params}${exprnApplSearchVO.paramsMng}&${exprnSearchVO.exprnParamsMng}&exprnNo=${exprnApplVO.exprnNo}"/>
                    <a href="./selectExprnApplListByExprn.do?<c:out value="${applListParam}"/>" class="p-button cancel">목록 </a>
                </div>
                <div class="col-12 right">
                    <input type="submit" class="p-button write" value="등록">
                </div>
            </div>
        </fieldset>
    </form:form>

</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("#zip").val(data.zonecode);
                $("#addr").val(data.address);
                $("#detailAddr").focus();
            }
        }).open();
    }

    $(document).ready(function() {

        <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
        $('input[type=radio][name=nmprSeCd]').change(function () {
            if ($(this).val() == 'GRP') {
                $('#grpNmInput').show();
            } else {
                $('#grpNmInput').hide();
                $('#grpNm').val('');
            }
        });
        </c:if>

        $('#email3').change(function () {
            if ($('#email3').val() == 'direct') {
                $('input[name=email2]').prop('readonly', false);
                $('input[name=email2]').val('');
            } else {
                $('input[name=email2]').prop('readonly', true);
                $('input[name=email2]').val($('#email3').val());
            }
        });

    })

    function fn_addExprnCheck(form) {

        var regexDate = RegExp(/^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/);
        var regPhone = /^01[016789]-?\d{3,4}-?\d{4}$/;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

        <c:if test="${fn:length(exprnVO.nmprSeCdArr) > 1}">
        if (!form.nmprSeCd.value) {
            alert("인원구분을 선택해주세요.");
            $('#nmprSeCd_IND').focus();
            return false;
        }
        </c:if>

        <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
        if (form.nmprSeCd.value == 'GRP') {
            if (!form.grpNm.value) {
                alert("인원구분 단체인 경우 단체명을 입력해주세요.");
                form.grpNm.focus();
                return false;
            }
        }
        </c:if>

        if (!form.applNm.value) {
            alert("신청자명을 입력해주세요.");
            form.applNm.focus();
            return false;
        }

        if (!form.birthDe.value) {
            alert("생년월일을 입력해주세요.");
            form.birthDe.focus();
            return false;
        } else {
            if (!regexDate.test(form.birthDe.value)) {
                alert("생년월일(yyyy-MM-dd)을 확인해주세요.");
                form.birthDe.focus();
                return false;
            }
        }

        if (!form.genderSe.value) {
            alert("성별을 선택해주세요.");
            $('#genderSeM').focus();
            return false;
        }

        if (!form.mobileNo1.value || !form.mobileNo2.value || !form.mobileNo3.value) {
            alert("연락처를 입력해주세요.");
            if (!form.mobileNo1.value) {
                $('#mobileNo1').focus();
                return false;
            }
            if (!form.mobileNo2.value) {
                $('#mobileNo2').focus();
                return false;
            }
            if (!form.mobileNo3.value) {
                $('#mobileNo3').focus();
                return false;
            }
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

        if (!form.totalCnt.value) {
            alert("신청인원을 입력해주세요.");
            form.totalCnt.focus();
            return false;
        }

        if (form.totalCnt.value <= 0) {
            alert("신청인원을 확인해주세요.");
            form.totalCnt.focus();
            return false;
        }

        var minCnt =
        <c:out value="${exprnVO.nmprMinCnt}"/>
        var maxCnt =
        <c:out value="${exprnVO.nmprMaxCnt}"/>

        if (minCnt > 0) {
            if (form.totalCnt.value < minCnt) {
                alert("최소 신청인원을 확인해주세요.");
                form.totalCnt.focus();
                return false;
            }
        }

        if (maxCnt > 0) {
            if (form.totalCnt.value > maxCnt) {
                alert("최대 신청인원을 확인해주세요.");
                form.totalCnt.focus();
                return false;
            }
        }

        <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
        // 총 인원
        let totalCnt = parseInt($("#totalCnt").val() || 0);

        // 세부 인원
        let adltCnt = parseInt($("#adltCnt").val() || 0);
        let teenCnt = parseInt($("#teenCnt").val() || 0);
        let elmntCnt = parseInt($("#elmntCnt").val() || 0);
        let childCnt = parseInt($("#childCnt").val() || 0);
        let infantCnt = parseInt($("#infantCnt").val() || 0);

        let detailSum = adltCnt + teenCnt + elmntCnt + childCnt + infantCnt;
        if (totalCnt !== detailSum) {
            form.adltCnt.focus();
            alert("세부 인원이 총 신청인원과 일치하지 않습니다. 다시 확인해주세요.");
            return false;
        }
        </c:if>

        if (!form.exprnDe.value) {
            alert("체험일자를 선택해주세요.");
            form.exprnDe.focus();
            return false;
        }

        if (!form.exprnSchdNo.value) {
            alert("체험시간을 선택해주세요.");
            form.exprnSchdNo.focus();
            return false;
        }

        if (confirm("등록하시겠습니까?")) {
            var birthDe = form.birthDe.value;
            form.birthDe.value = birthDe.replaceAll('-', '');
            return true;
        }

        return false;
    }

    $(document).on("click", ".prevButton, .nextButton", function () {

        var programCalendar = $('#exprnCalendar');
        var year = $(this).data('year');
        var month = $(this).data('month');

        $.ajax({
            cache: false,
            url: './exprnApplCalendarAjaxMng.do',
            type: 'POST',
            data: {
                exprnNo: '<c:out value="${exprnVO.exprnNo}"/>',
                year: year,
                month: month
            },
            success: function (res) {
                programCalendar.html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    });

    $(document).on("change", ".ymdBtn", function (e) {
        var date = $(this).val();

        $.ajax({
            cache: false,
            url: './exprnApplTimeListAjaxMng.do',
            type: 'POST',
            data: {
                exprnNo: '<c:out value="${exprnVO.exprnNo}"/>',
                exprnDe: date
            },
            success: function (res) {
                $('.timeList').html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    });

</script>

</body>
</html>
