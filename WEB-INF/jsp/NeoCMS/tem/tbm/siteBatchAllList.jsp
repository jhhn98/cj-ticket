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
    <span class="depth1_title icon_template">템플릿설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">템플릿 전체 배치</span>
</div>
<div class="dataWrap">
    <div class="form_wrap">
        <p class="info_text">관련 사이트 목록 : <c:forEach items="${templateSiteList}" var="site">
            <c:if test="${site.tmplatId eq template.tmplatId}"><c:out value="${site.siteNm}"/>(<c:out value="${site.siteId}"/>) &nbsp; &nbsp; &nbsp;</c:if>
        </c:forEach></p>
        <table>
            <colgroup>
                <col class="specWidth80px"/>
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
                <td class="textACenter"><a href="/neo/batchTemplateMainLayoutAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/<span class="em_red">main</span>.jsp</td>
                <td>메인페이지 레이아웃 배치</td>
            </tr>
            <tr>
                <td class="textARight">2</td>
                <td class="textACenter">서브 레이아웃</td>
                <td class="textACenter"><a href="/neo/batchTemplateSubLayoutAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td class="eng_text">/repository/<span class="em_blue">사이트ID</span>/<span class="em_red">sub</span>.jsp</td>
                <td>서브페이지 레이아웃 배치</td>
            </tr>
            <tr>
                <td class="textARight">3</td>
                <td class="textACenter">상단메뉴</td>
                <td class="textACenter"><a href="/neo/batchTemplateTopMenuAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td>/repository/<span class="em_blue">사이트ID</span>/menu/<span class="em_red">top</span>.jsp</td>
                <td>메인/서브 레이아웃의 상단메뉴에 사용되는 메뉴 배치</td>
            </tr>
            <tr>
                <td class="textARight">4</td>
                <td class="textACenter">왼쪽메뉴</td>
                <td class="textACenter"><a href="/neo/batchTemplateLeftMenuAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td>/repository/<span class="em_blue">사이트ID</span>/menu/left<span class="em_red">[menuNo]</span>.jsp</td>
                <td>서브 레이아웃의 왼쪽메뉴에 사용되는 메뉴 배치</td>
            </tr>
            <tr>
                <td class="textARight">5</td>
                <td class="textACenter">메뉴정보</td>
                <td class="textACenter"><a href="/neo/batchTemplateMenuInfoAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td>/repository/<span class="em_blue">사이트ID</span>/menu/<span class="em_red">[menuNo]</span>.json</td>
                <td>각 메뉴의 정보를 개별 파일로 배치</td>
            </tr>
            <tr>
                <td class="textARight">6</td>
                <td class="textACenter">평가결과</td>
                <td class="textACenter"><a href="/neo/batchTemplateEvalAll.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                <td>/repository/<span class="em_blue">사이트ID</span>/eval/<span class="em_red">[menuNo]</span>.json</td>
                <td>서브 레이아웃의 만족도평가결과 정보 배치</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <a href="./selectTemplateList.do" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
        </div>
    </div>
</div>


</body>
</html>