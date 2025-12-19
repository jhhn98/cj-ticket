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

		if(Number(cnt)+1 > 30){
			alert("더이상 추가가 불가능 합니다");
			return;
		}

		var newDiv = $("[id^='add_div_']").eq(0).clone();

		newDiv.attr("id","add_div_"+(Number(cnt)+1));

		newDiv.find(":text").val('');

		newDiv.find(":text").attr("name","answerList["+cnt+"].answer");
		newDiv.find("select").attr("name","answerList["+cnt+"].answerTy");
		newDiv.find(":file").attr("name","answerList["+cnt+"].file");

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

<script language="javascript">

	function validateQestnarQestn( form ) {

		if( !form.qestn.value ) {
			alert("질문을 입력해주세요.");
			form.qestn.focus();
			return false;
		}
		/*
                if( !form.qestnTy.value ) {
                    alert("답변유형을 선택해주세요.");
                    form.qestnTy.focus();
                    return false;
                }

                if( !form.multiAnswerAt.value ) {
                    alert("객관식답변타입을 선택해주세요.");
                    form.multiAnswerAt.focus();
                    return false;
                }
        */
		return true;
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
		<form:form modelAttribute="qestnarQestn" name="qestnarQestn" action="addQestnarQestnMng.do?key=${key}&siteId=${searchVO.siteId}&amp;${searchVO.params}"  enctype="multipart/form-data" onsubmit="return validateQestnarQestn(this)">

			<input type="hidden" name="qestnarNo" value="${qestnar.qestnarNo}"/>

			<table class="p-table p-table--bordered" data-rwdb="yes">
				<tr>
					<th  width="15%"><form:label path="qestn">질문문항</form:label><em style="color:#FF0000 ">*</em></th>
					<td  width="85%">
						<form:input class="p-input p-input--auto" path="qestn" size="40"/> <form:errors path="qestn"/>
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
						<form:radiobuttons items="${codeMapQest1}" path="qestnTy"/> <form:errors path="qestnTy"/>
					</td>
				</tr>
				<tr id="hidden_tr1" >
					<th>객관식 답변 갯수</th>
					<td>
						<form:select path="multiAnswerAt" class="p-input p-input--auto">
							<form:option value="N">단답(라디오버튼)</form:option>
							<form:option value="Y">복수답변(체크박스)</form:option>
						</form:select>
						가능답변수:<form:input class="p-input p-input--auto" path="answerCo" style="width:50px;" value="1" /> <form:errors path="multiAnswerAt"/>
					</td>
				</tr>
				<tr id="hidden_tr2" >
					<th>답변</th>
					<td>
						<div id="add_div_1" style="margin-top: 5px">
							<en>1</en>. <form:input class="p-input p-input--auto" path="answerList[0].answer" style="width:633px;"/>
							<span style="margin-left: 8px">
							<form:select path="answerList[0].answerTy" class="p-input p-input--auto">
								<form:options items="${codeMapQest2}"/>
							</form:select>
							</span>
							<div style="margin-top: 5px;margin-left: 20px"><input type="file" name="answerList[0].file" class="InputText" style="width:600px;" />
							</div>
						</div>
						<div style="height: 25px; margin-top: 10px">
							<a href="javascript:" onClick="fn_addAnswer();" class="p-button p-button--xsmall write"><span>예문항목추가</span></a>
						</div>
					</td>
				</tr>
			</table>

			<table class="p-table p-table--bordered" data-rwdb="yes">
				<tr>
					<td align="left">
						<a href="./selectQestnarMngList.do?key=${key}&siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>설문리스트</span></a>
						<a href="./updateQestnSortMngView.do?key=${key}&qestnarNo=${searchVO.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>문항순서변경</span></a>
						<a href="./selectQestnarMngResult.do?key=${key}&qestnarNo=${searchVO.qestnarNo}" class="p-button p-button--xsmall cancel" ><span>설문결과보기</span></a>
					</td>
					<td align="right">
						<span class="button blue"><input type="submit" value="등록 OR 질문추가" class="p-button p-button--xsmall info" /></span>
					</td>
				</tr>
			</table>
		</form:form>

		<div style="padding:10px"></div>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<table class="p-table p-table--bordered" data-rwdb="yes">
				<tr>
					<th width="15%">수정/삭제/순서변경</th>
					<td  width="85%">
						<a href="./updateQestnarQestnMngView.do?key=${key}&qestnarNo=${searchVO.qestnarNo}&amp;qestnarQestnNo=${result.qestnarQestnNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall info"><span>수정</span></a>
						<a href="./deleteQestnarQestnMng.do?key=${key}&qestnarNo=${searchVO.qestnarNo}&amp;qestnarQestnNo=${result.qestnarQestnNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" onclick="fn_deleteQestn(this.href); return false;" class="p-button p-button--xsmall restore"><span>삭제</span></a>
						<a href="./updateAnswerSortMngView.do?key=${key}&qestnarNo=${searchVO.qestnarNo}&amp;qestnarQestnNo=${result.qestnarQestnNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>순서변경</span></a>
					</td>
				</tr>
				<tr>
					<th  width="15%">문항 ${status.index+1 }</th>
					<td  width="85%">${result.qestn } </td>
				</tr>
				<tr>
					<th>답변유형</th>
					<td>
							${codeMapQest1[result.qestnTy]}
						<c:if test="${result.qestnTy eq 'QESTY02'}">
							<c:if test="${result.multiAnswerAt eq 'Y'}">
								(복수형 : ${result.answerCo}개 선택 가능)
							</c:if>
							<c:if test="${result.multiAnswerAt eq 'N'}">
								(단답형 : ${result.answerCo}개 선택 가능)
							</c:if>
						</c:if>
					</td>
				</tr>
				<c:if test="${result.qestnTy eq 'QESTY02'}">
					<tr>
						<th>예문</th>
						<td>
							<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
								${status2.index+1 }. ${result2.answer} <c:if test="${result2.answerTy eq 'ANSTY02'}">(예문주관식답변)</c:if>
								<a href="./deleteQestnarAnswerMng.do?key=${key}&qestnarAnswerNo=${result2.qestnarAnswerNo}&amp;qestnarNo=${searchVO.qestnarNo}&amp;qestnarQestnNo=${result.qestnarQestnNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall restore" onclick="fn_deleteAnswer(this.href); return false;">삭제</a>
								<c:if test="${not empty result2.imageFileNm}">
									<br/><img  src="${path}/${result2.imageFileNm }" alt="${exList.example }" title="${exList.example }" width="250" height="200">
								</c:if>

								<br/><br/>
							</c:forEach>
						</td>
					</tr>
				</c:if>
			</table>
		</c:forEach>
	</div>
</div>

</body>
</html>