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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사관리 목록</title>
<link rel="stylesheet" href="./css/neo.css" />
<link rel="stylesheet" href="./css/subheader.css" />
<script type="text/javascript" src="./js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript">
	$( document ).ready(function() {
		$(':checkbox').change(function(){
			var cnt = $(this).attr('id');
			if(cnt== $(this).parent().parent().find(':checkbox:checked').length){
				$(this).parent().parent().find(':checkbox:not(:checked)').attr("disabled", "disabled");
			}else{
				$(this).parent().parent().find(':checkbox').removeAttr("disabled");
			}
			
			var id= $(this).val();
			
			if($(this).is(":checked")){
				$("#"+id).removeAttr("disabled");
				$("#"+id).focus();
			}else{
				$("#"+id).attr("disabled", "disabled");
				$("#"+id).val('');
			}		
		 });
		
		$(':radio').change(function(){
			
			$(this).parent().parent().find(':radio').each(function(){
				var id= $(this).val();
				
				if($(this).is(":checked")){
					$("#"+id).removeAttr("disabled");
					$("#"+id).focus();
				}else{
					$("#"+id).attr("disabled", "disabled");
					$("#"+id).val('');
				}	
			});
		 });
	});
	
</script>
</head>
<body>

<form:form modelAttribute="qestnarRspns" name="qestnarRspns" action="addQestnarRspns.do?key=${key}&amp;${searchVO.params}" >
<form:hidden path="qestnarNo"/>
<h1 class="subHeader">설문등록</h1>
<div style="padding:10px">
		
		<c:set var="objctCnt" value="0" />
		<c:set var="sbjctCnt" value="0" />
		
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<h3>${status.count}. ${result.qestn} </h3>
			<c:if test="${not empty result.qestnDc}">
			<div class="ex">
			${result.qestnDc}
			</div>
			</c:if>
		
		<c:if test="${result.qestnTy eq 'QESTY02'}">		
		<ul class="clearfix">
			
			<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
			
			<li>
				<c:if test="${result.multiAnswerAt eq 'N'}">			
					<input type="radio" value="${result2.qestnarAnswerNo}"  name="objctList[${objctCnt}].qestnarAnswerNo"  >
				</c:if>
				<c:if test="${result.multiAnswerAt eq 'Y'}">
					<input type="checkbox"  id="${result.answerCo}" name="objctList[${objctCnt}].chkAnswerNo" class="checkbox" value="${result2.qestnarAnswerNo}" />
				</c:if>
				<label for="Exa1_1">${status2.count}) ${result2.answer}
				<c:if test="${result2.answerTy eq 'ANSTY02'}">
					<input type="text"  id="${result2.qestnarAnswerNo}" name="objctList[${objctCnt}].objctRspns" disabled="disabled" />
				</c:if>
				<c:if test="${not empty result2.imageFileNm}"><br/><br/><img src="${path}/${result2.imageFileNm }" alt="${result2.answer }" title="${result2.answer }" width="250" height="200" /><br/><br/></c:if>
				</label>
			</li>
			</c:forEach>
			<input type="hidden" name="objctList[${objctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />
			
			<c:set var="objctCnt" value="${objctCnt+1}" />	
		</ul>	
		</c:if>
		<c:if test="${result.qestnTy eq 'QESTY01'}">
		<label class="skip" for="UserExample_">내용</label>
			<form:textarea path="sbjctList[${sbjctCnt}].sbjctRspns" class="BoardInputText"  title="내용을 입력해주세요" rows="5" cols="40" />
		<input type="hidden" name="sbjctList[${sbjctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />
		<c:set var="sbjctCnt" value="${sbjctCnt+1}" />	
		</c:if>
		<span class="dot"></span>
		
		
		</c:forEach>
</div>
<div class="boardNavigation clearfix">  
    	<div class="floatRight">      
        <a href="./addQestnarQestnView.do?qestnarNo=${qestnar.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="button black"><span>돌아가기</span></a>
        </div>
    </div>
</form:form>
</body>
</html>