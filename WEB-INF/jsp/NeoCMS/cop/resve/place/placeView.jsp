<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} 상세</title>
</head>
<body>

<div class="p-wrap">

        <div>
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
        </div>

        <form:form modelAttribute="placeVO" name="placeVO" method="post" action="addPlace.do" onsubmit="return fn_addPlaceCheck(this)">
            <fieldset>
                <legend>장소 상세</legend>
                <c:forEach var="result" items="${placeSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <table class="p-table">
                    <caption>장소 상세</caption>
                    <colgroup>
                        <col class="w10p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row">운영기관</th>
                        <td>
                            (<c:out value="${prgSeMap[placeVO.prgSe]}"/>)
                            <c:set var="insttNo" value="instt${placeVO.insttNo}"/>
                            <c:out value="${eduInsttMap[insttNo]}"/>
                            <c:out value="${expInsttMap[insttNo]}"/>
                            <c:out value="${fctInsttMap[insttNo]}"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">장소명</th>
                        <td>
                            <c:out value="${placeVO.placeNm}"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td>
                            (<c:out value="${placeVO.zip}"/>) <c:out value="${placeVO.addr}"/> <c:out value="${placeVO.detailAddr}"/>
                            <br/>
                            위도 : <c:out value="${placeVO.lat}"/> / 경도 : <c:out value="${placeVO.lon}"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">사용여부</th>
                        <td>
                            <c:if test="${placeVO.useYn == 'Y'}">사용</c:if>
                            <c:if test="${placeVO.useYn == 'N'}">미사용</c:if>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="./selectPlaceList.do?<c:out value="${placeSearchVO.params}"/>" class="p-button cancel">목록 </a>
                    </div>
                    <div class="col-12 right">
                        <a href="./updatePlaceView.do?placeNo=<c:out value="${placeVO.placeNo}"/>&amp;<c:out value="${placeSearchVO.params}"/>" class="p-button edit">수정 </a>
                    </div>
                </div>
            </fieldset>
        </form:form>

</div>

</body>
</html>
