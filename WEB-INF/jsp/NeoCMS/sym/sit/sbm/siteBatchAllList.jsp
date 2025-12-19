<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>사이트 배치관리</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_site">사이트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">전체 배치</span>
</div>

<jsp:include page="../sii/subMenu.jsp" />

<div class="contents is_tab">

	<div class="table_fixed_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">

				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth160px"/>
						<col class="specWidth80px"/>
						<col class="specWidth300px"/>
						<col/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">배치명</th>
						<th scope="col">배치실행</th>
						<th scope="col">저장소 경로</th>
						<th scope="col">배치 설명</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td class="textARight">1</td>
						<td class="textACenter">메인 레이아웃</td>
						<td class="textACenter"><a href="/neo/batchMainLayoutAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/<span class="em_red">main</span>.jsp</td>
						<td>메인페이지 레이아웃 배치</td>
					</tr>
					<tr>
						<td class="textARight">2</td>
						<td class="textACenter">서브 레이아웃</td>
						<td class="textACenter"><a href="/neo/batchSubLayoutAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/<span class="em_red">sub</span>.jsp</td>
						<td>서브페이지 레이아웃 배치</td>
					</tr>
					<tr>
						<td class="textARight">3</td>
						<td class="textACenter">상단메뉴</td>
						<td class="textACenter"><a href="/neo/batchTopMenuAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/menu/<span class="em_red">top</span>.jsp</td>
						<td>메인/서브 레이아웃의 상단메뉴에 사용되는 메뉴 배치</td>
					</tr>
					<tr>
						<td class="textARight">4</td>
						<td class="textACenter">왼쪽메뉴</td>
						<td class="textACenter"><a href="/neo/batchLeftMenuAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/menu/left<span class="em_red">[menuNo]</span>.jsp</td>
						<td>서브 레이아웃의 왼쪽메뉴에 사용되는 메뉴 배치</td>
					</tr>
					<tr>
						<td class="textARight">5</td>
						<td class="textACenter">메뉴정보</td>
						<td class="textACenter"><a href="/neo/batchMenuInfoAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/menu/<span class="em_red">[menuNo]</span>.json</td>
						<td>각 메뉴의 정보를 개별 파일로 배치</td>
					</tr>
				<%/*
					<tr>
						<td class="textARight">6</td>
						<td class="textACenter">평가결과</td>
						<td class="textACenter"><a href="/neo/batchEvalAll.do" class="iconTextButton set small"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/eval/<span class="em_red">[menuNo]</span>.json</td>
						<td>서브 레이아웃의 만족도평가결과 정보 배치</td>
					</tr>
					<tr>
						<td class="textARight">7</td>
						<td class="textACenter">새평가</td>
						<td class="textACenter"><a href="/neo/addContentsEvalAll.do?siteId=" class="button blue"><span>배치</span></a></td>
						<td></td>
						<td>전체 메뉴에 대하여 새평가를 시작</td>
					</tr>
				*/%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="arrangementWrap data_button">
		<div class="arrLeft">
		</div>
		<div class="arrRight">

		</div>
	</div>
</div>
</body>
</html>