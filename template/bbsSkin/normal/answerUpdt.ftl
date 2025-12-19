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
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>

<%
		String ctx = request.getContextPath(); //콘텍스트명 얻어오기.
		response.setHeader("Pragma-directive", "no-cache");
		response.setHeader("Cache-directive", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires",0); 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="@@{menuInfo.siteId}" />
	<title><c:out value="@@{menuInfo.cntntsNm}"/> 수정</title>
	<title><c:out value="@@{menuInfo.cntntsNm}"/> 답변 수정</title>

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

<#if bbsDescription.updtDc?has_content>
	<div class="card card--line top">
		<div class="card-content">${bbsDescription.updtDc!""}</div>
  </div>
</#if>
	
	<div>
		<span class="p-icon p-icon__info-circle">주의사항</span>
		<span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
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
	<form name="bbsNttForm" id="bbsNtt" method="post" action="./updateBbsNtt.do" onsubmit="return fn_validatorBbsNtt(this)" enctype="multipart/form-data">
		<double-submit:preventer/>
  <fieldset>
  <legend>게시물 작성</legend>
	<input type="hidden" name="key" id="key" value="@@{key}"/>
	<input type="hidden" name="bbsNo" id="bbsNo" value="@@{bbsNtt.bbsNo}"/>
	<input type="hidden" name="nttNo" id="nttNo" value="@@{bbsNtt.nttNo}"/>
	<input type="hidden" name="upperNttNo" id="upperNttNo" value="@@{bbsNtt.upperNttNo}"/>
	<input type="hidden" name="searchCtgry" id="searchCtgry" value="@@{bbsNttVO.searchCtgry}"/>
	<input type="hidden" name="searchCnd" id="searchCnd" value="@@{bbsNttVO.searchCnd}"/>
	<input type="hidden" name="searchKrwd" id="searchKrwd" value="@@{bbsNttVO.searchKrwd}"/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="@@{bbsNttVO.pageIndex}"/>
	<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
	<input type="hidden" name="myView" id="myView" value="@@{param.myView}"/>
<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#if bbsFieldInputShow.aditFieldAt = 'N'>
		<#if bbsFieldInputShow.fieldCode = 'CTGRY'>
	<input type="hidden" name="ctgryNm" id="ctgryNm" value="@@{bbsNtt.ctgryNm}"/>
		<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
	<input type="hidden" name="othbcAt" id="othbcAt" value="@@{bbsNtt.othbcAt}"/>
		</#if>
	</#if>
</#list>
	<table class="p-table mobile block">
		<caption><c:out value="@@{bbsNtt.nttSj}"/> 수정 - ${fieldList} 입력</caption>
		<colgroup>
			<col class="w20p">
      <col>
		</colgroup>
		<tbody class="p-table--th-left">
<#if fieldList?index_of('DEPT') = -1>
		<tr>
			<th scope="row">부서명</th>
			<td><input type="text" name="deptNm" id="deptNm" value="@@{bbsNtt.deptNm}" style="width:250px;" class="p-input p-input--auto" /></td>
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
					<option value="@@{deptment.deptCode}"<c:if test="@@{bbsNtt.deptCode eq deptment.deptCode}"> selected="selected"</c:if>><c:forEach var="i" begin="2" end="@@{deptment.deptLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>@@{deptment.deptNm}</option>
				</c:forEach>
				</select>
				<input type="hidden" name="deptNm" id="deptNm" value="@@{bbsNtt.deptNm}"/>
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
			<td>@@{bbsNtt.writerNm}</td>
		</tr>
		<#elseif bbsFieldInputShow.fieldCode = 'FILE'>	
		<tr>
			<th scope="row">${bbsFieldInputShow.fieldUseNm}${getEssntl(bbsFieldInputShow.essntlAt)}</th>
      <td class="subject">				
				<c:set var="fileCnt" value="0" />
				<c:if test="@@{!empty bbsAtchmnflList}">
				<ul class="p-attach margin_b_15">
					<c:forEach var="bbsAtchmnfl" items="@@{bbsAtchmnflList}" varStatus="idx">
					<li class="p-attach__item">
						<span class="p-form-radio">
							<input type="radio" name="fileProcTy@@{idx.index}" id="fileProcTy@@{idx.index}_U" value="U" class="p-form-radio__input" checked>
							<label for="fileProcTy@@{idx.index}_U" class="p-form-radio__label margin_r_10">유지</label>
						</span>
						<span class="p-form-radio">
							<input type="radio" name="fileProcTy@@{idx.index}" id="fileProcTy_@@{idx.index}_D" value="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-radio__input">
							<label for="fileProcTy_@@{idx.index}_D" class="p-form-radio__label margin_r_10">삭제</label>
						</span>
						<span class="p-form-checkbox">
							<input type="checkbox" name="bdtInsrtAtTy@@{idx.index}" id="bdtInsrtAtTy_@@{idx.index}" value="<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-form-checkbox__input"<c:if test="@@{'Y' eq bbsAtchmnfl.bdtInsrtAt}"> checked</c:if>>
							<label for="bdtInsrtAtTy_@@{idx.index}" class="p-form-checkbox__label margin_r_20">본문삽입</label>
						</span>
						<a href="./downloadBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>"><span class="p-icon p-icon__@@{bbsAtchmnfl.fileExtsn}">@@{bbsAtchmnfl.fileExtsn} 문서</span><span><c:out value="@@{bbsAtchmnfl.fileNm}"/></span></a>
					</li>
						<c:set var="fileCnt" value="@@{fileCnt + 1}" />
					</c:forEach>
				</ul>
				</c:if>
										
				<c:forEach var="i" begin="@@{fileCnt+1}" end="@@{bbsInfo.posblAtchmnflCo}" step="1" varStatus="idx">
				<div class="p-upload">
					<div class="p-form-group">
						<div class="p-form-group__upload">
							<input type="file" name="atchmnfl" id="atchmnfl_@@{idx.index-fileCnt-1}" class="p-upload__file--hidden">
							<span id="filename_@@{idx.index-fileCnt-1}" class="p-input disabled"></span>
							<button type="button" class="p-upload__clear clear">선택한 @@{idx.index-fileCnt-1}번 첨부 제거</button>
						</div>
						<div class="p-input__addon">
							<label for="atchmnfl_@@{idx.index-fileCnt-1}" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#atchmnfl_@@{idx.index-fileCnt-1}" data-showfilename="#filename_@@{idx.index-fileCnt-1}">
							<span class="skip">atchmnfl_@@{idx.index-fileCnt-1}번째 </span>파일선택</label>
							<!-- data-original="#fileorg" : 첨부파일 input의 id 표시-->
						</div>
						<div class="p-form-checkbox padding_l_5">
							<input type="checkbox" name="bdtInsrtAt" id="bdtInsrtAt_@@{idx.index-fileCnt-1}" value="@@{idx.index-fileCnt-1}" class="p-form-checkbox__input">
							<label for="bdtInsrtAt_@@{idx.index-fileCnt-1}" class="p-form-checkbox__label">본문삽입</label>
						</div>
					</div>
					<input type="text" name="replcText" id="replcText_@@{idx.index-fileCnt-1}" class="p-input" title="@@{idx.index-fileCnt-1}번 첨부 이미지 대체 텍스트 입력" value="" placeholder="첨부 이미지 대체 텍스트 입력">
				</div>
				</c:forEach>

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
			<td><input type="text" name="telno" id="telno" value="@@{bbsNtt.telno}" style="width:250px;" class="p-input p-input--auto" /></td>
		</tr>
		<tr>
			<th scope="row"><label for="nttCn" class="p-form__label">${bbsFieldInputShow.fieldUseNm} ${getEssntl(bbsFieldInputShow.essntlAt)}</label></th>
			<td>
				<textarea name="nttCn" id="nttCn" class="p-input" style="${bbsFieldInputShow.fieldStyle!""}">@@{bbsNtt.nttCn}</textarea>
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
			<td><input type="text" name="nttSj" id="nttSj" class="p-input" ${getPlaceholder(bbsFieldInputShow.fieldDc!"")} style="${bbsFieldInputShow.fieldStyle!""}" value="<c:out value="@@{bbsNtt.nttSj}"/>"/></td>
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
		<input type="submit" class="p-button write" value="답변 수정">
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

$(document).ready(function() {	  
	changeCaptcha(); //Captcha Image 요청	  
	$('#reLoad').click(function(){ changeCaptcha(); }); //'새로고침'버튼의 Click 이벤트 발생시 'changeCaptcha()'호출
	//$('#soundOn').click(function(){ audioCaptcha(); }); //'음성듣기'버튼의 Click 이벤트 발생시 'audioCaptcha()'호출
});

function changeCaptcha() {
	//IE에서 '새로고침'버튼을 클릭시 CaptChaImg.jsp가 호출되지 않는 문제를 해결하기 위해 "?rand='+ Math.secureRandom()" 추가
	var array = new Uint32Array(6);
	window.crypto.getRandomValues(array);
	$('#catpcha').html('<img src="<%=ctx%>/captChaImg.do?rand='+ array.toString() + '"/>');

}

function winPlayer(objUrl) {
	$('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
}

function audioCaptcha() {
	var uAgent = navigator.userAgent;
	var soundUrl = '/captChaAudio.do';
	if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
		//IE일 경우 호출
		var array = new Uint32Array(6);
		window.crypto.getRandomValues(array);
		winPlayer(soundUrl+'?agent=msie&rand='+ array.toString());
	} else if (!!document.createElement('audio').canPlayType) {
		//Chrome일 경우 호출
		try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
	} else window.open(soundUrl, '', 'width=1,height=1');
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