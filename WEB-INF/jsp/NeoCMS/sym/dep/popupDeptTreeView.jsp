<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>


<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/popup.css" />
<link rel="stylesheet" href="./css/treeview.css" />


</head>
<body>
<script nonce="NEOCMSSCRIPT">
//하위메뉴 표시하기
function fn_setDeptList( data ) {

	// 상위부서 코드
	var upperCode = data.deptCode;
	var upperNm = data.deptNm;
	// 부서 목록
	var deptList = data.deptList;
	// 부서 수
	var deptCnt = data.deptList.length;
	
	if( deptCnt > 0 ) {
		
		// 기존 하위 부서 제거
		$("#ul_dept_" + upperCode).remove();
		// 상위메뉴에 UL추가
		$("#dept_" + upperCode).append("<ul id=\"ul_dept_" + upperCode + "\"></ul>");

		var i = 0;
		$.each( deptList, function(key) {
			i++;
			var dept = deptList[key].dept;
			var deptCode = dept.deptCode;
			var deptNm = dept.deptNm;
			var lwprtDeptCo = dept.lwprtDeptCo;
			var deptSttus = dept.deptSttus;
			
			// 숨김부서 아이콘 & 부서명 색
			var deptImg = "icon_tree_node_sub";
			var deptNmClass = "";
			if( deptSttus == "N" ) {
				deptImg = deptImg + "_x";
				deptNmClass = "class=\"hid\"";
			}
			
			// 메뉴 li 클래스
			var deptLiClass = i == deptCnt ? "class=\"last\"" : "";
			// 확장 버튼
			//var deptExpBtn = lwprtDeptCo > 0 ? "<a id=\"treeExp_" + deptCode + "\" href=\"#treeView\" onclick=\"fn_jsonlwprtDeptList('" + deptCode + "')\"><img id=\"treeExpIcon_" + deptCode + "\" src=\"./images/btn_plus.gif\"/></a>" : "";
			var deptExpBtn = lwprtDeptCo > 0 ? "<div id=\"treeExp_" + deptCode + "\" class=\"plus\" onclick=\"fn_jsonlwprtDeptList('" + deptCode + "')\"></div>" : "";
			// 메뉴타입별 아이콘
			//var deptIcon = "";//"<img style=\"vertical-align:sub\" src=\"./neo/images/" + menuTyImg + ".gif\" />";
			var deptIcon = "<a href=\"#deptIcon\"><img style=\"vertical-align:sub\" src=\"./images/"+ deptImg +".gif\" /></a>";
			// 메뉴명 링크
			var deptNmLink = "<a href=\"#\" onclick=\"fn_deptSelect('" + deptCode + "', '" + deptNm + "')\" " + deptNmClass + ">" + deptNm + "</a>";
			// 하위메뉴
			var deptLi = "<li " + deptLiClass + " id=\"dept_" + deptCode + "\">" + deptExpBtn + " " + deptIcon + " " + deptNmLink + "</li>";
			// 하위메뉴 추가
			$("#ul_dept_" + upperCode).append(deptLi);
		});
		//$("#treeExpIcon_" + upperCode).attr("src", "./images/btn_minus.gif");
		$("#treeExp_" + upperCode).attr("class", "minus");
		$("#treeExp_" + upperCode).attr("onclick", "fn_closeDept('" + upperCode + "')");
	}
	
}

function fn_closeDept( deptCode ) {
	$("#ul_dept_" + deptCode).remove();
	//$("#treeExpIcon_" + deptCode).attr("src", "./images/btn_plus.gif");
	$("#treeExp_" + deptCode).attr("class", "plus");
	$("#treeExp_" + deptCode).attr("onclick", "fn_jsonlwprtDeptList('" + deptCode + "')");
}

function fn_deptSelect( deptCode, deptNm ) {
	fn_getAjax( "./jsonEmpList.do?deptCode=" + deptCode + "&deptNm=" + deptNm, "json", fn_setEmpList );
}

function fn_setEmpList( data ) {
	// 부서 코드
	var deptCode = data.deptCode;
	var deptNm = data.deptNm;
		
	// 직원 목록
	var empList = data.empList;
	// 직원 수
	var empCnt = data.empList.length;
	
	$("#selectDeptNm").text("선택부서명 : " + deptNm);
	$("#selectDeptCo").text("소속 직원수 : " + empCnt + "명");

	$("#empList tbody").remove();
	$("#empList").append("<tbody></tbody>");

	var tableData = [];
	var i=0;
	
	if( empCnt > 0 ) {
		$.each( empList, function(key) {
			var emp = empList[key].emp;
			var deptCode = emp.deptCode;
			var deptNm = emp.deptNm;
			var emplCode = emp.emplCode;
			var emplNm = emp.emplNm;
			var emplJob = emp.emplJob;
			var emplEmail = emp.emplEmail;
			var emplTelno = emp.emplTelno;
			var rspofc = emp.rspofc;
			tableData[i++] = "<tr><td align=\"center\">" + deptNm + "</td><td align=\"center\"><a href=\"#\" onclick=\"fn_empSelect('" + deptCode + "','" + deptNm + "','" + emplCode + "','" + emplNm + "','" + emplTelno + "')\" class=\"iconButton><span>" + emplNm + "</span></a></td><td align=\"center\">" + rspofc + "</td><td align=\"center\">" + emplTelno + "</td><td>" + emplJob + "</td></tr>";
		});
	} else {
		tableData[i++] = "<tr><td align=\"center\" colspan=\"5\">등록된 직원이 없습니다.</td></tr>";		
	}
	
	$("#empList tbody").append(tableData.join(''));

}

function fn_empSelect( deptCode, deptNm, emplCode, emplNm, emplTelno ) {
<c:choose>
<c:when test="${param.mode eq 'user'}">
	$("#emplInfo", opener.document).html("<img src=\"./images/icon_tree_node_sub.gif\" style=\"vertical-align:middle\"/> " + deptNm + "(<span style=\"color:blue\">" + deptCode + "</span>) <img src=\"./images/icon_arrow_r.gif\" style=\"vertical-align:middle; margin:0 5px 0 5px\"/><img src=\"./images/icon_tree_node_user.gif\" style=\"vertical-align:middle\">" + emplNm + "(<span style=\"color:red\">" + emplCode + "</span>)");
	$("#emplCode", opener.document).val(emplCode);
	$("#deptCode", opener.document).val(deptCode);
</c:when>
<c:otherwise>
	$("#deptCode", opener.document).val(deptCode);
	$("#deptNm", opener.document).val(deptNm);
	$("#emplCode", opener.document).val(emplCode);
	$("#emplNm", opener.document).val(emplNm);
	$("#emplTelno", opener.document).val(emplTelno);
</c:otherwise>
</c:choose>
	window.close();
}

function fn_jsonlwprtDeptList(deptCode) {
	fn_getAjax( "./jsonLwprtDeptList.do?deptCode=" + deptCode, "json", fn_setDeptList );
}

$(document).ready(function() {
	fn_jsonlwprtDeptList('<c:out value="${bestDept.deptCode}"/>');
});

</script>
<h1>담당자검색</h1>

<div class="clearfix" style="width:1010px;margin-top:10px">

<div class="treeView" style="height:500px; width:200px; float:left;"><div class="box">
<span class="topNode"><a href="#" onclick="fn_deptSelect('<c:out value="${bestDept.deptCode}"/>','<c:out value="${bestDept.deptNm}"/>')"><c:out value="${bestDept.deptNm}"/></a></span>
<ul id="dept_${bestDept.deptCode}"></ul>
</div></div>

<div style="float:right; width:800px; height:500px; overflow-y:scroll;">
	
	<div class="clearfix">
		<div class="floatLeft" id="selectDeptNm">선택부서명 : 없음</div>
		<div class="floatRight" id="selectDeptCo">소속 직원수 : 0명</div>
	</div>

	<table>
	<colgroup>
		<col width="120">
		<col class="specWidth80px"/>
		<col class="specWidth80px"/>
		<col class="specWidth120px"/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">부서</th>
			<th scope="col">성명</th>
			<th scope="col">직책</th>
			<th scope="col">연락처</th>
			<th scope="col">업무</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td colspan="5" class="textACenter">부서를 선택해주세요.</td>
	</tr>
	</tbody> 
	</table>

</div>

</div>

</body>
</html>