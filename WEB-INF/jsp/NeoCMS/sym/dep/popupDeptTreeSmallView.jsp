<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script nonce="NEOCMSSCRIPT">
//하위메뉴 표시하기
function fn_pop_setDeptList( data ) {

	// 상위부서 코드
	var upperCode = data.deptCode;
	var upperNm = data.deptNm;
	// 부서 목록
	var deptList = data.deptList;
	// 부서 수
	var deptCnt = data.deptList.length;
	
	if( deptCnt > 0 ) {
		
		// 기존 하위 부서 제거
		$("#p_ul_dept_" + upperCode).remove();
		// 상위메뉴에 UL추가
		$("#p_dept_" + upperCode).append("<ul id=\"p_ul_dept_" + upperCode + "\"></ul>");

		var i = 0;
		$.each( deptList, function(key) {
			i++;
			var dept = deptList[key].dept;
			var deptCode = dept.deptCode;
			var deptNm = dept.deptNm;
			var lwprtDeptCo = dept.lwprtDeptCo;
			var deptSttus = dept.deptSttus;
			var deptSortCode = dept.deptSortCode;
			
			// 숨김부서 아이콘 & 부서명 색
			var deptImg = "icon_tree_node_sub";
			var deptNmClass = "";
			if( deptSttus == "N" ) {
				deptImg = deptImg + "_x";
				deptNmClass = "class=\"hid\" data-menu-hide=\"true\"";
			}
			
			// 메뉴 li 클래스
			var deptLiClass = i == deptCnt ? "class=\"last\"" : "";
			// 확장 버튼
			//var deptExpBtn = lwprtDeptCo > 0 ? "<a id=\"treeExp_" + deptCode + "\" href=\"#treeView\" onclick=\"fn_pop_jsonlwprtDeptList('" + deptCode + "')\"><img id=\"treeExpIcon_" + deptCode + "\" src=\"./images/btn_plus.gif\"/></a>" : "";
			var deptExpBtn = lwprtDeptCo > 0 ? "<button id=\"p_treeExp_" + deptCode + "\" class=\"treeView-icon zoom-in\" onclick=\"fn_pop_jsonlwprtDeptList('" + deptCode + "')\"></button>" : "";
			// 메뉴타입별 아이콘
			//var deptIcon = "";//"<img style=\"vertical-align:sub\" src=\"./neo/images/" + menuTyImg + ".gif\" />";
			var deptIcon = "<a href=\"#deptIcon\"><img style=\"vertical-align:sub\" src=\"./images/"+ deptImg +".gif\" /></a>";
			// 메뉴명 링크
			var deptNmLink = "<a href=\"#\" onclick=\"fn_pop_deptSelect('" + deptCode + "', '" + deptNm + "', '" + deptSortCode + "')\" " + deptNmClass + ">" + deptNm + "</a>";
			// 하위메뉴
			var deptLi = "<li " + deptLiClass + " id=\"p_dept_" + deptCode + "\" data-deptsort=\"" + deptSortCode + "\" data-deptcode=\"" + deptCode + "\"" + deptNmClass + ">" + deptExpBtn + " " + deptIcon + " " + deptNmLink + "</li>";
			// 하위메뉴 추가
			$("#p_ul_dept_" + upperCode).append(deptLi);
		});
		//$("#p_treeExpIcon_" + upperCode).attr("src", "./images/btn_minus.gif");
		$("#p_treeExp_" + upperCode).attr("class", "treeView-icon zoom-out");
		$("#p_treeExp_" + upperCode).attr("onclick", "fn_pop_closeDept('" + upperCode + "')");
	}
	
}

function fn_pop_closeDept( deptCode ) {
	$("#p_ul_dept_" + deptCode).remove();
	//$("#p_treeExpIcon_" + deptCode).attr("src", "./images/btn_plus.gif");
	$("#p_treeExp_" + deptCode).attr("class", "treeView-icon zoom-out");
	$("#p_treeExp_" + deptCode).attr("onclick", "fn_pop_jsonlwprtDeptList('" + deptCode + "')");
}

function fn_pop_deptSelect( deptCode, deptNm, deptSortCode ) {
	<c:choose>
		<c:when test="${param.mode eq 'upperDeptCode'}">
	$("#p_upperDeptCode").val(deptCode);
			<c:if test="${!empty param.deptSortCode}">
    var deptSortCodeOpener = '<c:out value="${param.deptSortCode}"/>';
    var deptSortCodeLen = <c:out value="${fn:length(param.deptSortCode)}"/>;
	var deptSortCodeCut = deptSortCode.substring(0, deptSortCodeLen);
	if( deptSortCodeOpener == deptSortCodeCut ) { alert('동일한 부서 또는 하위부서로는 이동 할 수 없습니다.'); return; }
			</c:if>
		</c:when>
		<c:otherwise>
	$("#p_deptCode").val(deptCode);
		</c:otherwise>
	</c:choose>
	$("#p_deptNm").html(deptNm + "(<span style=\"color:red\">" + deptCode + "</span>)");
	window.close();
}

function fn_pop_jsonlwprtDeptList(deptCode) {
    fn_getAjaxSync( "./jsonLwprtDeptList.do?deptCode=" + deptCode, "json", fn_pop_setDeptList );
}

$(document).ready(function() {
    fn_pop_jsonlwprtDeptList('<c:out value="${bestDept.deptCode}"/>');
});

</script>
<h1>부서검색</h1>
<div class="treeView_menu ">

    <div class="treeView topMargin" style="height:360px; width:360px;">
        <div class="box">
            <span class="topNode"><a href="#" onclick="fn_pop_deptSelect('<c:out value="${bestDept.deptCode}"/>','<c:out value="${bestDept.deptNm}"/>','<c:out value="${bestDept.deptSortCode}"/>')"><c:out value="${bestDept.deptNm}"/></a></span>
            <ul id="p_dept_<c:out value="${bestDept.deptCode}"/>"></ul>
        </div>
    </div>

</div>