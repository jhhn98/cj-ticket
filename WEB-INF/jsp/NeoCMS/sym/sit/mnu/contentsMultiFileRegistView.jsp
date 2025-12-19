<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<script nonce="NEOCMSSCRIPT">
    function fn_delete( url ) {
        return confirm("삭제하시겠습니까?");
    }
</script>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap">
    <form:form action="contentsMultiFileRegist.do" enctype="multipart/form-data" modelAttribute="menu">
        <form:hidden path="menuNo"/>



        <div id="dropzone" class="dropzone">파일을 여기에 드래그 해주세요</div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a onclick="moveTreeContents(this.href);return false;" href="./contentsFileList.do?menuNo=<c:out value="${menu.menuNo}"/>" class="iconTextButton list"><span>목록</span></a>
                <%--<a onclick="moveTreeContents(this.href);return false;" href="./contentsFileRegistView.do?menuNo=<c:out value="${menu.menuNo}"/>" class="button"><span>돌아가기</span></a>--%>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>
    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
	$(function () {
		var obj = $("#dropzone");

		obj.on('dragenter', function (e) {
			e.stopPropagation();
			e.preventDefault();
			$(this).css('border', '2px solid #5272A0');
		});

		obj.on('dragleave', function (e) {
			e.stopPropagation();
			e.preventDefault();
			$(this).css('border', '2px dotted #8296C2');
		});

		obj.on('dragover', function (e) {
			e.stopPropagation();
			e.preventDefault();
		});

		obj.on('drop', function (e) {
			e.preventDefault();
			$(this).css('border', '2px dotted #8296C2');

			var files = e.originalEvent.dataTransfer.files;
			if(files.length < 1)
				return;

			F_FileMultiUpload(files, obj);
		});

	});

	// 파일 멀티 업로드
	function F_FileMultiUpload(files, obj) {
		if(confirm(files.length + "개의 파일을 업로드 하시겠습니까?") ) {
			$(".spinner").show();
			var data = new FormData();
			for (var i = 0; i < files.length; i++) {
				data.append('atchmnfl', files[i]);
			}
			<c:set var="req" value="${pageContext.request}" />
			<c:set var="baseURL" value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 0, fn:length(req.requestURI)), req.contextPath)}" />
			var url = "<c:out value="${baseURL}"/>/neo/contentsMultiFileRegist.do?menuNo=<c:out value="${menu.menuNo}"/>";
			$.ajax({
				url: url,
				method: 'post',
				data: data,
				dataType: 'json',
				processData: false,
				contentType: false,
				error       : function( request, status, error ) {
                    if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                        alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                        location.href = "/neo/index.do";
                    }else{
                        //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
                    }
				},
				success: function(res) {
					alert(res.msg);
					if(res.result == 0){
						moveTreeContents("./contentsFileList.do?menuNo=<c:out value="${menu.menuNo}"/>");
						$(".spinner").hide();
					}

				},
				complete: function(){
					$(".spinner").hide();
				}

			});
		}
	}
</script>
