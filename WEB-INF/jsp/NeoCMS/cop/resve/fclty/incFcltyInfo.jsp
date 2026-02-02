<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="card card--line margin_b_30">
  <h3>시설 정보</h3>
  <table class="p-table margin_b_20">
    <caption>시설예약 정보 - 제목, 기관명, 접수기간, 시설기간, 내용, 첨부파일 정보 제공</caption>
    <colgroup>
      <col class="w15p" />
      <col />
      <col class="w15p" />
      <col />
    </colgroup>
    <tbody class="p-table--th-left">
    <tr class="p-table__subject">
      <th scope="row">[년도] 시설명</th>
      <td colspan="3">
        <span class="p-table__subject_text">
            [<c:out value="${fcltyVO.operYear}"/>] <c:out value="${fcltyVO.fcltyNm}"/>
            - <c:out value="${svcTyMap[fcltyVO.svcTyCd]}"/> - <c:out value="${fctPlaceMap['place'.concat(fcltyVO.placeNo)]}"/>
        </span>
      </td>
    </tr>
    <tr>
      <th scope="row">운영기관</th>
      <td colspan="3">
        [<c:out value="${insttVO.useYn eq 'Y' ? '운영중' : '미운영'}"/>]
        <c:out value="${insttVO.insttNm}"/>
        <c:if test="${insttVO.mtCoLmtt > 0}">
          - 기관 별 월 신청 가능 횟수 : <c:out value="${insttVO.mtCoLmtt}"/>번
        </c:if>
        <c:if test="${insttVO.rdcxptCoLmtt > 0}">
          - 기관 별 월 감면 가능 횟수 : <c:out value="${insttVO.rdcxptCoLmtt}"/>번
        </c:if>
      </td>
    </tr>
    <tr>
      <th scope="row">운영상태</th>
      <td><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></td>
      <th scope="row">표시여부</th>
      <td><c:out value="${fcltyVO.useYn eq 'Y' ? '표시' : '숨김'}"/></td>
    </tr>
    <tr>
      <th scope="row">접수기간</th>
      <td><c:out value="${fcltyVO.rcptBgnDe}"/> <c:out value="${fcltyVO.rcptBgnHh}"/>:<c:out value="${fcltyVO.rcptBgnMm}"/>
        ~
        <c:out value="${fcltyVO.rcptEndDe}"/> <c:out value="${fcltyVO.rcptEndHh}"/>:<c:out value="${fcltyVO.rcptEndMm}"/>
      </td>
      <th scope="row">시설예약기간</th>
      <td>
        <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
        <c:out value="${not empty fcltyVO.fcltyMinBgnDe ? ' ~ ' : ''}" />
        <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
      </td>
    </tr>

    <tr>
      <th scope="row">접수방식</th>
      <td>
        <c:forEach var="result" items="${fcltyVO.rcptMthdCdArr}" varStatus="status">
          <c:out value="${rcptMthdMap[result]}"/>
          <c:if test="${!status.last}">, </c:if>
        </c:forEach>
      </td>
      <th scope="row">제한사항</th>
      <td>
        <ul>
          <c:if test="${fcltyVO.mtLmttDayTime > 0}"><li>- 일 최대 이용 시간<c:out value="${fcltyVO.mtLmttDayTime}"/>시간</li></c:if>
          <c:if test="${fcltyVO.mtLmttTime > 0}"><li>- 월 최대 이용 시간<c:out value="${fcltyVO.mtLmttTime}"/>시간</li></c:if>
          <c:if test="${fcltyVO.nmprMinCnt > 0}"><li>- 최소 사용 인원<c:out value="${fcltyVO.nmprMinCnt}"/>명</li></c:if>
          <c:if test="${fcltyVO.nmprMaxCnt > 0}"><li>- 최대 사용 인원<c:out value="${fcltyVO.nmprMaxCnt}"/>명</li></c:if>
        </ul>
      </td>
    </tr>

    <tr>
      <th scope="row">선발방식</th>
      <td>
        <c:out value="${slctMthdMap[fcltyVO.slctMthdCd]}"/>

        <c:if test="${fcltyVO.slctMthdCd == 'DRWLT'}">
          ( 예정일 : <c:out value="${tsu:toDateFormat(fcltyVO.drwtDt, 'yyyyMMddHHmm', 'yyyy-MM-dd HH:mm')}"/> )
        </c:if>
      </td>
      <th scope="row">시설료 / 결제방식</th>
      <td>
        <c:choose>
          <c:when test="${fcltyVO.fcltyAmt > 0 and fcltyVO.amtMthd eq 'S'}">
            <fmt:formatNumber value="${tsu:xssNumberFilter(fcltyVO.fcltyAmt)}" pattern="#,##0"/> 원
          </c:when>
          <c:when test="${fcltyVO.fcltyAmt > 0 and fcltyVO.amtMthd eq 'D'}">
            기본료 <fmt:formatNumber value="${tsu:xssNumberFilter(fcltyVO.fcltyAmt)}" pattern="#,##0"/> 원, 시간별 차등요금제.
          </c:when>
          <c:otherwise>
            무료
          </c:otherwise>
        </c:choose>

        <c:forEach var="result" items="${fcltyVO.payMthdCdArr}" varStatus="status">
          <c:if test="${status.first}">/</c:if>
          <c:out value="${payMthdMap[result]}"/>
          <c:if test="${!status.last}">, </c:if>
        </c:forEach>
      </td>
    </tr>
    <c:if test="${fcltyVO.slctMthdCd == 'DRWLT'}">
      <tr>
        <th scope="row">추첨상태</th>
        <td colspan="3">
          <c:if test="${fcltyVO.slctMthdCd == 'DRWLT'}">
            <c:if test="${fcltyVO.drwtYn == 'N'}">
              추첨대기
              <c:set var="todate" value="${tsu:getNowDateTime('yyyyMMddHHmm')}"/>
              <c:if test="${fcltyVO.drwtDt <= todate && empty fcltyVO.drwtProcDt}">
                <button type="button" class="p-button info prepareDrwtProcess">예비추첨실행</button>
              </c:if>
              <c:if test="${!empty fcltyVO.drwtProcDt}">
                <button type="button" class="p-button info prepareDrwtProcess">예비추첨재실행</button>
                <button type="button" id="drwtWinList" class="p-button warning">추첨결과확인</button>
                <button type="button" id="drwtProcess" class="p-button danger">추첨확정진행</button>
              </c:if>
            </c:if>
            <c:if test="${fcltyVO.drwtYn == 'Y'}">
              추첨완료 ( <c:out value="${tsu:toDateFormat(fcltyVO.drwtProcDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> )
            </c:if>
          </c:if>
        </td>
      </tr>
    </c:if>
    </tbody>
  </table>
</div>