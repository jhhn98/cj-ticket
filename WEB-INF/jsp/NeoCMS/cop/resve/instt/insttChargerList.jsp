<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<div class="p-wrap">

	<table class="p-table p-table--bordered">
        <caption>운영기관 목록 - 번호, 구분, 운영기관명, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:180px">
            <col>
            <col style="width:180px">
            <col>
        </colgroup>
        <tbody class="text_center">
		<tr>
			<th colspan="4">운영기관 담당자 지정</th>
		</tr>
		<tr>
            <th scope="col">구분</th>
            <td scope="col" class="text_left"><c:choose><c:when test="${insttInfo.prgSe eq 'EDU'}">교육</c:when><c:when test="${insttInfo.prgSe eq 'EXP'}">체험</c:when><c:when test="${insttInfo.prgSe eq 'FCT'}">시설</c:when></c:choose></td>
            <th scope="col">운영기관명</th>
            <td scope="col" class="text_left"><c:out value="${insttInfo.insttNm}"/></td>
        </tr>
		</tbody>
	</table>
	<br />

    <div class="row">
        <div class="col-6">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong><c:out value="${fn:length(chargerList)}"/></strong></em>건
				<%/*&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]*/%>
			</span>
        </div>
        <div class="col-18 right">
			<a href="#n" class="p-button p-button--small primary" onclick="fn_popCharger();">담당자지정</a>
		<%/*
            <form:form modelAttribute="insttChargerSearchVO" name="insttSearchVO" method="get">
                <fieldset>
                    <legend>운영기관 검색</legend>
                    <form:hidden path="key"/>
                    <form:hidden path="pageUnit"/>
                    <form:hidden path="pageIndex"/>
                    <form:select path="searchPrgSe" cssClass="p-input p-input--auto" title="구분 선택">
                        <form:option value="" label="구분 선택"/>
                        <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <form:input path="searchKrwd" class="p-input p-input--auto" placeholder="기관명 입력"/>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
		*/%>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>운영기관 목록 - 번호, 구분, 운영기관명, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:300px">
            <col>
            <col style="width:120px">
            <col style="width:100px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">담당자명</th>
            <th scope="col">담당부서명</th>
            <th scope="col">등록일</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:forEach var="result" items="${chargerList}" varStatus="idx">
            <tr>
                <td><c:out value="${idx.index+1}"/></td>
                <td><c:out value="${result.chargerNm}"/> ( <c:out value="${result.chargerId}"/> )</td>
                <td><c:out value="${result.dept}"/></td>
                <td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                <td><a href="./deleteInsttCharger.do?key=<c:out value="${insttChargerSearchVO.key}"/>&amp;chargerNo=<c:out value="${result.chargerNo}"/>&amp;insttNo=<c:out value="${result.insttNo}"/>" class="p-button p-button--xsmall delete" onclick="return fn_delete();">삭제</a></td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(chargerList) eq 0}">
            <tr>
                <td colspan="7">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_t_20">
        <div class="col-24 right">
            <a href="./selectInsttList.do?<c:out value="${insttChargerSearchVO.params}"/>" class="p-button cancel">목록 </a>
        </div>
    </div>
</div>

<script>

    function fn_useYnCheck(insttNo) {
        var para = document.location.href.split("?");
        var url = './updateInsttUseYn.do?' + para[1] + '&insttNo=' + insttNo;
        var chkAt = $('#useYn_' + insttNo).is(":checked");

        if (chkAt) {
            if (confirm("운영여부를 운영으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=Y";
            } else {
                $('#useYn_'+insttNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("운영여부를 미운영으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=N";
            } else {
                $('#useYn_'+insttNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }
	
	function fn_popCharger() {
		var w = 850;
		var h = 500;
		
		// 화면 기준 가운데 좌표 계산
		var left = (window.screen.width  - w) / 2;
		var top  = (window.screen.height - h) / 2;
		
		window.open('./popupInsttCharger.do?insttNo=<c:out value="${insttChargerSearchVO.insttNo}"/>','_charger','width=' + w +',height=' + h +',left=' + left +',top=' + top +',resizable=yes,scrollbars=yes');
	}
</script>
</body>
</html>
