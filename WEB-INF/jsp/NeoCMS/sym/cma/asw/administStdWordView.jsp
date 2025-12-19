<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_2" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - AdministStdWord</title>
<meta name="decorator" content="neo" />


</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">행정표준용어</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">${administStdWord.wordNm}</span>
</div>


<div class="contents">

    <table>
        <colgroup>
            <col class="specWidth10per"/>
            <col class="specWidth40per"/>
            <col class="specWidth10per"/>
            <col class="specWidth40per"/>
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">구분</th>
                <td>${administStdWord.wordSe}</td>
                <th scope="row">주제</th>
                <td>${administStdWord.thema}</td>
            </tr>
            <tr>
                <th scope="row">용어명</th>
                <td>${administStdWord.wordNm}</td>
                <th scope="row">영문명</th>
                <td>${administStdWord.engNm}</td>
            </tr>
            <tr>
                <th scope="row">영문약어명</th>
                <td>${administStdWord.engAbrvNm}</td>
                <th scope="row">설명</th>
                <td>${administStdWord.wordDc}</td>
            </tr>
            <tr>
                <th scope="row">등록일</th>
                <td>${administStdWord.rgsde}</td>
                <th scope="row">상태</th>
                <td>${administStdWord.sttus}</td>
            </tr>
        </tbody>
    </table>
	<div class="arrangementWrap data_button">
		<div class="arrLeft"></div>
		<div class="arrRight">
			<a href="./selectAdministStdWordList.do?pageUnit=${administStdWordVO.pageUnit}&amp;searchInclsAt=${administStdWordVO.searchInclsAt}&amp;pageIndex=${administStdWordVO.pageIndex}&amp;searchCnd=${administStdWordVO.searchCnd}&amp;searchKrwd=${administStdWordVO.searchKrwd}" class="iconTextButton list"><span>목록</span></a>
		</div>
	</div>
</div>
</body>
</html>