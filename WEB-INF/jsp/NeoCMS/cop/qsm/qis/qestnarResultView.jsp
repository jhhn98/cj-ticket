<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<link rel="stylesheet" href="/common/css/board.css" />
	<script src="/common/js/calendar.js"></script>
	<title>${menuInfo.cntntsNm} 신청</title>
</head>
<body>

<div class="p-wrap">
	<div class="col-15">
		<h1 class="subHeader">설문통계</h1>
		<div style="padding:10px">
			<table class="p-table">
				<caption>
					설문정보
				</caption>
				<colgroup>
					<col width="11%" />
					<col width="10%" />
					<col width="" />
					<col width="8%" />
					<col width="8%" />
					<col width="8%" />
				</colgroup>
				<thead>
				<tr>
					<th scope="col">번호</th>
					<th colspan="2" scope="col">질문 및 도표</th>
					<th scope="col">응답수</th>
					<th scope="col">총응답</th>
					<th scope="col">비율</th>
				</tr>
				</thead>
				<tbody class="tb list">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:if test="${result.qestnTy eq 'QESTY02'}">

						<c:set var="rowSpanCnt" value="${fn:length(result.answerList)+1}" />
						<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
							<c:set var="rowSpanCnt" value="${fn:length(objctMap[result.qestnarQestnNo])+rowSpanCnt}" />
						</c:if>


						<tr>
							<th class="bd_left" scope="row"  rowspan="${rowSpanCnt}">문항${status.count}</th>
							<td class="text_left" colspan="2">${result.qestn}</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td class="bd_right">&nbsp;</td>
						</tr>

						<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
							<tr>
								<td><span class="title">${result2.answer}</span></td>
								<td class="text_left"><span class="bar" style="width:100%;"><img src="/common/images/board/<c:if test="${status2.index eq 0 || status2.index > 4}">pink</c:if><c:if test="${status2.index eq 1}">green</c:if><c:if test="${status2.index eq 2}">purple</c:if><c:if test="${status2.index eq 3}">yellow</c:if><c:if test="${status2.index eq 4}">blue</c:if>_bar.gif" width="${answerMap[result2.qestnarAnswerNo].pt}%" height="11" alt="${answerMap[result2.qestnarAnswerNo].pt}%" />
						</span></td>
								<td>${answerMap[result2.qestnarAnswerNo].answerCo}</td>
								<td>${answerMap[result2.qestnarAnswerNo].allCo}명</td>
								<td class="bd_right">${answerMap[result2.qestnarAnswerNo].pt}%</td>
							</tr>

							<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
								<c:forEach var="result3" items="${objctMap[result.qestnarQestnNo]}" varStatus="status3">
									<c:if test="${result3.qestnarAnswerNo eq result2.qestnarAnswerNo}">
										<tr>
											<td><span class="title">답변</span></td>
											<td class="text_left" colspan="3">${result3.objctRspns}</td>
											<td class="bd_right">&nbsp;</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>

						</c:forEach>
					</c:if>
					<c:if test="${result.qestnTy eq 'QESTY01'}">
						<tr>
							<th class="bd_left" scope="row"  rowspan="${fn:length(sbjctMap[result.qestnarQestnNo])+1}">문항${status.count}</th>
							<td class="text_left" colspan="2">${result.qestn}</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td class="bd_right">&nbsp;</td>
						</tr>

						<c:forEach var="result2" items="${sbjctMap[result.qestnarQestnNo]}" varStatus="status2">
							<tr>
								<td><span class="title">답변</span></td>
								<td class="text_left" colspan="3">${result2.sbjctRspns}</td>
								<td class="bd_right">&nbsp;</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectQestnarResultExcel.do?key=${key}&qestnarNo=${qestnar.qestnarNo}" title="새창" target="_blank" class="p-button write"><span>엑셀다운로드</span></a>
			</div>
			<div class="col-12 right">
				<a href="./addQestnarQestnMngView.do?key=${key}&qestnarNo=${qestnar.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button write"><span>돌아가기</span></a>
			</div>
		</div>

	</div>
</div>
</body>
</html>