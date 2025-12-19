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
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
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

	function qestnarRspnsSubmit( form ) {
		if(confirm('Registration survey would you do?')) {
			window.location = url;
			return true;
		}
		return false;
	}


</script>
<form:form modelAttribute="qestnarRspns" name="qestnarRspns" action="addQestnarRspns.do?key=${key}&amp;${searchVO.params}" onSubmit="return qestnarRspnsSubmit(this)"  >
<form:hidden path="qestnarNo"/>
<div id="board" class="clearfix">
    <h2>Survey information</h2>
    <table class="table_t1" summary="survey posts and ,Title, Period, Explanation providing information of etc">
        <caption>Survey information</caption>
        <colgroup>
        <col width="20%" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">Title</th>
                <td>${qestnar.qestnarSj}</td>
            </tr>
            <tr>
                <th scope="row">Explanation</th>
                <td>${qestnar.qestnarDc}</td>
            </tr>
            <tr>
                <th scope="row">Period</th>
                <td>${qestnar.bgndeYMD} ~ ${qestnar.enddeYMD}</td>
            </tr>
            <tr>
                <th scope="row">Number of survey</th>
                <td>${qestnar.qestnCo}</td>
            </tr>
        </tbody>
    </table>
    <div id="board" class="clearfix">
		<div id="poll_conts">

		<c:set var="objctCnt" value="0" />
		<c:set var="sbjctCnt" value="0" />

		<c:forEach var="result" items="${resultList}" varStatus="status">
		<h3>${status.count}. ${result.qestn} </h3>
			<c:if test="${not empty result.qestnDc}">
			<div class="indent margin_b_10">
			<%--${result.qestnDc}--%>
			<c:set var="resultQestnDc" value="${fn:replace(result.qestnDc, '&lt;', '<')}" />
			<c:set var="resultQestnDc" value="${fn:replace(resultQestnDc, '&gt;', '>')}" />
			<c:set var="resultQestnDc" value="${fn:replace(resultQestnDc, '<br/>', '')}" />
			${resultQestnDc}
			</div>
			</c:if>

		<c:if test="${result.qestnTy eq 'QESTY02'}">
		<div class="indent">
		<ul class="clearfix">

			<c:forEach var="result2" items="${result.answerList}" varStatus="status2">

			<li>
				<label for="Exa${status2}_${result2.qestnarAnswerNo}">
				<c:if test="${result.multiAnswerAt eq 'N'}">
					<input type="radio" id="Exa${status2}_${result2.qestnarAnswerNo}" name="objctList[${objctCnt}].qestnarAnswerNo" value="${result2.qestnarAnswerNo}" />
				</c:if>
				<c:if test="${result.multiAnswerAt eq 'Y'}">
					<input type="checkbox" id="Exa${status2}_${result2.qestnarAnswerNo}" name="objctList[${objctCnt}].chkAnswerNo" class="checkbox" value="${result2.qestnarAnswerNo}" />
				</c:if>
				${status2.count}) ${result2.answer}
				<c:if test="${result2.answerTy eq 'ANSTY02'}">
					<input type="text"  id="${result2.qestnarAnswerNo}" name="objctList[${objctCnt}].objctRspns" disabled="disabled" title="기타입력" />
					<input type="hidden"  name="objctList[${objctCnt}].objctRspnsLc" value="${status2.index}"/>
				</c:if>
				<c:if test="${not empty result2.imageFileNm}"><br/><br/><img src="${path}/${result2.imageFileNm }" alt="${result2.answer }" title="${result2.answer }" width="250" height="200" /><br/><br/></c:if>
				</label>
			</li>
			</c:forEach>
			<input type="hidden" name="objctList[${objctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />

			<c:set var="objctCnt" value="${objctCnt+1}" />
		</ul>
		</div>
		</c:if>
		<c:if test="${result.qestnTy eq 'QESTY01'}">
		<div class="indent">
		<label class="skip" for="UserExample_">Contents</label>
			<form:textarea path="sbjctList[${sbjctCnt}].sbjctRspns" title="enter contents" rows="5" cols="40" style="width:95%" />
		<input type="hidden" name="sbjctList[${sbjctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />
		</div>
		<c:set var="sbjctCnt" value="${sbjctCnt+1}" />
		</c:if>
		<span class="dot"></span>


		</c:forEach>
		</div>
	</div>
</div>
<div class="putA_center">
	<input type="submit" value="Send" class="btnC" />
	<a href="./selectQestnarList.do?key=${key}&amp;${searchVO.params}" title="Cancel" class="btnE">Cancel</a>
</div>
</form:form>

</body>
</html>