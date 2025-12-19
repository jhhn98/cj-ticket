<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="decorator" content="${siteInfo.siteId}" />
<title>${menuInfo.cntntsNm}</title>
</head>
<body>

<%-- XSS가 생길 수 있으므로 fn:escapeXml을 하여 사용 --%>
<c:set var="integrDeptCode" value="${fn:escapeXml(bbsNttVO.integrDeptCode)}"/>
<c:set var="searchCnd" value="${fn:escapeXml(bbsNttVO.searchCnd)}" />
<c:set var="searchKrwd" value="${fn:escapeXml(bbsNttVO.searchKrwd)}" />
<c:set var="searchCtgry" value="${fn:escapeXml(bbsNttVO.searchCtgry)}" />

<%-- 인코딩 --%>
<c:set var="encIntegrDeptCode" value="${tsu:encode(bbsNttVO.integrDeptCode,'UTF-8')}"/>
<c:set var="encSearchCnd" value="${tsu:encode(bbsNttVO.searchCnd,'UTF-8')}" />
<c:set var="encSearchKrwd" value="${tsu:encode(bbsNttVO.searchKrwd,'UTF-8')}" />
<c:set var="encSearchCtgry" value="${tsu:encode(bbsNttVO.searchCtgry,'UTF-8')}" />

<div class="p-wrap bbs bbs__form">
	
	<div class="p-table__guide form">
        <span class="p-table__guide-icon"></span>
        <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
    </div>
	
	<c:set var="url">?key=<c:out value="${key}"/>&bbsNo=<c:out value="${bbsNttVO.bbsNo}"/>&nttNo=<c:out value="${bbsNttVO.nttNo}"/>&searchCtgry=${encSearchCtgry}&searchCnd=${encSearchCnd}&searchKrwd=${encSearchKrwd}&pageIndex=${bbsNttVO.pageIndex}&integrDeptCode=${encIntegrDeptCode}</c:set>
	
	<form name="passwdForm" id="passwdForm" method="post" action="${url}" onsubmit="return passwdFormSubmit(this)">
	<fieldset>
	<table class="p-table mobile block form">
		<caption>게시물 비밀번호 입력</caption>
		<colgroup>
			<col class="w15p">
			<col>
		</colgroup>
		<tbody class="p-table--th-left">
		<tr>
			<th scope="row"><label class="p-form__label" for="passwd">비밀번호</label> <span class="p-form__required--icon">필수</span></th>
			<td><input type="password" name="passwd" id="passwd" class="p-input" style="width:200px" maxlength="20" required="true"></td>
		</tr>
		</tbody>
	</table>
	
	<div class="text_right margin_t_30">
		<a href="#n" class="p-button cancel" onclick="history.back();">취소</a>
		<input type="submit" class="p-button write" value="확인">
	</div>
	</fieldset>
	</form>
	
</div>

<script src="/common/js/default.js"></script>
<script>
	function passwdFormSubmit(frm) {
		if( !Trim(frm.passwd.value) ) {
			alert("비밀번호를 입력해 주세요");
			frm.passwd.focus();
			return false;
		}

		return true;
	}
</script>

</body>
</html>