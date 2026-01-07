<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_7" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>

	<title>접속로그-IP차단 설정</title>
	<meta name="decorator" content="neo" />
	<link rel="stylesheet" href="/site/staff/css/program.css" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">IP 차단 설정</span>
</div>
<%--<div class="tab_navigation type2 list">--%>
    <%--<c:forEach items="${siteInfoList}" var="site" varStatus="status">--%>
    <%--<a href="selectIpBlockList.do?mngSiteId=<c:out value="${site.siteId}"/>" class="<c:out value="${mngSiteId eq site.siteId ? 'current':''}"/>"><span><c:out value="${site.siteId}"/></span></a>--%>
    <%--</c:forEach>--%>
    <%--<a href="selectIpBlockList.do?mngSiteId=neo" class="<c:out value="${mngSiteId eq 'neo' ? 'current':''}"/>"><span>neo</span></a>
        <a href="selectIpBlockList.do?mngSiteId=staff" class="<c:out value="${mngSiteId eq 'staff' ? 'current':''}"/>"><span>staff</span></a>
</div>--%>
<div class="contents">
    <form name="ipBlock" id="ipBlock" method="post" action="./updateIpBlock.do" onsubmit="return validate()" >
    <input type="hidden" name="siteId" id="siteId" value="<c:out value="${mngSiteId}"/>" />
    <ul class="ipSetList marginTop_10 marginBottom_10 scroll_view">
        <li class="ipSet-element">
            <div class="label-title">
                <input id="ipTy1" name="ipBlockMode" value="allow" type="radio" ${ipBlockMode eq 'allow' ?"checked=\"checked\"":""}>
                <label for="ipTy1"><span>전체 허용</span></label>
            </div>
            <div class="input-list ${ipBlockMode eq 'allow' ?"active":""}">
                <strong class="title eng_text">허용하지 않을 접속 IP 설정</strong>
                <p class="info_text">기본적으로 전체허용 상태가 되며 하단에 작성한 IP만 접근이 금지됩니다.</p>
                <input type="hidden" name="allowCnt" id="allowCnt" value="<c:out value="${fn:length(allowList)+1}"/>"/>
                <ul>
                    <c:forEach varStatus="status" var="allow" items="${allowList}">
                        <li><input type="hidden" name="allowRowNum" value="<c:out value="${status.index + 1}"/>" />[${allow.enable}]
                            <div class="toggle inlineBlock ${allow.enable eq '' ?"active":""}" data-element-name="toggle">
                                <input type="checkbox" id="enable<c:out value="${status.index + 1}"/>" ${allow.enable eq '' ?"checked=\"checked\"":""} name="allowFlagList_<c:out value="${status.index + 1}"/>" data-true-value="Y" data-false-value="N" value="${allow.enable eq '' ?"Y":"N"}"/>
                                <label for="enable<c:out value="${status.index + 1}"/>">
                                    <span class="toggle_ui">on/off</span>
                                </label>
                            </div>
                            <div class="input_group">
                                <input type="text" name="allowDescList_<c:out value="${status.index + 1}"/>" value="<c:out value="${allow.description}"/>" title="IP 명칭" placeholder="IP 명칭 입력"/>
                                <input type="text" name="allowIPList_<c:out value="${status.index + 1}"/>"  value="<c:out value="${allow.ip}"/>" class="ipfield"  title="IP 주소" placeholder="IP 주소 입력"/>
                            </div>
                            <button type="button" class="delete">삭제</button>
                        </li>
                    </c:forEach>
                    <li><input type="hidden" name="allowRowNum" value="<c:out value="${fn:length(allowList)+1}"/>" />
                        <div class="toggle inlineBlock active" data-element-name="toggle">
                            <input type="checkbox" id="enable<c:out value="${fn:length(allowList)+1}"/>" checked="checked" name="allowFlagList_<c:out value="${fn:length(allowList)+1}"/>" data-true-value="Y" data-false-value="N" value="Y"/>
                            <label for="enable<c:out value="${fn:length(allowList)+1}"/>">
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="input_group">
                            <input type="text" name="allowDescList_<c:out value="${fn:length(allowList)+1}"/>" value="" title="IP 명칭" placeholder="IP 명칭 입력"/>
                            <input type="text" name="allowIPList_<c:out value="${fn:length(allowList)+1}"/>"  value=""  class="ipfield" title="IP 주소" placeholder="IP 주소 입력"/>
                        </div>
                        <button type="button" onclick="liAdd(this,'allow')" class="add">추가</button>
                    </li>
                </ul>
            </div>
        </li>
        <li class="ipSet-element">
            <div class="label-title">
                <input id="ipTy2" name="ipBlockMode" value="deny" type="radio" ${ipBlockMode eq 'deny' ?"checked=\"checked\"":""}>
                <label for="ipTy2"><span>전체 거부</span></label>
            </div>
            <div class="input-list ${ipBlockMode eq 'deny' ?"active":""}">
                <strong class="title eng_text">허용할 접속 IP 설정</strong>
                <p class="info_text">기본적으로 전체거부 상태가 되며 하단에 작성한 IP만 접근이 가능합니다.</p>
                <input type="hidden" name="denyCnt" id="denyCnt" value="<c:out value="${fn:length(denyList)+1}"/>"/>
                <ul>
                    <c:forEach varStatus="status" var="deny" items="${denyList}">
                        <li><input type="hidden" name="denyRowNum" value="<c:out value="${status.index + 1}"/>" />
                            <div class="toggle inlineBlock ${deny.enable eq '' ?"active":""}" data-element-name="toggle">
                                <input type="checkbox" id="deny_enable<c:out value="${status.index + 1}"/>" ${deny.enable eq '' ?"checked=\"checked\"":""} name="denyFlagList_<c:out value="${status.index + 1}"/>" data-true-value="Y" data-false-value="N" value="${deny.enable eq '' ?"Y":"N"}"/>
                                <label for="deny_enable<c:out value="${status.index + 1}"/>">
                                    <span class="toggle_ui">on/off</span>
                                </label>
                            </div>
                            <div class="input_group">
                                <input type="text" name="denyDescList_<c:out value="${status.index + 1}"/>" value="<c:out value="${deny.description}"/>" title="IP 명칭" placeholder="IP 명칭 입력"/>
                                <input type="text" name="denyIPList_<c:out value="${status.index + 1}"/>"  value="<c:out value="${deny.ip}"/>"  class="ipfield" title="IP 주소" placeholder="IP 주소 입력"/>
                            </div>
                            <button type="button" class="delete">삭제</button>
                        </li>
                    </c:forEach>
                    <li><input type="hidden" name="denyRowNum" value="<c:out value="${fn:length(denyList)+1}"/>" />
                        <div class="toggle inlineBlock active" data-element-name="toggle">
                            <input type="checkbox" id="enable_deny_<c:out value="${fn:length(denyList)+1}"/>" checked="checked" name="denyFlagList_<c:out value="${fn:length(denyList)+1}"/>" data-true-value="Y" data-false-value="N" value="Y"/>
                            <label for="enable_deny_<c:out value="${fn:length(denyList)+1}"/>">
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="input_group">
                            <input type="text" name="denyDescList_<c:out value="${fn:length(denyList)+1}"/>" value="" title="IP 명칭" placeholder="IP 명칭 입력"/>
                            <input type="text" name="denyIPList_<c:out value="${fn:length(denyList)+1}"/>"  value=""  class="ipfield" title="IP 주소" placeholder="IP 주소 입력"/>
                        </div>
                        <button type="button" onclick="liAdd(this,'deny')" class="add">추가</button>
                    </li>
                </ul>
            </div>
        </li>
    </ul>
    <div class="textARight marginTop_5">
        <button type="submit" class="iconTextButton write"><span>저장</span></button>
        <a href="./reloadIpBlock.do?XRC=true&mngSiteId=<c:out value="${mngSiteId}"/>" class="iconTextButton edit"><span>적용</span></a>
    </div>
    </form>
</div>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        toggleFunction();
    });
    function validate(){
        return true;
    }
</script>
</body>
</html>