<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="kr.co.hanshinit.NeoCMS.cmm.util.StringUtil" %>
<%@ page import="kr.co.hanshinit.NeoCMS.cop.qsm.service.Qestnar" %>

<%

	Qestnar qestnar = (Qestnar) request.getAttribute("qestnar");

	String filename = StringUtil.UrlEncoding(qestnar.getQestnarSj()) + ".xls";

	response.setHeader("Content-Type", "application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+filename );
	response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사관리 목록</title>
<style>
  td{
    border:0px solid #368c9f;
    padding:5px !important;
  }
  th{
    border:1px;
  }
  table{
    border:1px solid #53908e;
  }
</style>
</head>
<body>
<h1 class="subHeader">설문통계</h1>

    <table border="1" style="border:1px" >
		<tr>
			<td style="font:bold;font-size:13pt;background-color:#73bdc7;color:#ffffff">번호</td>
			<td style="font:bold;font-size:13pt;background-color:#73bdc7;color:#ffffff">질문</td>
			<td style="font:bold;font-size:13pt;background-color:#73bdc7;color:#ffffff">응답수</td>
			<td style="font:bold;font-size:13pt;background-color:#73bdc7;color:#ffffff">총응답</td>
			<td style="font:bold;font-size:13pt;background-color:#73bdc7;color:#ffffff">비율</td>
		</tr>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <c:if test="${result.qestnTy eq 'QESTY02'}">
            
				<c:set var="rowSpanCnt" value="${fn:length(result.answerList)+1}" />	
				<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
					<c:set var="rowSpanCnt" value="${fn:length(objctMap[result.qestnarQestnNo])+rowSpanCnt}" />
				</c:if>
								
				<tr>
					<th rowspan="${rowSpanCnt}">문항${status.count}</th>
					<td >${result.qestn}</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td >&nbsp;</td>
				</tr>
				
				<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
					<tr>
						<td><span class="title">${result2.answer}</span></td>
						<td>${answerMap[result2.qestnarAnswerNo].answerCo}명</td>
						<td>${answerMap[result2.qestnarAnswerNo].allCo}명</td>
						<td >${answerMap[result2.qestnarAnswerNo].pt}%</td>
					</tr>
					
					<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
						<c:forEach var="result3" items="${objctMap[result.qestnarQestnNo]}" varStatus="status3">
							<c:if test="${result3.qestnarAnswerNo eq result2.qestnarAnswerNo}">
							<tr>
								<td><span class="title">답변</span></td>
								<td colspan="3">${result3.objctRspns}</td>
								<td >&nbsp;</td>
							</tr>
							</c:if>
						</c:forEach>
					</c:if>
				
				</c:forEach>
            </c:if>
            <c:if test="${result.qestnTy eq 'QESTY01'}">
				<tr>
					<th class="bd_left" scope="row"  rowspan="${fn:length(sbjctMap[result.qestnarQestnNo])+1}">문항${status.count}</th>
					<td >${result.qestn}</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td >&nbsp;</td>
				</tr>
				
				<c:forEach var="result2" items="${sbjctMap[result.qestnarQestnNo]}" varStatus="status2">
					<tr>
					   <td>답변</td>
					   <td  colspan="2">${result2.sbjctRspns}</td>
					   <td >&nbsp;</td>
					</tr>
				</c:forEach>
            </c:if>
         </c:forEach>
    </table>
	
</body>
</html>