<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="DEPT_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="neo" />
    <script src="/neo/js/jquery-3.6.0.min.js"></script>
    <script src="./js/common.js"></script>
    <script nonce="NEOCMSSCRIPT">
        function mSelectChange() {
            document.pbhlthStoreVOForm.submit();
        }
    </script>
</head>
<body>
<div class="contents">

    <h2>부서정보 엑셀 다운로드</h2>
    현재 부서정보를 엑셀로 다운로드합니다
    <table class="table_t1" width="100%">
        <colgroup>
            <col width="140"/>
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th>엑셀다운로드</th>
            <td><a href="./downloadDeptXls.do" class="iconTextButton download"><span>부서 엑셀 다운로드</span></a></td>
        </tr>
        </tbody>
    </table>
    <br />

    <h2>직원정보 엑셀 다운로드</h2>
    현재 직원정보를 엑셀로 다운로드합니다.
    <table class="table_t1" width="100%">
        <colgroup>
            <col width="140"/>
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th>엑셀다운로드</th>
            <td><a href="./downloadEmplXls.do" class="iconTextButton download"><span>직원 엑셀 다운로드</span></a></td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>