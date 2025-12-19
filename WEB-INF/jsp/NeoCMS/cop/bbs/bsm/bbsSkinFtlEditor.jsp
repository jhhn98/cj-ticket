<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_2" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>스킨 편집(에디터)</title>
<meta name="decorator" content="neo" />
</head>
<body>
<%--
<script nonce="NEOCMSSCRIPT">
	$(window).resize(sizeContent);
	function sizeContent() {
		var newHeight = ($(window).height() - $("#tab_1").outerHeight() - $("#subMenu").outerHeight() - $(".page_location").outerHeight()  - $(".linkGroup").outerHeight() - 100) + "px";
		$("#freeMarkerCn").css("height", newHeight);
	}
	$(document).ready(sizeContent);
</script>
--%>
<div class="page_location">
    <span class="depth1_title icon_board">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">게시판스킨</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title">FTL 편집</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/>(<span class="em_red">/template/bbs/${bbsSkinVO.skinId}/<c:out value="${ empty bbsSkinVO.ftlName  ? 'list' : bbsSkinVO.ftlName}" />.ftl</span>) </span>
</div>
<div class="tab_navigation" id="subMenu">
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=<c:out value="${bbsSkinVO.ftlName}"/>" class="current"><span>FTL 편집</span></a>
	<a href="./selectSkinHistoryList.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=<c:out value="${bbsSkinVO.ftlName}"/>" class=" "><span>스킨 수정 이력</span></a>
	<a href="./selectSkinHistoryDiff.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=<c:out value="${bbsSkinVO.ftlName}"/>" class=""><span>스킨 버전별 비교</span></a>
</div>
<div class="tab_navigation_lank" id="tab_1">
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=list" class=" <c:out value="${bbsSkinVO.ftlName eq 'list' || empty bbsSkinVO.ftlName  ? 'current' : ''}" />"><span>list.ftl</span></a>
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=regist" class=" <c:out value="${bbsSkinVO.ftlName eq 'regist' ? 'current' : ''}" /> "><span>regist.ftl</span></a>
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=updt" class=" <c:out value="${bbsSkinVO.ftlName eq 'updt' ? 'current' : ''}" /> "><span>updt.ftl</span></a>
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=view" class=" <c:out value="${bbsSkinVO.ftlName eq 'view' ? 'current' : ''}" /> "><span>view.ftl</span></a>
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>&ftlName=reply" class=" <c:out value="${bbsSkinVO.ftlName eq 'reply' ? 'current' : ''}" /> "><span>reply.ftl</span></a>
</div>
<div class="dataWrap is_tabMulti">
    <%--action="updateSkinEditor.do"--%>
    <form name="bbsSkinVO" id="bbsSkinVO" method="post">
        <div class="textARight">
            <a href="./selectBbsSkinList.do" class="iconTextButton list"><span>목록으로</span></a>
            <a href="./batchBbsSkin.do?skinId=<c:out value="${bbsSkinVO.skinId}"/>" class="iconTextButton batch"><span>배치하기</span></a>
            <button type="button" onclick="data_save();" class="iconTextButton edit"><span>스킨수정</span></button>
        </div>
        <div class="form_wrap isTopFtl">
            <input type="hidden" name="updtId" id="updtId" value="<c:out value="${bbsSkinVO.lastUpdusrId}"/>" />
            <input type="hidden" name="skinId" id="skinId" value="<c:out value="${bbsSkinVO.skinId}"/>" />
            <input type="hidden" name="ftlName" id="ftlName" value="<c:out value="${bbsSkinVO.ftlName}"/>" />
            <textarea class="topMargin"  name="freeMarkerCn"  style="width:100%;white-space: pre;  border:solid 1px #000;">${freeMarkerCn}</textarea>
            <div id="freeMarkerCn" class="freeMarkerCn"></div>
        </div>
    </form>
    <script src="/common/js/ace/ace.js" charset="utf-8"></script>
    <script nonce="NEOCMSSCRIPT">
        var editor = ace.edit("freeMarkerCn");
        editor.setTheme("ace/theme/monokai");
        editor.session.setMode("ace/mode/ftl");
        var textarea = $('textarea[name="freeMarkerCn"]').hide();
        editor.getSession().setValue(textarea.val());
        editor.getSession().on('change', function(){
            textarea.val(editor.getSession().getValue());
        });
    </script>

    <!-- websocket javascript -->
    <script nonce="NEOCMSSCRIPT">
        var ws=undefined;
        var messages=document.getElementById("messages");

        function openSocket(){
            if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
                writeResponse("WebSocket is already opened.");
                return;
            }
            //웹소켓 객체 만드는 코드
            /* todo:웹소켓 proxy 사용시 포트번호 변경 필요 */
            <c:if test="${pageContext.request.scheme eq 'http'}">
            ws=new WebSocket("ws://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateSkinFTL.do");
            </c:if>
            <c:if test="${pageContext.request.scheme ne 'http'}">
            ws=new WebSocket("wss://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateSkinFTL.do");
            </c:if>
            ws.binaryType = "arraybuffer";
            ws.onopen=function(event){
                if(event.data===undefined) return;
            };
            ws.onmessage=function(event){
                writeResponse(event.data);
            };
            ws.onclose=function(event){

            };
            ws.onerror=function(event){
                console.log("소켓 정보를 확인 할 수 없어서 비 소켓 방식으로 저장합니다.");
            };
        }

        function send(text){
            ws.send(text);
        }

        function closeSocket(){
            ws.close();
        }
        function writeResponse(text){

            try {
                var ret = JSON.parse(text);
                if(ret == null || ret == ""){
                    alert("저장에 실패하였습니다.");
                }else{
                    if(ret.result == "true") {
                        alert("저장에 성공하였습니다.");
                    }else{
                        alert("저장에 실패하였습니다. 사유 : " + ret.msg);
                    }
                }
                console.log(text);
            } catch (error) {
                console.log("WebSocket is already opened");
            }
        }
        function data_save(){
            //if(ws.readyState != 1) {
                data_save_none_socket();
                return;
            //}
            var textarea = $('textarea[name="freeMarkerCn"]').hide();
            var freeMarkerCn = textarea.val();
            var encodeCn = btoa(unescape(encodeURIComponent(freeMarkerCn)));
            var jsonData = {
                result: true,
                data: encodeCn,
                skinId: $("#skinId").val(),
                ftlName: $("#ftlName").val(),
                updtId: $("#updtId").val(),
                sessionId: '<c:out value="${cookie.JSESSIONID.value}"/>'
            };

            var jsonMsg = JSON.stringify(jsonData);
            if(jsonMsg.length > 1000000){
                alert("입력된 내용이 너무 깁니다. 입력된 길이 : " + jsonMsg.length + " 최대 허용 길이 : 1,000,000");
                return false;
            }else{
                send(JSON.stringify(jsonData));
            }
        }



        function data_save_none_socket(){
            var textarea = $('textarea[name="freeMarkerCn"]').hide();
            var freeMarkerCn = textarea.val();
            var encodeCn = btoa(unescape(encodeURIComponent(freeMarkerCn)));


            $("#ns_data").val(encodeCn);
            $("#ns_skinId").val($("#skinId").val());
            $("#ns_ftlName").val($("#ftlName").val());
            $("#ns_updtId").val($("#updtId").val());

            $("#none_socket_form").submit();
        }

        $(document).ready(function() {
            openSocket();
        });
    </script>
</div>

<form id="none_socket_form" name="nsform" action="/neo/updateSkinEditor.do" method="post">
    <input type="hidden" name="data" id="ns_data" value=""/>
    <input type="hidden" name="skinId" id="ns_skinId" value=""/>
    <input type="hidden" name="ftlName" id="ns_ftlName" value=""/>
    <input type="hidden" name="updtId" id="ns_updtId" value=""/>
</form>
</body>
</html>