<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="SITE_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>사이트정보 상세정보</title>
    <meta name="decorator" content="neo" />
    <script nonce="NEOCMSSCRIPT">

        function fn_deleteSiteInfo( url ) {
            <c:choose>
            <c:when test="${'Y' eq siteInfo.dfltSiteAt}">
                alert("기본 사이트는 삭제할 수 없습니다.");
            </c:when>
            <c:otherwise>
                if(confirm("삭제하시겠습니까?")) {
                    window.location = url;
                    return false;
                }
            </c:otherwise>
            </c:choose>
            return false;
        }


    </script>
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_site">사이트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">상세정보</span>
</div>

<jsp:include page="./subMenu.jsp" />

<div class="dataWrap">
    <div class="form_wrap isTopBottom">
        <div class="alignHorizontal countThree">
            <div class="elementAlign">
                <table>
                    <colgroup>
                        <col class="specWidth140px"/>
                        <col/>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row">구분</th>
                        <td><c:out value="${siteSeMap[siteInfo.siteSe]}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">사이트ID</th>
                        <td class="eng_text"><c:out value="${siteInfo.siteId}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">사이트명</th>
                        <td><c:if test="${'Y' eq siteInfo.dfltSiteAt}"><span class="basic_site">기본사이트</span> </c:if><c:out value="${siteInfo.siteNm}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">제작자</th>
                        <td><c:out value="${siteInfo.siteAuthr}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">키워드</th>
                        <td><c:out value="${siteInfo.siteKwrd}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">사이트설명</th>
                        <td><c:out value="${siteInfo.siteDc}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">사이트URL</th>
                        <td class="eng_text"><a href="<c:out value="${siteInfo.siteUrl}"/>" target="_blank" title="새창" class="iconTextLink site"><c:out value="${siteInfo.siteUrl}"/></a></td>
                    </tr>
                    <tr>
                        <th scope="row">활성여부</th>
                        <td><c:out value="${actvtyAtMap[siteInfo.actvtyAt]}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">기관주소</th>
                        <td><c:out value="${siteInfo.insttAdres}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">기관전화번호</th>
                        <td class="eng_text"><c:out value="${siteInfo.insttTelno}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">기관팩스번호</th>
                        <td class="eng_text"><c:out value="${siteInfo.insttFax}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">기관이메일</th>
                        <td class="eng_text"><c:out value="${siteInfo.insttEmail}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">사이트저작권</th>
                        <td class="eng_text"><c:out value="${siteInfo.siteCpyrht}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">템플릿</th>
                        <td><c:out value="${template.tmplatNm}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">공공누리</th>
                        <td>
                            <p>
                                <c:out value="${koglAtMap[siteInfo.koglUseAt]}"/>
                                <c:if test="${'Y' eq siteInfo.koglUseAt}">
                                    : [<c:out value="${koglTyModelMap[siteInfo.dfltKoglTy].codeNm}"/>] <c:out value="${koglTyModelMap[siteInfo.dfltKoglTy].codeDc}"/>
                                </c:if>
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="elementAlign">
                <h2 class="marginTop_0">메인 게시판 </h2>
                <table>
                    <colgroup>
                        <col class="specWidth80px"/>
                        <col class="specWidth130px"/>
                        <col/>
                        <col class="specWidth120px"/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row">번호</th>
                        <th>게시판코드</th>
                        <th>게시판명</th>
                        <th>게시판번호</th>
                        <th>게시물갯수</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:if test="${empty incBbsList}">
                        <tr>
                            <td colspan="100%">연결된 게시판이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${incBbsList}" var="item" varStatus="status" >
                    <tr>
                        <td><c:out value="${status.index + 1}" /></td>
                        <td>\${boardList<c:out value="${status.index + 1}" />}</td>
                        <td><c:out value="${item.bbsNm}" /></td>
                        <td><c:out value="${item.bbsNo}" /></td>
                        <td><c:out value="${item.viewCnt}" /></td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>



                <h2 class="marginTop_10">메인 배너존 </h2>
                <table>
                    <colgroup>
                        <col class="specWidth80px"/>
                        <col class="specWidth130px"/>
                        <col/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row">번호</th>
                        <th>배너존코드</th>
                        <th>배너존명</th>
                        <th>배너존번호</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:if test="${empty incBannerZoneList}">
                        <tr>
                            <td colspan="100%">연결된 배너존이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${incBannerZoneList}" var="item" varStatus="status" >
                        <tr>
                            <td><c:out value="${status.index + 1}" /></td>
                            <td>\${bannerZone<c:out value="${status.index + 1}" />}</td>
                            <td><c:out value="${item.bannerZoneNm}" /></td>
                            <td><c:out value="${item.bannerZoneNo}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <h2 class="marginTop_10">메인 팝업존 </h2>
                <table>
                    <colgroup>
                        <col class="specWidth80px"/>
                        <col class="specWidth130px"/>
                        <col/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row">번호</th>
                        <th>팝업존코드</th>
                        <th>팝업존명</th>
                        <th>팝업존번호</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:if test="${empty incPopupZoneList}">
                        <tr>
                            <td colspan="100%">연결된 팝업존이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${incPopupZoneList}" var="item" varStatus="status" >
                        <tr>
                            <td><c:out value="${status.index + 1}" /></td>
                            <td>\${popupZone<c:out value="${status.index + 1}" />}</td>
                            <td><c:out value="${item.popupZoneNm}" /></td>
                            <td><c:out value="${item.popupZoneNo}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>




                <h2 class="marginTop_10">메인 링크존 </h2>
                <table>
                    <colgroup>
                        <col class="specWidth80px"/>
                        <col class="specWidth130px"/>
                        <col/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row">번호</th>
                        <th>링크존</th>
                        <th>링크존명</th>
                        <th>링크존번호</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:if test="${empty incLinkZoneList}">
                        <tr>
                            <td colspan="100%">연결된 링크존이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${incLinkZoneList}" var="item" varStatus="status" >
                        <tr>
                            <td><c:out value="${status.index + 1}" /></td>
                            <td>\${linkZone<c:out value="${status.index + 1}" />}</td>
                            <td><c:out value="${item.linkZoneNm}" /></td>
                            <td><c:out value="${item.linkZoneNo}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./updateSiteInfoView.do?siteSe=<c:out value="${siteInfo.siteSe}"/>&amp;siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton edit"><span>수정</span></a>
            <a href="./deleteSiteInfo.do?siteSe=<c:out value="${siteInfo.siteSe}"/>&amp;siteId=<c:out value="${siteInfo.siteId}"/>" onclick="fn_deleteSiteInfo(this.href); return false;" class="iconTextButton delete marginLeft_5"><span>삭제</span></a>
        </div>
    </div>
</div>
</body>
</html>