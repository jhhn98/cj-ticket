<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>게시판 카테고리 수정</title>
	<meta name="decorator" content="neo" />
	<script nonce="NEOCMSSCRIPT">
		<c:if test="${!empty message}">
		function fn_check_message() {
			alert("<c:out value='${message}'/>");
			<c:if test="${!empty fieldName}">
			$("#<c:out value="${fieldName}"/>").focus();
			</c:if>
		}
        $(window).on("load", function() {
			fn_check_message();
		});
		</c:if>
		function fn_validateBbsFieldVO( frm ) {
			return true;
		}
	</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 카테고리 수정</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class="current"><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class=""><span>첨부파일필드 관리</span></a>
    <a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="dataWrap">
    <form:form modelAttribute="bbsCategory" name="bbsCategoryForm" action="updateBbsCategory.do" onsubmit="return validateBbsCategory(this)">
        <form:hidden path="bbsNo"/>
        <form:hidden path="bbsCtgryNo"/>
        <input type="hidden" name="pageUnit" value="<c:out value="${bbsCategoryVO.pageUnit}"/>"/>
        <input type="hidden" name="searchCnd" value="<c:out value="${bbsCategoryVO.searchCnd}"/>"/>
        <input type="hidden" name="searchKrwd" value="<c:out value="${bbsCategoryVO.searchKrwd}"/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value="${bbsCategoryVO.pageIndex}"/>"/>
        <table>
            <colgroup>
                <col class="specWidth160px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="col" class="essential_input"><form:label path="ctgryNm">카테고리명</form:label></th>
                <td><form:input path="ctgryNm" size="40"/> <form:errors path="ctgryNm"/></td>
            </tr>
            </tbody>
        </table>

        <div class="arrangementWrap data_button">
            <div class="arrLeft">
                <a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsCategoryVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsCategoryVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsCategoryVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsCategoryVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>

    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        formLabelText();
    })
</script>
</body>
</html>