<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>템플릿 편집(에디터)</title>
<meta name="decorator" content="neo" />
<%--<script nonce="NEOCMSSCRIPT">
    $(window).resize(sizeContent);
    function sizeContent() {
        var newHeight = ($(window).height() - $("#tab_1").outerHeight() - $("#subMenu").outerHeight() - $(".page_location").outerHeight()  - $(".linkGroup").outerHeight() - 100) + "px";
        $("#freeMarkerCn").css("height", newHeight);
    }
    $(document).ready(sizeContent);
</script>--%>
</head>
<body>
    <%--action="updateSkinEditor.do"--%>
    <div class="page_location">
        <span class="depth1_title icon_template">템플릿설정</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth2_title"><c:out value="${template.tmplatNm}"/>(<span class="em_red"><c:out value="${template.tmplatId}"/></span>)</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth3_title">템플릿 수정</span>
        <i class="sign_gt">메뉴 위치 구분 기호 ></i>
        <span class="depth4_title">
   <c:out value="${item.tmplatIemNm}"/>(<span class="em_red">/template/<c:out value="${item.tmplatId}"/>/<c:out value="${item.tmplatIemSe}"/>/<c:out value="${item.tmplatIemFileNm}"/>.ftl</span>)</span>
    </div>
    <div class="tab_navigation" id="subMenu">
        <a href="./updateTemplateEditorView.do?templateId=<c:out value="${templateVO.templateId}"/>&tmplatIemNo=<c:out value="${templateVO.tmplatIemNo}"/>" class="current"><span>템플릿 수정</span></a>
        <a href="./selectTemplateHistoryList.do?templateId=<c:out value="${templateVO.templateId}"/>&tmplatIemNo=<c:out value="${templateVO.tmplatIemNo}"/>"><span>템플릿 수정 이력</span></a>
        <a href="./selectTemplateHistoryDiff.do?templateId=<c:out value="${templateVO.templateId}"/>&tmplatIemNo=<c:out value="${templateVO.tmplatIemNo}"/>"><span>템플릿 버전별 비교</span></a>
    </div>
    <div class="tab_navigation_lank" id="tab_1">
        <c:forEach var="result" items="${tempItems}" varStatus="status">
        <a href="./updateTemplateEditorView.do?templateId=<c:out value="${item.tmplatId}"/>&tmplatIemNo=<c:out value="${result.tmplatIemNo}"/>" class="<c:out value="${result.tmplatIemNo eq item.tmplatIemNo  ? 'current' : ''}" />"><span><c:out value="${result.tmplatIemSe}"/>/<c:out value="${result.tmplatIemFileNm}"/>.ftl</span></a>
        </c:forEach>
    </div>
    <div class="dataWrap is_tabMulti">
        <form name="templateVO" id="templateVO" method="post">
            <div id="fileInfo" class="textARight">
                <a href="/neo/selectTemplateList.do" class="iconTextButton list"><span>목록으로</span></a>
                <c:choose>
                    <c:when test="${item.tmplatIemFileNm eq 'main'}"><a href="./batchTemplateMainLayoutAll.do?tmplatId=<c:out value="${templateVO.templateId}"/>&amp;refURL=updateTemplateEditorView&amp;tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="iconTextButton batch"><span><c:out value="${item.tmplatIemFileNm}"/>&nbsp;배치하기</span></a></c:when>
                    <c:when test="${item.tmplatIemFileNm eq 'sub'}"><a href="./batchTemplateSubLayoutAll.do?tmplatId=<c:out value="${templateVO.templateId}"/>&amp;refURL=updateTemplateEditorView&amp;tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="iconTextButton batch"><span><c:out value="${item.tmplatIemFileNm}"/>&nbsp;배치하기</span></a></c:when>
                    <c:when test="${item.tmplatIemFileNm eq 'left'}"><a href="./batchTemplateLeftMenuAll.do?tmplatId=<c:out value="${templateVO.templateId}"/>&amp;refURL=updateTemplateEditorView&amp;tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="iconTextButton batch"><span><c:out value="${item.tmplatIemFileNm}"/>&nbsp;배치하기</span></a></c:when>
                    <c:when test="${item.tmplatIemFileNm eq 'top'}"><a href="./batchTemplateTopMenuAll.do?tmplatId=<c:out value="${templateVO.templateId}"/>&amp;refURL=updateTemplateEditorView&amp;tmplatIemNo=<c:out value="${item.tmplatIemNo}"/>" class="iconTextButton batch"><span><c:out value="${item.tmplatIemFileNm}"/>&nbsp;배치하기</span></a></c:when>
                </c:choose>
                <button type="button" onclick="data_save();" class="iconTextButton edit"><span>템플릿수정</span></button>
            </div>
            <div class="form_wrap isTopFtl">
                <input type="hidden" name="updtId" id="updtId" value="<c:out value="${templateVO.tempLastUpdusrId}"/>" />
                <input type="hidden" name="templateId" id="templateId" value="<c:out value="${templateVO.templateId}"/>" />
                <input type="hidden" name="tmplatIemNo" id="tmplatIemNo" value="<c:out value="${templateVO.tmplatIemNo}"/>" />
                <input type="hidden" name="ftlName" id="ftlName" value="<c:out value="${templateVO.ftlName}"/>" />
                <input type="hidden" name="folderName" id="folderName" value="<c:out value="${templateVO.folderName}"/>" />
                <textarea class="topMargin"  name="freeMarkerCn"  style="width:100%;white-space: pre;  border:solid 1px #000;"><c:out value="${freeMarkerCn}"/></textarea>
                <div id="freeMarkerCn" class="freeMarkerCn"></div>
                <script src="/common/js/ace/ace.js" charset="utf-8"></script>
                <script nonce="NEOCMSSCRIPT">
                    var editor = ace.edit("freeMarkerCn");
                    editor.setTheme("ace/theme/monokai");
                    editor.session.setMode("ace/mode/ftl");
                    var textarea = $('textarea[name="freeMarkerCn"]').hide();
                    editor.getSession().setValue(textarea.val());


                    var heightUpdateFunction = function() {
                        var newHeight =
                                editor.getSession().getScreenLength() * editor.renderer.lineHeight + editor.renderer.scrollBar.getWidth();
                        $('#editor').height(newHeight.toString() + "px");
                        $('#editor-section').height(newHeight.toString() + "px");

                        editor.resize();
                    };

                    // Set initial size to match initial content
                    heightUpdateFunction();

                    editor.getSession().on('change', function(){
                        textarea.val(editor.getSession().getValue());
                        heightUpdateFunction();
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
                        ws=new WebSocket("ws://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateTempalteFTL.do");
                        </c:if>
                        <c:if test="${pageContext.request.scheme ne 'http'}">
                        ws=new WebSocket("wss://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateTempalteFTL.do");
                        </c:if>
                        ws.binaryType = "arraybuffer";
                        ws.onopen=function(event){
                            if(event.data===undefined) return;
                        };
                        ws.onmessage=function(event){
                            writeResponse(event.data);
                        };
                        ws.onclose=function(event){}
                        ws.onerror=function(event){
                            console.log("소켓 정보를 확인 할 수 없어서 비 소켓 방식으로 저장합니다.");
                        }
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
                            tmplatIemNo: $("#tmplatIemNo").val(),
                            updtId: $("#updtId").val(),
                            templateId: $("#templateId").val(),
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
                        $("#ns_tmplatIemNo").val($("#tmplatIemNo").val());
                        $("#ns_updtId").val($("#updtId").val());
                        $("#ns_templateId").val($("#templateId").val());

                        $("#none_socket_form").submit();
                    }


                    $(document).ready(function() {
                        openSocket();
                    });
                </script>
            </div>
        </form>
        <form id="none_socket_form" name="nsform" action="/neo/updateTemplateProc.do" method="post">
            <input type="hidden" name="data" id="ns_data" value=""/>
            <input type="hidden" name="tmplatIemNo" id="ns_tmplatIemNo" value=""/>
            <input type="hidden" name="updtId" id="ns_updtId" value=""/>
            <input type="hidden" name="templateId" id="ns_templateId" value=""/>
        </form>
    </div>
</body>
</html>