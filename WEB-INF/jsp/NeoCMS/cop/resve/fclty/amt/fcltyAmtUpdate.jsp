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
                <label for="amtMthd1" class="p-form-radio__label">운영 시간별 동일요금 적용 (<b><fmt:formatNumber value="${fcltyVO.fcltyAmt}" pattern="#,###"/></b>)원</label>
            </span>
            <span class="p-form-radio">
                <input type="radio" name="amtMthdRadio" id="amtMthd2" class="p-form-radio__input" value="D"<c:if test="${fcltyVO.amtMthd == 'D'}"> checked</c:if>>
                <label for="amtMthd2" class="p-form-radio__label">운영 시간별 차등요금 적용</label>
            </span>
        </div>
      </td>
    </tr>
    </tbody>
  </table>

  <form action="" name="sFrm" id="sFrm">
    <input type="hidden" name="fcltyNo" value="">
  </form>


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
</div>
</body>
</html>