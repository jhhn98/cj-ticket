<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="/repository/common/search/searchTop.jsp" />		
            
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>시설예약</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['FCT']}"/>건</span>
                </div>
                <div class="tableScroll">
                    <table class="table-searchResult">
                        <caption>체험/견학-번호, 강좌명, 내용, 운영상태</caption>
                        <thead>
                        <tr>
                            <th scope="col" class="first">번호</th>
                            <th scope="col">년도</th>
                            <th scope="col">프로그램명</th>
							<th scope="col">접수기간</th>
							<th scope="col">이용기간</th>
							<th scope="col">운영기관</th>
							<th scope="col">이용요금</th>
							<th scope="col">신청/정원</th>
                            <th scope="col">운영상태</th>
                        </tr>
                        </thead>
                        <tbody>
				<c:forEach var="item" items="${fctInfoList}" varStatus="idx">
                        <tr>
                            <td class="first textAlignCenter"><span class="mobile-th">번호</span><c:out value="${idx.index + 1}"/></td>
                            <td class="textAlignCenter"><span class="mobile-th">년도</span><c:out value="${item.operYear}"/></td>
							<td><span class="mobile-th">프로그램명</span><a href="./selectFctWebView.do?key=14&amp;fctNo=<c:out value="${item.resveNo}"/>" target="_blank" title="새창"><c:out value="${item.resveNm}"/></a></td>
							<td class="textAlignCenter"><span class="mobile-th">접수기간</span><c:out value="${tsu:toDateFormat(item.rceptBgn,'yyyyMMddHHmm','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.rceptEnd,'yyyyMMddHHmm','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">이용기간</span><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.endde,'yyyyMMdd','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">운영기관</span><c:out value="${item.insttNm}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">이용요금</span><c:choose><c:when test="${!empty item.chrge && item.chrge ne 0}"><fmt:formatNumber value="${item.chrge}" type="number" /></c:when><c:otherwise>무료</c:otherwise></c:choose></td>
							<td class="textAlignCenter"><span class="mobile-th">신청/정원</span><c:out value="${item.rceptNmpr}"/>/<c:out value="${item.rcritNmpr}"/></td>
                            <td class="textAlignCenter"><span class="mobile-th">운영상태</span><!--<span class="lectureState state1"></span>--></td>
                        </tr>
				</c:forEach>
				<c:if test="${empty fctInfoList}">
						<tr>
                            <td class="textAlignCenter" colspan="9">검색된 정보가 없습니다</td>
						</tr>
				</c:if>
                        </tbody>
                    </table>
                </div>

                <div class="p-pagination">
                    <div class="p-page">
					<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./searchList.do?${searchInfoVO.paramsExclPi}&amp;pageIndex=" />
                    </div>
                </div>
				
            </section>
			
<jsp:include page="/repository/common/search/searchBottom.jsp" />