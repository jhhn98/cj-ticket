<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="PRG_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - ProgramManage</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
    function fn_deleteProgram( url ) {
        if(confirm("삭제하시겠습니까?")) {
            window.location = url;
            return true;
        }
        return false;
    }
</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title"><c:out value="${program.progrmNm}"/> 상세정보</span>
</div>
<div class="dataWrap">
    <table>
        <colgroup>
            <col class="specWidth200px"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row">프로그램명</th>
            <td><c:out value="${program.progrmNm}"/></td>
        </tr>
        <tr>
            <th scope="row">프로그램URL</th>
            <td><span class="eng_text">/사이트ID/<c:out value="${program.progrmUrl}"/></span></td>
        </tr>
        <tr>
            <th scope="row">관리기능유무</th>
            <td>${manageFnctEnncMap[program.manageFnctEnnc]}</td>
        </tr>
        <tr>
            <th scope="row">관리URL</th>
            <td><c:out value="${program.manageUrl}"/></td>
        </tr>
        <tr>
            <th scope="row">프로그램설명</th>
            <td><c:out value="${program.progrmDc}"/></td>
        </tr>
        <tr>
            <th scope="row">프로그램CODE</th>
            <td><c:out value="${program.progrmCode}"/></td>
        </tr>
		<tr>
            <th scope="row">프로그램 구분</th>
            <td><c:out value="${program.progrmSe}"/></td>
        </tr>
        </tbody>
    </table>

    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <a href="./selectProgramList.do?pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./updateProgramView.do?progrmNo=<c:out value="${programVO.progrmNo}"/>&amp;pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
            <a href="./deleteProgram.do?progrmNo=<c:out value="${programVO.progrmNo}"/>&amp;pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" onclick="fn_deleteProgramManage(this.href); return false;" class="iconTextButton delete marginLeft_5"><span>삭제</span></a>
        </div>
    </div>
</div>
</body>
</html>