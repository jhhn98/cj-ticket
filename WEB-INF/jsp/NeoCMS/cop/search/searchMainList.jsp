<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<jsp:include page="/repository/common/search/searchTop.jsp" />
            			
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>체험/견학</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['EXPRN']}"/>건</span>
			<c:if test="${!empty exprnInfoList}">
                    <a href="./searchList.do?searchCnd=EXPRN&amp;searchKrwd=<c:out value="${searchInfoVO.searchKrwd}"/>">더보기</a>
			</c:if>
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
				<c:forEach var="item" items="${exprnInfoList}" varStatus="idx">
                        <tr>
                            <td class="first textAlignCenter"><span class="mobile-th">번호</span><c:out value="${idx.index + 1}"/></td>
                            <td class="textAlignCenter"><span class="mobile-th">년도</span><c:out value="${item.operYear}"/></td>
							<td><span class="mobile-th">프로그램명</span><a href="./selectExprnWebView.do?key=8&amp;exprnNo=<c:out value="${item.resveNo}"/>" target="_blank" title="새창"><c:out value="${item.resveNm}"/></a></td>
							<td class="textAlignCenter"><span class="mobile-th">접수기간</span><c:out value="${tsu:toDateFormat(item.rceptBgn,'yyyyMMddHHmm','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.rceptEnd,'yyyyMMddHHmm','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">이용기간</span><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMdd','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.endde,'yyyyMMdd','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">운영기관</span><c:out value="${item.insttNm}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">이용요금</span><c:choose><c:when test="${!empty item.chrge && item.chrge ne 0}"><fmt:formatNumber value="${item.chrge}" type="number" /></c:when><c:otherwise>무료</c:otherwise></c:choose></td>
							<td class="textAlignCenter"><span class="mobile-th">신청/정원</span><c:out value="${item.rceptNmpr}"/>/<c:out value="${item.rcritNmpr}"/></td>
                            <td class="textAlignCenter">
								<span class="mobile-th">운영상태</span>
							<c:choose>
								<c:when test="${item.rceptSttus eq 'RCPT_WAIT'}"><span class="lectureState state1"></c:when>
								<c:when test="${item.rceptSttus eq 'RCPT_END' || item.rceptSttus eq 'RCPT_END'}"><span class="lectureState state3"></c:when>
								<c:otherwise><span class="lectureState state2"></c:otherwise>
							</c:choose>
								<c:out value="${exprnSttusMap[item.rceptSttus]}"/></span>
							</td>
                        </tr>
				</c:forEach>
				<c:if test="${empty exprnInfoList}">
						<tr>
                            <td class="textAlignCenter" colspan="9">검색된 정보가 없습니다</td>
						</tr>
				</c:if>
                        </tbody>
                    </table>
                </div>
            </section>
			
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>시설예약</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['FCT']}"/>건</span>
			<c:if test="${!empty fctInfoList}">
                    <a href="./searchList.do?searchCnd=FCT&amp;searchKrwd=<c:out value="${searchInfoVO.searchKrwd}"/>">더보기</a>
			</c:if>
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
                            <td class="textAlignCenter">
								<span class="mobile-th">운영상태</span>
							<c:choose>
								<c:when test="${item.rceptSttus eq 'RCPT_WAIT'}"><span class="lectureState state1"></c:when>
								<c:when test="${item.rceptSttus eq 'RCPT_END' || item.rceptSttus eq 'RCPT_END'}"><span class="lectureState state3"></c:when>
								<c:otherwise><span class="lectureState state2"></c:otherwise>
							</c:choose>
								<c:out value="${fcltySttusMap[item.rceptSttus]}"/></span>
							</td>
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
            </section>
			
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>교육/강좌</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['EDU']}"/>건</span>
			<c:if test="${!empty eduInfoList}">
                    <a href="./searchList.do?searchCnd=EDU&amp;searchKrwd=<c:out value="${searchInfoVO.searchKrwd}"/>">더보기</a>
			</c:if>
                </div>
                    <table class="table-searchResult">
                        <caption>교육/강좌-번호, 강좌명, 내용, 운영상태</caption>
                        <thead>
                        <tr>
                            <th scope="col" class="first">번호</th>
                            <th scope="col">년도</th>
                            <th scope="col">강좌명</th>
							<th scope="col">접수기간</th>
							<th scope="col">운영기간</th>
							<th scope="col">대상</th>
							<th scope="col">이용요금</th>
							<th scope="col">신청/정원</th>
                            <th scope="col">운영상태</th>
                        </tr>
                        </thead>
                        <tbody>
				<c:forEach var="item" items="${eduInfoList}" varStatus="idx">
					<c:set var="targetNm" value="" />
					<c:forEach var="map" items="${targetCdMap}">
						<c:if test="${fn:contains(item.targetCd, map.key)}">
							<c:choose>
								<c:when test="${empty targetNm}"><c:set var="targetNm" value="${map.value}" /></c:when>
								<c:otherwise><c:set var="targetNm" value="${targetNm},${map.value}" /></c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
                        <tr>
                            <td class="first textAlignCenter"><span class="mobile-th">번호</span><c:out value="${idx.index + 1}"/></td>
                            <td class="textAlignCenter"><span class="mobile-th">년도</span><c:out value="${item.operYear}"/></td>
							<td><span class="mobile-th">강좌명</span><a href="./selectEduLctreWebView.do?key=19&amp;lctreNo=<c:out value="${item.resveNo}"/>" target="_blank" title="새창"><c:out value="${item.resveNm}"/></a></td>
							<td class="textAlignCenter"><span class="mobile-th">접수기간</span><c:out value="${tsu:toDateFormat(item.rceptBgn,'yyyyMMddHHmm','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.rceptEnd,'yyyyMMddHHmm','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">운영기간</span><c:out value="${tsu:toDateFormat(item.bgnde,'yyyyMMddHHmm','yyyy.MM.dd')}"/> ~ <c:out value="${tsu:toDateFormat(item.endde,'yyyyMMddHHmm','yyyy.MM.dd')}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">대상</span><c:out value="${targetNm}"/></td>
							<td class="textAlignCenter"><span class="mobile-th">이용요금</span><c:choose><c:when test="${!empty item.chrge && item.chrge ne 0}"><fmt:formatNumber value="${item.chrge}" type="number" /></c:when><c:otherwise>무료</c:otherwise></c:choose></td>
							<td class="textAlignCenter"><span class="mobile-th">신청/정원</span><c:out value="${item.rceptNmpr}"/>/<c:out value="${item.rcritNmpr}"/></td>
                            <td class="textAlignCenter">
								<span class="mobile-th">운영상태</span>
							<c:choose>
								<c:when test="${item.rceptSttus eq 'RCPT_WAIT'}"><span class="lectureState state1"></c:when>
								<c:when test="${item.rceptSttus eq 'RCPT_END' || item.rceptSttus eq 'RCPT_END'}"><span class="lectureState state3"></c:when>
								<c:otherwise><span class="lectureState state2"></c:otherwise>
							</c:choose>
								<c:out value="${eduSttusMap[item.rceptSttus]}"/></span>
							</td>
                        </tr>
				</c:forEach>
				<c:if test="${empty eduInfoList}">
						<tr>
                            <td class="textAlignCenter" colspan="9">검색된 정보가 없습니다</td>
						</tr>
				</c:if>
                        </tbody>
                    </table>
            </section>
			
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>공연/영화</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['MNH']}"/>건</span>
                    <c:if test="${!empty pblprfrApiList}">
                        <a href="./searchList.do?searchCnd=MNH&amp;searchKrwd=<c:out value="${searchInfoVO.searchKrwd}"/>">더보기</a>
                    </c:if>
                </div>
                <c:if test="${!empty pblprfrApiList}">
                    <ul class="imageList-searchResult">
                        <c:forEach var="item" items="${pblprfrApiList}">
                            <li>
                                <a href="<c:out value="${item.link}"/>">
                                    <c:choose>
                                        <c:when test="${not empty item.img}">
                                            <c:choose>
                                                <c:when test="${fn:contains(item.img, 'default_poster.jpg')}">
                                                    <span class="image no-image"><img src="/site/www/images/search/img-logo.png" alt="<c:out value="${item.title}"/>"></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="image"><img src="<c:out value="${item.img}"/>" alt="<c:out value="${item.title}"/>"></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="image no-image"><img src="/site/www/images/search/img-logo.png" alt="<c:out value="${item.title}"/>"></span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="place"><c:out value="${item.place}"/></span>
                                    <span class="title"><c:out value="${item.title}"/></span>
                                    <span class="date"><c:out value="${item.pubDate}"/></span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </section>
			
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>게시판</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['BORD']}"/>건</span>
			<c:if test="${!empty nttList}">
                    <a href="./searchList.do?searchCnd=BORD&amp;searchKrwd=<c:out value="${searchInfoVO.searchKrwd}"/>">더보기</a>
			</c:if>
                </div>
			<c:if test="${!empty nttList}">
                <ul class="textList-searchResult">
				<c:forEach var="item" items="${nttList}">
                    <li>
                        <a href="<c:out value="${item.nttLink}"/>" target="_blank">
                            <span class="title">
                                <em class="titleText"><c:out value="${item.nttSj}"/></em><em class="date"><c:out value="${tsu:toDateFormat(item.rgsde,'yyyyMMddHHmmss','yyyy.MM.dd')}"/></em>
                            </span>
                            <span class="text"><c:out value="${item.nttCn}"/></span>
                            <span class="url"><c:out value="${item.nttLink}"/></span>
                        </a>
                    </li>
				</c:forEach>
                </ul>
			</c:if>
            </section>
			
<jsp:include page="/repository/common/search/searchBottom.jsp" />