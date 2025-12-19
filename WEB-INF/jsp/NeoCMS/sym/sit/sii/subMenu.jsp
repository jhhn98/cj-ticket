<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="tab_navigation">
		<a href="./selectSiteInfoList.do" class=" <c:if test="${empty siteInfo.siteSe}">current</c:if>"><span>전체</span></a>
		<c:forEach var="siteSeList" items="${siteSeList}" varStatus="status">
			<a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteSeList.code}"/>" class=" <c:if test="${siteSeList.code eq siteInfo.siteSe}">current</c:if>"><span><c:out value=" ${siteSeList.codeNm}"/></span></a>
		</c:forEach>
		<a href="./selectCmmnDetailCodeList.do?clCode=SYS&codeId=SITE01" class="siteGroup_set"><span>사이트구분설정</span></a>
		<a href="./selectSiteBatchAllList.do" class="allArrangement_site<c:if test="${siteInfo.siteSe eq null}"> current</c:if>"><span>전체 배치</span></a>
        <p>${siteInfo.siteSe}</p>
	</div>