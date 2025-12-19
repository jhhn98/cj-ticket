<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_2" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 스킨관리 목록</title>
<meta name="decorator" content="neo" />
<script src="/common/js/spin.js"></script>
<script nonce="NEOCMSSCRIPT">
    function fn_changeSite( val ) {
        window.location = "./selectBbsSkinList.do?siteId=" + val;
    }
</script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_board">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">게시판스킨</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title">스킨관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title">목록</span>
</div>
<div class="contents">
    <script nonce="NEOCMSSCRIPT">
        function fn_deleteBbsSkin( url ) {
            if( confirm("삭제하시겠습니까?") ) {
                window.location = url;
            }
        }
    </script>
    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text">등록된 스킨 수 : <c:out value="${fn:length(bbsSkinList)}"/>건</span>
        </div>
        <div class="arrRight">
        </div>
    </div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth40px"/>
                        <col class="specWidth80px"/>
                        <col/>
                        <col class="specWidth80px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">스킨ID</th>
                        <th scope="col">스킨이름</th>
                        <th scope="col">등록일</th>
                        <th scope="col">FTL편집</th>
                        <th scope="col">설정</th>
                        <th scope="col">배치</th>
                        <%--<th scope="col">수정</th>--%>
                        <th scope="col">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="sNumber" value="${fn:length(bbsSkinList)}" />
                    <c:forEach var="result" items="${bbsSkinList}" varStatus="status">
                        <tr data-display="true">
                            <td class="textARight"><c:out value="${sNumber}"/></td>
                            <td class="textACenter"><c:out value="${result.skinId}"/></td>
                            <td><a href="./updateBbsSkinView.do?skinId=<c:out value="${result.skinId}"/>" class="iconTextLink edit"><c:out value="${result.skinNm}"/></a></td>
                            <td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                            <td class="textACenter"><a href="./updateSkinEditorView.do?skinId=<c:out value="${result.skinId}"/>&ftlName=list" class="iconTextButton edit small"><span>FTL수정</span></a></td>
                            <td class="textACenter"><a href="./updateBbsSkinInfoView.do?skinId=<c:out value="${result.skinId}"/>" class="iconTextButton set small"><span>설정</span></a></td>
                            <td class="textACenter"><a href="./batchBbsSkin.do?skinId=<c:out value="${result.skinId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                            <%--<td class="textACenter"><a href="./updateBbsSkinView.do?skinId=<c:out value="${result.skinId}"/>" class="iconTextButton edit small"><span>수정</span></a></td>--%>
                            <td class="textACenter"><a href="./deleteBbsSkin.do?skinId=<c:out value="${result.skinId}"/>" onclick="fn_deleteBbsSkin(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
                        </tr>
                        <c:set var="sNumber" value="${sNumber-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(bbsSkinList) == 0}">
                        <tr>
                            <td colspan="7" class="textACenter">등록된 스킨이 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
        </div>
        <div class="arrRight">
            <a href="./addBbsSkinView.do" class="iconTextButton write"><span>등록</span></a>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>
