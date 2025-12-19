<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ page import="kr.co.hanshinit.NeoCMS.uat.uia.service.LoginUtil" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<c:url var="paramValue" value="">
	<c:param name="key" value="@@{key}"/>
	<c:param name="bbsNo" value="@@{bbsNttVO.bbsNo}"/>
	<c:param name="nttNo" value="@@{bbsNttVO.nttNo}"/>
	<c:param name="searchCtgry" value="@@{bbsNttVO.searchCtgry}"/>
	<c:param name="searchCnd" value="@@{bbsNttVO.searchCnd}" />
	<c:param name="searchKrwd" value="@@{bbsNttVO.searchKrwd}" />
	<c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
	<c:param name="pageIndex" value="@@{bbsNttVO.pageIndex}"/>
</c:url>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="@@{menuInfo.siteId}" />
	<title>${bbs.bbsNm} 상세보기</title>

	<link rel="stylesheet" type="text/css" href="/common/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/common/css/program.css" />
	<script src="/common/js/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="p-wrap bbs bbs__view">

	<#if (bbsDescription.viewDc!"")?string != ''>
		<div class="card card--line bottom">
			<div class="card-content">
				${bbsDescription.viewDc!""}
			</div>
		</div>
	</#if>


<#if bbsInfo.snsScrapUseAt = 'Y' && ( bbsInfo.facebookUseAt = 'Y' || bbsInfo.twitterUseAt = 'Y' )>
	<script nonce="NEOCMSSCRIPT">
		function fn_sendTwitter( url ) {
			window.open( url, "twitter", "" );
		}
	
		function fn_sendFacebook( url ) {
			window.open( url, "facebook", "" );
		}
	</script>
	<div class="text_right margin_b_10">
	<#if bbsInfo.facebookUseAt = 'Y'>
		<c:url var="facebookUrl" value="http://www.facebook.com/sharer.php">
			<c:param name="u">@@{requestUrl}</c:param>
			<c:param name="t">@@{bbsNtt.nttSj}</c:param>
		</c:url>
		<a href="" class="p-icon p-icon__facebook">페이스북 공유</a>
	</#if>
	<#if bbsInfo.twitterUseAt = 'Y'>
		<c:url var="twitterUrl" value="http://twitter.com/home">
			<c:param name="status">@@{bbsNtt.nttSj} @@{requestUrl}</c:param>
		</c:url>
		<a href="" class="p-icon p-icon__twitter">트위터 공유</a>
	</#if>
	</div>
</#if>

<#assign fieldList="">
<#assign fieldCodeList="">
<#list bbsFieldInputShowList as bbsFieldInputShow>
	<#assign fieldList=fieldList + "${bbsFieldInputShow.fieldUseNm}">
	<#assign fieldCodeList=fieldCodeList + "|${bbsFieldInputShow.fieldCode}|">
	<#if bbsFieldInputShow_has_next>
		<#assign fieldList=fieldList + ", ">
	</#if>
</#list>

	<table class="p-table block" data-table="rwd" data-tabletype="block" data-breakpoint="760">
		<caption>${bbs.bbsNm} 상세보기 - ${fieldList} 정보 제공</caption>
		<colgroup>
			<col class="w20p">
			<col>
		</colgroup>
		<tbody class="p-table--th-left">
<#list bbsFieldInputShowList as bbsFieldInputShow>
		<tr>
	<#if bbsFieldInputShow.fieldCode != 'SJ' && bbsFieldInputShow.fieldCode != 'CN' && bbsFieldInputShow.fieldCode != 'WRTER' && bbsFieldInputShow.fieldCode != 'RGSDE' && bbsFieldInputShow.fieldCode != 'RDCNT'>
			<th scope="row">${bbsFieldInputShow.fieldUseNm}</th>
	</#if>
	<#if bbsFieldInputShow.fieldCode = 'SJ'>
			<td colspan="2">
				<span class="p-table__subject_text">
		<#if bbsInfo.ctgryUseAt = 'Y' && bbsInfo.ctgryTy = 'CTGY03'>
					<c:if test="@@{!empty bbsNtt.ctgryNm}">[<c:out value="@@{bbsNtt.ctgryNm}"/>]</c:if>
		</#if>
					<c:out value="@@{bbsNtt.nttSj}"/>
				</span>
		<#assign wrterField=fieldCodeList?index_of("|WRTER|")>
		<#assign rgsdeField=fieldCodeList?index_of("|RGSDE|")>
		<#assign rdcntField=fieldCodeList?index_of("|RDCNT|")>
		<#if wrterField gt -1 || rgsdeField gt -1 || rdcntField gt -1>
				<div class="p-author__info">
			<#if wrterField gt -1>
					<span class="p-split"><em class="skip">작성자 :</em> <c:out value="@@{bbsNtt.writerNm}"/></span>
			</#if>
			<#if rgsdeField gt -1>
					<span class="p-split"><em class="skip">작성일 :</em> <time><c:out value="@@{bbsNtt.frstRegisterPnttmYMD}"/></time></span>
			</#if>
			<#if rdcntField gt -1>
					<span class="p-split"><em class="skip">조회 :</em> <svg width="18" height="15" fill="#959595" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#eye" y="1"></use></svg> <span><c:out value="@@{bbsNtt.rdcnt}"/></span></span>
			</#if>
				</div>
		</#if>
			</td>
	<#elseif bbsFieldInputShow.fieldCode = 'CTGRY'>
			<td><c:out value="@@{fn:replace(bbsNtt.ctgryNm,'|','')}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'DEPT'>
			<td><c:out value="@@{bbsNtt.deptNm}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'FILE'>
			<td>
			<c:if test="@@{fn:length(bbsAtchmnflList) > 0}">
				<ul class="p-attach">
			<c:forEach var="bbsAtchmnfl" items="@@{bbsAtchmnflList}">
					<li class="p-attach__item">
						<a href="./downloadBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" class="p-attach__link">
						<span class="p-icon p-icon__<c:out value="@@{bbsAtchmnfl.fileExtsn}"/>"><c:out value="@@{bbsAtchmnfl.fileExtsn}"/> 문서</span>
						<span><c:out value="@@{bbsAtchmnfl.fileNm}"/></span>
						<svg width="20" height="23" fill="#3b3e42" focusable="false" class="margin_l_5"><use xlink:href="/common/images/program/p-icon.svg#arrow-circle-down" y="2"></use></svg>
						</a>
					</li>
			</c:forEach>
				</ul>
			</c:if>
			</td>
	<#elseif bbsFieldInputShow.fieldCode = 'OTHBCAT'>
			<td><c:if test="@@{bbsNtt.othbcAt eq 'Y'}">공개</c:if><c:if test="@@{bbsNtt.othbcAt eq 'N'}">비공개</c:if></td>
	<#elseif bbsFieldInputShow.fieldCode = 'WRITERIP'>
			<td><c:out value="@@{bbsNtt.writerIp}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'CTTPC'>
			<td><c:out value="@@{bbsNtt.telno}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'MOBLPHON'>
			<td><c:out value="@@{bbsNtt.moblphon}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'EMAIL'>
			<td><c:out value="@@{bbsNtt.email}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'HMPG'>
			<td><c:out value="@@{bbsNtt.hmpg}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADRES'>
			<td>(<c:out value="@@{bbsNtt.zip}"/>) <c:out value="@@{bbsNtt.ares}"/> <c:out value="@@{bbsNtt.detailAres}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'CN'>
			<td colspan="2" title="내용" class="p-table__content">
			<c:forEach var="bbsAtchmnfl" items="@@{bbsAtchmnflList}">
				<c:if test="@@{bbsAtchmnfl.bdtInsrtAt eq 'Y'}">
				<c:if test="@@{bbsAtchmnfl.bdtInsrtAt eq 'Y' && ( bbsAtchmnfl.fileExtsn eq 'jpg' || bbsAtchmnfl.fileExtsn eq 'jpeg' || bbsAtchmnfl.fileExtsn eq 'gif' || bbsAtchmnfl.fileExtsn eq 'png' )}">
				<div class="p-photo">
					<div class="p-photo__wrap">
						<img src="<c:out value="@@{bbsAtchmnfl.storePath}"/>/<c:out value="@@{bbsAtchmnfl.storeFileNm}"/>" alt="<c:out value="@@{bbsAtchmnfl.replcText}"/>">
						<span class="p-photo__zoom">
							<a href="<c:out value="@@{bbsAtchmnfl.storePath}"/>/<c:out value="@@{bbsAtchmnfl.storeFileNm}"/>" class="p-photo__link" target="_blank" title="새창">
								<svg width="20" height="18" fill="rgba(255,255,255,.85)" focusable="false">
								<title>사진 확대보기</title>
								<use xlink:href="/common/images/program/p-icon.svg#expand-arrows"></use>
							</svg>
							</a>
						</span>
					</div>
				</div>
				</c:if>
				</c:if>
			</c:forEach>
				@@{tsu:xssClearNttCn(bbsNtt.htmlUseAt,bbsNtt.nttCn)}
			</td>
	<#elseif bbsFieldInputShow.fieldCode = 'BGNDE'>
			<td><c:out value="@@{bbsNtt.bgndeYMDHMS}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ENDDE'>
			<td><c:out value="@@{bbsNtt.enddeYMDHMS}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD1'>
			<td><c:out value="@@{bbsNtt.aditfield1}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD2'>
			<td><c:out value="@@{bbsNtt.aditfield2}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD3'>
			<td><c:out value="@@{bbsNtt.aditfield3}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD4'>
			<td><c:out value="@@{bbsNtt.aditfield4}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD5'>
			<td><c:out value="@@{bbsNtt.aditfield5}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD6'>
			<td><c:out value="@@{bbsNtt.aditfield6}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD7'>
			<td><c:out value="@@{bbsNtt.aditfield7}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD8'>
			<td><c:out value="@@{bbsNtt.aditfield8}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD9'>
			<td><c:out value="@@{bbsNtt.aditfield9}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD10'>
			<td><c:out value="@@{bbsNtt.aditfield10}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD11'>
			<td><c:out value="@@{bbsNtt.aditfield11}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD12'>
			<td><c:out value="@@{bbsNtt.aditfield12}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD13'>
			<td><c:out value="@@{bbsNtt.aditfield13}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD14'>
			<td><c:out value="@@{bbsNtt.aditfield14}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD15'>
			<td><c:out value="@@{bbsNtt.aditfield15}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD16'>
			<td><c:out value="@@{bbsNtt.aditfield16}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD17'>
			<td><c:out value="@@{bbsNtt.aditfield17}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD18'>
			<td><c:out value="@@{bbsNtt.aditfield18}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD19'>
			<td><c:out value="@@{bbsNtt.aditfield19}"/></td>
	<#elseif bbsFieldInputShow.fieldCode = 'ADITFIELD20'>
			<td><c:out value="@@{bbsNtt.aditfield20}"/></td>
	</#if>
		</tr>
</#list>
		</tbody>
	</table>

	<div class="row margin_t_30">
		<div class="col-12">
		<c:if test="@@{bbsAuthor.updateBtnAuth}">
			<a href="./updateBbsNttView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered edit">수정
				<svg width="16" height="13" fill="#202e70" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#edit"></use>
				</svg>
			</a>
		</c:if>
		<c:if test="@@{bbsAuthor.deleteBtnAuth}">
			<a href="./deleteBbsNtt.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered delete" onclick="fn_deleteBbsNtt(this.href); return false;">삭제
				<svg width="14" height="17" fill="#202e70" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#trash"></use>
				</svg>
			</a>
		</c:if>
		<c:if test="@@{VIEW_SE ne 'RTSY03'}">
			<c:if test="@@{bbsInfo.replySe eq 'RTSY02'}">
				<c:if test="@@{bbsAuthor.replyBtnAuth}">
			<a href="./addBbsNttReplyView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered reply">답변
				<svg width="16" height="18" fill="#2e3135" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#comment-alt-lines"></use>
				</svg>
			</a>
				</c:if>
			</c:if>
			<c:if test="@@{bbsInfo.replySe eq 'RTSY03'}">
				<c:if test="@@{bbsAuthor.answerBtnAuth}">
			<a href="./updateBbsNttAnswerView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered reply">답변
				<svg width="16" height="18" fill="#2e3135" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#comment-alt-lines"></use>
				</svg>
			</a>
				</c:if>
			</c:if>
		</c:if>
		</div>
		<div class="col-12 right">
			<a href="./selectBbsNttList.do<c:out value="@@{paramValue}"/>" class="p-button write">목록<span></span>
				<svg width="16" height="18" fill="#fff" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#bars"></use>
				</svg>
			</a>
		</div>
	</div>

<c:if test="@@{bbsInfo.replySe eq 'RTSY03'}">

	<c:if test="@@{VIEW_SE ne 'RTSY03' && !empty bbsNttAnswer.answerCn}">

	<table class="p-table block margin_t_60" data-table="rwd" data-tabletype="block" data-breakpoint="760">
		<caption><c:out value="@@{bbs.bbsNm}"/> 답변 - 작성일, 답변내용 정보 제공</caption>
		<colgroup>
			<col class="w20p">
			<col>
		</colgroup>
		<tbody class="p-table--th-left">
		<tr>
			<th scope="row">작성일</th>
			<td><time><c:out value="@@{bbsNttAnswer.frstRegisterPnttmYMD}"/></time></td>
		</tr>
		<tr>
			<th scope="row">답변내용</th>
			<td>
				<c:out value="@@{bbsNttAnswer.answerCn}"/>
			</td>
		</tr>
		</tbody>
	</table>
	<div class="text_right margin_t_30">
		<a href="./updateBbsNttAnswerView.do<c:out value="@@{paramValue}"/>" class="p-button edit">답변 수정<span></span></a>
	</div>

	</c:if>

	<c:if test="@@{VIEW_SE eq 'RTSY03'}">

	<form name="bbsNttAnswer" id="bbsNttAnswer" method="post" action="./updateBbsNttAnswer.do">
		<fieldset>
			<legend><c:out value="@@{bbs.bbsNm}"/> 답변</legend>
			<input type="hidden" name="key" id="key" value="<c:out value="@@{key}"/>"/>
			<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="@@{bbsNttVO.bbsNo}"/>"/>
			<input type="hidden" name="nttNo" id="nttNo" value="<c:out value="@@{bbsNttVO.nttNo}"/>"/>
			<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
			<table class="p-table block margin_t_60" data-table="rwd" data-tabletype="block" data-breakpoint="760">
				<caption>{게시판이름} 상세보기 - 제목, 담당부서, 담당자, 담당연락처, 내용, 첨부파일 정보 제공</caption>
				<colgroup>
					<col class="w20p">
					<col>
				</colgroup>
				<tbody class="p-table--th-left">
				<tr>
					<th scope="row"><label for="" class="p-form__label">작성자</label></th>
					<td><c:out value="@@{sessionScope.loginVO.userNm}"/></td>
				</tr>
				<tr>
					<th scope="row">답변 내용</th>
					<td>
						<textarea name="answerCn" id="answerCn" cols="30" rows="10" class="p-input"><c:out value="@@{bbsNttAnswer.answerCn}"/></textarea>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="text_right margin_t_30">
				<input type="submit" class="p-button write" value="답변 등록">
			</div>
		</fieldset>
	</form>

	</c:if>
	
</c:if>
   
<#if bbsInfo.answerUseAt = 'Y'>

	<script nonce="NEOCMSSCRIPT">
		function fn_validateBbsNttComment( frm ) {
			if( !frm.commentCn.value ) {
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
			return true;
		}
	
		function fn_deleteBbsNttComment( url ) {
			if( confirm("댓글을 삭제하시겠습니까?") ) {
				window.location = url;
			}
		}
	</script>

	<div class="p-comment">
	
		<div class="p-comment__heading">댓글</div>
		<form name="bbsNttComment" id="bbsNttComment" action="./insertBbsNttComment.do" method="post" class="replyForm" onsubmit="return fn_validateBbsNttComment(this)">
			<fieldset>
				<legend>댓글 쓰기</legend>
				<input type="hidden" name="key" id="key" value="<c:out value="@@{key}"/>"/>
				<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="@@{bbsNttVO.bbsNo}"/>"/>
				<input type="hidden" name="nttNo" id="nttNo" value="<c:out value="@@{bbsNttVO.nttNo}"/>"/>
				<input type="hidden" name="searchCtgry" id="searchCtgry" value="<c:out value="@@{bbsNttVO.searchCtgry}"/>"/>
				<input type="hidden" name="searchCnd" id="searchCnd" value="<c:out value="@@{bbsNttVO.searchCnd}"/>"/>
				<input type="hidden" name="searchKrwd" id="searchKrwd" value="<c:out value="@@{bbsNttVO.searchKrwd}"/>"/>
				<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="@@{bbsNttVO.pageIndex}"/>"/>
				<input type="hidden" name="integrDeptCode" id="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
				<div class="p-comment__form">
					<textarea name="commentCn" id="commentCn" cols="80" rows="10" required="required" class="p-input"></textarea>
				</div>
				<div class="p-comment__button">
					<input type="submit" class="p-button write" value="댓글 등록하기"/>
				</div>
			</fieldset>
		</form>
<% if( !LoginUtil.isLogined(session) ) { %>
		<script nonce="NEOCMSSCRIPT">
			$("#commentCn").focus(function(){
				if( confirm("인증 후 댓글 쓰기가 가능합니다\n로그인 페이지로 이동 하시겠습니까?") ) {
					$("#commentSubmit").focus();
					window.location="/loginView.do?rurl=REFERER";
				} else {
					$("#commentSubmit").focus();
				}
			});
		</script>
<% } %>

		<p class="p-comment__list-info">현재 <strong><fmt:formatNumber value="@@{fn:length(bbsNttCommentList)}" pattern="#,###"/></strong>개의 댓글이 있습니다.</p>
	<c:if test="@@{fn:length(bbsNttCommentList) != 0}">
		<ul class="p-comment__list">
		<c:forEach var="bbsNttComment" items="@@{bbsNttCommentList}">
			<li class="p-comment__item">
				<div class="p-author__info">
					<span class="p-split"><c:out value="@@{bbsNttComment.writerNm}"/></span>
					<span class="p-split"><time><c:out value="@@{bbsNttComment.frstRegisterPnttmYMD}"/></time></span>
					<button type="button" title="댓글 삭제" class="p-comment__button_delete" onclick="fn_deleteBbsNttComment('./deleteBbsNttComment.do<c:out value="@@{paramValue}"/>&amp;nttCommentNo=<c:out value="@@{bbsNttComment.nttCommentNo}"/>'); return false;">
						<svg width="14" height="14" fill="#555" focusable="false">
							<title>댓글 삭제</title>
							<use xlink:href="/common/images/program/p-icon.svg#times"></use>
							<switch><foreignObject width="14" height="14"><span class="p-icon p-icon__times">댓글삭제</span></foreignObject></switch>
						</svg>
					</button>
				</div>
				<c:out value="@@{bbsNttComment.commentCn}"/>
			</li>
		</c:forEach>
		</ul>
	</c:if>

	</div>

</#if>

<c:if test="@@{!empty bbsNttPrev || !empty bbsNttNext}">
	<ul class="p-post-move margin_t_60">
	<c:if test="@@{!empty bbsNttPrev}">
		<li class="p-post-move__item prev"><strong class="p-post-move__title">이전글</strong> <a href="./selectBbsNttView.do?key=<c:out value="@@{key}"/>&amp;bbsNo=<c:out value="@@{bbsNttVO.bbsNo}"/>&amp;nttNo=<c:out value="@@{bbsNttPrev.nttNo}"/>&amp;searchCtgry=<c:out value="@@{bbsNttVO.searchCtgry}"/>&amp;searchCnd=<c:out value="@@{bbsNttVO.searchCnd}"/>&amp;searchKrwd=<c:out value="@@{bbsNttVO.searchKrwd}"/>&amp;pageIndex=<c:out value="@@{bbsNttVO.pageIndex}"/>&amp;integrDeptCode=<c:out value="@@{bbsNttVO.integrDeptCode}"/>" class="p-post-move__link"><c:out value="@@{bbsNttPrev.nttSj}"/></a></li>
	</c:if>
	<c:if test="@@{!empty bbsNttNext}">
		<li class="p-post-move__item next"><strong class="p-post-move__title">다음글</strong> <a href="./selectBbsNttView.do?key=<c:out value="@@{key}"/>&amp;bbsNo=<c:out value="@@{bbsNttVO.bbsNo}"/>&amp;nttNo=<c:out value="@@{bbsNttNext.nttNo}"/>&amp;searchCtgry=<c:out value="@@{bbsNttVO.searchCtgry}"/>&amp;searchCnd=<c:out value="@@{bbsNttVO.searchCnd}"/>&amp;searchKrwd=<c:out value="@@{bbsNttVO.searchKrwd}"/>&amp;pageIndex=<c:out value="@@{bbsNttVO.pageIndex}"/>&amp;integrDeptCode=<c:out value="@@{bbsNttVO.integrDeptCode}"/>" class="p-post-move__link"><c:out value="@@{bbsNttNext.nttSj}"/></a></li>
	</c:if>
	</ul>
</c:if>

</div>

<script src="/common/js/default.js"></script>
<script nonce="NEOCMSSCRIPT">

	function fn_deleteBbsNtt( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}

</script>

</body>
</html>