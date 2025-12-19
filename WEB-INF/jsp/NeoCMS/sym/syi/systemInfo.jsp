<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.Scanner"%>
<%@ page import="java.lang.Runtime"%>
<%@ page import="java.lang.Exception"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.File"%>
<%@ page import="java.lang.management.ClassLoadingMXBean"%>
<%@ page import="java.lang.management.ManagementFactory"%>
<%@ page import="java.lang.management.MemoryMXBean"%>
<%@ page import="java.lang.management.MemoryUsage"%>
<%@ page import="java.lang.management.RuntimeMXBean"%>
<%@ page import="java.lang.management.ThreadMXBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_6" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>접속로그</title>
<meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">시스템 정보</span>
</div>
<div class="contents not_etc">
    <div class="scroll_view not_etc">
        <h2 class="marginTop_0">종합정보</h2>
        <table>
            <caption>시스템 정보 - 항목, 정보</caption>
            <colgroup>
                <col class="specWidth400px"/>
                <col/>
            </colgroup>
            <thead>
            <tr>
                <th scope="col">항목</th>
                <th scope="col">정보</th>
            </tr>
            </thead>
            <tbody>
            <%

                java.util.Enumeration<?> e = System.getProperties().propertyNames();

                while(e.hasMoreElements()){

                    String obj = (String)e.nextElement();
            %>
            <tr>
                <th scope="row" class="textARight"><span class="eng_text"><%= obj %></span></th>
                <td style="word-break:break-all"><span class="eng_text"><%= System.getProperty(obj) %></span></td>
            </tr>
            <%

                }

            %>
            </tbody>
        </table>
            <!--
        디스크 정보
        <table>
        <tr>
            <th class="textALeft">df -k</th>
        </tr>
        <tr>
            <td>
                <pre>
    <%

    /*
    try

    {

        Process process = Runtime.getRuntime().exec("df -k");

        BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));

        Scanner scanner = new Scanner(br);

        scanner.useDelimiter(System.getProperty("line.separator"));

        while(scanner.hasNext()) {
            out.println(scanner.next());
        }

        scanner.close();

        br.close();

    } catch(Exception ex) {

        ex.printStackTrace();

    }
    */
    %>
                </pre>
            </td>
        </tr>
        </table>

        <br/>
    -->
        <%
            MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();
            MemoryUsage heap = membean.getHeapMemoryUsage();
            MemoryUsage nonheap = membean.getNonHeapMemoryUsage();
        %>

        <h2>메모리 정보</h2>
        <table>
            <caption>메모리 정보 - 항목, 정보</caption>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <thead>
            <tr>
                <th scope="col">항목</th>
                <th scope="col">정보</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row"><span class="eng_text">Heap Memory</span></th>
                <td><span class="eng_text"><%= heap.toString() %></span></td>
            </tr>
            <tr>
                <th scope="row"><span class="eng_text">NonHeap Memory</span></th>
                <td><span class="eng_text"><%= nonheap.toString() %></span></td>
            </tr>
            </tbody>
        </table>
        <%
            ThreadMXBean tbean = (ThreadMXBean) ManagementFactory.getThreadMXBean();
            long[] ids = tbean.getAllThreadIds();
        %>
        <h2>Cpu Thread</h2>
        <div class="arrangementWrap">
            <div class="arrLeft">
                <p class="table_text"><span class="em_red_bold eng_text">Thread Count : <%= tbean.getThreadCount() %></span></p>
            </div>
            <div class="arrRight"></div>
        </div>
        <table>
            <caption>Thread ID, Thread Time</caption>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <thead>
                <tr>
                    <th scope="col"><span class="eng_text">Thread ID</span></th>
                    <th scope="col"><span class="eng_text">Thread Time</span></th>
                </tr>
            </thead>
            <tbody>
                <% for (long id : ids) { %>
                <tr>
                    <th scope="row"><span class="eng_text">Thread CPU Time ID = <%= id %></span></th>
                    <td><span class="eng_text"><%= tbean.getThreadCpuTime(id) %></span></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>