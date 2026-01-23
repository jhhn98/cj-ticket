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
  <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 사용료관리 수정 </title>
</head>
<body>

<script src="/common/js/default.js"></script>

<div class="p-wrap">

  <div>
    <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
    <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
  </div>


  <table class="p-table">
    <caption>시설 사용료 등록방법 선택</caption>
    <colgroup>
      <col class="w15p">
      <col />
    </colgroup>
    <tbody class="p-table--th-left">
    <tr>
      <th scope="row">시설 사용료 설정 <span class="p-form__required--icon margin_l_5">필수</span></th>
      <td>
        <div class="p-form-group w20p">
            <%-- 시설 사용료 등록방법 - S: 동일요금 / D: 차등요금 --%>
            <span class="p-form-radio">
                <input type="radio" name="amtMthdRadio" id="amtMthd1" class="p-form-radio__input" value="S"<c:if test="${fcltyVO.amtMthd == 'S'}"> checked</c:if>>
                <label for="amtMthd1" class="p-form-radio__label">운영 시간별 동일요금 적용 (<b><fmt:formatNumber value="${fcltyVO.fcltyAmt}" pattern="#,##0"/></b>)원</label>
            </span>
            <span class="p-form-radio">
                <input type="radio" name="amtMthdRadio" id="amtMthd2" class="p-form-radio__input" value="D"<c:if test="${fcltyVO.amtMthd == 'D'}"> checked</c:if>>
                <label for="amtMthd2" class="p-form-radio__label">운영 시간별 차등요금 적용 (직접 입력)</label>
            </span>
        </div>
      </td>
    </tr>
    </tbody>
  </table>

  <form:form modelAttribute="fcltySchdVO" id="dFrm" method="post" action="./updateFcltyAmtDtype.do" onsubmit="return fn_fcltyAmtDtypeChk(this)" style="display:none;">
    <fieldset>
      <legend>시설 요금 수정</legend>
      <table class="p-table" id="fcltySchdPdTable">
        <caption>시설 요금 수정</caption>
          <form:hidden path="fcltyNo"/>

          <c:forEach var="result" items="${fcltySearchVO.paramsMap}">
            <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
          </c:forEach>
          <c:forEach var="result" items="${fcltySearchVO.paramsMapMng}">
            <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
          </c:forEach>

        <colgroup>
          <col class="w15p">
          <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
          <th scope="row">요일별 시간별 사용료 <span class="p-form__required--icon margin_l_5">필수</span></th>
          <td>
            <table class="w50p">
              <colgroup>
                <col class="w15p">
                <col />
              </colgroup>
              <thead>
                <tr>
                  <th style="text-align: center;">요일</th>
                  <th style="text-align: center;">시간별 요금</th>
                </tr>
              </thead>
              <tbody class="text_center" id="fcltyTimeTable">
                  <c:set var="day" value="${fcltyTmList[0].fcltyDay}" />
                  <c:set var="idx" value="1" />

                  <c:forEach var="result" items="${fcltyTmList}" varStatus="status">

                    <c:if test="${day ne result.fcltyDay}">
                      <c:set var="day" value="${fcltyTmList[status.index].fcltyDay}" />
                      <c:set var="idx" value="1" />
                    </c:if>
                    <c:if test="${day eq result.fcltyDay and idx eq 1}">
                      <tr>
                        <td><em<c:out value="${(result.fcltyDay eq '1' or result.fcltyDay eq '7') ? ' class=em_red':''}"/>><c:out value="${dayMap[result.fcltyDay]}" /></em></td>
                        <td style="text-align: left;">
                    </c:if>
                        <ul>
                            <input type="hidden" name="fcltyAmtList[<c:out value="${status.index}"/>].fcltyDay" value="<c:out value="${day}"/>">
                            <input type="hidden" name="fcltyAmtList[<c:out value="${status.index}"/>].fcltyBgnHm" value="<c:out value="${result.fcltyBgnHm}"/>">
                            <input type="hidden" name="fcltyAmtList[<c:out value="${status.index}"/>].fcltyEndHm" value="<c:out value="${result.fcltyEndHm}"/>">
                            <li style="margin-bottom: 5px;">
                              · ${result.fcltyBgnHh} : ${result.fcltyBgnMm} ~  ${result.fcltyEndHh} : ${result.fcltyEndMm} &nbsp;
                              <input type="text" class="p-input p-input--auto w15p time-amt" maxlength="6"
                                     name="fcltyAmtList[<c:out value="${status.index}"/>].timeAmt"
                                     value="<c:out value="${(result.timeAmt eq '0' or empty result.timeAmt) ? fcltyVO.fcltyAmt : result.timeAmt}"/>"
                                     oninput="fn_numChk(this)" />원
                            </li>
                        </ul>

                    <c:if test="${day ne result.fcltyDay}">
                        </td>
                      </tr>
                    </c:if>
                    <c:set var="idx" value="${idx + 1}" />
                  </c:forEach>
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
          <c:choose>
            <c:when test="${applCnt gt 0}">
              <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
              신청자가 있는 경우 사용료 수정이 불가합니다.
            </c:when>
            <c:otherwise><input type="submit" class="p-button edit" value="수정"></c:otherwise>
          </c:choose>
        </div>
      </div>
    </fieldset>
  </form:form>


  <form action="./updateFcltyAmtStype.do" name="sFrm" id="sFrm" style="display: none;">
    <input type="hidden" name="fcltyNo" value="<c:out value="${fcltyVO.fcltyNo}"/>">

    <c:forEach var="result" items="${fcltySearchVO.paramsMap}">
      <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>
    <c:forEach var="result" items="${fcltySearchVO.paramsMapMng}">
      <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>

    <div class="row margin_t_20">
      <div class="col-12">
        <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">목록 </a>
      </div>
      <div class="col-12 right">
        <c:choose>
          <c:when test="${applCnt gt 0}">
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            신청자가 있는 경우 사용료 수정이 불가합니다.
          </c:when>
          <c:otherwise><input type="submit" class="p-button edit" value="수정"></c:otherwise>
        </c:choose>
      </div>
    </div>
  </form>

</div>

<script>
  $(document).ready(function (){
    <c:if test="${fcltyVO.amtMthd == 'S'}">
      $('#sFrm').show();
    </c:if>
    <c:if test="${fcltyVO.amtMthd == 'D'}">
      $('#dFrm').show();
    </c:if>

    $(document).on("change", 'input[name=amtMthdRadio]', function () {
      if($(this).val() == 'S') {
        $('#sFrm').show();
        $('#dFrm').hide();
      } else if ($(this).val() == 'D') {
        $('#dFrm').show();
        $('#sFrm').hide();
      }
    });

  });

  function fn_fcltyAmtDtypeChk(frm) {

    let bool = true;
    $('.time-amt').each(function () {
      if ($(this).val().trim() === '') {
        $(this).trigger('focus');
        bool = false;
      }
    });

    if (!bool) {
      alert('사용료를 입력해주세요.');
      return false;
    }

    if(confirm("위 내용대로 사용료를 수정하시겠습니까?")) {
      return true;
    }
  }

</script>
</body>
</html>