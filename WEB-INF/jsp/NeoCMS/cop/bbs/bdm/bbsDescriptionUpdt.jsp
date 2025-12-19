<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 설명 수정</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
    <c:if test="${!empty message}">
    function fn_check_message() {
        alert("<c:out value='${message}'/>");
        <c:if test="${!empty fieldName}">
        $("#<c:out value="${fieldName}"/>").focus();
        </c:if>
    }
    $(window).on("load", function() {
        fn_check_message();
    });
    </c:if>
</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 설명관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class="current"><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" class=""><span>첨부파일필드 관리</span></a>
    <a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsDescriptionVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsDescriptionVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsDescriptionVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsDescriptionVO.pageIndex}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="dataWrap is_tab">
    <form:form modelAttribute="bbsDescription" name="bbsDescriptionForm" action="updateBbsDescription.do" onsubmit="return false;">
        <form:hidden path="bbsNo"/>
        <input type="hidden" name="pageUnit" value="${bbsDescriptionVO.pageUnit}"/>
        <input type="hidden" name="searchCnd" value="${bbsDescriptionVO.searchCnd}"/>
        <input type="hidden" name="searchKrwd" value="${bbsDescriptionVO.searchKrwd}"/>
        <input type="hidden" name="pageIndex" value="${bbsDescriptionVO.pageIndex}"/>
        <div class="form_wrap bbsDescription">
            <div class="form_element full">
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>비공개</h2>
                        <div class="other_content"><form:checkbox path="clsdrDcReplcAt" value="Y" label="콘텐츠 내용으로 대체"/></div>
                    </div>
                    <div class="arrangementWrap marginTop_15 marginBottom_10">
                        <div class="arrLeft">
                            <p class="info_text marginTop_0">비공개 게시판이고, 목록을 표시 하지 않을 때만 표출시킵니다.</p>
                        </div>
                        <div class="arrRight">
                        </div>
                    </div>
                    <div><textarea class="topMargin" name="clsdrDc">${bbsDescription.clsdrDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="clsdrDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>목록 상단</h2>
                        <div class="other_content"><form:checkbox path="listUpendDcReplcAt" value="Y" label="콘텐츠 내용으로 대체"/></div>
                    </div>
                    <div><textarea class="topMargin" name="listUpendDc">${bbsDescription.listUpendDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="listUpendDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>목록 하단</h2>
                        <div class="other_content"><form:checkbox path="listLptDcReplcAt" value="Y" label="콘텐츠 내용으로 대체"/></div>
                    </div>
                    <div><textarea class="topMargin" name="listLptDc">${bbsDescription.listLptDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="listLptDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>읽기</h2>
                    </div>
                    <div><textarea class="topMargin" name="viewDc">${bbsDescription.viewDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="viewDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>쓰기</h2>
                    </div>
                    <div><textarea class="topMargin" name="registDc">${bbsDescription.registDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="registDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>수정</h2>
                    </div>
                    <div><textarea class="topMargin" name="updtDc">${bbsDescription.updtDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="updtDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>답변</h2>
                    </div>
                    <div><textarea class="topMargin" name="replyDc">${bbsDescription.replyDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="replyDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>개인정보 수집&이용 내역 동의내용</h2>
                    </div>
                    <div><textarea class="topMargin" name="agreementDc">${bbsDescription.agreementDc}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="agreementDc" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>민감정보 처리 내역 동의내용</h2>
                    </div>
                    <div><textarea class="topMargin" name="agreementDc2">${bbsDescription.agreementDc2}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="agreementDc2" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>고유식별정보 수집&이용 내역 동의내용</h2>
                    </div>
                    <div><textarea class="topMargin" name="agreementDc3">${bbsDescription.agreementDc3}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="agreementDc3" class="contentsCn"></div>
                    </div>
                </div>
                <div class="element_wrap">
                    <div class="title_area">
                        <h2>개인정보 3자 제공 내역 동의내용</h2>
                    </div>
                    <div><textarea class="topMargin" name="agreementDc4">${bbsDescription.agreementDc4}</textarea></div>
                    <div class="form_wrap editorContents">
                        <div id="agreementDc4" class="contentsCn"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="/neo/updateBbsDescription.do?bbsNo=<c:out value="${bbsDescription.bbsNo}"/>" class="iconTextButton batch"><span>배치</span></a>
            </div>
            <div class="arrRight">
                <button type="button" onclick="data_save()" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>

<script src="/common/js/ace/ace.js" charset="utf-8"></script>
<script nonce="NEOCMSSCRIPT">
    function initAceEditor(id){
        var editor = ace.edit(id);
        editor.setTheme("ace/theme/monokai");
        editor.session.setMode("ace/mode/html");
        var textarea = $('textarea[name="'+id+'"]').hide();
        editor.getSession().setValue(textarea.val());
        editor.getSession().on('change', function(){
            textarea.val(editor.getSession().getValue());
        });
    }

    //("clsdrDc");
    //("listUpendDc");
    //("listLptDc");
    //("viewDc");
    //("registDc");
    //("updtDc");
    //("replyDc");
    //("agreementDc");
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
        ws=new WebSocket("ws://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateDescriptionSave.do");
        </c:if>
        <c:if test="${pageContext.request.scheme ne 'http'}">
        ws=new WebSocket("wss://<%=request.getRequestURL().toString().replace(request.getRequestURI(),"").replace("http://","").replace("https://","")%>/neo/ws/updateDescriptionSave.do");
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
        if(ws.readyState != 1) {
            data_save_none_socket();
            return;
        }
        var plainText = {
            "clsdrDc":$('textarea[name="clsdrDc"]').val(),
            "listUpendDc":$('textarea[name="listUpendDc"]').val(),
            "listLptDc":$('textarea[name="listLptDc"]').val(),
            "viewDc":$('textarea[name="viewDc"]').val(),
            "registDc":$('textarea[name="registDc"]').val(),
            "updtDc":$('textarea[name="updtDc"]').val(),
            "replyDc":$('textarea[name="replyDc"]').val(),
            "agreementDc":$('textarea[name="agreementDc"]').val(),
            "agreementDc2":$('textarea[name="agreementDc2"]').val(),
            "agreementDc3":$('textarea[name="agreementDc3"]').val(),
            "agreementDc4":$('textarea[name="agreementDc4"]').val(),
            "clsdrDcReplcAt":$('input:checkbox[name="clsdrDcReplcAt"]').is(":checked"),
            "listUpendDcReplcAt":$('input:checkbox[name="listUpendDcReplcAt"]').is(":checked"),
            "listLptDcReplcAt":$('input:checkbox[name="listLptDcReplcAt"]').is(":checked")
        };
        var encodeCn = btoa(unescape(encodeURIComponent(JSON.stringify(plainText))));
        var jsonData = {
            result: true,
            data: encodeCn,
            bbsNo: $("#bbsNo").val(),
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
        var plainText = {
            "clsdrDc":$('textarea[name="clsdrDc"]').val(),
            "listUpendDc":$('textarea[name="listUpendDc"]').val(),
            "listLptDc":$('textarea[name="listLptDc"]').val(),
            "viewDc":$('textarea[name="viewDc"]').val(),
            "registDc":$('textarea[name="registDc"]').val(),
            "updtDc":$('textarea[name="updtDc"]').val(),
            "replyDc":$('textarea[name="replyDc"]').val(),
            "agreementDc":$('textarea[name="agreementDc"]').val(),
            "agreementDc2":$('textarea[name="agreementDc2"]').val(),
            "agreementDc3":$('textarea[name="agreementDc3"]').val(),
            "agreementDc4":$('textarea[name="agreementDc4"]').val(),
            "clsdrDcReplcAt":$('input:checkbox[name="clsdrDcReplcAt"]').is(":checked"),
            "listUpendDcReplcAt":$('input:checkbox[name="listUpendDcReplcAt"]').is(":checked"),
            "listLptDcReplcAt":$('input:checkbox[name="listLptDcReplcAt"]').is(":checked")
        };
        var encodeCn = btoa(unescape(encodeURIComponent(JSON.stringify(plainText))));


        $("#ns_data").val(encodeCn);
        $("#ns_bbsNo").val($("#bbsNo").val());

        $("#none_socket_form").submit();
    }


    $(document).ready(function() {
        openSocket();

        $(".contentsCn").css("height","300");
        initAceEditor("clsdrDc");
        initAceEditor("listUpendDc");
        initAceEditor("listLptDc");
        initAceEditor("viewDc");
        initAceEditor("registDc");
        initAceEditor("updtDc");
        initAceEditor("replyDc");
        initAceEditor("agreementDc");
        initAceEditor("agreementDc2");
        initAceEditor("agreementDc3");
        initAceEditor("agreementDc4");

    });
</script>

<form id="none_socket_form" name="nsform" action="/neo/updateBbsDescriptionProc.do" method="post">
    <input type="hidden" name="data" id="ns_data" value=""/>
    <input type="hidden" name="bbsNo" id="ns_bbsNo" value=""/>
    <input type="hidden" name="siteId" id="ns_siteId" value="<c:out value="${menu.siteId}"/>"/>
</form>
</body>
</html>