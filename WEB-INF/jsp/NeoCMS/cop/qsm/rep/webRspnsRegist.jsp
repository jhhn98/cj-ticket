<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>${menuInfo.cntntsNm} 설문참여</title>
	<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
<script type="text/javascript">
	$( document ).ready(function() {
		$(':checkbox').change(function(){
			var cnt = $(this).attr('id').split("_")[1];
			if(cnt== $(this).parent().parent().parent().find(':checkbox:checked').length){
				$(this).parent().parent().parent().find(':checkbox:not(:checked)').attr("disabled", "disabled");
			}else{
				$(this).parent().parent().parent().find(':checkbox').removeAttr("disabled");
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

			$(this).parent().parent().parent().find(':radio').each(function(){
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
		var obj = document.getElementById("qestnarRspns");
		<c:set var="objctCnt" value="0" />
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${result.qestnTy eq 'QESTY02'}">
		var chk = 0;
		<c:if test="${result.multiAnswerAt eq 'N'}">
		for(k=0;k<obj['objctList[${objctCnt}].qestnarAnswerNo'].length;k++) {
			if( obj['objctList[${objctCnt}].qestnarAnswerNo'][k].checked == true ) {
				chk = chk + 1;
				break;
			}
		}

		if( chk == 0 ) {
			alert("${objctCnt + 1}번째 문항에 대한 답변을 선택해 주세요.");
			obj['objctList[${objctCnt}].qestnarAnswerNo'][0].focus();
			return false;
		}
		</c:if>
		<c:if test="${result.multiAnswerAt eq 'Y'}">
		for(k=0;k<obj['objctList[${objctCnt}].chkAnswerNo'].length;k++) {
			if( obj['objctList[${objctCnt}].chkAnswerNo'][k].checked == true ) {
				chk = chk + 1;
			}
		}

		if( chk == 0 ) {
			alert("${objctCnt + 1}번째 문항에 대한 답변을 선택해 주세요.");
			obj['objctList[${objctCnt}].chkAnswerNo'][0].focus();
			return false;
		}

		if( chk > ${result.answerCo} ) {
			alert("${objctCnt + 1}번째 문항에 대한 답변은 ${result.answerCo}개까지만 선택 가능합니다.");
			return false;
		}
		</c:if>

		<c:set var="objctCnt" value="${objctCnt+1}" />
		</c:if>
		</c:forEach>

		if(confirm('설문조사 등록을 하시겠습니까?')) {
			window.location = url;
			return true;
		}

		return false;
	}

</script>


<div class="program participate">
	<form:form modelAttribute="qestnarRspns" name="qestnarRspns" action="addQestnarRspns.do?key=${key}&amp;${searchVO.params}"  onSubmit="return qestnarRspnsSubmit(this)">
		<form:hidden path="qestnarNo"/>
		<fieldset>
			<legend>설문조사 - 참여하기</legend>
			<h3>설문정보</h3>
			<div class="part_top_box">
				<span class="title">${qestnar.qestnarSj}</span>
				<div class="category_box clearfix">
					<div class="category deadline">
						<span class="category_title">설문기간</span>
						<span class="category_result">${qestnar.bgndeYMD} ~ ${qestnar.enddeYMD}</span>	<!--//category_result-->
					</div>	<!--//category-->
					<div class="category number">
						<span class="category_title">문항수</span>
						<span class="category_result">${qestnar.qestnCo}</span>	<!--//category_result-->
					</div>		<!--//category-->
				</div>	<!--//category_box-->
				<div class="desc_box clearfix">
					<span class="desc_title">설명</span>
					<div class="explain">
							${qestnar.qestnarDc}
					</div>	<!--//explain-->
				</div>	<!--//desc_box-->
			</div>	<!--//part_top_box-->

			<div class="check_list_box">
				<ul class="check_list">

					<c:set var="objctCnt" value="0" />
					<c:set var="sbjctCnt" value="0" />

					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:if test="${result.qestnTy eq 'QESTY02'}">
							<!--객관식-->
							<li class="check_item">
								<div class="check_title clearfix">
							<span class="count">
								<span class="count_text">${status.count}</span>
							</span>	<!--//count-->
									<span class="title">${result.qestn}</span>
									<br/>
										${result.qestnDc}
								</div>	<!--//check_title-->
								<div class="public_box">
									<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
										<c:if test="${result.multiAnswerAt eq 'N'}">
											<!--가능답변 1개-->
											<div class="public_wrap clearfix">
												<div class="left_box">
												<span class="sd_input">
													<input type="radio" id="${result2.qestnarAnswerNo}_${result.answerCo}" name="objctList[${objctCnt}].qestnarAnswerNo" value="${result2.qestnarAnswerNo}" >
													<label for="${result2.qestnarAnswerNo}_${result.answerCo}"><i></i>${status2.count}) ${result2.answer}</label>
												</span>
														<%--<div class="sub_desc">
                                                            <span class="text">장점: 기존 건축물의 창문 라인을 유지하여 철거를 최소화</span>
                                                            <span class="text">단점: 내단열로 인한 기존 건축물 전용면적 감소, 기존 적벽돌과 증축부분의 색상 차이로 인한 이질감 발생 우려</span>
                                                        </div>--%>	<!--//sub_desc-->
												</div>	<!--//left_box-->
												<c:if test="${not empty result2.imageFileNm}">
													<div class="right_box">
														<div class="photobox">
															<div class="photo_wrap" style="background-image:url(${path}/${result2.imageFileNm })"></div>
															<div class="photo_img">
																<img src="${path}/${result2.imageFileNm }" alt="${result2.answer }">
															</div>	<!--//photo_img-->
														</div>	<!--//photobox-->
													</div>	<!--//right_box-->
												</c:if>

											</div>	<!--//public_wrap-->
										</c:if>
										<c:if test="${result.multiAnswerAt eq 'Y'}">
											<!--가능답변 2개이상-->
											<div class="public_wrap type2 clearfix">
												<div class="left_box">
												<span class="sd_input">
													<input type="checkbox" id="${result2.qestnarAnswerNo}_${result.answerCo}" name="objctList[${objctCnt}].chkAnswerNo" value="${result2.qestnarAnswerNo}">
													<label for="${result2.qestnarAnswerNo}_${result.answerCo}">${status2.count}) ${result2.answer}</label>
												</span>
												<c:if test="${not empty result2.imageFileNm}">
													<div class="right_box">
														<div class="photobox">
															<div class="photo_wrap" style="background-image:url(${path}/${result2.imageFileNm })"></div>
															<div class="photo_img">
																<img src="${path}/${result2.imageFileNm }" alt="${result2.answer }">
															</div>	<!--//photo_img-->
														</div>	<!--//photobox-->
													</div>	<!--//right_box-->
												</c:if>
												</div>	<!--//left_box-->
											</div>	<!--//public_wrap-->
										</c:if>
										<c:if test="${result2.answerTy eq 'ANSTY02'}">
											<!--객관식안에 주관식있을경우-->
											<div class="public_wrap type2 clearfix">
												<div class="area_box">
													<div class="sd_input">
														<textarea title="주관식 답변 입력" id="${result2.qestnarAnswerNo}" name="objctList[${objctCnt}].objctRspns" disabled="disabled" title="기타 입력" cols="10" rows="5"></textarea>
														<input type="hidden"  name="objctList[${objctCnt}].objctRspnsLc" value="${result2.qestnarAnswerNo}"/>
													</div>	<!--//sd_input-->
													<c:if test="${not empty result2.imageFileNm}">
														<div class="right_box">
															<div class="photobox">
																<div class="photo_wrap" style="background-image:url(${path}/${result2.imageFileNm })"></div>
																<div class="photo_img">
																	<img src="${path}/${result2.imageFileNm }" alt="${result2.answer }">
																</div>	<!--//photo_img-->
															</div>	<!--//photobox-->
														</div>	<!--//right_box-->
													</c:if>
												</div>	<!--//area_box-->
											</div>	<!--//public_wrap-->
										</c:if>

									</c:forEach>
									<input type="hidden" name="objctList[${objctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />
									<c:set var="objctCnt" value="${objctCnt+1}" />
								</div>	<!--//public_box-->
							</li>	<!--//check_item-->
						</c:if>
						<c:if test="${result.qestnTy eq 'QESTY01'}">
							<!--주관식-->
							<li class="check_item">
								<div class="check_title clearfix">
							<span class="count">
								<span class="count_text">${status.count}</span>
							</span>	<!--//count-->
									<span class="title">${result.qestn}</span>
								</div>	<!--//check_title-->
								<div class="public_box">
									<div class="public_wrap type2 clearfix">
										<div class="area_box">
											<div class="sd_input">
												<textarea title="주관식 답변 입력" name="sbjctList[${sbjctCnt}].sbjctRspns" id="sbjctList[${sbjctCnt}].sbjctRspns" cols="10" rows="5"></textarea>
												<input type="hidden" name="sbjctList[${sbjctCnt}].qestnarQestnNo" value="${result.qestnarQestnNo}" />
											</div>	<!--//sd_input-->
										</div>	<!--//area_box-->
									</div>	<!--//public_wrap-->
								</div>	<!--//public_box-->
							</li>	<!--//check_item-->
							<c:set var="sbjctCnt" value="${sbjctCnt+1}" />
						</c:if>
					</c:forEach>
				</ul>	<!--//check_list-->
			</div>	<!--//check_list_box-->
			<div class="form_box">
				<input type="submit" value="저장" class="btn">
				<a href="./selectQestnarList.do?key=${key}&amp;${searchVO.params}" title="취소" class="btn type3">취소</a>
			</div>	<!--//form_box-->
		</fieldset>
	</form:form>
</div>	<!--//program participate-->
</body>
</html>