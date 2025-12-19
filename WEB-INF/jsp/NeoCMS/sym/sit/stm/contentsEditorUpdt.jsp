<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%--
<script nonce="NEOCMSSCRIPT">
$(window).resize(sizeContent);
function sizeContent() {
	var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#fileInfo").height() - 60) - 60 + "px";
	$("#contentsCn").css("height", newHeight);
}
$(document).ready(sizeContent);
</script>
--%>
<jsp:include page="../mnu/subMenu.jsp" />

<script nonce="NEOCMSSCRIPT">
	function fn_previewContents() {
		//var textarea = $('textarea[name="contentsCn"]').hide();
		$("#previewCntntsCn").val(CKEDITOR.instances.contentsCn.getData());
		$("#previewForm").submit();
	}
</script>

<form name="previewForm" id="previewForm" method="post" action="/${menu.siteId}/previewContents.do" target="_blank">
	<input type="hidden" name="menuNo"  value="${menu.menuNo}"/>
	<input type="hidden" name="cntntsCn" id="previewCntntsCn"/>
</form>
<div class="dataWrap is_tabNaviStyle2">
    <form:form modelAttribute="contentsEdit" name="contentsEditForm" action="updateContentsText.do">

        <form:hidden path="siteId"/>
        <form:hidden path="menuNo"/>

        <div id="fileInfo" class="arrangementWrap marginTop_10 marginBottom_10">
            <div class="arrLeft">
                <span class="file_location">콘텐츠 파일 : <span class="em_red eng_text"><!-- ${contentsFilePath} -->/repository/${menu.siteId}/contents/${menu.menuNo}.html</span></span>
            </div>
            <div class="arrRight">
                <button type="button" onclick="fn_previewContents()" class="iconTextButton preview"><span>미리보기</span></button>
                <button type="button" onclick="data_save();" class="iconTextButton edit marginLeft_5"><span>콘텐츠 수정</span></button>
            </div>
        </div>
        <div class="form_wrap isTop">
            <textarea class="topMargin editor" id="contentsCn" name="contentsCn" data-form-class="contentsCn" style="border:solid 1px #000;">${contentsCn}</textarea>
        </div>
    </form:form>
</div>

<script src="/common/plugin/ckeditor/ckeditor.js"></script>
<script nonce="NEOCMSSCRIPT">

	$(document).ready(function() {

		if ( CKEDITOR.env.ie && CKEDITOR.env.version < 9 )
			CKEDITOR.tools.enableHtml5Elements( document );

		// The trick to keep the editor in the sample quite small
		// unless user specified own height.

		CKEDITOR.config.height = $("#contentsCn").css("height");
		CKEDITOR.config.width = 'auto';
		CKEDITOR.config.allowedContent = true;
		CKEDITOR.config.contentsCss = "/site/${menu.siteId}/css/sub.css";
		var initSample = ( function() {
			var wysiwygareaAvailable = isWysiwygareaAvailable(),
					isBBCodeBuiltIn = !!CKEDITOR.plugins.get( 'bbcode' );

			return function() {
				var editorElement = CKEDITOR.document.getById( 'contentsCn' );

				// :(((
				if ( isBBCodeBuiltIn ) {
					editorElement.setHtml(''
					);
				}

				// Depending on the wysiwygarea plugin availability initialize classic or inline editor.
				if ( wysiwygareaAvailable ) {
					CKEDITOR.replace( 'contentsCn' );

				} else {
					editorElement.setAttribute( 'contenteditable', 'true' );
					CKEDITOR.inline( 'contentsCn' );

					// TODO we can consider displaying some info box that
					// without wysiwygarea the classic editor may not work.
				}

			};

			function isWysiwygareaAvailable() {
				// If in development mode, then the wysiwygarea must be available.
				// Split REV into two strings so builder does not replace it :D.
				if ( CKEDITOR.revision == ( '%RE' + 'V%' ) ) {
					return true;
				}
				return !!CKEDITOR.plugins.get( 'wysiwygarea' );
			}
		} )();
		initSample();
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
		var contentsCn = CKEDITOR.instances.contentsCn.getData();
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
        var contentsCn = CKEDITOR.instances.contentsCn.getData();
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
<form id="none_socket_form" name="nsform" action="/neo/updateContentsEditSaveProc.do" method="post">
    <input type="hidden" name="data" id="ns_data" value=""/>
    <input type="hidden" name="menuNo" id="ns_menuNo" value=""/>
    <input type="hidden" name="updtId" id="ns_updtId" value=""/>
    <input type="hidden" name="siteId" id="ns_siteId" value="<c:out value="${menu.siteId}"/>"/>
</form>