<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="/repository/common/search/searchTop.jsp" />		
            
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>시티투어</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['TOUR']}"/>건</span>
                </div>
                <div class="tableScroll">
                    <table class="table-searchResult">
                        <caption>체험/견학-번호, 강좌명, 내용, 운영상태</caption>
                        <thead>
                        <tr>
                            <th scope="col" class="first">번호</th>
                            <th scope="col">코스명</th>
							<th scope="col">접수기간</th>
							<th scope="col">이용기간</th>
							<th scope="col">운영기관</th>
							<th scope="col">이용요금</th>
							<th scope="col">신청/정원</th>
                            <th scope="col">운영상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="first textAlignCenter"><span class="mobile-th">번호</span><c:out value="${idx.index + 1}"/></td>
                            <td><span class="mobile-th">코스명</span><a href="#n" target="_blank" title="새창"><c:out value="${item.resveNm}"/></a></td>
							<td class="textAlignCenter"><span class="mobile-th">접수기간</span></td>
							<td class="textAlignCenter"><span class="mobile-th">이용기간</span></td>
							<td class="textAlignCenter"><span class="mobile-th">운영기관</span></td>
							<td class="textAlignCenter"><span class="mobile-th">이용요금</span></td>
							<td class="textAlignCenter"><span class="mobile-th">신청/정원</span></td>
                            <td class="textAlignCenter"><span class="mobile-th">운영상태</span></td>
                        </tr>
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