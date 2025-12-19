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
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta name="keywords" content="담당자 확인" />
    <meta name="description" content="담당자 확인" />
	<link rel="stylesheet" href="/common/css/font.css" />
    <link rel="stylesheet" href="/common/css/default.css" />
    <link rel="stylesheet" href="/site/staff/css/common.css" />
    <link rel="stylesheet" href="/site/staff/css/program.css" />
	<title>담당자 확인</title>
</head>
<body>

<div class="contents">

	<div class="row">
        <div class="col-6">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong><c:out value="${fn:length(userInfoList)}"/></strong></em>건
			</span>
        </div>
        <div class="col-18 right">
            <form:form modelAttribute="userInfoVO" name="userInfoVO" method="get">
                <fieldset>
                    <legend>운영기관 검색</legend>
					<input type="hidden" name="insttNo" id="insttNo" value="<c:out value="${insttChargerSearchVO.insttNo}"/>"/>
					<form:hidden path="searchCnd" value="userNm" />
                    <form:input path="searchKrwd" class="p-input p-input--auto" placeholder="담당자명 입력" style="width:150px;"/>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
        </div>
    </div>
	
    <table class="p-table p-table--bordered">
        <caption>운영기관 목록 - 번호, 구분, 운영기관명, 사용여부 등 제공</caption>
        <colgroup>
			<col style="width:100px">
            <col style="width:100px">
            <col>
            <col style="width:180px">
            <col style="width:90px">
        </colgroup>
        <thead>
        <tr>
			<th scope="col">아이디</th>
            <th scope="col">담당자명</th>
            <th scope="col">부서명</th>
			<th scope="col">이메일</th>
            <th scope="col">비고</th>
        </tr>
        </thead>
        <tbody class="text_center">
		<c:forEach var="item" items="${userInfoList}">
		<tr>
			<td><c:out value="${item.userId}"/></td>
			<td><c:out value="${item.userNm}"/></td>
			<td class="text_left"><c:out value="${item.gmDeptFullNm}"/></td>
			<td><c:out value="${item.email}"/></td>
			<td><a href="./addInsttCharger.do?insttNo=<c:out value="${insttChargerSearchVO.insttNo}"/>&amp;chargerId=<c:out value="${item.userId}"/>" class="p-button p-button--xsmall info" onclick="fn_addCharger(this.href);return false;">담당자지정</a></td>
		</tr>
		</c:forEach>
		<c:if test="${!empty userInfoVO.searchKrwd && empty userInfoList}">
		<tr>
			<td colspan="5">검색된 정보가 없습니다.</td>
		</tr>
		</c:if>
		<c:if test="${empty userInfoVO.searchKrwd}">
		<tr>
			<td colspan="5">검색어를 입력하세요</td>
		</tr>
		</c:if>
		</tbody>
	</table>

</div>

<script>
	function fn_addCharger(url) {
		if( !confirm("담당자로 지정하시겠습니까?") ) {
			return false;
		}
		
		location.href = url;
	}
</script>

</body>
</html>