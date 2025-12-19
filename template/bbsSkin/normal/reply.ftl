<#ftl encoding="utf-8"/>
<#function getEssntl essntlAt>
	<#local essntl = "">
	<#if essntlAt = '1' || essntlAt = '3'>
		<#local essntl = "<span class=\"p-form__required--icon\">필수</span>">
	<#else>
		<#local essntl = "">
	</#if>
	<#return essntl>
</#function>
<#function getFieldDc fieldDc>
	<#local dc = "">
	<#if fieldDc != "">
		<#local dc = "<div class=\"small margin_t_5\"><svg width=\"20\" height=\"25\" fill=\"#202e70\"><title>주의사항</title><use xlink:href=\"/common/images/program/p-icon.svg#exclamation-circle-solid\" y=\"-1\"></use><switch><foreignObject width=\"20\" height=\"20\">주의사항</foreignObject></switch></svg> ${fieldDc}</div>">
	</#if>
	<#return dc>
</#function>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="@@{menuInfo.siteId}" />
	<title>@@{menuInfo.cntntsNm} 답변</title>

	<link rel="stylesheet" type="text/css" href="/common/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/common/css/program.css" />
</head>
<body>

<div class="p-wrap bbs bbs__form">

	<#if (bbsDescription.registDc!"")?string != ''>
		<div class="card card--line bottom">
			<div class="card-content">
				${bbsDescription.registDc!""}
			</div>
		</div>
	</#if>

	<div>
		<svg width="20" height="25" fill="#202e70" focusable="false">
			<use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use>
		</svg>
		<span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
	</div>

	<#assign fieldList="">
	<#list bbsFieldInputShowList as bbsFieldInputShow>
	    <#if bbsFieldInputShow.fieldCode = 'FILE'>
	        <#assign fieldList=fieldList + "${bbsFieldInputShow.fieldUseNm}, 이미지 ${bbsFieldInputShow.fieldUseNm}의 대체텍스트">
	    <#else>
	        <#assign fieldList=fieldList + "${bbsFieldInputShow.fieldUseNm}">
		</#if>
		<#if bbsFieldInputShow_has_next>
			<#assign fieldList=fieldList + ", ">
		</#if>
	</#list>

	<form name="bbsNttForm" id="bbsNtt" method="post" action="./addBbsNttReply.do" onsubmit="<#if bbsInfo.editorUseAt = 'Y'>$('#nttCn').val(CKEDITOR.instances.contentsCn.getData());</#if>return fn_validatorBbsNtt(this)" enctype="multipart/form-data">
		<fieldset>
			<legend>게시물 글쓰기</legend>
			<input type="hidden" name="key" id="key" value="<c:out value="@@{key}"/>"/>
			<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="@@{bbsNo}"/>"/>
			<input type="hidden" name="nttNo" id="nttNo" value="<c:out value="@@{nttNo}"/>"/>
			<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
			<table class="p-table mobile block">
				<caption>${bbs.bbsNm} 글쓰기 - ${fieldList} 입력</caption>
				<colgroup>
					<col class="w20p">
					<col>
				</colgroup>
				<tbody class="p-table--th-left">
	<#list bbsFieldInputShowList as bbsFieldInputShow>
		<#if bbsFieldInputShow.aditFieldAt = 'N'>
			<#if bbsFieldInputShow.fieldCode = 'CTGRY'>
				<tr>
					<th scope="row"><label for="ctgryNm" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<select name="ctgryNm" id="ctgryNm" class="p-input p-input--auto">
							<option value="">${bbsFieldInputShow.fieldUseNm} 선택</option>
				<#list bbsCategoryList as bbsCategory>
							<option value="${bbsCategory.ctgryNm}" <c:if test="@@{'${bbsCategory.ctgryNm}' eq bbsNttVO.ctgryNm}">selected="selected"</c:if>>${bbsCategory.ctgryNm}</option>
				</#list>
						</select>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'DEPT'>
				<tr>
					<th scope="row"><label for="deptCode" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<select name="deptCode" id="deptCode" class="p-input p-input--auto" onchange="fn_changeDept(this, 'deptNm');">
							<option value="">부서 선택</option>
						<c:forEach var="deptment" items="@@{departmentList}">
							<option value="@@{deptment.deptCode}" <c:if test="@@{bbsNttVO.deptCode eq deptment.deptCode}">selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach><c:out value="@@{deptment.deptNm}"/></option>
						</c:forEach>
						</select>
						<input type="hidden" name="deptNm" id="deptNm" value="<c:out value="@@{bbsNttVO.deptNm}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'WRTER'>
				<tr>
					<th scope="row">${bbsFieldInputShow.fieldUseNm}</th>
					<td><c:out value="@@{bbsNttVO.writerNm}"/> ${getFieldDc(bbsFieldInputShow.fieldDc!"")}</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'FILE'>
				<tr>
					<th scope="row"><label for="atchmnfl_0" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
				<#list 1..bbsInfo.posblAtchmnflCo as i>
						<div class="p-upload">
							<div class="p-form-group">
								<div class="p-form-group__upload">
									<input type="file" name="atchmnfl" id="atchmnfl_${i_index}" class="p-upload__file--hidden" multiple>
									<span id="filename_${i_index}" class="p-input disabled"></span>
									<button type="button" class="p-upload__clear clear">선택한 ${i_index}번 첨부 제거</button>
								</div>
								<div class="p-input__addon">
									<label for="atchmnfl_${i_index}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_${i_index}" data-showfilename="#filename_${i_index}"><span class="skip">${i_index}번째 </span>파일선택</label>
								</div>
								<div class="p-form-checkbox padding_l_5">
									<input type="checkbox" name="bdtInsrtAt" id="bdtInsrtAt_${i_index}" value="${i_index}" class="p-form-checkbox__input">
									<label for="bdtInsrtAt_${i_index}" class="p-form-checkbox__label">본문삽입</label>
								</div>
							</div>
							<input type="text" name="replcText" id="replcText_${i_index}" class="p-input" title="${i_index}번 첨부 이미지 대체 텍스트 입력" value="" placeholder="첨부 이미지 대체 텍스트 입력">
						</div>
				</#list>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
				<tr>
					<th scope="row">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</th>
					<td>
						<span class="p-form-radio">
							<input type="radio" name="othbcAt" id="othbcAt_0" class="p-form-radio__input" value="Y" <c:if test="@@{'Y' eq bbsNttVO.othbcAt}">checked="checked"</c:if>>
							<label for="othbcAt_0" class="p-form-radio__label margin_r_10">공개</label>
						</span>
						<span class="p-form-radio">
							<input type="radio" name="othbcAt" id="othbcAt_1" class="p-form-radio__input" value="N" <c:if test="@@{'N' eq bbsNttVO.othbcAt}">checked="checked"</c:if>>
							<label for="othbcAt_1" class="p-form-radio__label margin_r_10">비공개</label>
						</span>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'ADRES'>
				<tr>
					<th scope="row">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</th>
					<td>
						<button type="button" class="p-button p-button--small gray margin_r_10" onclick="fn_postCodeSearch(false,'zip','adres','detailAdres','addressShow');">주소 검색</button>
						<span class="small">
							<svg width="20" height="25" fill="#202e70 ">
								<title>주의사항</title>
								<use xlink:href="/common/images/program/p-icon.svg#exclamation-circle-solid" y="-1"></use>
								<switch><foreignObject width="20" height="20">주의사항</foreignObject></switch>
							</svg>
							우편번호 검색창이 새창으로 열립니다.
						</span>
						<div class="p-form__address" id="addressShow" style="display:none"></div>
						<input type="hidden" name="zip" id="zip"/>
						<input type="hidden" name="adres" id="adres"/>
						<input type="hidden" name="detailAdres" id="detailAdres"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'CN'>
				<tr>
					<th scope="row"><label for="nttCn" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<textarea name="nttCn" id="nttCn" class="p-input" rows="80" cols="10" style="${bbsFieldInputShow.fieldStyle!""}"><c:out value="@@{bbsNttVO.nttCn}"/></textarea>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
						<#if bbsInfo.editorUseAt = 'Y'>
							<script src="/common/plugin/ckeditor/ckeditor.js"></script>
							<script nonce="NEOCMSSCRIPT">

								$(document).ready(function() {

									if ( CKEDITOR.env.ie && CKEDITOR.env.version < 9 )
										CKEDITOR.tools.enableHtml5Elements( document );

									// The trick to keep the editor in the sample quite small
									// unless user specified own height.

									CKEDITOR.config.height = $("#nttCn").css("height");
									CKEDITOR.config.width = 'auto';
									CKEDITOR.config.allowedContent = true;
									var initSample = ( function() {
										var wysiwygareaAvailable = isWysiwygareaAvailable(),
												isBBCodeBuiltIn = !!CKEDITOR.plugins.get( 'bbcode' );

										return function() {
											var editorElement = CKEDITOR.document.getById( 'nttCn' );

											// :(((
											if ( isBBCodeBuiltIn ) {
												editorElement.setHtml(''
												);
											}

											// Depending on the wysiwygarea plugin availability initialize classic or inline editor.
											if ( wysiwygareaAvailable ) {
												CKEDITOR.replace( 'nttCn' );

											} else {
												editorElement.setAttribute( 'contenteditable', 'true' );
												CKEDITOR.inline( 'nttCn' );

												// TODO we can consider displaying some info box that
												// without wysiwygarea the classic editor may not work.
											}

										};

										function isWysiwygareaAvailable() {
											// If in development mode, then the wysiwygarea must be available.
											// Split REV into two strings so builder does not replace it :D.
											if ( CKEDITOR.revision == ( '%RE' + 'V%' ) ) {
												return true;
											}
											return !!CKEDITOR.plugins.get( 'wysiwygarea' );
										}
									} )();
									initSample();
								});
							</script>
						</#if>
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'BGNDE'>
				<tr>
					<th scope="row"><label for="bgnde" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<div class="p-form-group p-date" data-date="datepicker">
							<input type="text" name="bgnde" id="bgnde" class="p-input" value="<c:out value="@@{bbsNttVO.bgndeYMDHMS}"/>" placeholder="yyyy-mm-dd">
							<div class="p-input__split">
								<button type="button" class="p-input__item p-date__icon">달력 열기</button>
							</div>
						</div>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'ENDDE'>
				<tr>
					<th scope="row"><label for="endde" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>	
						<div class="p-form-group p-date" data-date="datepicker">
							<input type="text" name="endde" id="endde" class="p-input" value="<c:out value="@@{bbsNttVO.enddeYMDHMS}"/>" placeholder="yyyy-mm-dd">
							<div class="p-input__split">
								<button type="button" class="p-input__item p-date__icon">달력 열기</button>
							</div>
						</div>

						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'SJ'>
				<tr>
					<th scope="row"><label for="nttSj" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="nttSj" id="nttSj" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.nttSj}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'CTTPC'>
				<tr>
					<th scope="row"><label for="telno" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="telno" id="telno" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.telno}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'MOBLPHON'>
				<tr>
					<th scope="row"><label for="moblphon" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="moblphon" id="moblphon" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.moblphon}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'EMAIL'>
				<tr>
					<th scope="row"><label for="email" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="email" id="email" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.email}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'HMPG'>
				<tr>
					<th scope="row"><label for="hmpg" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="hmpg" id="hmpg" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.hmpg}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			</#if>
		<#else>
				<tr>
					<th scope="row">
			<#if bbsFieldInputShow.fieldSe = 'FESE04' || bbsFieldInputShow.fieldSe = 'FESE06'>
						${bbsFieldInputShow.fieldUseNm}
			<#else>
						<label for="${bbsFieldInputShow.fieldCode?lower_case}" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label>
			</#if>
					 </th>
			<#if bbsFieldInputShow.fieldSe = 'FESE01' || bbsFieldInputShow.fieldSe = 'FESE02'>
					<td>
						<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE03'>
					<td>
						<textarea name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}"><c:out value="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}}"/></textarea>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE04'>
					<td>
				<#list bbsFieldInputShow.fieldDataList?split("^") as dataList>
						<span class="p-form-radio">
							<input type="radio" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-radio__input" <c:if test="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case} eq '${dataList}'}">checked="checked"</c:if> value="${dataList}">
							<label for="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-radio__label margin_r_10">${dataList}</label>
						</span>
				</#list>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE05'>
					<td>
						<select name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input p-input--auto">
							<option value="">${bbsFieldInputShow.fieldUseNm} 선택</option>
				<#list bbsFieldInputShow.fieldDataList?split("^") as dataList>
							<option value="${dataList}" <c:if test="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case} eq '${dataList}'}">selected="selected"</c:if>>${dataList}</option>
				</#list>
						</select>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE06'>
					<td>
					<#list bbsFieldInputShow.fieldDataList?split("^") as dataList>
						<span class="p-form-checkbox">
							<input type="checkbox" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-checkbox__input" value="${dataList}" <c:if test="@@{fn:contains(bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}, '${dataList}')  }">checked="checked"</c:if>><label for="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-checkbox__label">${dataList}</label>
						</span>
					</#list>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE07'>
					<td>
						<button type="button" class="p-button p-button--small gray margin_r_10" onclick="fn_postCodeSearch(true,null,null,null,'addressShow_${bbsFieldInputShow.fieldCode}');">주소 검색</button>
						<span class="small">
							<svg width="20" height="25" fill="#202e70 ">
								<title>주의사항</title>
								<use xlink:href="/common/images/program/p-icon.svg#exclamation-circle-solid" y="-1"></use>
								<switch><foreignObject width="20" height="20">주의사항</foreignObject></switch>
							</svg>
							우편번호 검색창이 새창으로 열립니다.
						</span>
						<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="addressShow_${bbsFieldInputShow.fieldCode}" class="p-input p-form__address" title="주소 입력"  value="<c:out value="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}}"/>">
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE08'>
					<td>
						<div class="p-form-group p-date" data-date="datepicker">
							<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input"  value="<c:out value="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}}"/>" placeholder="yyyy-mm-dd">
							<div class="p-input__split">
								<button type="button" class="p-input__item p-date__icon">달력 열기</button>
							</div>
						</div>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE09'>
					<td>
						<select name="${bbsFieldInputShow.fieldCode?lower_case}_sel" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input p-input--auto" onchange="fn_changeDept(this, '${bbsFieldInputShow.fieldCode?lower_case}_val');">
							<option value="">부서 선택</option>
						<c:forEach var="deptment" items="@@{departmentList}">
							<option value="@@{deptment.deptNm}" <c:if test="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case} eq deptment.deptNm}">selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach><c:out value="@@{deptment.deptNm}"/></option>
						</c:forEach>
						</select>
						<input type="hidden" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_val" value="<c:out value="@@{bbsNttVO.${bbsFieldInputShow.fieldCode?lower_case}}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#else>
					<td></td>
			</#if>
				</tr>
		</#if>
	</#list>
				</tbody>
			</table>
			
			<div class="text_right margin_t_30">
				<a href="./selectBbsNttList.do?key=<c:out value="@@{key}"/>&amp;bbsNo=<c:out value="@@{bbsNo}"/>&amp;searchCtgry=<c:out value="@@{bbsNttVO.searchCtgry}"/>&amp;integrDeptCode=<c:out value="@@{bbsNttVO.integrDeptCode}"/>" class="p-button cancel">취소</a>
				<input type="submit" class="p-button write" value="글등록">
			</div>
			
		</fieldset>
	</form>

</div>

<script src="/common/js/default.js"></script>
<c:if test="@@{!empty message}">
<script nonce="NEOCMSSCRIPT">
	function fn_check_message() {
		alert("<c:out value='@@{message}'/>");
	<c:if test="@@{!empty fieldNm}">
				@@("#<c:out value="@@{fieldNm}"/>").focus();
	</c:if>
	}
	@@(window).on("load", function() {
		fn_check_message();
	});
</script>
</c:if>
<script nonce="NEOCMSSCRIPT">

var jusoSelector = {};

function popUpCommonSimple( path , winName , widthSize , heightSize ){
	var winHandle;
	var topPoint = (window.screen.height-heightSize)/2;
	var leftPoint = (window.screen.width-widthSize)/2;
	if(winHandle)winHandle.close();
	 winHandle = window.open( path , winName, "width="+ widthSize +", height=" + heightSize + ", status=0, location=0, menubar=0, toolbar=0, scrollbars=auto, help=0, hide=0, center=yes, left=" + leftPoint + ", top=" + topPoint );
	if(winHandle==null){
	   alert("사용자 설정에 의해 팝업이 차단되었습니다. \n\n자세한 내용을 보시려면 [도구]-[인터넷옵션]-[개인정보] 화면에서 팝업차단 체크를 해제하여 주십시오."); 
	}else{
	 winHandle.focus();
	}
	return winHandle;
}

function fn_postCodeSearch(inline,zipcodeId,addressId,detailAddressId,addressShowId)
{
	jusoSelector.inline = inline;
	jusoSelector.zipcodeId = zipcodeId;
	jusoSelector.addressId = addressId;
	jusoSelector.detailAddressId = detailAddressId;
	jusoSelector.addressShowId = addressShowId;
	var path = "/common/jusoPopup.jsp";
	popUpCommonSimple( path , 'postcode', 460,450 );
}

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	if( jusoSelector.inline ) {
		document.getElementById(jusoSelector.addressShowId).value = "(" + zipNo + ") " + roadAddrPart1 + roadAddrPart2 + " " + addrDetail;
	} else {
		document.getElementById(jusoSelector.zipcodeId).value = zipNo;
		document.getElementById(jusoSelector.addressId).value = roadAddrPart1 + roadAddrPart2;
		document.getElementById(jusoSelector.detailAddressId).value = addrDetail;
		document.getElementById(jusoSelector.addressShowId).innerHTML = "(" + zipNo + ") " + roadAddrPart1 + roadAddrPart2 + " " + addrDetail;
		document.getElementById(jusoSelector.addressShowId).style.display = "block";
	}
}

function fn_changeDept(select, id) {
	var option = select.options[select.selectedIndex],
		value = option.value;
		text = option.text.trim();
	if( !value ) {
		document.getElementById(id).value = "";
	} else {
		document.getElementById(id).value = text;
	}
}

function fn_validatorBbsNtt( frm ) {

<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#if bbsFieldInputShow.aditFieldAt = 'N'>
		<#if bbsFieldInputShow.fieldCode = 'CTGRY'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'ctgryNm') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'ctgryNm');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'DEPT'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'deptCode') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'deptCode');
		return false;
	}		
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( !fn_isRadioChecked( frm, 'othbcAt') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'ADRES'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'zip') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		return false;
	}
	if( fn_isEmpty( frm, 'adres') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'CN'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'nttCn') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'nttCn');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'BGNDE'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'bgnde') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'bgnde');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'ENDDE'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'endde') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'endde');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'SJ'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'nttSj') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'nttSj');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'CTTPC'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'telno') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'telno');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'MOBLPHON'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'moblphon') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'moblphon');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'EMAIL'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'email') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'email');
		return false;
	}
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'HMPG'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'hmpg') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'hmpg');
		return false;
	}
			</#if>
		</#if>
	<#else>
		<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
			<#if bbsFieldInputShow.fieldSe = 'FESE01'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
	if( !isNumeric(frm['${bbsFieldInputShow.fieldCode?lower_case}'].value) ) {
		alert("${bbsFieldInputShow.fieldUseNm}는(은) 숫자로 입력해주세요.");
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE02'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE03'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE04'>
	if( !fn_isRadioChecked( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE05'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE06'>
	if( !fn_isRadioChecked( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE08'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			<#elseif bbsFieldInputShow.fieldSe = 'FESE09'>
	if( fn_isEmpty( frm, '${bbsFieldInputShow.fieldCode?lower_case}') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, '${bbsFieldInputShow.fieldCode?lower_case}');
		return false;
	}
			</#if>
		</#if>
	</#if>
</#list>

	return true;

}

</script>

</body>
</html>