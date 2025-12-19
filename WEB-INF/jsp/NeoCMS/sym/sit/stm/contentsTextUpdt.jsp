<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:include page="../mnu/subMenu.jsp" />
<script nonce="NEOCMSSCRIPT">
    function fn_previewContents() {
        var textarea = $('textarea[name="contentsCn"]').hide();
        $("#previewCntntsCn").val(textarea.val());
        $("#previewForm").submit();
    }
</script>
<form name="previewForm" id="previewForm" method="post" action="/${menu.siteId}/previewContents.do" target="_blank">
    <input type="hidden" name="menuNo"  value="${menu.menuNo}"/>
    <input type="hidden" name="cntntsCn" id="previewCntntsCn"/>
</form>
<div class="dataWrap is_tabNaviStyle2">
    <form name="contentsEdit" id="contentsEdit" method="post">
        <input type="hidden" name="siteId"  value="${menu.siteId}"/>
        <input type="hidden" name="menuNo" id="menuNo"  value="${menu.menuNo}"/>
        <div id="fileInfo" class="arrangementWrap marginTop_10 marginBottom_10">
            <div class="arrLeft">
                <span class="file_location">콘텐츠 파일 : <span class="em_red eng_text"><!-- ${contentsFilePath} -->/repository/${menu.siteId}/contents/${menu.menuNo}.html</span></span>
            </div>
            <div class="arrRight">
                <button type="button" onclick="fn_previewContents()" class="iconTextButton preview"><span>미리보기</span></button>
                <button type="button" onclick="data_save();" class="iconTextButton edit marginLeft_5"><span>콘텐츠 수정</span></button>
            </div>
        </div>
        <textarea class="topMargin" name="contentsCn">${contentsCn}</textarea>
        <div class="form_wrap isTop">
            <div id="contentsCn" class="contentsCn"></div>
        </div>
    </form>
</div>
<script src="/common/js/ace/ace.js" charset="utf-8"></script>
<script nonce="NEOCMSSCRIPT">
	var editor = ace.edit("contentsCn");
	editor.setTheme("ace/theme/monokai");
	editor.session.setMode("ace/mode/html");
	var textarea = $('textarea[name="contentsCn"]').hide();
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
        ws=new WebSocket("ws://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateContentsEditSave.do");
        </c:if>
        <c:if test="${pageContext.request.scheme ne 'http'}">
        ws=new WebSocket("wss://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateContentsEditSave.do");
        </c:if>
        ws.binaryType = "arraybuffer";
        ws.onopen=function(event){
            if(event.data===undefined) return;
        };
        ws.onmessage=function(event){
            writeResponse(event.data);
        };
        ws.onclose=function(event){
        }
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
        var textarea = $('textarea[name="contentsCn"]').hide();
        var contentsCn = textarea.val();
        var encodeCn = btoa(unescape(encodeURIComponent(contentsCn)));
        var jsonData = {
            result: true,
            data: encodeCn,
            menuNo: $("#menuNo").val(),
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

        var textarea = $('textarea[name="contentsCn"]').hide();
        var contentsCn = textarea.val();
        var encodeCn = btoa(unescape(encodeURIComponent(contentsCn)));

        $("#ns_data").val(encodeCn);
        $("#ns_menuNo").val($("#menuNo").val());
        $("#ns_updtId").val($("#updtId").val());

        fn_ajax_submit("none_socket_form");
    }


    $(document).ready(function() {
        openSocket();

    });
</script>


<form id="none_socket_form" name="nsform" action="/neo/updateContentsHtmlSaveProc.do" method="post">
    <input type="hidden" name="data" id="ns_data" value=""/>
    <input type="hidden" name="menuNo" id="ns_menuNo" value=""/>
    <input type="hidden" name="updtId" id="ns_updtId" value=""/>
    <input type="hidden" name="siteId" id="ns_siteId" value="<c:out value="${menu.siteId}"/>"/>
</form>