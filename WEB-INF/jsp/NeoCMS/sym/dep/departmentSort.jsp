<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="department" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="department">
<script nonce="NEOCMSSCRIPT">
<c:forEach items="${errors.allErrors}" var="error" varStatus="status">
	<c:if test="${status.first}">
				<c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
		alert("<c:out value="${errMsg}"/>");
	</c:if>
</c:forEach>
</script>
</spring:hasBindErrors>
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
 <script nonce="NEOCMSSCRIPT">
	function index_up() {
		var form = document.getElementById('departmentSortForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('부서를 선택하여 주세요.');
			return false;
		}
		if( SelectIndex ) {
			temp = form.idx.options[SelectIndex].text;
			form.idx.options[SelectIndex].text = form.idx.options[SelectIndex-1].text;
			form.idx.options[SelectIndex-1].text = temp;
			tempindex = form.idx.options[SelectIndex].value;
			form.idx.options[SelectIndex].value = form.idx.options[SelectIndex-1].value;
			form.idx.options[SelectIndex-1].value = tempindex;
			form.idx.selectedIndex = SelectIndex-1;
		}
	}
	function index_ups() {
		var form = document.getElementById('departmentSortForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('부서를 선택하여 주세요.');
			return false;
		}
		if( SelectIndex ) {
			temp = form.idx.options[SelectIndex].text;
			tempindex = form.idx.options[SelectIndex].value;
			for( var LoopI=SelectIndex-1; LoopI>=0; LoopI-- ) {
				form.idx.options[LoopI+1].text = form.idx.options[LoopI].text;
				form.idx.options[LoopI+1].value = form.idx.options[LoopI].value;	
			}
			form.idx.options[0].text = temp;
			form.idx.options[0].value = tempindex;
			form.idx.selectedIndex = 0;	
		}
	}
	function index_dn() {
		var form = document.getElementById('departmentSortForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('부서를 선택하여 주세요.');
			return false;
		}
		if( SelectIndex+1 < form.idx.length ) {
			temp = form.idx.options[SelectIndex+1].text;
			form.idx.options[SelectIndex+1].text = form.idx.options[SelectIndex].text;
			form.idx.options[SelectIndex].text = temp;
			tempindex = form.idx.options[SelectIndex+1].value;
			form.idx.options[SelectIndex+1].value = form.idx.options[SelectIndex].value;
			form.idx.options[SelectIndex].value = tempindex;
			form.idx.selectedIndex = SelectIndex+1;
		}
	}
	function index_dns() {
		var form = document.getElementById('departmentSortForm');
		var SelectIndex = form.idx.selectedIndex;
		var SelectLength = form.idx.length-1;
		if( SelectIndex < 0 ) {
			alert('부서를 선택하여 주세요.');
			return false;
		}
		if( SelectIndex < SelectLength ) {
			temp = form.idx.options[SelectIndex].text;
			tempindex = form.idx.options[SelectIndex].value;
			for( var LoopI=SelectIndex+1; LoopI<=SelectLength; LoopI++ ) {
				form.idx.options[LoopI-1].text = form.idx.options[LoopI].text;
				form.idx.options[LoopI-1].value = form.idx.options[LoopI].value;	
			}
			form.idx.options[SelectLength].text = temp;
			form.idx.options[SelectLength].value = tempindex;
			form.idx.selectedIndex = SelectLength;	
		}
	}
	function IdxSubmit( form ) {
		form.idxData.value = "";
		for(var i=0; i<form.idx.length; i++)
			form.idxData.value += form.idx.options[i].value + '^';
		fn_ajax_submit(form.id);
		return false;
	}
	function fn_ajax_submit(form_id){
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
			success: function (res) {
				//console.log(res);
				jQuery(spinner).css('display', 'none');
				$(".treeView_content").html(res);
			}, // success
			error: function (request,xhr, status) {
				//alert(request.responseText);
                alert("에러가 발생하였습니다.");
				//$(".treeView_content").html(request.responseText);
				jQuery(spinner).css('display', 'none');
			},
			complete: function () {
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
			}
		});
	}
</script>

<jsp:include page="./subMenu.jsp" />
<div class="marginTop_20 marginLeft_30 marginRight_30">
    <form name="departmentSortForm" id="departmentSortForm" method="post" action="./sortDepartment.do" onsubmit="return IdxSubmit(this)">

        <input type="hidden" name="upperDeptCode" id="upperDeptCode" value="<c:out value="${upperDept.deptCode}"/>"/>
        <input type="hidden" name="idxData" id="idxData" value=""/>

    <div class="topMargin">
        <select name="idx" style="height:260px; width:100%; border:solid 1px #528ED8" size="16">
    <c:forEach var="result" items="${deptList}" varStatus="status">
        <option value="<c:out value="${result.deptCode}"/>"><c:out value="${result.deptNm}"/></option>
    </c:forEach>
        </select>
    </div>

    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <button type="button" onclick="index_ups()" class="iconButton angle_double_up marginRight_5"><span>맨위로</span></button>
            <button type="button" onclick="index_up()" class="iconButton angle_up marginRight_5"><span>위로</span></button>
            <button type="button" onclick="index_dn()" class="iconButton angle_down marginRight_5"><span>아래로</span></button>
            <button type="button" onclick="index_dns()" class="iconButton angle_double_down"><span>맨아래로</span></button>
        </div>
        <div class="arrRight">
            <button type="submit" class="iconTextButton sort"><span>순서변경</span></button>
        </div>
    </div>

    </form>
</div>