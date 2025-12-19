<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script nonce="NEOCMSSCRIPT">
	function index_up() {
		var form = document.getElementById('menu');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('메뉴를 선택하여 주세요.');
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
		var form = document.getElementById('menu');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('메뉴를 선택하여 주세요.');
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
		var form = document.getElementById('menu');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('메뉴를 선택하여 주세요.');
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
		var form = document.getElementById('menu');
		var SelectIndex = form.idx.selectedIndex;
		var SelectLength = form.idx.length-1;
		if( SelectIndex < 0 ) {
			alert('메뉴를 선택하여 주세요.');
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
</script>
<jsp:include page="./subMenu.jsp" />
<div class="marginTop_20 marginLeft_30 marginRight_30">
    <form:form modelAttribute="menu" name="menuForm" action="sortMenu.do" onsubmit="return IdxSubmit(this);return false;" method="post">

        <form:hidden path="siteId"/>
        <form:hidden path="menuNo"/>
        <input type="hidden" name="idxData" id="idxData" value=""/>

        <select name="idx" style="height:260px; width:100%; border:solid 1px #528ED8" size="16">
<c:forEach var="menuList" items="${menuList}" varStatus="status">
    <option value="<c:out value="${menuList.menuNo}"/>"><c:out value="${menuList.menuNm}"/></option>
</c:forEach>
        </select>
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
    </form:form>
</div>
<c:if test="${param.act eq 1}">
	<script nonce="NEOCMSSCRIPT">
		//parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${menu.menuNo}"/>);
		fn_jsonlwprtMenuList(<c:out value="${menu.menuNo}"/>);
	</script>
</c:if>