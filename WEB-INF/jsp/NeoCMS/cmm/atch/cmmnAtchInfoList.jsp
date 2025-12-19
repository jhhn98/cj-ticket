<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="ATC_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>공통청부파일 관리 목록</title>
<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_attch">첨부파일설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">공통첨부파일관리</span>
</div>

<script nonce="NEOCMSSCRIPT">
    function fn_delete( url ) {
        return confirm("삭제하시겠습니까?");
    }
</script>


<div class="contents">

    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text">등록수 : <c:out value="${paginationInfo.totalRecordCount}"/>건</span>
        </div>
        <div class="arrRight"></div>
    </div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth100px"/>
                        <col/>
                        <col class="specWidth150px"/>
                        <col class="specWidth90px"/>
                        <col class="specWidth90px"/>
                        <col class="specWidth150px"/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">코드</th>
                        <th scope="col">명칭</th>
                        <%-- <th scope="col">설명</th> --%>
                        <th scope="col">저장경로</th>
                        <th scope="col">사이즈(MB)</th>
                        <th scope="col">첨부파일수</th>
                        <th scope="col">허용 확장자</th>
                        <th scope="col">관리</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:forEach var="result" items="${results}" varStatus="status">
                    <tr data-display="true">
                        <td><a href="./cmmnAtchInfoView.do?infoCode=<c:out value="${result.infoCode }"/>&amp;pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.infoCode }"/></a></td>
                        <td><c:out value="${result.infoNm }"/></td>
                        <%-- <td class="textALeft" ><c:out value="${result.infoDc }"/></td> --%>
                        <td class="textALeft"><span class="eng_text"><c:out value="${result.storePath }"/></span></td>
                        <td><span class="eng_text"><c:out value="${result.fileMaxSize }"/>MB</span></td>
                        <td><c:out value="${result.fileMaxCo }"/></td>
                        <td class="textALeft"><span class="eng_text"><c:out value="${result.fileLmttExtns }"/></span></td>
                        <td>
                            <a href="./cmmnAtchInfoUpdtView.do?infoCode=<c:out value="${result.infoCode }"/>&amp;pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconButton edit marginLeft_5 marginRight_5"><span>수정</span></a>
                            <c:if test="${result.infoCode ne 'MENU_CNTNS'}">
                                <a href="./cmmnAtchInfoDelete.do?infoCode=<c:out value="${result.infoCode }"/>&amp;pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconButton delete marginLeft_5 marginRight_5" onclick="return fn_delete();"><span>삭제</span></a>
                            </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${fn:length(results) == 0}">
                    <tr>
                        <td colspan="10" class="textACenter">등록된 정보가 없습니다.</td>
                    </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./cmmnAtchInfoList.do?pageIndex=" />
        </div>
        <div class="arrRight">
            <a href="./cmmnAtchInfoRegistView.do?pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex }"/>" class="iconTextButton write"><span>등록</span></a>
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
