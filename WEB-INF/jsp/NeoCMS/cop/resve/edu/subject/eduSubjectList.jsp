<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>과목 관리 목록</title>
</head>
<body>

<div class="p-wrap">
    <div class="row p-relative">
        <div class="col-6 margin_t_5">
            <a href="?key=${key}" title="목록 초기화">
                <span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###"/></strong> 건</span>
                <span class="division_line">[ <strong><c:out value="${paginationInfo.currentPageNo}"/></strong> / <c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
            </a>
        </div>
        <div class="col-18 right">
            <form id="schSubjectFrm" method="get" action="/${menuInfo.siteId}/selectEduSubjectList.do">
                <fieldset>
                    <legend>과목 검색</legend>
                    <input type="hidden" name="key" value="${key}"/>
                    <select name="searchInsttNo" onchange="insttIdChange(this.value)" class="p-input p-input--auto">
                        <option value="">기관선택</option>
                        <c:forEach var="instt" items="${eduInsttList}">
                            <option value="${instt.insttNo}"${instt.insttNo eq eduSubjectVO.searchInsttNo ? ' selected="true"':''}><c:out value="${instt.insttNm}"/></option>
                        </c:forEach>
                    </select>
                    <select id="searchCtgryNo" name="searchCtgryNo" onchange="this.form.submit()" class="p-input p-input--auto">
                        <option value="">카테고리선택</option>
                    </select>
                    <input name="searchSubjectNm" value="${eduSubjectVO.searchSubjectNm}" title="검색어 입력" placeholder="검색어 입력" class="p-input p-input--auto"/>
                    <button type="submit" class="p-button p-button--small primary">검색</button>
                </fieldset>
            </form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption><c:out value="${menuInfo.cntntsNm}"/> 목록 - 번호, 기관명, 카테고리명, 과목명, 재수강제한횟수, 사용여부, 관리</caption>
        <colgroup>
            <col class="w60"/>
            <col />
            <col class="w240"/>
            <col />
            <col class="w120"/>
            <col class="w130"/>
            <col class="w110"/>
            <col class="w100"/>
            <col class="w140"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">기관명</th>
            <th scope="col">카테고리명</th>
            <th scope="col">과목명</th>
            <th scope="col">수강료</th>
            <th scope="col">재수강<br/>제한횟수</th>
            <th scope="col">사용여부</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="pageNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${eduSubjectList}" varStatus="status">
            <tr class="colored">
                <td><c:out value="${pageNo}"/></td>
                <td><c:out value="${result.insttNm}"/></td>
                <td><c:out value="${result.ctgryNm}"/></td>
                <td class="p-subject"><c:out value="${result.subjectNm}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${result.chrgeSe eq 'F'}">무료</c:when>
                        <c:otherwise><fmt:formatNumber value="${result.eduAmt}" pattern="#,###"/></c:otherwise>
                    </c:choose>
                </td>
                <td><b><c:out value="${result.retakeCnt}"/></b>회</td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input type="checkbox" class="p-switcher__input" id="useYn${result.subjectNo}"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="${result.subjectNo}" onchange="fn_useYn(this, '${result.subjectNo}', '${result.useYn}')">
                        <label for="useYn${result.subjectNo}" class="p-switcher__label"><em class="p-switcher__text blind">사용</em></label>
                    </span>
                </td>
                <td>
                    <a href="./updateEduSubjectView.do?subjectNo=${result.subjectNo}&amp;<c:out value="${eduSubjectVO.params}"/>" class="p-button p-button--xsmall edit">수정</a>
                    <a href="./deleteEduSubject.do?subjectNo=${result.subjectNo}&amp;<c:out value="${eduSubjectVO.params}"/>" onclick="fn_delete(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
                </td>
            </tr>
            <c:set var="pageNo" value="${pageNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(eduSubjectList) == 0}">
            <tr>
                <td colspan="9" class="empty">등록된 정보가 없습니다</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_t_10">
        <div class="col-4"></div>
        <div class="col-16 center">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduSubjectList.do?${fn:escapeXml(eduSubjectVO.paramsExclPi)}&amp;pageIndex=" />
        </div>
        <div class="col-4 right">
            <a href="./addEduSubjectListView.do?<c:out value="${eduSubjectVO.params}"/>"  class="p-button primary">등록</a>
        </div>
    </div>

</div>

<script nonce="NEOCMSSCRIPT">
    //기관명선택 이벤트
    function insttIdChange(val) {
        var isVal = false;
        $('#searchCtgryNo').empty();
        $('#searchCtgryNo').append('<option value="">선택하세요</option>');
        <c:forEach var="result" items="${eduCategoryList}">
        if(val == "${result.insttNo}" ){
            var option = $("<option value=\"${result.ctgryNo}\"${result.ctgryNo eq eduSubjectVO.searchCtgryNo ? ' selected':''}>${result.ctgryNm}</option>");
            $('#searchCtgryNo').append(option);
            isVal = true;
        }
        </c:forEach>
        if(!isVal){
            $('#searchCtgryNo').empty();
            $('#searchCtgryNo').append('<option value="">카테고리 없음</option>');
            $('#searchCtgryNo').attr("disabled", true);
        } else {
            $('#searchCtgryNo').attr("disabled", false);
        }
        var selitem = '<c:out value="${eduSubjectVO.searchInsttNo}"/>';
        if(selitem != val){
            document.getElementById('schSubjectFrm').submit();
        }
    }

    //사용여부 변경
    function fn_useYn(el, subjectNo, useYn){
        var newUseYn = el.checked ? 'Y' : 'N';

        $.ajax({
            url: './ajaxEduSubjectUseYn.do?key=${key}',
            type: 'POST',
            cache: false,
            data: {"subjectNo":subjectNo, "useYn":newUseYn},
            success: function (res) {
                if(res == 1) alert("변경되었습니다.");
                else if(res == 2) alert("잘못된 접근입니다.");
                else if(res == 0) alert("변경에 실패하였습니다.");
                $('.p-wrap').load(location.href+' .p-wrap');
            },
            error: function (request,xhr, status) {
                alert("에러가 발생하였습니다.");
                $('.p-wrap').load(location.href+' .p-wrap');
            }
        });
    }

    function fn_delete( url ) {
        if( confirm("한 번 삭제한 정보는 복구할 수 없습니다.\n해당 프로그램을 정말 삭제하시겠습니까?") ) {
            window.location = url;
        }
    }

    $(document).ready(function() {
        //분류 트리거
        <c:if test="${!empty eduSubjectVO.searchInsttNo}">insttIdChange('<c:out value="${eduSubjectVO.searchInsttNo}"/>');</c:if>
    });
</script>
</body>
</html>