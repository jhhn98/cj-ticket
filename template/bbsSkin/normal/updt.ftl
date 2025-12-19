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
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="@@{menuInfo.siteId}" />
	<title><c:out value="@@{menuInfo.cntntsNm}"/> 수정</title>

	<link rel="stylesheet" type="text/css" href="/common/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/common/css/program.css" />
	<link rel="stylesheet" type="text/css" href="/common/css/jquery.simple-dtpicker.css" />
	<script src="/common/js/jquery.simple-dtpicker.js"></script>
</head>
<body>

<div class="p-wrap bbs bbs__form">

	<#if (bbsDescription.updtDc!"")?string != ''>
		<div class="card card--line bottom">
			<div class="card-content">
				${bbsDescription.updtDc!""}
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
	<#assign fieldCodeList="">
	<#list bbsFieldInputShowList as bbsFieldInputShow>
		<#assign fieldCodeList=fieldCodeList + "|${bbsFieldInputShow.fieldCode}|">
		<#if bbsFieldInputShow.fieldCode = 'FILE'>
			<#assign fieldList=fieldList + "${bbsFieldInputShow.fieldUseNm}, 이미지 ${bbsFieldInputShow.fieldUseNm}의 대체텍스트">
		<#else>
			<#assign fieldList=fieldList + "${bbsFieldInputShow.fieldUseNm}">
		</#if>
		<#if bbsFieldInputShow_has_next>
			<#assign fieldList=fieldList + ", ">
		</#if>
	</#list>
	<form name="bbsNttForm" id="bbsNtt" method="post" action="./updateBbsNtt.do" onsubmit="<#if bbsInfo.editorUseAt = 'Y'>$('#nttCn').val(CKEDITOR.instances.contentsCn.getData());</#if>return fn_validatorBbsNtt(this)" enctype="multipart/form-data">
		<double-submit:preventer/>
		<fieldset>
			<legend>게시물 수정</legend>
			<input type="hidden" name="key" id="key" value="<c:out value="@@{key}"/>"/>
			<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="@@{bbsNtt.bbsNo}"/>"/>
			<input type="hidden" name="nttNo" id="nttNo" value="<c:out value="@@{bbsNtt.nttNo}"/>"/>
			<input type="hidden" name="searchCtgry" id="searchCtgry" value="<c:out value="@@{bbsNttVO.searchCtgry}"/>"/>
			<input type="hidden" name="searchCnd" id="searchCnd" value="<c:out value="@@{bbsNttVO.searchCnd}"/>"/>
			<input type="hidden" name="searchKrwd" id="searchKrwd" value="<c:out value="@@{bbsNttVO.searchKrwd}"/>"/>
			<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="@@{bbsNttVO.pageIndex}"/>"/>
			<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
			<input type="hidden" name="myView" id="myView" value="<c:out value="@@{param.myView}"/>"/>
			<table class="p-table mobile block">
				<caption>${bbs.bbsNm} 수정 - ${fieldList} 입력</caption>
				<colgroup>
					<col class="w20p">
					<col>
				</colgroup>
				<tbody class="p-table--th-left">
				<#if bbsInfo.noticeUseAt = 'Y'>
					<c:if test="@@{bbsNttVO.bbsManageMode eq true}">
						<tr>
							<th scope="row">공지사항</th>
							<td>

								<script nonce="NEOCMSSCRIPT">
									$(document).ready(function() {
										$('#noticeAt_0').change(function() {
											if($(this).prop("checked")) {
												$(".notice_time_chk").prop("disabled",false);
												$('#noticeBgnde').appendDtpicker({'locale':'ko','dateFormat':'YYYY-MM-DD hh:mm:00'});
												$('#noticeEndde').appendDtpicker({'locale':'ko','dateFormat':'YYYY-MM-DD hh:mm:00'});
											}else{
												$(".notice_time_chk").prop("disabled",true);
												$('#noticeBgnde').handleDtpicker('destroy');
												$('#noticeEndde').handleDtpicker('destroy');
											}
										});
										if( $('#noticeAt_0').prop("checked") ) {
											$(".notice_time_chk").prop("disabled",false);
											$('#noticeBgnde').appendDtpicker({'locale':'ko','dateFormat':'YYYY-MM-DD hh:mm:00'});
											$('#noticeEndde').appendDtpicker({'locale':'ko','dateFormat':'YYYY-MM-DD hh:mm:00'});
										}else{
											$(".notice_time_chk").prop("disabled",true);
											$('#noticeBgnde').handleDtpicker('destroy');
											$('#noticeEndde').handleDtpicker('destroy');
										}
									});
								</script>
								<span class="p-form-radio">
									<input type="checkbox" name="noticeAt" id="noticeAt_0" class="p-form-checkbox__input" value="Y" <c:if test="@@{'Y' eq bbsNtt.noticeAt}">checked="checked"</c:if>>
									<label for="noticeAt_0" class="p-form-checkbox__label margin_r_10">공지사항</label>
								</span>
								<div class="p-form-inline">
									<label for="noticeBgnde">공지시작일</label>
									<input type="text" name="noticeBgnde" id="noticeBgnde" class="p-input notice_time_chk" readonly="readonly" <c:if test="@@{'N' eq bbsNtt.noticeAt}">disabled="disabled"</c:if> value="<c:out value="@@{bbsNtt.noticeBgndeYMDHMS}"/>" placeholder="yyyy-mm-dd">
								</div>
								<div class="p-form-inline">
									<label for="noticeEndde">공지종료일</label>
									<input type="text" name="noticeEndde" id="noticeEndde" class="p-input notice_time_chk" readonly="readonly" <c:if test="@@{'N' eq bbsNtt.noticeAt}">disabled="disabled"</c:if> value="<c:out value="@@{bbsNtt.noticeEnddeYMDHMS}"/>" placeholder="yyyy-mm-dd">
								</div>
							</td>
						</tr>
					</c:if>
					<c:if test="@@{bbsNttVO.bbsManageMode eq false}">
						<input type="hidden" name="noticeAt" id="noticeAt" value="N" />
					</c:if>
				</#if>
	<#list bbsFieldInputShowList as bbsFieldInputShow>
		<#if bbsFieldInputShow.aditFieldAt = 'N'>
			<#if bbsFieldInputShow.fieldCode = 'CTGRY'>
				<tr>
					<th scope="row"><label for="ctgryNm" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<link rel="stylesheet" href="/common/css/chosen.css" />
						<select name="ctgryNm" id="ctgryNm" class="p-input p-input--auto chosen-select" multiple data-placeholder="${bbsFieldInputShow.fieldUseNm} 선택" data-no_results_text="${bbsFieldInputShow.fieldUseNm}가 존재하지 않습니다." >
							<#list bbsCategoryList as bbsCategory>
								<option value="|${bbsCategory.ctgryNm}|" <c:if test="@@{fn:contains(bbsNtt.ctgryNm,'|${bbsCategory.ctgryNm}|')}">selected="selected"</c:if>>${bbsCategory.ctgryNm}</option>
							</#list>
						</select>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
						<script src="/common/js/chosen/chosen.jquery.min.js"></script>
						<script src="/common/js/chosen/prism.js"></script>
						<script src="/common/js/chosen/init.js"></script>
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'DEPT'>
				<tr>
					<th scope="row"><label for="deptCode" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<select name="deptCode" id="deptCode" class="p-input p-input--auto" onchange="fn_changeDept(this, 'deptNm');">
							<option value="">부서 선택</option>
						<c:forEach var="deptment" items="@@{departmentList}">
							<option value="<c:out value="@@{deptment.deptCode}"/>" <c:if test="@@{bbsNtt.deptCode eq deptment.deptCode}">selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach><c:out value="@@{deptment.deptNm}"/></option>
						</c:forEach>
						</select>
						<input type="hidden" name="deptNm" id="deptNm" value="<c:out value="@@{bbsNtt.deptNm}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'FILE'>
				<tr>
					<th scope="row"><label for="atchmnfl_0" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
				<c:set var="fileCnt" value="0" />
				<c:if test="@@{empty bbsAtchFieldList}">
					<c:forEach var="bbsAtchmnfl" items="@@{bbsAtchmnflList}" varStatus="idx">
						<ul class="p-attach margin_b_15">
							<li class="p-attach__item">
								<span class="p-form-radio">
									<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_U" class="p-form-radio__input" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"  checked="checked" value="U">
									<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_U" class="p-form-radio__label margin_r_10">유지</label>
								</span>
								<span class="p-form-radio">
									<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_M" class="p-form-radio__input file-chg-radio" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" value="M">
									<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_M" class="p-form-radio__label margin_r_10">변경</label>
								</span>
								<span class="p-form-radio">
									<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_D" class="p-form-radio__input" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"  value="D">
									<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_D" class="p-form-radio__label margin_r_10">삭제</label>
								</span>
								<span class="p-form-checkbox">
								</span>
								<a href="./downloadBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"><span class="p-icon p-icon__<c:out value="@@{bbsAtchmnfl.fileExtsn}"/>"><c:out value="@@{bbsAtchmnfl.fileExtsn}"/> 문서</span><span><c:out value="@@{bbsAtchmnfl.fileNm}"/></span></a>
								<div class="p-upload" style="display:none;" id="upload_pan_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>">
									<div class="p-form-group">
										<div class="p-form-group__upload">
											<input type="file" name="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-upload__file--hidden" multiple>
											<span id="filename_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-input disabled">(${bbsInfo.posblAtchmnflExtsn} 파일)</span>
											<button type="button" class="p-upload__clear clear">선택한 첨부 제거</button>
										</div>
										<div class="p-input__addon">
											<label for="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" data-showfilename="#filename_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"><span class="skip"><c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>번째 </span>파일선택</label>
										</div>
										<div class="p-form-checkbox padding_l_5">
											<input type="checkbox" name="bdtInsrtAtTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="bdtInsrtAtTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-checkbox__input" value="Y" <c:if test="@@{'Y' eq bbsAtchmnfl.bdtInsrtAt}">checked="checked"</c:if>>
											<label for="bdtInsrtAtTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-checkbox__label margin_r_20">본문삽입</label>
										</div>
									</div>
									<input type="text" name="replcText<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="replcText_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-input" title="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>번 첨부 이미지 대체 텍스트 입력" value="@@{bbsAtchmnfl.replcText}" placeholder="첨부 이미지 대체 텍스트 입력">
								</div>
							</li>
						</ul>
						<c:set var="fileCnt" value="@@{fileCnt + 1}" />
					</c:forEach>
					<c:forEach var="i" begin="@@{fileCnt+1}" end="@@{bbsInfo.posblAtchmnflCo}" step="1" varStatus="idx">
						<div class="p-upload">
							<div class="p-form-group">
								<div class="p-form-group__upload">
									<input type="file" name="atchmnfl" id="atchmnfl_@@{idx.index-fileCnt-1}" class="p-upload__file--hidden" >
									<span id="filename_@@{idx.index-fileCnt-1}" class="p-input disabled">@@{atch.attachNm} - (@@{atch.attachExt}파일)</span>
									<button type="button" class="p-upload__clear clear">선택한 @@{idx.index-fileCnt-1}번 첨부 제거</button>
								</div>
								<div class="p-input__addon">
									<label for="atchmnfl_@@{idx.index-fileCnt-1}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_@@{idx.index-fileCnt-1}" data-showfilename="#filename_@@{idx.index-fileCnt-1}"><span class="skip">@@{idx.index-fileCnt-1}번째 </span>파일선택</label>
								</div>
								<input type="checkbox" name="bdtInsrtAt" id="bdtInsrtAt_@@{idx.index-fileCnt-1}" value="@@{idx.index-fileCnt-1}" class="p-form-checkbox__input">
								<label for="bdtInsrtAt_@@{idx.index-fileCnt-1}" class="p-form-checkbox__label">본문삽입</label>
							</div>
							<input type="hidden" name="replcText" id="replcText_@@{idx.index-fileCnt-1}" value="">
						</div>
					</c:forEach>
				</c:if>
				<c:if test="@@{not empty bbsAtchFieldList}">
					<c:forEach var="atch" items="@@{bbsAtchFieldList}" varStatus="at_idx">
						<c:set var="hasAtchfile" value="0"/>
						<c:if test="@@{fn:length(bbsAtchmnflList) > 0}">
							<c:forEach var="bbsAtchmnfl" items="@@{bbsAtchmnflList}" varStatus="idx">
								<c:choose>
									<c:when test="@@{bbsAtchmnfl.attachNo ne atch.attachNo}">
									</c:when>
									<c:otherwise>
										<c:set var="hasAtchfile" value="1"/>
										<ul class="p-attach margin_b_15">
											<li class="p-attach__item">
												<span class="p-form-radio">
													<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_U" class="p-form-radio__input" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"  checked="checked" value="U">
													<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_U" class="p-form-radio__label margin_r_10">유지</label>
												</span>
												<span class="p-form-radio">
													<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_M" class="p-form-radio__input file-chg-radio" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" value="M">
													<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_M" class="p-form-radio__label margin_r_10">변경</label>
												</span>
												<span class="p-form-radio">
													<input type="radio" name="fileProcTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_D" class="p-form-radio__input" data-key="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"  value="D">
													<label for="fileProcTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>_D" class="p-form-radio__label margin_r_10">삭제</label>
												</span>
												<span class="p-form-checkbox">
												</span>
												<a href="./downloadBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"><span class="p-icon p-icon__<c:out value="@@{bbsAtchmnfl.fileExtsn}"/>"><c:out value="@@{bbsAtchmnfl.fileExtsn}"/> 문서</span><span><c:out value="@@{bbsAtchmnfl.fileNm}"/></span></a>
												<div class="p-upload" style="display:none;" id="upload_pan_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>">
													<div class="p-form-group">
														<div class="p-form-group__upload">
															<input type="file" name="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-upload__file--hidden" multiple>
															<span id="filename_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-input disabled"><c:out value="@@{atch.attachNm}"/> - (<c:out value="@@{atch.attachExt}"/>파일)</span>
															<button type="button" class="p-upload__clear clear">선택한 첨부 제거</button>
														</div>
														<div class="p-input__addon">
															<label for="atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" data-showfilename="#filename_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"><span class="skip"><c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>번째 </span>파일선택</label>
														</div>
														<div class="p-form-checkbox padding_l_5">
															<c:choose>
																<c:when test="@@{atch.bdtInsertAt eq 'Y'}">
																	<input type="checkbox" name="bdtInsrtAtTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="bdtInsrtAtTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-checkbox__input" value="Y" <c:if test="@@{'Y' eq bbsAtchmnfl.bdtInsrtAt}">checked="checked"</c:if>>
																	<label for="bdtInsrtAtTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-checkbox__label margin_r_20">본문삽입</label>
																</c:when>
																<c:otherwise>
																	<input type="hidden" name="bdtInsrtAtTy<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="bdtInsrtAtTy_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" value="">
																</c:otherwise>
															</c:choose>
														</div>
													</div>

													<c:choose>
														<c:when test="@@{atch.replcUseAt eq 'Y'}">
															<input type="text" name="replcText<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="replcText_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-input" title="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>번 첨부 이미지 대체 텍스트 입력" value="@@{bbsAtchmnfl.replcText}" placeholder="첨부 이미지 대체 텍스트 입력">
														</c:when>
														<c:otherwise>
															<input type="hidden" name="replcText<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" id="replcText_<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" value="">
														</c:otherwise>
													</c:choose>

												</div>
											</li>
										</ul>
										<c:set var="fileCnt" value="@@{fileCnt + 1}" />
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						<c:if test="@@{hasAtchfile eq '0'}">
							<input type="hidden" name="attachNo_@@{atch.attachNo}" id="attachNo_@@{atch.attachNo}" value="@@{atch.attachNo}">
							<div class="p-upload">
								<div class="p-form-group">
									<div class="p-form-group__upload">
										<input type="file" name="atchmnfl_@@{atch.attachNo}" id="atchmnfl_@@{atch.attachNo}" class="p-upload__file--hidden" >
										<span id="filename_@@{atch.attachNo}" class="p-input disabled">@@{atch.attachNm} - (@@{atch.attachExt}파일)</span>
										<button type="button" class="p-upload__clear clear">선택한 @@{atch.attachNo}번 첨부 제거</button>
									</div>
									<div class="p-input__addon">
										<label for="atchmnfl_@@{atch.attachNo}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_@@{atch.attachNo}" data-showfilename="#filename_@@{atch.attachNo}"><span class="skip">@@{atch.attachNo}번째 </span>파일선택</label>
									</div>
									<c:choose>
										<c:when test="@@{atch.bdtInsertAt eq 'Y'}">
											<div class="p-form-checkbox padding_l_5">
												<input type="checkbox" name="bdtInsrtAt@@{atch.attachNo}" id="bdtInsrtAt_@@{atch.attachNo}" value="@@{atch.attachNo}" class="p-form-checkbox__input">
												<label for="bdtInsrtAt_@@{atch.attachNo}" class="p-form-checkbox__label">본문삽입</label>
											</div>
										</c:when>
										<c:otherwise>
											<input type="hidden" name="bdtInsrtAt@@{atch.attachNo}" id="bdtInsrtAt_@@{atch.attachNo}" value="@@{atch.attachNo}">
										</c:otherwise>
									</c:choose>
								</div>
								<c:choose>
									<c:when test="@@{atch.replcUseAt eq 'Y'}">
										<input type="text" name="replcText@@{atch.attachNo}" id="replcText_@@{atch.attachNo}" class="p-input" title="@@{atch.attachNo}번 첨부 이미지 대체 텍스트 입력" value="" placeholder="첨부 이미지 대체 텍스트 입력">
									</c:when>
									<c:otherwise>
										<input type="hidden" name="replcText@@{atch.attachNo}" id="replcText_@@{atch.attachNo}" value="">
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>
					</c:forEach>

				</c:if>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
				<tr>
					<th scope="row">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</th>
					<td>
						<span class="p-form-radio">
							<input type="radio" name="othbcAt" id="othbcAt_0" class="p-form-radio__input" value="Y" <c:if test="@@{'Y' eq bbsNtt.othbcAt}">checked="checked"</c:if>>
							<label for="othbcAt_0" class="p-form-radio__label margin_r_10">공개</label>
						</span>
						<span class="p-form-radio">
							<input type="radio" name="othbcAt" id="othbcAt_1" class="p-form-radio__input" value="N" <c:if test="@@{'N' eq bbsNtt.othbcAt}">checked="checked"</c:if>>
							<label for="othbcAt_1" class="p-form-radio__label margin_r_10">비공개</label>
						</span>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'ADRES'>
				<tr>
					<th scope="row">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</th>
					<td>
						<button type="button" class="p-button p-button--small gray margin_r_10" onclick="openDaumZipAddress();">주소 검색</button>
						<span class="small">
							<svg width="20" height="25" fill="#202e70 ">
								<title>주의사항</title>
								<use xlink:href="/common/images/program/p-icon.svg#exclamation-circle-solid" y="-1"></use>
								<switch><foreignObject width="20" height="20">주의사항</foreignObject></switch>
							</svg>
							우편번호 검색창이 새창으로 열립니다.
						</span>
						<div class="p-form__address" id="addressShow" <c:if test="@@{empty bbsNtt.zip && empty bbsNtt.adres && empty bbsNtt.detailAdres}">style="display:none"</c:if>>(<c:out value="@@{bbsNtt.zip}"/>) <c:out value="@@{bbsNtt.adres}"/> <c:out value="@@{bbsNtt.detailAdres}"/></div>
						<input type="hidden" name="zip" id="zip"/>
						<input type="hidden" name="adres" id="adres"/>
						<input type="text" name="detailAdres" id="detailAdres" class="p-input" style="display: none;" placeholder="상세주소 입력"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'CN'>
				<tr>
					<th scope="row"><label for="nttCn" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<textarea name="nttCn" id="nttCn" class="p-input" rows="80" cols="10" style="${bbsFieldInputShow.fieldStyle!""}"><c:out value="@@{bbsNtt.nttCn}"/></textarea>
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
						<div class="p-form-inline">
							<input type="text" name="bgnde" id="bgnde" class="p-input" readonly="readonly" value="<c:out value="@@{bbsNtt.bgndeYMDHMS}"/>" placeholder="yyyy-mm-dd">
							<button type="button" class="p-form__date-button" title="${bbsFieldInputShow.fieldUseNm} 선택" onclick="getTimeCalendar(document.bbsNttForm.bgnde);">
								<span class="p-icon p-icon__calendar-alt">달력 열기</span>
							</button>
						</div>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'ENDDE'>
				<tr>
					<th scope="row"><label for="endde" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>

						<div class="p-form-inline">
							<input type="text" name="endde" id="endde" class="p-input"  readonly="readonly" value="<c:out value="@@{bbsNtt.enddeYMDHMS}"/>" placeholder="yyyy-mm-dd">
							<button type="button" class="p-form__date-button" title="${bbsFieldInputShow.fieldUseNm} 선택" onclick="getTimeCalendar(document.bbsNttForm.endde);">
								<span class="p-icon p-icon__calendar-alt">달력 열기</span>
							</button>
						</div>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'SJ'>
				<tr>
					<th scope="row"><label for="nttSj" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="nttSj" id="nttSj" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.nttSj}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'CTTPC'>
				<tr>
					<th scope="row"><label for="telno" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="telno" id="telno" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.telno}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'MOBLPHON'>
				<tr>
					<th scope="row"><label for="moblphon" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="moblphon" id="moblphon" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.moblphon}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'EMAIL'>
				<tr>
					<th scope="row"><label for="email" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="email" id="email" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.email}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
				</tr>
			<#elseif bbsFieldInputShow.fieldCode = 'HMPG'>
				<tr>
					<th scope="row"><label for="hmpg" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
					<td>
						<input type="text" name="hmpg" id="hmpg" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.hmpg}"/>"/>
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
						<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE03'>
					<td>
						<textarea name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}"><c:out value="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}}"/></textarea>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE04'>
					<td>
				<#list bbsFieldInputShow.fieldDataList?split("^") as dataList>
						<span class="p-form-radio">
							<input type="radio" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-radio__input" <c:if test="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case} eq '${dataList}'}">checked="checked"</c:if> value="${dataList}">
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
							<option value="${dataList}" <c:if test="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case} eq '${dataList}'}">selected="selected"</c:if>>${dataList}</option>
				</#list>
						</select>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE06'>
					<td>
					<#list bbsFieldInputShow.fieldDataList?split("^") as dataList>
						<span class="p-form-checkbox">
							<input type="checkbox" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-checkbox__input" value="${dataList}" <c:if test="@@{fn:contains(bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}, '${dataList}')  }">checked="checked"</c:if>><label for="${bbsFieldInputShow.fieldCode?lower_case}_${dataList_index}" class="p-form-checkbox__label">${dataList}</label>
						</span>
					</#list>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE07'>
					<td>
						<button type="button" class="p-button p-button--small gray margin_r_10" onclick="openDaumZipAddressAdit('addressShow_${bbsFieldInputShow.fieldCode}');">주소 검색</button>
						<span class="small">
							<svg width="20" height="25" fill="#202e70 ">
								<title>주의사항</title>
								<use xlink:href="/common/images/program/p-icon.svg#exclamation-circle-solid" y="-1"></use>
								<switch><foreignObject width="20" height="20">주의사항</foreignObject></switch>
							</svg>
							우편번호 검색창이 새창으로 열립니다.
						</span>
						<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="addressShow_${bbsFieldInputShow.fieldCode}" class="p-input p-form__address" title="주소 입력"  value="<c:out value="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}}"/>">
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#elseif bbsFieldInputShow.fieldSe = 'FESE08'>
					<td>
						<div class="p-form-group p-date" data-date="datepicker">
							<input type="text" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}" class="p-input"  value="<c:out value="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}}"/>" placeholder="yyyy-mm-dd">
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
							<option value="<c:out value="@@{deptment.deptNm}"/>" <c:if test="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case} eq deptment.deptNm}">selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach><c:out value="@@{deptment.deptNm}"/></option>
						</c:forEach>
						</select>
						<input type="hidden" name="${bbsFieldInputShow.fieldCode?lower_case}" id="${bbsFieldInputShow.fieldCode?lower_case}_val" value="<c:out value="@@{bbsNtt.${bbsFieldInputShow.fieldCode?lower_case}}"/>"/>
						${getFieldDc(bbsFieldInputShow.fieldDc!"")}
					</td>
			<#else>
					<td></td>
			</#if>
				</tr>
		</#if>

	</#list>
			<#if  bbsInfo.regDateUpdateUseAt = "Y" >
			<c:if test="@@{bbsNttVO.bbsManageMode eq true}">
				<tr>
					<th>작성일</th>
					<td>
						<div class="p-form-inline">
							<input type="text" name="frstRegisterPnttm" id="frstRegisterPnttm" class="p-input"  readonly="readonly" value="<c:out value="@@{bbsNtt.frstRegisterPnttmYMDHMS2}"/>" placeholder="yyyy-mm-dd">
							<button type="button" class="p-form__date-button" title="작성일 선택" onclick="getTimeCalendar(document.bbsNttForm.frstRegisterPnttm);">
								<span class="p-icon p-icon__calendar-alt">달력 열기</span>
							</button>
						</div>
					</td>
				</tr>
			</c:if>
			</#if>
			<#if  bbsInfo.koglNttUseAt = "Y" >
				<tr>
					<th>공공누리 선택</th>
					<td>
						<ul class="kogl_layer">
							<li class="block">
								<input type="radio" name="koglNttType" id="koglNttType1" <c:out value="@@{bbsNtt.koglNttType eq 'MENU_SET' || empty bbsNtt.koglNttType ? 'checked=\"checked\"':''}"/> value="MENU_SET">
								<label for="koglNttType1">게시판 설정값으로 사용</label>
							</li>
							<li>
								<input type="radio" name="koglNttType" id="koglNttType2" <c:out value="@@{bbsNtt.koglNttType eq 'KOGLTY01' ? 'checked=\"checked\"':''}"/> value="KOGLTY01">
								<label for="koglNttType2">
									제1유형 : 출처표시
								</label>
							</li>
							<li>
								<input type="radio" name="koglNttType" id="koglNttType3" <c:out value="@@{bbsNtt.koglNttType eq 'KOGLTY02' ? 'checked=\"checked\"':''}"/> value="KOGLTY02">
								<label for="koglNttType3">
									제2유형 : 출처 표시 + 상업적 이용금지
								</label>
							</li>
							<li>
								<input type="radio" name="koglNttType" id="koglNttType4" <c:out value="@@{bbsNtt.koglNttType eq 'KOGLTY03' ? 'checked=\"checked\"':''}"/> value="KOGLTY03">
								<label for="koglNttType4">
									제3유형 : 출처 표시 + 변경금지
								</label>
							</li>
							<li>
								<input type="radio" name="koglNttType" id="koglNttType5"  <c:out value="@@{bbsNtt.koglNttType eq 'KOGLTY04' ? 'checked=\"checked\"':''}"/> value="KOGLTY04">
								<label for="koglNttType5">
									제4유형 : 출처 표시 + 상업용금지 + 변경금지
								</label>
							</li>
						</ul>
					</td>
				</tr>
			</#if>
				</tbody>
			</table>
			
			<div class="text_right margin_t_30">
				<a href="./selectBbsNttList.do?key=<c:out value="@@{key}"/>&amp;bbsNo=<c:out value="@@{bbsNttVO.bbsNo}"/>&amp;nttNo=<c:out value="@@{bbsNttVO.nttNo}"/>&amp;searchCtgry=<c:out value="@@{bbsNttVO.searchCtgry}"/>&amp;searchCnd=<c:out value="@@{bbsNttVO.searchCnd}"/>&amp;searchKrwd=<c:out value="@@{bbsNttVO.searchKrwd}"/>&amp;pageIndex=<c:out value="@@{bbsNttVO.pageIndex}"/>&amp;integrDeptCode=<c:out value="@@{bbsNttVO.integrDeptCode}"/>" class="p-button cancel">취소</a>
				<input type="submit" class="p-button write" value="수정">
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
<script nonce="NEOCMSSCRIPT">
	$(document).ready(function() {

		$('input[type="radio"]').on('change', function(e) {
			console.log($(this).prop("name"));
			if($(this).hasClass("file-chg-radio")){
				if(this.checked == true){
					$("#upload_pan_"+$(this).data("key")).show();
				}
			}else{
				$("#upload_pan_"+$(this).data("key")).hide();
			}

		});
	});
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script nonce="NEOCMSSCRIPT">
	function openDaumZipAddressAdit(adresField) {
		new daum.Postcode({
			oncomplete:function(data) {
				$("#"+adresField).val(data.address);
				$("#"+adresField).focus();
			}
		}).open();
	}
	function openDaumZipAddress() {
		new daum.Postcode({
			oncomplete:function(data) {
				$("#zip").val(data.zonecode);
				$("#adres").val(data.address);
				$("#detailAdres").focus();
				$("#detailAdres").show();
				$("#addressShow").show();
				$("#addressShow").html("(" + data.zonecode + ") " + data.address + " " );
				console.log(data);
			}
		}).open();
	}
</script>
<script src="/common/js/program.min.js"></script>
</body>
</html>