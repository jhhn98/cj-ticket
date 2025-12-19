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
<title>${menuInfo.cntntsNm} 결과화면</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div class="program participate type2">
	<form action=""> <!--//action값 채워주세요-->
		<fieldset>
			<legend>설문조사 - 결과보기</legend>
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

			<div class="all_btn">
				<a href="" class="btn small open">전체열기</a>
				<a href="" class="btn small close">전체닫기</a>
			</div>
			<div class="check_list_box">
				<ul class="check_list">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:if test="${result.qestnTy eq 'QESTY02'}">
							<!--객관식-->
							<c:set var="rowSpanCnt" value="${fn:length(result.answerList)+1}" />
							<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
								<c:set var="rowSpanCnt" value="${fn:length(objctMap[result.qestnarQestnNo])+rowSpanCnt}" />
							</c:if>


							<li class="check_item active">
								<div class="qna_btn_wrap">
									<button type="button" class="check_title qna_btn active clearfix" title="답변 닫기">
							<span class="count">
								<span class="count_text">${status.count}</span>
							</span>	<!--//count-->
										<span class="title">${result.qestn}</span>
									</button>	<!--//check_title-->
								</div>
								<div class="public_box" style="display: block;">
									<div class="result_box">
										<div class="survey_table">
											<table>
												<caption>설문결과 - 총 응답자, 비율, 응답수 순으로 정보 제공</caption>
												<colgroup>
													<col>
													<col>
													<col>
												</colgroup>
												<thead>
												<tr>
													<c:set var="allCount" value="0"/>
													<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
														<c:if test="${result.qestnarQestnNo eq result2.qestnarQestnNo}">
															<c:set var="allCount" value="${allCount+1}"/>
														</c:if>
													</c:forEach>
													<th><span class="th01">총 응답자: <span class="point_color">${allCount}</span>명</span></th>
													<th><span class="th02">비율</span></th>
													<th><span class="th03">응답수</span></th>
												</tr>
												</thead>
												<tbody>
												<c:forEach var="result2" items="${result.answerList}" varStatus="status2">
													<tr>
														<td>
															<div class="div_per n01">
																<p class="blt">${result2.answer}</p>
																<div class="per_bar"> <span class="per_point" style="width:${answerMap[result2.qestnarAnswerNo].pt}%">${answerMap[result2.qestnarAnswerNo].pt}%</span></div>
															</div>
														</td>
														<td>${answerMap[result2.qestnarAnswerNo].pt}%</td>
														<td>${answerMap[result2.qestnarAnswerNo].answerCo}명</td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
										<c:if test="${not empty objctMap[result.qestnarQestnNo]}">
											<div class="opinion">
											<ul>
											<li>기타의견
											<ul class="bu">
												<c:forEach var="result3" items="${objctMap[result.qestnarQestnNo]}" varStatus="status3">
														<li>${result3.objctRspns}</li>
												</c:forEach>
											</ul>
											</li>
											</ul>
											</div>
										</c:if>
									</div>
								</div>	<!--//public_box-->
							</li>	<!--//check_item-->
						</c:if>
						<c:if test="${result.qestnTy eq 'QESTY01'}">
							<!--주관식-->
							<li class="check_item">
								<div class="qna_btn_wrap">
									<button type="button" class="check_title qna_btn clearfix" title="답변 열기">
												<span class="count">
													<span class="count_text">${status.count}</span>
												</span>	<!--//count-->
										<span class="title">${result.qestn}</span>
									</button>	<!--//check_title-->
								</div>
								<div class="public_box">
									<c:forEach var="result2" items="${sbjctMap[result.qestnarQestnNo]}" varStatus="status2">
										${result2.sbjctRspns}
									</c:forEach>
								</div>	<!--//public_box-->
							</li>	<!--//check_item-->
						</c:if>
					</c:forEach>
				</ul>	<!--//check_list-->
			</div>	<!--//check_list_box-->
			<script>
				/* 아코디언 열고 닫기 */
				$('.qna_btn').on('click', function(){
					var $this = $(this),
							$Title = $this.parent('.qna_btn_wrap'),
							$Item = $Title.parent('.check_item'),
							$Layer = $Title.siblings('.public_box'),
							IsActive = 	$this.is('.active');
					if(!IsActive){
						$this.addClass('active').attr('title', '답변 닫기');
						$Item.addClass('active');
						$Layer.slideDown();
					} else{
						$this.removeClass('active').attr('title', '답변 열기');
						$Item.removeClass('active');
						$Layer.slideUp();
					}
				});
			</script>
		</fieldset>
	</form>
</div>  <!--//program participate type2-->
</body>
</html>