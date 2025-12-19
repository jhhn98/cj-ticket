<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<jsp:include page="./subMenu.jsp" />
<script nonce="NEOCMSSCRIPT">
    function fn_delete( url ) {
        if(confirm("삭제하시겠습니까?")){
            moveTreeContents(url);
            return false;
        }

        return false;
    }
</script>
<div class="dataWrap is_tabNaviStyle2">
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth60px"/>
                        <col class="specWidth150px"/>
                        <col />
                        <col />
                        <col class="specWidth60px"/>
                        <!--<col />-->
                        <%--<col class="specWidth80px"/>--%>
                        <col class="specWidth260px"/>
                        <col class="specWidth120px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">저장경로</th>
                        <th scope="col">원본파일명</th>
                        <th scope="col">저장파일명</th>
                        <th scope="col">확장자</th>
                        <!--<th scope="col">본문삽입 여부</th>-->
                        <%--<th scope="col">암호화</th>--%>
                        <th scope="col">다운로드 URL</th>
                        <th scope="col">비고</th>
                    </tr>
                    </thead>
                    <tbody class="textACenter">
                    <c:forEach var="result" items="${results}" varStatus="status">
                    <tr>
                        <td><c:out value="${status.count }"/></td>
                        <td class="textALeft"><span class="eng_text"><c:out value="${result.storePath }"/></span></td>
                        <td><span class="eng_text"><c:out value="${result.fileNm }"/></span></td>
                        <td class="textALeft"><span class="eng_text"><c:out value="${result.storeFileNm }"/></span></td>
                        <td><span class="eng_text"><c:out value="${result.fileExtsn }"/></span></td>
                        <!--<td><c:out value="${result.bdtInsrtAt }"/></td>-->
                        <%--<td><c:out value="${result.encAt}"/></td>--%>
                        <td class="textALeft">
                            <a href="#n" class="iconTextLink copy" onclick="copyClipboard('/downloadContentsFile.do?key=<c:out value="${menu.menuNo}"/>&amp;fileNo=<c:out value="${result.fileNo }"/>');return false;"><span>링크 복사</span></a>
                            <c:forEach items="${result.thumbPath}" var="thumb" varStatus="thumbIdx">
                                <a href="#n" class="iconTextLink copy marginLeft_10" onclick="copyClipboard('<c:out value="${thumb}"/>');return false;"><span>섬네일링크 복사</span></a>
                            </c:forEach>
                            <a href ="/downloadContentsFile.do?key=<c:out value="${menu.menuNo}"/>&amp;fileNo=<c:out value="${result.fileNo }"/>" class="iconTextLink file download marginLeft_10"><span class="eng_text">다운로드</span></a><br />
                        </td>
                        <td>
                            <a onclick="moveTreeContents(this.href);return false;" href="./contentsFileUpdtView.do?menuNo=<c:out value="${menu.menuNo}"/>&amp;fileNo=<c:out value="${result.fileNo}"/>" class="iconTextButton edit small"><span>수정</span></a>
                            <a href="./contentsFileDelete.do?menuNo=<c:out value="${menu.menuNo}"/>&amp;fileNo=<c:out value="${result.fileNo }"/>&amp;pageIndex=<c:out value="${cmmnAtchFileVO.pageIndex}"/>" class="iconTextButton delete small marginRight_5" onclick="return fn_delete(this.href);"><span>삭제</span></a>
                        </td>

                    </tr>
                    </c:forEach>
                    <c:if test="${fn:length(results) == 0}">
                    <tr>
                        <td colspan="8" class="textACenter">등록된 정보가 없습니다.</td>
                    </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft"></div>
        <div class="arrRight">
            <a onclick="moveTreeContents(this.href);return false;" href="./contentsMultiFileRegistView.do?menuNo=<c:out value="${menu.menuNo}"/>" class="iconTextButton write"><span>등록</span></a>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	function copyClipboard(val) {
		var dummy = document.createElement("textarea");
		document.body.appendChild(dummy);
		dummy.value = val;
		dummy.select();
		document.execCommand("copy");
		document.body.removeChild(dummy);
		alert("URL 정보가 복사되었습니다.");
	}
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
