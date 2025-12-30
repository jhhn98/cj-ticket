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
	
	<form:form modelAttribute="hldyInfo" name="hldyInfo" method="post" action="./addHldyInfo.do" onsubmit="return fn_addHldyInfo(this)">
	<fieldset>
	<input type="hidden" name="key" id="key1" value="<c:out value="${hldyInfoSearchVO.key}"/>"/>
	<input type="hidden" name="searchInstt" id="searchInstt1" value="<c:out value="${hldyInfoSearchVO.searchInstt}"/>"/>
	<table class="p-table p-table--bordered">
		<colgroup>
            <col style="width:150px">
            <col>
		</colgroup>
		<tbody>
		<tr>
			<th>공휴일명</th>
			<td><form:input path="hldyNm" style="width:450px;" class="p-input p-input--auto" /></td>
		</tr>
		<tr>
			<th>공휴일 설정</th>
			<td>
				<div class="p-form-group w20p">
					<span class="p-form-checkbox">
						<input type="checkbox" name="eveyrAt" id="eveyrAt" class="p-form-checkbox__input" value="Y"><label for="eveyrAt" class="p-form-checkbox__label">매년적용</label>
					</span> &nbsp; 
					
					<select name="insttNo" id="insttNo" class="p-input p-input--auto">
				<c:if test="${loginVO.userSe eq 'ADMIN'}">
						<option value="0">기관 선택(공통)</option>
				</c:if>
				<c:forEach var="item" items="${insttList}">
						<option value="<c:out value="${item.insttNo}"/>"><c:out value="${item.insttNm}"/></option>
				</c:forEach>
					</select> &nbsp; 
					<form:input path="bgnde" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" readonly="true"/>
					<span class="p-input__addon">
						<button type="button" class="p-input__item" title="시작일 선택" onclick="getCalendar(document.hldyInfo.bgnde);">
							<svg width="14" height="16" fill="#888" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use></svg>
						</button>
					</span> &nbsp;~&nbsp; 
					<form:input path="endde" style="width:100px;" class="p-input p-input--auto" placeholder="yyyy-MM-dd" readonly="true"/>
					<span class="p-input__addon">
						<button type="button" class="p-input__item" title="종료일 선택" onclick="getCalendar(document.hldyInfo.endde);">
							<svg width="14" height="16" fill="#888" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#calendar-alt"></use></svg>
						</button>
					</span> &nbsp; 
					<input value="공휴일 등록하기" type="submit" class="p-button p-button--small primary">
				</div>
			</td>
		</tr>
		</tbody>
	</table>
	</fieldset>
	</form:form>
	<br />
	
    <div class="row">
        <div class="col-6">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong><c:out value="${paginationInfo.totalRecordCount}"/></strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>
        <div class="col-18 right">
			 <form:form modelAttribute="hldyInfoSearchVO" name="hldyInfoSearchVO" method="get">
                <fieldset>
                    <legend>운영기관 검색</legend>
                    <form:hidden path="key"/>
                    <form:hidden path="pageUnit"/>
                    <form:hidden path="pageIndex"/>
                    <form:select path="searchInstt" cssClass="p-input p-input--auto" title="기관 선택">
                        <form:option value="" label="기관 선택"/>
						<form:option value="0" label="공통 공휴일"/>
                        <form:options items="${insttList}" itemValue="insttNo" itemLabel="insttNm"/>
                    </form:select>

                    <form:input path="searchKrwd" class="p-input p-input--auto" placeholder="공휴일명 입력"/>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>운영기관 목록 - 번호, 구분, 운영기관명, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:200px">
			<col>
			<col style="width:120px">
            <col style="width:300px">
			<col style="width:150px">
			<col style="width:120px">
            <col style="width:100px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">기관구분</th>
			<th scope="col">공휴일명</th>
            <th scope="col">매년적용여부</th>
			<th scope="col">공휴일 기간</th>
			<th scope="col">사용여부</th>
			<th scope="col">등록일</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
		<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="item" items="${hldyInfoList}" varStatus="idx">
            <tr>
                <td><c:out value="${currentPageStartNo}"/></td>
                <td><c:choose><c:when test="${item.insttNo eq 0}">공통 공휴일</c:when><c:otherwise><c:out value="${insttMap[item.insttNo]}"/></c:otherwise></c:choose></td>
                <td class="text_left"><c:out value="${item.hldyNm}"/></td>
                <td><c:out value="${item.eveyrAt}"/></td>
				<td>
				<c:choose>
					<c:when test="${item.eveyrAt eq 'Y' && item.bgnde eq item.endde}"><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','MM-dd')}"/></c:when>
					<c:when test="${item.eveyrAt eq 'Y'}"><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','MM-dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.endde,'yyyyMMdd','MM-dd')}"/></c:when>
					<c:when test="${item.bgnde eq item.endde}"><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','yyyy-MM-dd')}"/></c:when>
					<c:otherwise><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','yyyy-MM-dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.endde,'yyyyMMdd','yyyy-MM-dd')}"/></c:otherwise>
				</c:choose>
				</td>
				<td>
			<c:choose>
				<c:when test="${item.insttNo eq '0' && loginVO.userSe ne 'ADMIN'}">
					<c:choose>
						<c:when test="${item.useYn eq 'Y'}">사용함</c:when>
						<c:otherwise>사용안함</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<span class="p-switcher p-switcher--single">
                        <input id="useYn_<c:out value="${item.hldyNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${item.useYn eq 'Y'}"> checked</c:if> value="Y" onchange="fn_useYnCheck(<c:out value="${item.hldyNo}"/>)">
                        <label for="useYn_<c:out value="${item.hldyNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">사용</em></label>
                    </span>
				</c:otherwise>
			</c:choose>
				</td>
				<td><c:out value="${item.frstRegisterPnttmYMD}"/></td>
                <td>
				<c:if test="${(item.insttNo eq '0' && loginVO.userSe eq 'ADMIN') || item.insttNo ne '0'}">
					<a href="./deleteHldyInfo.do?<c:out value="${hldyInfoSearchVO.params}"/>&amp;hldyNo=<c:out value="${item.hldyNo}"/>" class="p-button p-button--xsmall delete" onclick="return fn_deleteHldy(this.href);">삭제</a>
				</c:if>
				</td>
            </tr>
			<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(hldyInfoList) eq 0}">
            <tr>
                <td colspan="8">등록된 정보가 없습니다</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    
    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectHldyInfoList.do?${hldyInfoSearchVO.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
    <div class="text_right">
        &nbsp;
    </div>
	
	${closeDayList}
	
</div>

<script>
	function fn_addHldyInfo(obj) {
		if( !obj.hldyNm.value || obj.hldyNm.value.trim().length == 0 ) {
			alert("공휴일명을 입력해 주세요");
			obj.hldyNm.value = '';
			obj.hldyNm.focus();
			return false;
		}
		
		if( !obj.bgnde.value ) {
			alert("시작일을 선택해 주세요");	
			return false;
		}
		
		if( !obj.endde.value ) {
			alert("종료일을 선택해 주세요");
			return false;
		}
		
		if( obj.bgnde.value > obj.endde.value ) {
			alert("시작일, 종료일 정보가 올바르지 않습니다.");
			return false;
		}
		
		return true;
	}
	
    function fn_useYnCheck(hldyNo) {
        var obj = $('#useYn_' + hldyNo);
		var isChecked = obj.is(':checked');
		var chkVal;
		
        if (isChecked) {
            if( !confirm("사용여부를 사용으로 변경 하시겠습니까?") ) {
                obj.prop('checked', false);
                return false;
            }
			chkVal = "Y";
        } else {
            if( !confirm("사용여부를 미사용으로 변경 하시겠습니까?") ) {
				obj.prop('checked', true);
                return false;
            }
			chkVal = "N";
        }
		
		$.ajax({
			url: './jsonHldyInfoUseYn.do',
			data	: {'hldyNo' : hldyNo, 'useYn':chkVal},
			cache : false,
			type : "POST",
			dataType : "text",
			success: function (result) {
				if( result == "\"false\"") {
					if( chkVal == "Y" ) obj.prop('checked', false);
					else  obj.prop('checked', true);
				}
			},
			error:function(request,status,error) {
				if( chkVal == "Y" ) obj.prop('checked', false);
				else  obj.prop('checked', true);
				alert("사용여부 변경에 실패하였습니다.");
			}
		});
    }

    function fn_deleteHldy() {
        return confirm("삭제하시겠습니까?");
    }
</script>
</body>
</html>
