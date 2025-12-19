<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${menuInfo.cntntsNm} 결과</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div id="board" class="clearfix">
	<div class="list_typeB">
		<h2>설문정보</h2>
		<div class="tit_area">
			<ul class="clearfix">
				<li class="titA">
					<div class="case_tit">설문명</div>
					<div class="case_cont bold">${qestnar.qestnarSj}</div>
				</li>
				<li class="titA">
					<div class="case_tit">설문기간</div>
					<div class="case_cont">${qestnar.bgndeYMD} ~ ${qestnar.enddeYMD}</div>
				</li>
				<li class="titA">
					<div class="case_tit">문항수</div>
					<div class="case_cont">${qestnar.qestnCo}</div>
				</li>
				<li class="titA">
					<div class="case_tit">설명</div>
					<div class="case_cont">${qestnar.qestnarDc}</div>
				</li>
			</ul>
			<h2>설문통계</h2>
			<table class="table_t1" summary="설문통계에 결과표로 질문 및 도표, 응답수, 총응답, 비율의 정보를 제공합니다.">
				<caption>설문정보</caption>
				<colgroup>
					<col width="11%" />
					<col width="" />
					<col width="15%" />
					<col width="10%" />
					<col width="10%" />
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
						<td class="bd_left" scope="row" align="center" rowspan="${rowSpanCnt}">문항${status.count}</td>
						<td class="text_left" colspan="4">${result.qestn}</td>

						<td class="bd_right">&nbsp;</td>
					</tr>

					<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
					<tr>
						<td><span class="title">${result2.answer}</span></td>
						<td class="text_left"><span class="bar">
						<img src="/common/images/board/<c:if test="${status2.index eq 0 || status2.index > 4}">pink</c:if><c:if test="${status2.index eq 1}">green</c:if><c:if test="${status2.index eq 2}">purple</c:if><c:if test="${status2.index eq 3}">yellow</c:if><c:if test="${status2.index eq 4}">blue</c:if>_bar.gif" width="${answerMap[result2.qestnarAnswerNo].pt}%" height="11" alt="${answerMap[result2.qestnarAnswerNo].pt}%" />
						</span>
						</td>
						<td>${answerMap[result2.qestnarAnswerNo].answerCo}</td>
						<td>${answerMap[result2.qestnarAnswerNo].allCo}명</td>
						<td class="bd_right">${answerMap[result2.qestnarAnswerNo].pt}%</td>
					</tr>

					<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
					<c:forEach var="result3" items="${objctMap[result.qestnarQestnNo]}" varStatus="status3">
						<c:if test="${result3.qestnarAnswerNo eq result2.qestnarAnswerNo && result3.objctRspns != ''}">
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
						<td class="text_left" colspan="4">${result.qestn}</td>
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
	</div>

	<div class="putB_center">
		<a href="./selectQestnarList.do?key=${key}&amp;${searchVO.params}" class="btnA">목록</a>
	</div>

</div>

</body>
</html>