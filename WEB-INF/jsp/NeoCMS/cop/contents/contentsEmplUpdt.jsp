<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>



<!DOCTYPE html>
<html lang="ko">
<head>
<title><c:out value="${menuInfo.cntntsNm}"/> 담당자 변경</title>
<meta name="decorator" content="<c:out value="${menuInfo.siteId}"/>" />
</head>
<body> 

<div class="p-wrap">
	<div class="col-20">
		<div>
			<svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
      <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
    </div>
		
		<form name="contentsEmpl" id="contentsEmpl" action="updateContentsEmpl.do">
		<fieldset>
    <legend><c:out value="${menuInfo.cntntsNm}"/> 담당자 변경</legend>
    <input type="hidden" name="key" value="<c:out value="${param.key}"/>"/>
    <input type="hidden" name="menuNo" value="<c:out value="${param.menuNo}"/>"/>
    <c:forEach var="result" items="${contentsSearchVO.paramsMap}">
    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>

		<table class="p-table">
			<caption><c:out value="${menuInfo.cntntsNm}"/> 담당자 변경</caption>
			<colgroup>
				<col class="w20p">
				<col />
			</colgroup>
			<tbody class="p-table--th-left">
      <tr>
				<th scope="row">사이트명</th>
        <td>${siteInfo.siteNm}</td>
			</tr>
      <tr>
				<th scope="row">메뉴명</th>
        <td>${menu.menuNm}</td>
			</tr>
      <tr>
				<th scope="row">메뉴 경로</th>
				<td>
					<a href="/${menu.siteId}/sub.do?key=${menu.menuNo}" title="새창" target="_blank">
					<c:set var="arrMenuNavi" value="${fn:split(menu.navi,'^')}"/>
					<c:forEach var="result" items="${arrMenuNavi}" varStatus="idx">
					<c:set var="arrNavi" value="${fn:split(result,'|')}"/>
						${arrNavi[1]}<c:if test="${!idx.last}"> &gt; </c:if>
					</c:forEach>
					</a>
				</td>
			</tr>
			<tr>
				<th scope="row">담당부서</th>
				<td><c:out value="${menu.deptNm}"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="emplNm" class="p-form__label">담당자 이름</label></th>
				<td><input type="text" name="emplNm" id="emplNm" value="<c:out value="${menu.emplNm}"/>" style="width:200px" class="p-input"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="emplTelno" class="p-form__label">연락처</label></th>
				<td><input type="text" name="emplTelno" id="emplTelno" value="<c:out value="${menu.emplTelno}"/>" style="width:200px" class="p-input"/></td>
			</tr>
			</tbody>
		</table>
		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectContentsList.do?<c:out value="${contentsSearchVO.params}"/>&amp;key=<c:out value="${param.key}"/>" class="p-button cancel">목록 </a>
      </div>
      <div class="col-12 right">
				<input type="submit" class="p-button write" value="수정">
      </div>
		</div>
    </fieldset>
    </form>
	
	</div>
</div>

</body>
</html>