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
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 관리자 직권 신청서 입력</title>
</head>
<body>

<script src="/common/js/default.js"></script>

<div class="p-wrap">

    <jsp:include page="../incFcltyInfo.jsp" />

    <h3>시설 사용자 정보 입력 <c:if test="${fcltyVO.operSttus ne 'RCPT_ING'}"><em class="em_b_red"> - 운영상태가 [접수중]이 아니라 등록이 불가합니다.</em></c:if> </h3>
  <div>
    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
    <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
  </div>

  <form:form modelAttribute="fcltyApplVO" name="fcltyApplVO" method="post" action="addFcltyAppl.do" onsubmit="return fn_addFcltyApplCheck(this)">
    <fieldset>
      <legend>(관리자) 시설 사용 신청서 입력</legend>
      <form:hidden path="fcltyNo"/>
      <form:hidden path="mngrAt"/>
      <form:hidden path="insttNo"/>
      <form:hidden path="key"/>
      <form:hidden path="totalCnt"/>

      <table class="p-table">
        <caption>(관리자) 시설 사용 신청서 입력</caption>
        <colgroup>
          <col class="w15p">
          <col />
        </colgroup>
        <tbody class="p-table--th-left">

        <tr>
            <th scope="row">시설 사용일자 선택 <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td id="fcltyCalendar">
                <jsp:include page="../schd/fcltyApplCalendar.jsp" />
            </td>
        </tr>

        <c:if test="${fcltyVO.fcltyAmt > 0}">
          <tr>
            <th scope="row">시설 사용요금 <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td>
              <span id="amt">0원</span>
              <form:hidden path="fcltyAmt" />
              <form:hidden path="totalPayAmt" />
            </td>
          </tr>

          <tr>
            <th scope="row">사용요금 지불 방식 <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td>
              <form:select class="p-input p-input--auto" path="payMthdCd" required="required">
                <form:option value="" label="= 선택해주세요. =" />
                <c:forEach items="${payMthdList}" var="item" varStatus="idx">
                  <c:if test="${item.code ne 'ELCTRN'}">
                    <form:option value="${item.code}" label="${item.codeNm}" />
                  </c:if>
                </c:forEach>
              </form:select>
            </td>
          </tr>
        </c:if>

        <c:if test="${fcltyVO.nmprSeCd eq 'IND,GRP'}">
          <tr>
            <th scope="row"><label for="nmprSeCd"> 인원구분</label> <span class="p-form__required--icon margin_l_5">필수</span></th>
            <td>
              <select class="p-input p-input--auto" id="nmprSeCd" name="nmprSeCd" onchange="fn_nmprSeCdChk(this.value);" required="required">
                <option value="">선택해주세요.</option>
                <c:forEach var="result" items="${nmprSeList}" varStatus="status">
                  <option value="<c:out value="${result.code}"/>"<c:if test="${result.code == fcltyApplVO.payMthdCd}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                </c:forEach>
              </select>
            </td>
          </tr>
        </c:if>

        <tr id="grpNmTr" style="display: none;">
          <th scope="row"><form:label path="grpNm">단체명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td><form:input path="grpNm" class="p-input p-input--auto" maxlength="30" placeholder="단체명" /></td>
        </tr>

        <tr id="useCntTr" style="display: none;">
          <th scope="row"><form:label path="useCnt">사용인원</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td>
            <form:input path="useCnt" class="p-input p-input--auto" oninput="fn_numChk(this)" maxlength="4" placeholder="숫자만 입력 가능합니다." />명

            <c:if test="${fcltyVO.nmprMinCnt > 0 || fcltyVO.nmprMaxCnt > 0}">
              <span class="p-table__content padding_l_10">
                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                  <em class="em_black">
                <c:if test="${fcltyVO.nmprMinCnt > 0}">
                  최소 신청인원 : <c:out value="${fcltyVO.nmprMinCnt}"/> 명
                </c:if>
                <c:if test="${fcltyVO.nmprMinCnt > 0 && nmprMaxCnt > 0}"> / </c:if>
                <c:if test="${fcltyVO.nmprMaxCnt > 0}">
                  최대 신청인원 : <c:out value="${fcltyVO.nmprMaxCnt}"/> 명
                </c:if>
                </em>
              </span>
            </c:if>
          </td>
        </tr>

        <tr>
          <th scope="row"><form:label path="applNm">신청자명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td><form:input path="applNm" class="p-input p-input--auto" maxlength="20" placeholder="신청자명" required="required" /></td>
        </tr>

        <tr>
          <th scope="row"><form:label path="genderSe">성별</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td>
            <span class="p-form-radio">
                <form:radiobutton path="genderSe" id="genderSe1" value="M" cssClass="p-form-radio__input"/>
                <label for="genderSe1" class="p-form-radio__label">남</label>
            </span>
            <span class="p-form-radio">
                <form:radiobutton path="genderSe" id="genderSe2" value="F" cssClass="p-form-radio__input"/>
                <label for="genderSe2" class="p-form-radio__label">여</label>
            </span>
          </td>
        </tr>

        <tr>
          <th scope="row"><form:label path="birthDe">생년월일</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td>
            <div class="p-form-group p-date w10p" data-date="datepicker" data-date-start-view="3">
              <form:input path="birthDe" class="p-input p-input--auto" maxlength="10" placeholder="YYYY-MM-DD" required="required" />
              <span class="p-input__split">
                  <button type="button" class="p-input__item p-date__icon">달력 열기</button>
              </span>
            </div>
          </td>
        </tr>

        <tr>
          <th scope="row"><form:label path="mobileNo">연락처</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td><form:input path="mobileNo" class="p-input p-input--auto" oninput="fn_numChk(this)" maxlength="12" placeholder="숫자만입력가능" required="required" /></td>
        </tr>

        <tr>
          <th scope="row"><form:label path="zip">주소</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td>
            <div class="p-form-group w20p">
              <form:input path="zip" class="p-input p-input--auto" placeholder="우편번호 (자동입력)" readonly="true" maxlength="6" required="required"/>
              <span class="p-input__addon">
                  <button type="button" class="p-button primary addressSearchButton" onclick="openDaumZipAddress();">주소검색</button>
              </span>
            </div>
            <div class="p-form-group w50p">
              <form:input path="addr" class="p-input" placeholder="주소 (자동입력)" readonly="true" required="required"/>
            </div>
            <div class="p-form-group w50p">
              <form:input path="detailAddr" class="p-input" placeholder="상세주소" maxlength="30" required="required"/>
            </div>
          </td>
        </tr>

        <tr>
          <th scope="row"><form:label path="email1">이메일</form:label></th>
          <td>
            <div class="p-form-group w40p">
              <form:input path="email1" class="p-input p-inpu--auto" maxlength="20" />
              <span class="p-form__split">@</span>
              <form:input path="email2" class="p-input p-inpu--auto" maxlength="20"/>
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

        <c:if test="${fcltyVO.resInqUseYn eq 'Y'}">
        <tr>
          <th scope="row"><form:label path="resInqCd">거주지</form:label> </th>
          <td>
            <form:select class="p-input p-input--auto" path="resInqCd">
              <form:option value="" label="= 선택해주세요 =" />
              <form:options items="${lgldongList}" itemValue="code" itemLabel="codeNm"/>
            </form:select>
          </td>
        </tr>
        </c:if>

        <c:if test="${not empty fcltyVO.aditIem1}">
          <tr>
            <th scope="row"><form:label path="aditIem1"><c:out value="${fcltyVO.aditIem1}"/></form:label> </th>
            <td><form:input path="aditIem1" class="p-input w50p" maxlength="100" placeholder="${fcltyVO.aditIem1} 입력" /></td>
          </tr>
        </c:if>

        <c:if test="${not empty fcltyVO.aditIem2}">
          <tr>
            <th scope="row"><form:label path="aditIem2"><c:out value="${fcltyVO.aditIem2}"/></form:label> </th>
            <td><form:input path="aditIem2" class="p-input w50p" maxlength="100" placeholder="${fcltyVO.aditIem2} 입력" /></td>
          </tr>
        </c:if>

        <tr>
          <th scope="row"><form:label path="memo">메모(관리자만 확인 가능)</form:label> </th>
          <td><form:textarea path="memo" class="p-input w50p" /></td>
        </tr>

        </tbody>
      </table>
      <div class="row margin_t_20">
        <div class="col-12">
          <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
        </div>
        <div class="col-12 right">
          <c:if test="${fcltyVO.operSttus ne 'RCPT_ING'}">
          </c:if>
          <c:choose>
            <c:when test="${fcltyVO.operSttus eq 'RCPT_ING'}"><input type="submit" class="p-button edit" value="관리자 직권 등록"></c:when>
            <c:otherwise><button type="button" class="p-button">운영상태가 [접수중]일 때 등록이 가능합니다.</button></c:otherwise>
          </c:choose>
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

  function fn_nmprSeCdChk(obj) {
    if (obj === 'IND') {
      $('#grpNmTr').hide();
      $('#useCntTr').hide();
    } else if (obj === 'GRP') {
      $('#grpNmTr').show();
      $('#useCntTr').show();
    }
  }

  $(document).ready(function() {
    <c:if test="${fcltyVO.nmprSeCd eq 'GRP'}">
      $('#grpNmTr').show();
      $('#useCntTr').show();
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

  });

  $(document).on('change', '#fcltySchdNo', function() {
    let totAmt = $("#fcltySchdNo").find("option:selected").data("totAmt");
    let fcltyAmt = $("#fcltySchdNo").find("option:selected").data("fcltyAmt");
    if (Number(totAmt) > 0) {
      $('#amt').text(fcltyAmt);
      $('#fcltyAmt').val(totAmt);
      $('#totalPayAmt').val(totAmt);
    }
  });

  function fn_addFcltyApplCheck(form) {
    var regexDate = RegExp(/^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/);

    if(form.nmprSeCd.value === 'GRP') {
      <c:if test="${fcltyVO.nmprMinCnt > 0}">
        const minCnt = '<c:out value="${fcltyVO.nmprMinCnt}"/>';
        if (Number(form.useCnt.value) < Number(minCnt)) {
          alert("최소 신청인원은 "+minCnt+"명 입니다.");
          form.useCnt.focus();
          return false;
        }
      </c:if>
      <c:if test="${fcltyVO.nmprMaxCnt > 0}">
        const maxCnt = '<c:out value="${fcltyVO.nmprMaxCnt}"/>';
        if (Number(form.useCnt.value) > Number(maxCnt)) {
          alert("최대 신청인원은 "+maxCnt+"명 입니다.");
          form.useCnt.focus();
          return false;
        }
      </c:if>
    }

    if (!regexDate.test(form.birthDe.value)) {
      alert("생년월일(yyyy-MM-dd) 형식을 확인해주세요.");
      form.birthDe.focus();
      return false;
    }

    if (!confirm('위 내용대로 등록하시겠습니까?')) {
      return false;
    }
  }

  $(document).on("click", ".prevButton, .nextButton", function () {

    var programCalendar = $('#fcltyCalendar');
    var year = $(this).data('year');
    var month = $(this).data('month');

    $.ajax({
      cache: false,
      url: './fcltyApplCalendarMngAjax.do',
      type: 'POST',
      data: {
        fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
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
      url: './fcltyApplTimeListMngAjax.do',
      type: 'POST',
      data: {
        fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
        fcltyDe: date
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
