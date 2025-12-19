<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="DEPT_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="decorator" content="neo" />
<script src="/neo/js/jquery-3.6.0.min.js"></script>
<script src="./js/common.js"></script>
<script nonce="NEOCMSSCRIPT">
    var isDeptSelectMode = false;
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
				var deptSortCode = dept.deptSortCode;

				// 숨김부서 아이콘 & 부서명 색
				var deptImg = "icon_tree_node_sub";
				var deptNmClass = "";
				if( deptSttus == "N" ) {
					deptImg = deptImg + "_x";
					deptNmClass = " data-menu-hide=\"true\"";
				}

				// 부서 li 클래스
				var deptLiClass = i == deptCnt ? " class=\"last\"" : "";
				var deptExpBtn = lwprtDeptCo > 0 ? "<button id=\"treeExp_" + deptCode + "\" class=\"treeView-icon zoom-in\" onclick=\"fn_jsonlwprtDeptList('" + deptCode + "')\"></button>" : "";

				// 부서명 링크
                var flagOne = "";
                if(isDeptSelectMode == true){
                    flagOne = "flag_on";
                }
				var deptNmLink = "<a class=\"dept_selector " + flagOne + "\"  href=\"./selectEmployeeList.do?deptCode=" + deptCode + "\" id=\""+deptCode+"\" data-name=\""+ deptNm + "\" onclick=\"moveDeptTree('"+ deptCode + "',this.href);return false;\"  " + deptNmClass + ">" + deptNm + "</a>";

				// 하위부서
				var deptLi = "<li" + deptLiClass + " id=\"dept_" + deptCode + "\" data-deptsort=\"" + deptSortCode + "\" data-deptcode=\"" + deptCode + "\"" + deptNmClass + ">" + deptExpBtn + " " + deptNmLink + "</li>";

				// 하위부서 추가
				$("#ul_dept_" + upperCode).append(deptLi);
			});
			$("#treeExp_" + upperCode).attr("class", "treeView-icon zoom-out");
			$("#treeExp_" + upperCode).attr("onclick", "fn_closeDept('" + upperCode + "')");
		}

	}

	function fn_closeDept( deptCode ) {
		$("#ul_dept_" + deptCode).remove();
		$("#treeExp_" + deptCode).attr("class", "treeView-icon zoom-in");
		$("#treeExp_" + deptCode).attr("onclick", "fn_jsonlwprtDeptList('" + deptCode + "')");
	}

	function fn_deptSelect( deptCode, deptName ) {
		fn_getAjaxSync( "./jsonEmpList.do?deptCode=" + deptCode + "&deptName=" + deptName, "json", fn_setEmpList );
	}

	function fn_jsonlwprtDeptList(deptCode) {
		fn_getAjaxSync( "./jsonLwprtDeptList.do?deptCode=" + deptCode, "json", fn_setDeptList );
	}

	$(document).ready(function() {
        fn_jsonlwprtDeptList('${bestDept.deptCode}');
        <c:if test="${not empty call_deptcode}">
        fn_jsonlwprtDeptList('${call_deptcode}');
        </c:if>
        <c:if test="${empty call_emplcode && not empty call_deptcode}">
        moveTreeContents("/neo/selectEmployeeList.do?deptCode=${call_deptcode}");
        </c:if>
        <c:if test="${not empty call_emplcode}">
        moveTreeContents("/neo/updateEmployeeView.do?deptCode=${call_deptcode}&emplCode=${call_emplcode}");
        </c:if>
        //selectEmployeeList
		fn_searchDeptTreeView();
	});

	function fn_ajax_search_submit(form_id){
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
            async:false,
			success: function (res) {
				jQuery(spinner).css('display', 'none');
				$(".treeView_content").html(res);
			}, // success
			error: function (request,xhr, status) {
				//alert(request.responseText);
                alert("에러가 발생하였습니다.");
				jQuery(spinner).css('display', 'none');
			},
			complete: function () {
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
			}
		});
        return false;
	}
	function fn_ajax_search_form_submit(){
		if($("#searchCndDept").val() == "dept"){
			//$("#departmentForm").attr("action","departmentTreeView.do");
			///neo/jsonSearchDepart.do
            var form_id = "departmentForm";
            //$("#departmentForm").attr("action","jsonSearchDepart.do");
            var formData = $("#"+form_id).serialize();
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: "jsonSearchDepart.do", // 요기에
                type: 'POST',
                data: formData,
                async:false,
                success: function (res) {
                    jQuery(spinner).css('display', 'none');
                    $(".topNode").next().html("");
                    fn_jsonlwprtDeptList('${bestDept.deptCode}');
                    for(var i=0;i<res.departmentList.length;i++){
                        //res.departmentList[i].deptSortCode;
                        fn_searchDept(res.departmentList[i].deptSortCode);
                    }
                    for(var i=0;i<res.departmentList.length;i++){
                        //res.departmentList[i].deptSortCode;
                        fn_searchDeptHighLight(res.departmentList[i].deptSortCode);
                    }
                    //$(".treeView_content").html(res);
                }, // success
                error: function (request,xhr, status) {
                    //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                    jQuery(spinner).css('display', 'none');
                },
                complete: function () {
                    jQuery(spinner).css('display', 'none');
                    downloadLinkPass();
                }
            });
            return false;
		}else{
			$("#departmentForm").attr("action","searchEmployeeList.do");
			fn_ajax_search_submit("departmentForm");
			$(".searchHighLight").removeClass("searchHighLight");
			//만약 직원검색이라면 ajax로 직원검색창을 contentsView에 불러옴
			return false;
		}
	}
</script>
</head>
<body>
<div class="treeView_menu">
    <div id="header" class="subHeader">
        <a href="./updateDeptAndEmpl.do" class="upload_menu" title="부서 엑셀 업로드">부서 엑셀 업로드</a>
        <a href="./downloadDeptAndEmpl.do" class="download_menu" title="부서 엑셀 다운로드">부서 엑셀 다운로드</a>
    </div>
	<div id="searchForm" class="treeSearch">
		<form:form modelAttribute="department" name="departmentForm" id="departmentForm" action="departmentTreeView.do" method="post" onsubmit="return fn_ajax_search_form_submit();">
			<form:select path="searchCnd" id="searchCndDept" class="searchSlct">
				<form:option value="dept" label="부서" />
				<form:option value="all" label="직원" />
			</form:select>
			<form:input path="searchKrwd" id="searchKrwdDept" class="searchKrwd" placeholder="부서/직원검색"/>
			<button type="submit" class="searchBtn">검색</button>
		</form:form>
	</div>

	<div id="treeView" class="treeView">
        <div class="treeViewWrap">
            <span class="topNode"><a class="dept_selector "href="./selectEmployeeList.do?deptCode=${bestDept.deptCode}" id="${bestDept.deptCode}" data-name="${bestDept.deptNm}"   onclick="moveDeptTree('${bestDept.deptCode}',this.href);return false;" >${bestDept.deptNm}</a></span>
            <div id="dept_${bestDept.deptCode}" class="dept_list"></div>
        </div>
	</div>
	<c:if test="${!empty department.searchKrwd}">
    <div class="treeView" id="treeView">
        <div class="treeViewWrap">
            <div class="dept_list">
                <ul>
                <c:forEach var="department" items="${departmentList}" varStatus="status">
                    <li class="first<c:if test="${department.deptSttus eq 'N'}"> hid</c:if>">
                        <a href="./selectEmployeeList.do?deptCode=<c:out value="${department.deptCode}"/>" id="${department.deptCode}"  data-name="${department.deptNm}" onclick="moveDeptTree('${department.deptCode}',this.href);return false;" ><c:out value="${department.deptNm}"/></a>
                    </li>
                </c:forEach>
                </ul>
            </div>
        </div>
    </div>
	</c:if>
</div>
<div class="treeView_content">
</div>
<script nonce="NEOCMSSCRIPT">
	function fn_searchDept(deptSort){
		for(i=2;i<deptSort.length;i+=2){
			var deptUpper = deptSort.substr(0,i);
			var deptCode = $('[data-deptsort="'+deptUpper+'"]').data("deptcode");
			fn_jsonlwprtDeptList(deptCode);
		}

	}
	function fn_searchDeptHighLight(deptSort){
		// data-deptsort='"+deptSortCode+"' data-deptcode='"+deptCode+"'
		var deptNo = $('[data-deptsort='+deptSort+']').data("deptcode");
		$("#dept_"+deptNo).addClass("searchHighLight");
	}
	function fn_searchDeptTreeView(){
		<c:if test="${!empty department.searchKrwd}">
		<c:forEach var="deptSearch" items="${departmentList}" varStatus="status">
		fn_searchDept('<c:out value="${deptSearch.deptSortCode}"/>');
		</c:forEach>
		<c:forEach var="deptSearch" items="${departmentList}" varStatus="status">
		fn_searchDeptHighLight('<c:out value="${deptSearch.deptSortCode}"/>');
		</c:forEach>
		</c:if>
	}
	function moveDeptTree(deptCode, moveurl){
	    if(isDeptSelectMode == true){
            var deptNm = $("#"+deptCode).data("name");
            if($("#upperDeptCode").val() != undefined){
                //상위부서 변경상태라면
                $("#upperDeptCode").val(deptCode);
                $("#deptNm").html(deptNm + "(<span style=\"color:red\">" + deptCode + "</span>)");
                isDeptSelectMode = false;

                $(".dept_selector").removeClass("flag_on");
                $("#info_dept_text").hide();
                $("#deptSpanNm").html("상위부서변경");
            }else{
                //직원변경의 소속부서 변경이라면
                $("#deptCode").val(deptCode);
                $("#deptNm").html(deptNm + "(<span style=\"color:red\">" + deptCode + "</span>)");
                isDeptSelectMode = false;

                $(".dept_selector").removeClass("flag_on");
                $("#info_dept_text").hide();
                $("#deptSpanNm").html("부서변경");
            }



        }else{
            moveTreeContents(moveurl);
        }


    }

    function moveTreeContents(moveurl){
        return  moveTreeContents(moveurl,false);
    }
    function moveTreeContents(moveurl,isCallHistory){

		jQuery(spinner).css('display', '');
		$.ajax({
			url: moveurl,
			method: 'post',
            async: false,
			success: function(res) {
				//console.log(res);
				$(".treeView_content").html(res);

				var req_url = get_query(moveurl);
                if(req_url != "" && moveurl.search("prevUpperDeptCode=") >= 0){
                    fn_jsonlwprtDeptList(req_url["prevUpperDeptCode"]);
                }
				if(req_url != "" && moveurl.search("act=1") >= 0){
					fn_jsonlwprtDeptList(req_url["upperDeptCode"]);
				}
				//prevUpperDeptCode
				jQuery(spinner).css('display', 'none');

			},
			error       : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
                }
                jQuery(spinner).css('display', 'none');
			},
			complete: function(){
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
                var origin = location.origin;
                const target = moveurl.replace(origin,'');
                if(isCallHistory == false || isCallHistory == undefined){
                    //사용자가 클릭 등의 액션으로 페이지가 이동되었다면 history에 저장함. 이 값은 뒤로가기 에서 사용됨.
                    history.pushState({target:target}, 'NeoCMS 부서정보', location);
                }
			}

		});
		return false;
	}
	function get_query(param_url){
		var url = param_url;
		var qs = url.substring(url.indexOf('?') + 1).split('&');
		for(var i = 0, result = {}; i < qs.length; i++){
			qs[i] = qs[i].split('=');
			result[qs[i][0]] = decodeURIComponent(qs[i][1]);
		}
		return result;
	}



    $(document).ready(function() {
        $(window).on('popstate', function(event) {
            var data = event.originalEvent.state;
            if(data.target != null && data.target != undefined){
                event.preventDefault();
                //메뉴 트리 우측의 컨텐츠내용을 history에 저장된 값으로 치환하고
                //isCallHistory 매개변수를 true를 입력하여서 히스토리에 기록되는것을 막음.
                moveTreeContents(data.target,true);
            }else{
                //그외의 경우 정상적인 뒤로가기 기능이 작동.
            }
        });
    });
</script>

</body>
</html>