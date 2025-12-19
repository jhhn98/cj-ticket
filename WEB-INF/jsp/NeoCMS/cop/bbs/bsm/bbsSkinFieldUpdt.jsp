<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_2" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>게시판스킨 필드 수정</title>
	<meta name="decorator" content="neo" />
	<script nonce="NEOCMSSCRIPT">
		<c:if test="${!empty message}">
		function fn_check_message() {
			alert("<c:out value='${message}'/>");
			<c:if test="${!empty fieldName}">
			$("#<c:out value="${fieldName}"/>").focus();
			</c:if>
		}
		$(window).on("load", function() {
			fn_check_message();
		});
		</c:if>
		function fn_validateBbsFieldVO( frm ) {
			return true;
		}
	</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판스킨</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">스킨관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 필드관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsSkinInfoView.do?skinId=${bbsSkin.skinId}" class=""><span>설정관리</span></a>
	<a href="./updateBbsSkinFieldView.do?skinId=${bbsSkin.skinId}" class="current"><span>필드관리</span></a>
	<a href="./updateBbsSkinFieldListSortView.do?skinId=${bbsSkin.skinId}" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsSkinFieldInputSortView.do?skinId=${bbsSkin.skinId}" class=" "><span>입력/보기 순서 변경</span></a>
</div>
<div class="dataWrap is_tab">
	<form:form name="bbsFieldVOForm" action="updateBbsSkinField.do" onsubmit="return validateBbsFieldVO(this)">

	<input type="hidden" name="skinId" id="skinId" value="<c:out value="${bbsSkin.skinId}"/>"/>
    <p class="info_text">관리자 보기 기능 설정시 일반 보기 기능은 기본으로 설정됩니다.</p>
	<div class="form_wrap fieldForm">
		<div class="table_fixed_wrap default">
			<div id="tableScroll" class="form_table">
				<div class="scroll_view">
					<table class="settingFormTable bbsFieldSet">
						<colgroup>
                            <col style="width:100px;"/>
                            <col style="width:90px;"/>
                            <col style="width:100px;"/>
                            <col style="width:500px;"/>
                            <col style="width:auto;"/>
                            <col style="width:250px;"/>
                            <col style="width:250px;"/>
						</colgroup>
						<thead>
						<tr>
							<th scope="col">항목(필드명)</th>
							<th scope="col">항목명 변경</th>
							<th scope="col">사용 설정</th>
							<th scope="col">항목 표시 설정</th>
							<th scope="col">목록 항목 넓이</th>
							<th scope="col">입력요소 스타일</th>
							<th scope="col">입력요소 설명</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${bbsSkinFieldList}" varStatus="status">
							<tr>
								<c:if test="${result.aditFieldAt eq 'N'}">
									<input type="hidden" name="fieldSe" id="fieldSe_<c:out value="${result.skinFieldNo}"/>" value="dummy"/>
									<input type="hidden" name="fieldDataList" id="fieldDataList_<c:out value="${result.skinFieldNo}"/>" value="dummy"/>
								</c:if>
								<input type="hidden" name="fieldNo" id="fieldNo_<c:out value="${result.skinFieldNo}"/>" value="<c:out value="${result.skinFieldNo}"/>"/>
								<input type="hidden" name="fieldNm" id="fieldNm_<c:out value="${result.skinFieldNo}"/>" value="<c:out value="${result.fieldNm}"/>"/>
								<input type="hidden" name="aditFieldAt" id="aditFieldAt_<c:out value="${result.skinFieldNo}"/>" value="<c:out value="${result.aditFieldAt}"/>"/>

								<td class="textARight fieldTitle" <c:if test="${result.aditFieldAt eq 'Y'}">rowspan="2"</c:if>>
									<c:out value="${result.fieldNm}"/>
									<p class="em_gray eng_text">[<c:out value="${result.fieldCode}"/>]</p>
									<c:set var="searchUseAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.searchUseAt eq '1'}"><c:set var="searchUseAtAtt" value="checked=\"checked\""/></c:when>
										<c:when test="${result.searchUseAt eq '2'}"><c:set var="searchUseAtAtt" value="disabled=\"disabled\""/></c:when>
										<c:when test="${result.searchUseAt eq '3'}"><c:set var="searchUseAtAtt" value="checked=\"checked\" disabled=\"disabled\""/></c:when>
									</c:choose>
									<c:set var="encryptFieldAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.encryptFieldAt eq '1'}"><c:set var="encryptFieldAtAtt" value="checked=\"checked\""/></c:when>
										<c:when test="${result.encryptFieldAt eq '2'}"><c:set var="encryptFieldAtAtt" value="disabled=\"disabled\""/></c:when>
										<c:when test="${result.encryptFieldAt eq '3'}"><c:set var="encryptFieldAtAtt" value="checked=\"checked\" disabled=\"disabled\""/></c:when>
									</c:choose>
									<label for="searchUseAt_<c:out value="${result.skinFieldNo}"/>">검색 포함</label>
									<input type="checkbox" name="searchUseAt" id="searchUseAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${searchUseAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>" title="검색"/>

									<label for="encryptFieldAt_<c:out value="${result.skinFieldNo}"/>">암호화사용</label>
									<input type="checkbox" name="encryptFieldAt" id="encryptFieldAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${encryptFieldAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>" title="암호화사용"/><br />
								</td>
								<td>
									<input type="text" name="fieldUseNm" id="fieldUseNm_<c:out value="${skinFieldNo}"/>" size="10" value="<c:out value="${result.fieldUseNm}"/>" class="block"/>
								</td>
								<td>
									<c:set var="fieldUseAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.fieldUseAt eq '1'}"><c:set var="fieldUseAtAtt" value="checked=\"checked\""/></c:when>
										<c:when test="${result.fieldUseAt eq '2'}"><c:set var="fieldUseAtAtt" value="disabled=\"disabled\""/></c:when>
										<c:when test="${result.fieldUseAt eq '3'}"><c:set var="fieldUseAtAtt" value="checked=\"checked\" disabled=\"disabled\""/></c:when>
									</c:choose>
									<c:set var="essntlAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.essntlAt eq '1'}"><c:set var="essntlAtAtt" value="checked=\"checked\""/></c:when>
										<c:when test="${result.essntlAt eq '2'}"><c:set var="essntlAtAtt" value="disabled=\"disabled\""/></c:when>
										<c:when test="${result.essntlAt eq '3'}"><c:set var="essntlAtAtt" value="checked=\"checked\" disabled=\"disabled\""/></c:when>
									</c:choose>
									<input type="checkbox" name="fieldUseAt" id="fieldUseAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${fieldUseAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="fieldUseAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5 marginRight_15">사용</label>
									<input type="checkbox" name="essntlAt" id="essntlAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${essntlAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="essntlAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5">필수</label>
								</td>
								<td>
									<c:set var="viewShowAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.viewMngOnlyShowAt eq '1'}">
											<c:set var="viewShowAtAtt" value="A"/>
										</c:when>
										<c:when test="${result.viewMngOnlyShowAt eq '0' and result.viewShowAt eq '1'}">
											<c:set var="viewShowAtAtt" value="Y"/>
										</c:when>
										<c:when test="${result.viewShowAt eq '0'}">
											<c:set var="viewShowAtAtt" value="N"/>
										</c:when>
									</c:choose>


									<c:set var="listShowAtAtt" value=""/>
									<c:choose>
										<c:when test="${result.listMngOnlyShowAt eq '1'}">
											<c:set var="listShowAtAtt" value="A"/>
										</c:when>
										<c:when test="${result.listMngOnlyShowAt eq '0' and result.listShowAt eq '1'}">
											<c:set var="listShowAtAtt" value="Y"/>
										</c:when>
										<c:when test="${result.listShowAt eq '0'}">
											<c:set var="listShowAtAtt" value="N"/>
										</c:when>
									</c:choose>
									<div class="setting_block element_count_two">
										<div class="element_inlineBlock rank_inline">
											<label for="viewShowAt">보기(등록,수정)</label>
											<select id="viewShowAt" name="viewShowAt" class="marginLeft_5">
												<option value="N" <c:out value="${viewShowAtAtt eq 'N' ? 'selected=\"selected\"' : ''}"/>>숨김</option>
												<option value="Y" <c:out value="${viewShowAtAtt eq 'Y' ? 'selected=\"selected\"' : ''}"/>>일반보기</option>
												<option value="A" <c:out value="${viewShowAtAtt eq 'A' ? 'selected=\"selected\"' : ''}"/>>관리자만</option>
											</select>
												<%--
                                                <input type="checkbox" name="viewShowAt" id="viewShowAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${viewShowAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="viewShowAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5 marginRight_10">일반</label>
                                                <input type="checkbox" name="viewMngOnlyShowAt" id="viewMngOnlyShowAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${viewMngOnlyShowAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="viewMngOnlyShowAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5">관리자</label>
                                                --%>
										</div>
										<div class="element_inlineBlock">
											<label for="listShowAt">목록</label>
											<select id="listShowAt" name="listShowAt" class="marginLeft_5">
												<option value="N" <c:out value="${listShowAtAtt eq 'N' ? 'selected=\"selected\"' : ''}"/>>숨김</option>
												<option value="Y" <c:out value="${listShowAtAtt eq 'Y' ? 'selected=\"selected\"' : ''}"/>>일반보기</option>
												<option value="A" <c:out value="${listShowAtAtt eq 'A' ? 'selected=\"selected\"' : ''}"/>>관리자만</option>
											</select>
												<%--
                                                <input type="checkbox" name="listShowAt" id="listShowAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${listShowAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="listShowAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5 marginRight_10">일반</label>
                                                <input type="checkbox" name="listMngOnlyShowAt" id="listMngOnlyShowAt_<c:out value="${result.skinFieldNo}"/>" <c:out value="${listMngOnlyShowAtAtt}"/> value="<c:out value="${result.skinFieldNo}"/>"/><label for="listMngOnlyShowAt_<c:out value="${result.skinFieldNo}"/>" class="marginLeft_5">관리자</label>
                                                --%>
										</div>
									</div>
								</td>
								<td>
									<input type="text" name="listWidthSize" id="listWidthSize_<c:out value="${result.skinFieldNo}"/>" size="1" value="<c:out value="${result.listWidthSize}"/>" class="block"/>
									<p class="info_text">단위 포함하여 작성<span class="eng_text">(%,px)</span></p>
								</td>
								<td>
									<input type="text" name="fieldStyle" id="fieldStyle_<c:out value="${result.skinFieldNo}"/>" size="10" value="<c:out value="${result.fieldStyle}"/>" title="스타일 설정" placeholder="입력요소 스타일을 입력" class="block"/>
								</td>
								<td>
									<input type="text" name="fieldDc" id="fieldDc_<c:out value="${result.skinFieldNo}"/>" size="10" value="<c:out value="${result.fieldDc}"/>" title="설명" placeholder="입력요소에 대한 설명을 입력" class="block"/>
								</td>
							</tr>
							<c:if test="${result.aditFieldAt eq 'Y'}">
								<tr>
									<td colspan="6">
										<div class="setting_block element_count_two">
											<div class="element_inlineBlock">
												<select name="fieldSe" id="fieldSe_<c:out value="${result.skinFieldNo}"/>" class="block">
													<option value="">필드 구분 선택</option>
													<c:forEach var="fieldSe" items="${fieldSeList}">
														<option value="<c:out value="${fieldSe.code}"/>" <c:if test="${fieldSe.code eq result.fieldSe}">selected="selected"</c:if>><c:out value="${fieldSe.codeNm}"/></option>
													</c:forEach>
												</select>
											</div>
											<div class="element_inlineBlock">
												<input type="text" name="fieldDataList" id="fieldDataList_<c:out value="${result.skinFieldNo}"/>" size="20" value="<c:out value="${result.fieldDataList}"/>" title="데이터 목록" placeholder="checkbox, radio, select일 경우 목록을 '^'로 구분하여 입력" class="block"/>
											</div>
										</div>
										<!--<p class="info_text">RADIO, SELECT 일 경우 목록을 ","로 구분하여 입력</p>-->
									</td>
								</tr>
							</c:if>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="arrangementWrap marginTop_20">
		<div class="arrLeft">
				<%--<a href="./selectBbsSkinList.do" class="iconTextButton list"><span>목록</span></a>--%>
		</div>
		<div class="arrRight">
			<button type="submit" class="iconTextButton write"><span>수정</span></button>
		</div>
	</div>
		</form:form>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>

</body>
</html>