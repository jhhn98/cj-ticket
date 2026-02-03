<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ page import="kr.co.hanshinit.NeoCMS.uat.uia.service.LoginUtil" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>

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
	<title><c:out value="@@{menuInfo.cntntsNm}"/> 상세보기</title>

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
		<a href="#n" onclick="fn_sendTwitter('<c:out value="@@{facebookUrl}"/>')" class="p-icon p-icon__facebook" title="새창">페이스북 공유</a>
	</#if>
	<#if bbsInfo.twitterUseAt = 'Y'>
		<c:url var="twitterUrl" value="http://twitter.com/home">
			<c:param name="status">@@{bbsNtt.nttSj} @@{requestUrl}</c:param>
		</c:url>
		<a href="#n" onclick="fn_sendTwitter('<c:out value="@@{twitterUrl}"/>')" class="p-icon p-icon__twitter" title="새창">트위터 공유</a>
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
	<c:choose>
		<c:when test="@@{ ((isNttWriter ne true && bbsNttVO.bbsManageMode eq false) && '${bbsFieldInputShow.viewMngOnlyShowAt}' ne '0')}">
		</c:when>
		<c:otherwise>
		<tr>
	<#if bbsFieldInputShow.fieldCode != 'NOTICEAT' && bbsFieldInputShow.fieldCode != 'SJ' && bbsFieldInputShow.fieldCode != 'CN' && bbsFieldInputShow.fieldCode != 'WRTER' && bbsFieldInputShow.fieldCode != 'RGSDE' && bbsFieldInputShow.fieldCode != 'RDCNT'>
			<th scope="row">${bbsFieldInputShow.fieldUseNm}<c:if test="@@{'${bbsFieldInputShow.viewMngOnlyShowAt}' ne '0'}">[관리자]</c:if></th>
	</#if>
	<#if bbsFieldInputShow.fieldCode = 'SJ'>
			<td colspan="2"><c:if test="@@{'${bbsFieldInputShow.viewMngOnlyShowAt}' ne '0'}">[관리자]</c:if>
				<c:if test="@@{bbsNtt.deleteAt eq 'Y'}"><span class="p-icon p-icon__deleted">삭제된글</span></c:if>
				<span class="p-table__subject_text">
		<#if bbsInfo.ctgryUseAt = 'Y' && bbsInfo.ctgryTy = 'CTGY03'>
					<c:if test="@@{!empty bbsNtt.ctgryNm}">[<c:out value="@@{fn:replace(bbsNtt.ctgryNm,'|','')}"/>] </c:if>
		</#if>
					<c:if test="@@{bbsNtt.deleteAt eq 'Y'}"><del></c:if>
					<c:out value="@@{bbsNtt.nttSj}"/>
					<c:if test="@@{bbsNtt.deleteAt eq 'Y'}"></del></c:if>
				</span>
		<#assign wrterField=fieldCodeList?index_of("|WRTER|")>
		<#assign rgsdeField=fieldCodeList?index_of("|RGSDE|")>
		<#assign rdcntField=fieldCodeList?index_of("|RDCNT|")>
		<#if wrterField gt -1 || rgsdeField gt -1 || rdcntField gt -1>
				<div class="p-author__info">
			<#if wrterField gt -1>
					<span class="p-split"><em class="skip">작성자 :</em>
						<#if  (bbsInfo.maskingNameUseAt!"")?string = 'Y'>
							<c:out value="@@{fn:substring(bbsNtt.writerNm,0,1)}*@@{fn:substring(bbsNtt.writerNm,fn:length(bbsNtt.writerNm)-1,fn:length(bbsNtt.writerNm))}"/>
						<#else>
							<c:out value="@@{bbsNtt.writerNm}"/>
						</#if>
					</span>
			</#if>
			<#if rgsdeField gt -1>
					<span class="p-split"><em class="skip">작성일 :</em> <time><c:out value="@@{bbsNtt.frstRegisterPnttmYMD}"/></time></span>
			</#if>
			<#if rdcntField gt -1>
					<span class="p-split"><em class="skip">조회 :</em> <svg width="18" height="15" fill="#959595" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#eye" y="1"></use></svg> <span><fmt:formatNumber value="@@{tsu:xssNumberFilter(bbsNtt.rdcnt)}" pattern="#,###"/></span></span>
			</#if>
					<c:if test="@@{bbsNtt.deleteAt eq 'Y'}"><span class="p-deleted__info margin_l_15">삭제자 : <c:out value="@@{bbsNtt.deleteId}"/> / 삭제사유 : <c:out value="@@{bbsNtt.deleteResn}"/> / 삭제일 : <time><c:out value="@@{bbsNtt.deletePnttmYMD}"/></time></span></c:if>
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
						</a>
						<!--<c:if test="@@{bbsAtchmnfl.previewUse eq true}">
							<a href="./previewBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" target="_blank" class="p-attach__preview p-button">
							<i class="p-icon p-icon__search"></i> 미리보기
							</a>
						</c:if>-->
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
			<td>
				<#if bbsInfo.geoMapUseAt = 'Y'>
					<c:if test="@@{!empty bbsNtt.adres}">
						<div id="map" style="width:100%;height:450px;"></div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@prop['daum.map.app.key']"/>&libraries=services"></script>
						<script>

							var map = null;
							var geocoder = null;
							var markers = [];
							$(function(){
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div
										mapOption = {
											center: new kakao.maps.LatLng(36.645442, 127.494456), // 지도의 중심좌표
											level: 3 // 지도의 확대 레벨
										};


								map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
								geocoder = new kakao.maps.services.Geocoder();

								var mapTypeControl = new kakao.maps.MapTypeControl();
								map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

								// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
								var zoomControl = new kakao.maps.ZoomControl();
								map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

								map.setDraggable(false);

								var address = "<c:out value="@@{bbsNtt.adres}"/>";
								//주소로 검색
								geocoder.addressSearch(address, function(result, status){
									//성공
									if (status === kakao.maps.services.Status.OK) {
										var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
										if(markers){
											hideMarkers();
										}
										//결과값으로 받은 위치를 마커로 표시
										var marker = new kakao.maps.Marker({
											map: map,
											position: coords
										});
										marker.setMap(map);
										markers.push(marker);

										//인포윈도우
										var infowindow = new kakao.maps.InfoWindow({
											content: ''
											//content: '<div style="width:150px;text-align:center;padding:6px 0;"></div>'
										});
										//infowindow.open(map, marker);

										// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
										map.setCenter(coords);
									}
								});
							});
							function setMarkers(map) {
								for (var i = 0; i < markers.length; i++) {
									markers[i].setMap(map);
								}
							}
							// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
							function hideMarkers() {
								setMarkers(null);
							}
						</script>
					</c:if>
				</#if>
				(<c:out value="@@{bbsNtt.zip}"/>) <c:out value="@@{bbsNtt.adres}"/> <c:out value="@@{bbsNtt.detailAdres}"/>
			</td>
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
				@@{bbsNtt.nttCn}
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
		</c:otherwise>
	</c:choose>
</#list>
		</tbody>
	</table>

	<div class="row margin_t_30">
		<div class="col-12">
		<c:if test="@@{bbsAuthor.updateBtnAuth}">
			<a href="./updateBbsNttView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered edit">수정</a>
		</c:if>
		<c:if test="@@{bbsAuthor.deleteBtnAuth}">
			<c:if test="@@{bbsNtt.deleteAt eq 'Y'}">
				<a href="./deleteBbsNttForce.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered delete" onclick="fn_deleteBbsNttForce(this.href); return false;">영구삭제</a>
				<a href="./restoreBbsNtt.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered delete" onclick="fn_restoreBbsNtt(this.href); return false;">복원</a>
			</c:if>
			<c:if test="@@{bbsNtt.deleteAt eq 'N'}">
				<a href="./deleteBbsNtt.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered delete" onclick="fn_deleteBbsNtt(this.href); return false;">삭제</a>
			</c:if>
		</c:if>
		<c:if test="@@{VIEW_SE ne 'RTSY03'}">
<#--

			<c:if test="@@{bbsInfo.replySe eq 'RTSY02'}">
				<c:if test="@@{bbsAuthor.replyBtnAuth}">
					<a href="./addBbsNttReplyView.do?key=@@{key}&amp;bbsNo=@@{bbsNttVO.bbsNo}&amp;nttNo=@@{bbsNttVO.nttNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;searchCnd=@@{bbsNttVO.searchCnd}&amp;searchKrwd=@@{bbsNttVO.searchKrwd}&amp;pageIndex=@@{bbsNttVO.pageIndex}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}" class="p-button p-button--bordered reply">답변</a>
				</c:if>
			</c:if>
			<c:if test="@@{bbsInfo.replySe eq 'RTSY03'}">
				<c:if test="@@{bbsAuthor.answerBtnAuth}">
					<a href="./addBbsNttReplyView.do?key=@@{key}&amp;bbsNo=@@{bbsNttVO.bbsNo}&amp;nttNo=@@{bbsNttVO.nttNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;searchCnd=@@{bbsNttVO.searchCnd}&amp;searchKrwd=@@{bbsNttVO.searchKrwd}&amp;pageIndex=@@{bbsNttVO.pageIndex}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}" class="p-button p-button--bordered reply">답변 등록하기</a>
					<!--<a href="./updateBbsNttAnswerView.do?key=@@{key}&amp;bbsNo=@@{bbsNttVO.bbsNo}&amp;nttNo=@@{bbsNttVO.nttNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;searchCnd=@@{bbsNttVO.searchCnd}&amp;searchKrwd=@@{bbsNttVO.searchKrwd}&amp;pageIndex=@@{bbsNttVO.pageIndex}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}" class="p-button p-button--bordered reply">답변</a>&ndash;&gt;
				</c:if>
			</c:if>
-->

			<c:if test="@@{bbsInfo.replySe eq 'RTSY02'}">
				<c:if test="@@{bbsAuthor.replyBtnAuth}">
					<a href="./addBbsNttReplyView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered reply">답변</a>
				</c:if>
			</c:if>
			<c:if test="@@{bbsInfo.replySe eq 'RTSY03'}">
				<c:if test="@@{bbsAuthor.answerBtnAuth}">
			<a href="./addBbsNttReplyView.do<c:out value="@@{paramValue}"/>" class="p-button p-button--bordered reply">답변</a>
				</c:if>
			</c:if>
		</c:if>
		</div>
		<div class="col-12 right">
			<a href="./selectBbsNttList.do<c:out value="@@{paramValue}"/>" class="p-button write">목록<span></span></a>
		</div>
	</div>
	<div class="card card--bgcolor bbs__manage col text_center" style="display:none;z-index:1;" id="delete_pan">
		<form name="bbsNttDelete" id="bbsNttDelete" method="post" onsubmit="return fn_deleteBbsNttOk()" action="./deleteBbsNtt.do<c:out value="@@{paramValue}"/>">
			<fieldset>
				<legend><c:out value="@@{bbs.bbsNm}"/> 게시물삭제</legend>
				<select name="deleteResn" id="deleteResn" class="p-input p-input--auto" title="삭제 사유 선택">
					<c:forEach var="dr" items="@@{deleteResn}" varStatus="status">
						<option value="@@{dr.codeNm}"><c:out value="@@{dr.codeNm}"/></option>
					</c:forEach>
				</select>
				<button type="submit" class="p-button p-button--small darken">게시물삭제</button>
			</fieldset>
		</form>
	</div>
<c:if test="@@{not empty movePrevBbs}">
	<div class="card card--bgcolor bbs__manage col text_center">
		@@{movePrevBbs.bbsNm}에서 관리자에 의해 이동되었습니다.
	</div>
</c:if>
	<c:if test="@@{bbsNttVO.bbsManageMode eq true}">

		<link rel="stylesheet" href="/common/css/chosen.css" />

		<div class="card card--bgcolor bbs__manage text_center">
			<div class="col-auto p-input--auto">
				<form name="bbsNttMove" id="bbsNttMove" method="post" action="./moveBbsNtt.do">
					<fieldset>
						<legend><c:out value="@@{bbs.bbsNm}"/> 게시물이동</legend>
						<input type="hidden" name="key" value="<c:out value="@@{key}"/>"/>
						<input type="hidden" name="bbsNo" value="<c:out value="@@{bbsNttVO.bbsNo}"/>"/>
						<input type="hidden" name="nttNo" value="<c:out value="@@{bbsNttVO.nttNo}"/>"/>
						<input type="hidden" name="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>

						<select name="target" id="target" class="p-input p-input--auto  chosen-select" data-placeholder="이동할 게시판 선택" data-no_results_text="게시판이 존재하지 않습니다." title="이동할 게시판 선택">
							<c:forEach var="si" items="@@{siteList}" varStatus="status">
								<optgroup label="@@{si.siteNm}">
									<c:forEach var="bbs" items="@@{bbsMap[si.siteId]}" varStatus="status">
										<option value="@@{bbs.bbsNo}"><c:out value="@@{bbs.bbsNm}"/></option>
									</c:forEach>
								</optgroup>
							</c:forEach>
						</select>
						<button type="submit" class="p-button p-button--small darken">게시물이동</button>
					</fieldset>
				</form>
			</div>
			<div class="col-auto p-input--auto">
				<form name="bbsNttCopy" id="bbsNttCopy" method="post" action="./copyBbsNtt.do">
					<fieldset>
						<legend><c:out value="@@{bbs.bbsNm}"/> 게시물복사</legend>
						<input type="hidden" name="key" value="<c:out value="@@{key}"/>"/>
						<input type="hidden" name="bbsNo" value="<c:out value="@@{bbsNttVO.bbsNo}"/>"/>
						<input type="hidden" name="nttNo" value="<c:out value="@@{bbsNttVO.nttNo}"/>"/>
						<input type="hidden" name="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>

						<select name="target" id="target2" class="p-input p-input--auto chosen-select" data-placeholder="복사할 게시판 선택" data-no_results_text="게시판이 존재하지 않습니다." title="복사할 게시판 선택" multiple>
							<c:forEach var="si" items="@@{siteList}" varStatus="status">
								<optgroup label="@@{si.siteNm}">
									<c:forEach var="bbs" items="@@{bbsMap[si.siteId]}" varStatus="status">
										<option value="@@{bbs.bbsNo}"><c:out value="@@{bbs.bbsNm}"/></option>
									</c:forEach>
								</optgroup>
							</c:forEach>
						</select>
						<button type="submit" class="p-button p-button--small darken">게시물복사</button>

					</fieldset>
				</form>
			</div>
		</div>

		<script src="/common/js/chosen/chosen.jquery.min.js"></script>
		<script src="/common/js/chosen/prism.js"></script>
		<script src="/common/js/chosen/init.js"></script>
	</c:if>
	<%-- 답변 --%>
	<c:if test="@@{bbsInfo.replySe eq 'RTSY03' || bbsInfo.replySe eq 'RTSY04'}">
		<c:forEach var="bbsNttAnswer" items="@@{answerInfoList}">
			<br />
			<table class="p-table block margin_t_60" data-table="rwd" data-tabletype="block" data-breakpoint="760">
				<caption>${bbs.bbsNm} 답변 내용보기 - 제목, 담당부서, 담당자, 담당연락처, 내용, 첨부파일 정보 제공</caption>
				<colgroup>
					<col class="w15p">
					<col>
				</colgroup>
				<tbody class="p-table--th-left">
				<tr>
					<th style="text-align:center;" colspan="2">답변내용</th>
				</tr>
				<tr>
					<th scope="row">부서명</th>
					<td><c:out value="@@{bbsNttAnswer['answerInfo'].deptNm}"/></td>
				</tr>
				<c:if test="@@{isBbsMng}">
					<tr>
						<th scope="row">작성자</th>
						<td><c:out value="@@{bbsNttAnswer['answerInfo'].writerNm}"/></td>
					</tr>
				</c:if>
				<tr>
					<th scope="row">작성일</th>
					<td>
						<time>
							<c:if test="@@{empty bbsNttAnswer['answerInfo'].lastUpdusrPnttm}">
								@@{tsu:toDateFormat(bbsNttAnswer['answerInfo'].frstRegisterPnttm,'yyyyMMddHHmmss','yyyy-MM-dd')}
							</c:if>
							<c:if test="@@{!empty bbsNttAnswer['answerInfo'].lastUpdusrPnttm}">
								@@{tsu:toDateFormat(bbsNttAnswer['answerInfo'].lastUpdusrPnttm,'yyyyMMddHHmmss','yyyy-MM-dd')}
							</c:if>
						</time>
					</td>
				</tr>
				<tr>
					<td colspan="2" title="내용" class="p-table__content">@@{tsu:autoLink(bbsNttAnswer['answerInfo'].nttCn)}</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<c:if test="@@{!empty bbsNttAnswer['answerAtchmnfl']}">
							<ul class="p-attach">
								<c:forEach var="bbsAtchmnfl" items="@@{bbsNttAnswer['answerAtchmnfl']}">
									<li class="p-attach__item">
										<a href="./downloadBbsFile.do?atchmnflNo=@@{bbsAtchmnfl.atchmnflNo}" class="p-attach__link">
											<span class="p-icon p-icon__<c:out value="@@{bbsAtchmnfl.fileExtsn}"/>"><c:out value="@@{bbsAtchmnfl.fileExtsn}"/> 파일</span>
											<span><c:out value="@@{bbsAtchmnfl.fileNm}"/></span>
											<i class="p-icon p-icon__arrow-circle-down"></i>
										</a>
										<!--<a href="./previewBbsFile.do?atchmnflNo=<c:out value="@@{bbsAtchmnfl.atchmnflNo}"/>" target="_blank" class="p-attach__preview p-button"><i class="p-icon p-icon__search"></i> 미리보기</a>-->
						</li>
		</c:forEach>
		</ul>
	</c:if>
	</td>
	</tr>
	</tbody>
	</table>
	<c:if test="@@{bbsAuthor.answerBtnAuth}">
		<script>
			function fn_deleteBbsNttAnswer(url) {
				if( confirm("답변을 삭제하시겠습니까?") ) {
					window.location = url;
				}
			}
		</script>
		<div class="text_right margin_t_30">
			<a href="./updateBbsNttView.do?key=@@{key}&amp;bbsNo=@@{bbsNttVO.bbsNo}&amp;nttNo=@@{bbsNttAnswer['answerInfo'].nttNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;searchCnd=@@{bbsNttVO.searchCnd}&amp;searchKrwd=@@{bbsNttVO.searchKrwd}&amp;pageIndex=@@{bbsNttVO.pageIndex}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}" class="p-button edit">답변수정</a>
			<a href="./deleteBbsNtt.do?key=@@{key}&amp;bbsNo=@@{bbsNttVO.bbsNo}&amp;nttNo=@@{bbsNttAnswer['answerInfo'].nttNo}&amp;searchCtgry=@@{bbsNttVO.searchCtgry}&amp;searchCnd=@@{bbsNttVO.searchCnd}&amp;searchKrwd=@@{bbsNttVO.searchKrwd}&amp;pageIndex=@@{bbsNttVO.pageIndex}&amp;integrDeptCode=@@{bbsNttVO.integrDeptCode}&amp;replyDelete=Y" onclick="fn_deleteBbsNttAnswer(this.href); return false;" class="p-button delete">삭제</a>
		</div>
	</c:if>
	</c:forEach>
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
		//if( confirm("삭제하시겠습니까?") ) {
			$("#delete_pan").show();
			$("#deleteResn").focus();
			//window.location = url;
		//}
	}

	function fn_deleteBbsNttOk( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			return true;
		}
		return false;
	}
	function fn_deleteBbsNttForce( url ) {
		if( confirm("영구삭제하시겠습니까? 삭제된 게시물은 복구가 불가능합니다.") ) {
			window.location = url;
		}
	}
	function fn_restoreBbsNtt( url ) {
		if( confirm("복원하시겠습니까?") ) {
			window.location = url;
		}
	}


</script>

</body>
</html>