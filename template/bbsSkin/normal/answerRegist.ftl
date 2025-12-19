<#ftl encoding="utf-8"/>
<#function getEssntl essntlAt>
	<#local essntl = "">
	<#if essntlAt = '1' || essntlAt = '3'>
		<#local essntl = " <span class=\"p-form__required--icon\">필수</span>">
	<#else>
		<#local essntl = "">
	</#if>
	<#return essntl>
</#function>
<#function getPlaceholder fieldDc>
	<#local placeHolder = "">
	<#if fieldDc != "">
		<#local placeHolder = " placeholder=\"${fieldDc}\"">
	</#if>
	<#return placeHolder>
</#function>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="@@{menuInfo.siteId}" />
	<title><c:out value="@@{menuInfo.cntntsNm}"/> 답변 등록</title>

	<link rel="stylesheet" type="text/css" href="/common/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/common/css/program.css" />
</head>
<body>

<c:if test="@@{siteId eq 'iframe'}">
<div id="container">
	<main class="main">
		<article>
			<div class="contents">
</c:if>

<div class="p-wrap bbs bbs__form">

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

<#if bbsDescription.registDc?has_content>
	<div class="card card--line top">
		<div class="card-content">${bbsDescription.registDc!""}</div>
	</div>
</#if>

	<div>
		<span class="p-icon p-icon__info-circle">주의사항</span>
		<span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
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
	<form name="bbsNttForm" id="bbsNtt" method="post" action="./addBbsNttReply.do" onsubmit="return fn_validatorBbsNtt(this)" enctype="multipart/form-data">
		<double-submit:preventer/>
  <fieldset>
  <legend>게시물 작성</legend>
  <input type="hidden" name="key" id="key" value="@@{key}"/>
	<input type="hidden" name="bbsNo" id="bbsNo" value="@@{bbsNo}"/>
	<input type="hidden" name="nttNo" id="nttNo" value="@@{nttNo}"/>
	<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#if bbsFieldInputShow.aditFieldAt = 'N'>
		<#if bbsFieldInputShow.fieldCode = 'CTGRY'>
	<input type="hidden" name="ctgryNm" id="ctgryNm" value="@@{bbsNttInfo.ctgryNm}"/>
		<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
	<input type="hidden" name="othbcAt" id="othbcAt" value="@@{bbsNttInfo.othbcAt}"/>
		</#if>
	</#if>
</#list>
  <table class="p-table mobile block">
		<caption>${bbs.bbsNm} 글쓰기 - ${fieldList} 입력</caption>
		<colgroup>
			<col class="w20p">
      <col>
		</colgroup>
		<tbody class="p-table--th-left">
<#if fieldList?index_of('DEPT') = -1>
		<tr>
			<th scope="row">부서명</th>
			<td><input type="text" name="deptNm" id="deptNm" value="@@{bbsNttVO.deptNm}" style="width:250px;" class="p-input p-input--auto" /></td>
		</tr>
</#if>
<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#if bbsFieldInputShow.aditFieldAt = 'N'>
		<#if bbsFieldInputShow.fieldCode = 'DEPT'>
		<tr>
			<th scope="row"><label for="deptCode">${bbsFieldInputShow.fieldUseNm}${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
			<td>
				<select name="deptCode" id="deptCode" onchange="fn_changeDept(this, 'deptNm');" class="p-input p-input--auto">
					<option value="">부서 선택</option>
				<c:forEach var="deptment" items="@@{departmentList}">
					<option value="@@{deptment.deptCode}" <c:if test="@@{bbsNttVO.deptCode eq deptment.deptCode}">selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>@@{deptment.deptNm}</option>
				</c:forEach>
				</select>
				<input type="hidden" name="deptNm" id="deptNm" value="@@{bbsNttVO.deptNm}"/>
			<#if bbsFieldInputShow.fieldDc?has_content>
				<div class="small margin_t_5">
					<span class="p-icon p-icon__info-circle-solid">주의사항</span>${bbsFieldInputShow.fieldDc!""}
				</div>
			</#if>
			</td>
		</tr>
		<#elseif bbsFieldInputShow.fieldCode = 'WRTER'>
		<tr>
			<th scope="row">${bbsFieldInputShow.fieldUseNm}</th>
			<td>@@{bbsNttVO.writerNm}</td>
		</tr>
		<#elseif bbsFieldInputShow.fieldCode = 'FILE'>
		<tr>
			<th scope="row">${bbsFieldInputShow.fieldUseNm}${getEssntl(bbsFieldInputShow.essntlAt)}</th>
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
							<label for="atchmnfl_${i_index}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_${i_index}" data-showfilename="#filename_${i_index}">
							<span class="skip">atchmnfl_${i_index}번째 </span>파일선택</label>
							<!-- data-original="#fileorg" : 첨부파일 input의 id 표시, data-showfilename="#filename" : 파일면 표시될 곳의 id-->
						</div>
						<div class="p-form-checkbox padding_l_5">
							<input type="checkbox" name="bdtInsrtAt" id="bdtInsrtAt_${i_index}" value="${i_index}" class="p-form-checkbox__input">
							<label for="bdtInsrtAt_${i_index}" class="p-form-checkbox__label">본문삽입</label>
						</div>
					</div>
					<input type="text" name="replcText" id="replcText_${i_index}" value="@@{bbsNttVO.replcText[${i_index}]}" class="p-input" title="${i_index}번 첨부 이미지 대체 텍스트 입력" value="" placeholder="첨부 이미지 대체 텍스트 입력">
				</div>
				</#list>
				<#if bbsFieldInputShow.fieldDc?has_content>
				<div class="small margin_t_5">
					<span class="p-icon p-icon__info-circle-solid">주의사항</span>${bbsFieldInputShow.fieldDc!""}
				</div>
				</#if>
			</td>
		</tr>
		<#elseif bbsFieldInputShow.fieldCode = 'CN'>
		<tr>
			<th scope="row"><label for="nttCn" class="p-form__label">연락처</label></th>
			<td><input type="text" name="telno" id="telno" value="@@{bbsNttVO.telno}" style="width:250px;" class="p-input p-input--auto" /></td>
		</tr>
		<tr>
			<th scope="row"><label for="nttCn" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
			<td>
				<textarea name="nttCn" id="nttCn" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}">@@{bbsNttVO.nttCn}</textarea>
			<#if bbsFieldInputShow.fieldDc?has_content>
				<div class="small margin_t_5">
					<span class="p-icon p-icon__info-circle-solid">주의사항</span>${bbsFieldInputShow.fieldDc!""}
        </div>
			</#if>
			</td>
		</tr>
		<#elseif bbsFieldInputShow.fieldCode = 'SJ'>
		<tr class="p-table__subject">
			<th scope="row"><label for="nttSj" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
			<td><input type="text" name="nttSj" id="nttSj" class="p-input" ${getPlaceholder(bbsFieldInputShow.fieldDc!"")} style="${bbsFieldInputShow.fieldStyle!""}" value="@@{bbsNttVO.nttSj}"/></td>
		</tr>
		</#if>
	<#else>
		<#if bbsFieldInputShow.mngrShowAt = '1'>
		<c:if test="@@{bbsAuthor.authorBbsMng}">
		</#if>

		<#if bbsFieldInputShow.mngrShowAt = '1'>
		</c:if>
		</#if>
	</#if>
	
</#list>
    </tbody>
	</table>
  
	<div class="text_right margin_t_30">
		<a href="./selectBbsNttList.do?key=@@{key}&amp;bbsNo=@@{bbsNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}" class="p-button cancel">취소</a>
		<input type="submit" class="p-button write" value="답변 등록">
	</div>
  </fieldset>
	</form>

</div>

<c:if test="@@{!empty message}">
<script type="text/javascript">
 	function fn_check_message() {
 		alert("<c:out value='@@{message}'/>");
    <c:if test="@@{!empty fieldNm}">
	    @@("#@@{fieldNm}").focus();
    </c:if>
 	}
	@@(window).on("load", function() {
		fn_check_message();
	});
</script>
 </c:if>
<script type="text/javascript">

function fn_validatorBbsNtt( frm ) {

<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#if bbsFieldInputShow.aditFieldAt = 'N'>
		<#if bbsFieldInputShow.fieldCode = 'DEPT'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	if( fn_isEmpty( frm, 'deptCode') ) {
		alert(fn_getMessage("SELECT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'deptCode');
		return false;
	}		
			</#if>
		<#elseif bbsFieldInputShow.fieldCode = 'CN'>
			<#if bbsFieldInputShow.essntlAt = '1' || bbsFieldInputShow.essntlAt = '3'>
	
				<#if bbsInfo.editorUseAt = 'Y'>
	CKEDITOR.instances.ckeditor.updateElement();
				</#if>

	if( fn_isEmpty( frm, 'nttCn') ) {
		alert(fn_getMessage("INPUT", '${bbsFieldInputShow.fieldUseNm}'));
		fn_setFocus(frm, 'nttCn');
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
		</#if>
	<#else>
		
	</#if>
</#list>
	
	return true;		
}
</script>


<c:if test="@@{siteId eq 'iframe'}">
			</div>
		</article>
	</main>
</div>
</c:if>

<script src="/common/js/program.min.js"></script>
</body>
</html>