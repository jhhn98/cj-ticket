<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<link rel="stylesheet" href="/common/css/board.css" />
	<script src="/common/js/calendar.js"></script>
	<title>${menuInfo.cntntsNm} 수정</title>
</head>
<body>

<script type="text/javascript">

	$( document ).ready(function() {
		$('input[name="qestnTy"]').change(function(){
			if($(this).val()=='QESTY01'){
				$("[id^='hidden_tr']").hide();
			}else{
				$("[id^='hidden_tr']").show();
			}
		});
	});


	function fn_addAnswer(){

		var cnt = $("[id^='add_div_']").size();

		if(Number(cnt)+1 > 10){
			alert("더이상 추가가 불가능 합니다");
			return;
		}

		var newDiv = $("[id^='add_div_']").eq(0).clone();

		newDiv.find("[id$='qestnarAnswerNo']").remove();

		newDiv.attr("id","add_div_"+(Number(cnt)+1));

		newDiv.find(":text").val('');

		newDiv.find(":text").attr("name","answerList["+cnt+"].answer");
		newDiv.find("select").attr("name","answerList["+cnt+"].answerTy");
		newDiv.find("#fileDiv").html('');
		newDiv.find("#fileDiv").html("<input type='file' name='answerList["+cnt+"].file' class='InputText' style='width:600px;'' />");


		newDiv.find("en").html(Number(cnt)+1);
		newDiv.insertAfter($("#add_div_"+cnt));
	}

	function fn_deleteAnswer( url ){
		if(confirm("삭제하시겠습니까?")){
			window.location = url;
		}
	}

	function fn_deleteQestn( url ){
		if(confirm("삭제하시겠습니까?")){
			window.location = url;
		}
	}

</script>

<div class="p-wrap">
	<div class="col-15">

		<h1 class="subHeader">설문조사질문 &gt; 등록 </h1>
		<table class="p-table p-table--bordered" data-rwdb="yes">
			<tr>
				<th  width="15%">제목</th>
				<td  width="85%">${qestnar.qestnarSj}</td>
			</tr>
			<tr>
				<th  width="15%">설명</th>
				<td  width="85%">${qestnar.qestnarDc}</td>
			</tr>
			<tr>
				<th  width="15%">기간</th>
				<td  width="85%">${qestnar.bgndeYMD} ~ ${qestnar.enddeYMD}</td>
			</tr>
		</table>

<div style="margin-top: 20px"></div>
<form:form modelAttribute="qestnarQestn" name="qestnarQestn" action="updateQestnarQestnMng.do?siteId=${searchVO.siteId}&key=${key}&${searchVO.params}"  enctype="multipart/form-data" onsubmit="return validateQestnarQestn(this)">

<input type="hidden" name="qestnarNo" value="${qestnar.qestnarNo}"/>
<form:hidden path="qestnarQestnNo"/>

	<table class="p-table p-table--bordered" data-rwdb="yes">
			<tr>
				<th  width="15%"><form:label path="qestn">질문문항</form:label><em style="color:#FF0000 ">*</em></th>
				<td  width="85%">
					<form:input class="p-input p-input--auto"  path="qestn" size="40"/> <form:errors path="qestn"/>
				 </td>
			</tr>
			<tr>
				<th  width="15%"><form:label path="qestnDc">질문설명</form:label></th>
				<td  width="85%">
					<form:textarea class="p-input p-input--auto" path="qestnDc" title="질문 설명" style="width:633px; height:40px" />
					<br /> <font style="color: #FF0000">※ 줄바꿈시 &lt;br /&gt; 태그를 붙여주세요.</font>
				</td>
			</tr>
			<tr>
				<th>답변 유형</th>
				<td>
					 <form:radiobuttons items="${codeMapQest1}" path="qestnTy"/>
				</td>
			</tr>
			<tr id="hidden_tr1" <c:if test="${qestnarQestn.qestnTy eq 'QESTY01'}">style="display: none;"</c:if>>
				<th>객관식 답변 갯수</th>
				<td> 
					<form:select path="multiAnswerAt">
						<form:option value="N">단답(라디오버튼)</form:option>
						<form:option value="Y">복수답변(체크박스)</form:option>
					</form:select>
					 가능답변수:<form:input class="p-input p-input--auto"  path="answerCo" style="width:50px;" /> <form:errors path="qestn"/>
				</td>
			</tr>
			<tr id="hidden_tr2" <c:if test="${qestnarQestn.qestnTy eq 'QESTY01'}">style="display: none;"</c:if>>
				<th>답변</th>
				<td> 
					<c:forEach var="result" items="${qestnarQestn.answerList}" varStatus="status">
					<div id="add_div_${status.count }" style="margin-top: 5px">
					<form:hidden path="answerList[${status.index}].qestnarAnswerNo" />
						<en>${status.count}</en>. <form:input class="p-input p-input--auto"  path="answerList[${status.index}].answer" style="width:633px;"/>
							<span style="margin-left: 8px">
							<form:select path="answerList[${status.index}].answerTy">
								<form:options items="${codeMapQest2}"/>
							</form:select>
							</span>
						<div style="margin-top: 5px;margin-left: 20px" id="fileDiv">
							<c:if test="${not empty result.imageFileNm}">
							이미지파일명 : ${result.streFileNm} 
								<form:radiobutton path="answerList[${status.index}].fileDelAt" value="" />유지
			 					<form:radiobutton path="answerList[${status.index}].fileDelAt" value="Y"/>삭제
								<form:hidden path="answerList[${status.index}].imageFileNm"/>
								<form:hidden path="answerList[${status.index}].streFileNm"/>
							</c:if>
							<input type="file" name="answerList[${status.index}].file" class="InputText" style="width:600px;" />
						</div>
					</div>
					</c:forEach>
					
					<c:if test="${fn:length(qestnarQestn.answerList) == 0}">
					<div id="add_div_1" style="margin-top: 5px">
						<en>1</en>. <form:input class="p-input p-input--auto"  path="answerList[0].answer" style="width:633px;"/>
							<span style="margin-left: 8px">
							<form:select path="answerList[0].answerTy">
								<form:options items="${codeMapQest2}"/>
							</form:select>
							</span>
							<div style="margin-top: 5px;margin-left: 20px" id="fileDiv">
							<input type="file" name="answerList[0].file" class="InputText" style="width:600px;" />
							</div>
					</div>
					</c:if>
					
					<div style="height: 25px; margin-top: 10px">
						<a href="javascript:" onClick="fn_addAnswer();" class="button blue"><span>예문항목추가</span></a>
					</div>
				</td>
			</tr>
		</table>

		<table class="p-table " data-rwdb="yes">
		<tr>
			<td align="left">
				<a href="./selectQestnarList.do?siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>설문리스트</span></a>
				<a href="./addQestnarQestnView.do?qestnarNo=${qestnarQestn.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>돌아가기</span></a>
			</td>
			<td align="right"><span class="button blue"><input type="submit" value="질문수정"  class="p-button p-button--xsmall info" /></span></td>
		</tr>
		</table>
</form:form>

	</div>
</div>
</body>
</html>