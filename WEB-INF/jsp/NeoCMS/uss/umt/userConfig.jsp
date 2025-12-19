<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>사용자 정보 설정 관리</title>
    <meta name="decorator" content="neo" />

    <script src="<c:url value='/cmm/validator.do'/>"></script>
    <c:if test="${!empty message}">
        <script nonce="NEOCMSSCRIPT">
            function fn_check_message() {
                alert("<c:out value='${message}'/>");
                <c:if test="${!empty fieldName}">
                $("#<c:out value="${fieldName}"/>").focus();
                </c:if>
            }
            $(window).on("load", function() {
                fn_check_message();
            });
        </script>
    </c:if>
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_user">사용자관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">사용자 정보 설정 관리</span>
</div>
<div class="tab_navigation">
    <a href="/neo/selectUserInfoList.do"><span>사용자 관리</span></a></li>
    <a href="/neo/selectIndvdlinfoHistList.do"><span>개인정보처리이력</span></a></li>
<%--    <a href="/neo/selectUserForceLoginHistList.do"><span>개별로그인이력</span></a></li>--%>
    <a href="/neo/updateUserConfigView.do" class="current"><span>사용자 정보 설정 관리</span></a></li>
</div>

<div class="dataWrap">
    <form:form modelAttribute="userConcfig" name="userInfoForm" action="updateUserConfig.do" >
        <input type="hidden" name="reAgreementAt" id="reAgreementAt" value="N" />
        <input type="hidden" name="drmncyUseAt" id="drmncyUseAt" value="N" />
        <input type="hidden" name="pwdchgUseAt" id="pwdchgUseAt" value="N" />
        <div class="form_wrap isTopBottom">
            <h2>사용자 기본설정</h2>
            <table>
                <colgroup>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row"><form:label path="failLimitCount">비밀번호 오류 제한 횟수</form:label></th>
                    <td>
                        <form:input path="failLimitCount" size="40"/> <form:errors path="failLimitCount"/>
                    </td>
                    <th scope="row">중복 로그인 차단</th>
                    <td>
                        <div class="toggle <c:out value="${userConcfig.snsKakaoUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="dupLgnBlkUseAt" name="dupLgnBlkUseAt"   <c:out value="${userConcfig.dupLgnBlkUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <form:label path="dupLgnBlkUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">재동의 요구 기간</th>
                    <td>
                        <div class="toggle active" data-element-name="toggle">
                            <form:checkbox path="reAgreementAt" value="Y" id="reAgreementAt" data-true-value="Y" data-false-value="N" checked="checked"/>
                            <form:label path="reAgreementAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="reAgreementPeriod" size="40"/> <form:errors path="reAgreementPeriod"/></span>
                        </div>
                    </td>
                    <th scope="row"><form:label path="drmncyUserPeriod">휴면계정 처리 기간</form:label></th>
                    <td>
                        <div class="toggle active" data-element-name="toggle">
                            <form:checkbox path="drmncyUseAt" value="Y" id="drmncyUseAt" data-true-value="Y" data-false-value="N" checked="checked"/>
                            <form:label path="drmncyUseAt">
                                휴면처리 사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="drmncyUserPeriod" size="40"/> <form:errors path="drmncyUserPeriod"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="drmncyMethod">휴면계정 처리 방법</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="drmncyMethod" size="40"/> <form:errors path="drmncyMethod"/></span>
                        </div>
                    </td>
                    <th scope="row"><form:label path="mailServerUrl">메일서버 접속 정보</form:label></th>
                    <td>
                        <div class="form_element full marginBottom_10">
                            <span class="element_wrap"><form:input path="mailServerUrl" size="40"/> <form:errors path="mailServerUrl"/></span>
                        </div>
                        <div class="toggle" data-element-name="toggle">
                            <form:checkbox path="drmncyMailUseAt" value="Y" id="drmncyMailUseAt" data-true-value="Y" data-false-value="N"/>
                            <form:label path="drmncyMailUseAt">
                                휴면 메일발송 사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="mailServerId">메일서버 아이디</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="mailServerId" size="40"/> <form:errors path="mailServerId"/></span>
                        </div>
                    </td>
                    <th scope="row"><form:label path="mailServerPwd">메일서버 비밀번호</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="mailServerPwd" size="40"/> <form:errors path="mailServerPwd"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="passwordUsePeriod">패스워드 변경 기간</form:label></th>
                    <td>
                        <div class="form_element marginBottom_10">
                            <span class="element_wrap"><form:input path="passwordUsePeriod" size="10"/> <form:errors path="passwordUsePeriod"/></span>
                        </div>
                        <div class="toggle" data-element-name="toggle">
                            <form:checkbox path="pwdchgUseAt" value="Y" id="pwdchgUseAt" data-true-value="Y" data-false-value="N"/>
                            <form:label path="pwdchgUseAt">
                                패스워드 유효기간 사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                    </td>
                    <th scope="row"><form:label path="rewardWords">계정 입력 불가 예약어 리스트<br>(콤마 구분)</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="rewardWords" size="40"/> <form:errors path="rewardWords"/></span>
                        </div>
                    </td>
                </tr>
                <%--<form:hidden path="loginModeIdPwd"/>
                <form:hidden path="loginModeRealName"/>--%>
                <tr>
                    <th scope="row">ID PWD 로그인 방식</th>
                    <td>
                        <div class="toggle <c:out value="${userConcfig.loginModeIdPwd eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="loginModeIdPwd" name="loginModeIdPwd"   <c:out value="${userConcfig.loginModeIdPwd eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <form:label path="loginModeIdPwd">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                    </td>
                    <th scope="row">실명인증방식 선택</th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="loginModeRealName">
                                    <form:option value='N' label="실명인증 사용 안함" />
                                    <form:option value='NICE' label="NICE 사용" />
                                    <form:option value='SIREN' label="SIREN 사용" />
                                </form:select>
                                <form:errors path="loginModeRealName"/>
                            </span>
                        </div>
                    </td>
                </tr>
                <%--<form:hidden path="loginModeIpin"/>
                <form:hidden path="loginModeSNS"/>--%>
                <tr>
                    <th scope="row">IPIN 방식 선택</th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="loginModeIpin">
                                    <form:option value='N' label="IPIN 사용 안함" />
                                    <form:option value='NICE' label="NICE 사용" />
                                    <form:option value='SIREN' label="SIREN 사용" />
                                </form:select>
                                <form:errors path="loginModeIpin"/>
                            </span>
                        </div>
                    </td>
                    <th scope="row">SNS 로그인</th>
                    <td>
                        <div class="toggle  <c:out value="${userConcfig.loginModeSNS eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="loginModeSNS" name="loginModeSNS" <c:out value="${userConcfig.loginModeSNS eq 'Y' ? 'checked=\"checked\"':''}"/> value="<c:out value="${userConcfig.loginModeSNS }"/>" data-true-value="Y" data-false-value="N"/>
                            <form:label path="loginModeSNS">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </form:label>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <h2>SIREN24 실명인증 사용시 필수입력</h2>
            <table>
                <colgroup>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">실명인증 ID</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenRealNameID"/></span>
                        </div>
                    </td>
                    <th scope="row">실명인증 서비스번호</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenRealNameServiceNo"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">실명인증 결과수신URL</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenRealNameRetUrl"/></span>
                        </div>
                    </td>
                    <th scope="row">IPIN인증 ID</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenIpinID"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">IPIN 서비스번호</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenIpinServiceNo"/></span>
                        </div>
                    </td>
                    <th scope="row">IPIN 결과수신URL</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="sirenIpinRetUrl"/></span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="marginTop_10 marginBottom_20">
                <p class="info_text em_red_bold">실명인증 프로그램 경로 : /common/realname/siren24/</p>
                <p class="info_text em_red_bold">IPIN 프로그램 경로 : /common/ipin/siren24/</p>
                <p class="info_text em_red_bold">SIREN24를 사용할때는 반드시 SIREN24로부터 받은 jar파일을 프로젝트에 포함하여야합니다. CMS에서 기본으로 제공되는 jar파일은 임시 파일입니다.</p>
            </div>
            <h2>NICE 실명인증 사용시 필수입력</h2>
            <table>
                <colgroup>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">실명인증 ID</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="niceRealNameID"/></span>
                        </div>
                    </td>
                    <th scope="row">실명인증 암호</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="niceRealNamePWD" /></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">IPIN인증 ID</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="niceIpinID" /></span>
                        </div>
                    </td>
                    <th scope="row">IPIN인증 암호</th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="niceIpinPWD"/></span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="marginTop_10 marginBottom_20">
                <p class="info_text em_red_bold">실명인증 프로그램 경로 : /common/realname/nice_check/</p>
                <p class="info_text em_red_bold">IPIN 프로그램 경로 : /common/ipin/nice_check/</p>
            </div>
            <%--<form:hidden path="snsNaverUseAt"/>
            <form:hidden path="snsFaceBookUseAt"/>
            <form:hidden path="snsKakaoUseAt"/>
            <form:hidden path="snsGoogleUseAt"/>--%>
            <h2>SNS 인증 API</h2>
            <table>
                <colgroup>
                    <col class="specWidth15per"/>
                    <col/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">소셜 미디어</th>
                    <th scope="col">API 설정</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">네이버</th>
                    <td>
                        <div class="toggle <c:out value="${userConcfig.snsNaverUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="snsNaverUseAt" name="snsNaverUseAt"  <c:out value="${userConcfig.snsNaverUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <label for="snsNaverUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="social_set">
                            <div class="set_element">
                                <label for="snsNaverClientID">네이버 Client ID</label>
                                <form:input path="snsNaverClientID" id="snsNaverClientID"/>
                            </div>
                            <div class="set_element">
                                <label for="snsNaverClientSecret">네이버 Client Secret</label>
                                <form:input path="snsNaverClientSecret" id="snsNaverClientSecret"/>
                            </div>
                            <div class="set_element">
                                <label for="snsNaverCallbackUrl">네이버 CallBack URL</label>
                                <form:input path="snsNaverCallbackUrl" id="snsNaverCallbackUrl"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">페이스북</th>
                    <td>
                        <div class="toggle  <c:out value="${userConcfig.snsFaceBookUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="snsFaceBookUseAt" name="snsFaceBookUseAt"  <c:out value="${userConcfig.snsFaceBookUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <label for="snsFaceBookUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="social_set">
                            <div class="set_element">
                                <label for="snsFaceBookAppID">페이스북 Client ID</label>
                                <form:input path="snsFaceBookAppID" id="snsFaceBookAppID"/>
                            </div>
                            <div class="set_element">
                                <label for="snsFaceBookAppSecret">페이스북 Client Secret</label>
                                <form:input path="snsFaceBookAppSecret" id="snsFaceBookAppSecret"/>
                            </div>
                            <div class="set_element">
                                <label for="snsFaceBookCallbackUrl">페이스북 CallBack URL</label>
                                <form:input path="snsFaceBookCallbackUrl" id="snsFaceBookCallbackUrl"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">카카오</th>
                    <td>
                        <div class="toggle  <c:out value="${userConcfig.snsKakaoUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="snsKakaoUseAt" name="snsKakaoUseAt"   <c:out value="${userConcfig.snsKakaoUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <label for="snsKakaoUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="social_set">
                            <div class="set_element">
                                <label for="snsKakaoRestApiKey">카카오 REST API 키</label>
                                <form:input path="snsKakaoRestApiKey" id="snsKakaoRestApiKey"/>
                            </div>
                            <div class="set_element">
                                <label for="snsKakaoClientSecret">카카오 Client Secret</label>
                                <form:input path="snsKakaoClientSecret" id="snsKakaoClientSecret"/>
                            </div>
                            <div class="set_element">
                                <label for="snsKakaoJavascriptKey">카카오 자바스크립트 Key</label>
                                <form:input path="snsKakaoJavascriptKey" id="snsKakaoJavascriptKey"/>
                            </div>
                            <div class="set_element">
                                <label for="snsKakaoCallbackUrl">카카오 CallBack URL</label>
                                <form:input path="snsKakaoCallbackUrl" id="snsKakaoCallbackUrl"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">구글 로그인 API</th>
                    <td>
                        <div class="toggle <c:out value="${userConcfig.snsGoogleUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="snsGoogleUseAt" name="snsGoogleUseAt"  <c:out value="${userConcfig.snsGoogleUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="Y" data-true-value="Y" data-false-value="N"/>
                            <label for="snsGoogleUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="social_set">
                            <div class="set_element">
                                <label for="snsGoogleClientID">구글 Client ID</label>
                                <form:input path="snsGoogleClientID" id="snsGoogleClientID"/>
                            </div>
                            <div class="set_element">
                                <label for="snsGoogleClientSecret">구글 Client Secret</label>
                                <form:input path="snsGoogleClientSecret" id="snsGoogleClientSecret"/>
                            </div>
                            <div class="set_element">
                                <label for="snsGoogleCallbackUrl">구글 CallBack URL</label>
                                <form:input path="snsGoogleCallbackUrl" id="snsGoogleCallbackUrl"/>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectUserInfoList.do" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        formLabelText();
        toggleFunction();
    })
</script>
</body>
</html>