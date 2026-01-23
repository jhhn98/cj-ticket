<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>NEO Administrator - UserInfo</title>
	<meta name="decorator" content="neo" />


	<script nonce="NEOCMSSCRIPT">
		function fn_deleteUserInfo(url) {
			if( confirm("선택한 사용자를 삭제 하시겠습니까?") ) {
				window.location = url;
			}
		}
	</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_user">사용자관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">사용자 관리</span>
</div>
<div class="tab_navigation">
	<a href="/neo/selectUserInfoList.do" class="current"><span>사용자 관리</span></a></li>
	<a href="/neo/selectIndvdlinfoHistList.do"><span>개인정보처리이력</span></a></li>
	<%--<a href="/neo/selectUserForceLoginHistList.do"><span>개별로그인이력</span></a></li>--%>
	<a href="/neo/updateUserConfigView.do"><span>사용자 정보 설정 관리</span></a></li>
</div>

<div class="contents is_tab">

	<div class="arrangementWrap data_info">
		<div class="arrLeft">
            <span class="table_text">총 : ${paginationInfo.totalRecordCount} 명</span>
            <span class="table_text">Page : ${paginationInfo.currentPageNo} / ${paginationInfo.totalPageCount}</span>
		</div>
		<div class="arrRight">
            <form:form modelAttribute="userInfoVO" name="searchForm" method="get">
                <div class="table_search">
                    <%-- 토글. 설정 onoff
                    <span class="srch_element toggle">
                        <label for="toggle_test">검색어 포함</label>
                        <input type="checkbox" id="toggle_test"/>
                        <span class="toggle_ui">포함여부</span>
                    </span>
                    --%>
                    <span class="srch_element select">
                        <form:select path="pageUnit" cssClass="select">
                            <form:option value="10">10 페이지</form:option>
                            <form:option value="20">20 페이지</form:option>
                            <form:option value="30">30 페이지</form:option>
                            <form:option value="40">40 페이지</form:option>
                            <form:option value="50">50 페이지</form:option>
                        </form:select>
                    </span>
					<span class="srch_element select">
                        <form:select path="searchCntc" cssClass="select">
                            <form:option value="">연계구분</form:option>
							<form:option value="N">일반</form:option>
                            <form:option value="Y">연계</form:option>
                        </form:select>
                    </span>
                    <span class="srch_element select">
                        <form:select path="searchCnd" cssClass="select">
                            <form:option value="all">전체</form:option>
                            <form:option value="userId">아이디</form:option>
                            <form:option value="userNm">이름</form:option>
                            <form:option value="email">이메일</form:option>
                            <form:option value="deptNm">부서명</form:option>
                        </form:select>
                    </span>
                    <span class="srch_element text">
                        <form:input path="searchKrwd" cssClass="input_text" placeholder="검색어 입력"/>
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="search_button">검색</button>
                    </span>
					<span class="srch_element text">
						<%--<a href="./getGmuserInfoListTxt.do" class="iconTextButton write" onclick="fn_gmuserInfoSubmit(this.href);return false;"><span>직원정보 업데이트(파일)</span></a>--%>
						<a href="./getGmuserInfoList.do" class="iconTextButton write" onclick="fn_gmuserInfoSubmit(this.href);return false;"><span>직원정보 업데이트(주소)</span></a>
					</span>
                </div>
            </form:form>
		</div>
	</div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth30px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth110px"/>
                        <col class="specWidth100px"/>
                        <col class="specWidth110px"/>
                        <col class="specWidth100px"/>
                        <col class="specWidth100px"/>
                        <col class="specWidth100px"/>
                        <col class="specWidth60px"/>
                        <%--<col class="specWidth60px"/>--%>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">아이디</th>
                        <th scope="col">구분</th>
                        <th scope="col">부서</th>
                        <th scope="col">부서코드</th>
                        <th scope="col">이름</th>
                        <th scope="col">직원코드</th>
                        <th scope="col">이메일</th>
                        <th scope="col">로그인실패횟수</th>
                        <th scope="col">가입일</th>
                        <th scope="col">접속로그</th>
                        <%--<th scope="col">로그인</th>--%>
                        <th scope="col">수정</th>
                        <th scope="col">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="${userInfoList}" varStatus="status">
                        <tr data-display="true">
                            <td class="textARight"><c:out value="${currentPageStartNo}"/></td>
                            <td class="textACenter"><c:out value="${result.userId}"/></td>
                            <td class="textACenter"><c:out value="${userSeMap[result.userSe]}"/></td>
                            <td><c:if test="${!empty result.deptNm}"><c:out value="${result.deptNm}"/></c:if></td>
                            <td><c:if test="${!empty result.deptCode }">
                                    <c:if test="${!empty result.deptNm }"><a href="departmentTreeView.do?call_deptcode=<c:out value="${result.deptCode}"/>" class="iconTextButton department"><span><c:out value="${result.deptCode}"/></span></a></c:if>
                                    <c:if test="${ empty result.deptNm }"><a href="#n" onclick="alert('부서정보가 변경 혹은 삭제되어 일치하는 부서정보를 찾을 수 없습니다.')" class="iconTextButton delete"><span><c:out value="${result.deptCode}"/></span></a></c:if>
                                </c:if>
                            </td>
                            <td><c:out value="${result.userNm}"/></td>
                            <td><c:if test="${!empty result.emplCode }">
                                    <c:if test="${!empty result.emplCheck }"><a href="departmentTreeView.do?call_deptcode=<c:out value="${result.deptCode}"/>&call_emplcode=<c:out value="${result.emplCode}"/>" class="iconTextButton user_code"><span><c:out value="${result.emplCode}"/></span></a></c:if>
                                    <c:if test="${ empty result.emplCheck }"><a href="#n" onclick="alert('직원정보가 변경 혹은 삭제되어 일치하는 직원정보를 찾을 수 없습니다.')" class="iconTextButton delete"><span><c:out value="${result.emplCode}"/></span></a></c:if>
                                </c:if>
                            </td>
                            <td><c:out value="${result.email}"/></td>
                            <td class="textACenter"><c:out value="${result.loginFailCnt}"/>
                                <a onclick="return pwdBanReset(this.href);" href="./userInfoFailedReset.do?userId=<c:out value="${result.userId}"/>&amp;call=list&amp;pageUnit=<c:out value="${userInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${userInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${userInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${userInfoVO.pageIndex}"/>" class="iconButton refresh small marginLeft_10"><span>초기화</span></a></td>
                            <td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                            <td class="textACenter"><a href="./selectUserLoginHistList.do?userId=<c:out value="${result.userId}"/>&amp;pageUnit=<c:out value="${userInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${userInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${userInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${userInfoVO.pageIndex}"/>" class="iconButton view"><span>로그인이력</span></a></td>
                            <%--<td class="textACenter"><a href="./forceLogin.do?userId=<c:out value="${result.userId}"/>" class="iconButton login"><span>개별로그인</span></a></td>--%>
                            <td class="textACenter"><a href="./updateUserInfoView.do?userId=<c:out value="${result.userId}"/>" class="iconButton userEdit"><span>수정</span></a></td>
                            <td class="textACenter"><a href="./deleteUserInfo.do?userId=<c:out value="${result.userId}"/>" class="iconButton userDelete" onclick="fn_deleteUserInfo(this.href); return false;"><span>삭제</span></a></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(userInfoList) == 0}">
                        <tr>
                            <td colspan="100%" class="textACenter">검색된 회원정보가 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectUserInfoList.do?pageUnit=${tsu:xssLinkFilter(userInfoVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(userInfoVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(userInfoVO.searchKrwd)}&amp;searchCntc=${tsu:xssLinkFilter(userInfoVO.searchCntc)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
			<a href="./addUserInfoView.do" class="iconTextButton write"><span>등록</span></a>
            <a href="./downloadXlsUserInfoList.do?searchCnd=${tsu:xssLinkFilter(userInfoVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(userInfoVO.searchKrwd)}" class="marginLeft_5 iconTextButton download"><span>엑셀로 내려받기</span></a>

		</div>
	</div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
    function pwdBanReset(url) {
        if(confirm("해당 사용자의 로그인 실패 횟수를 초기화 하시겠습니까?")){
            location.href = url;
            return true;
        }
        return false;
    }

	function fn_gmuserInfoSubmit(url) {
		if( !confirm("직원정보를 업데이트 하시겠습니까?") ) {
			return false;
		}
		
		location.href = url;
	}
</script>
</body>
</html>
