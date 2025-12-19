<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shCore.js"></script>--%>
<%--<link rel=stylesheet type=text/css href="./syntaxhighlighter/styles/shCoreDefault.css">--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushAS3.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushBash.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushCpp.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushCSharp.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushCss.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushDelphi.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushDiff.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushGroovy.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushJava.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushJavaFX.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushJScript.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushPerl.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushPhp.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushPlain.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushPowerShell.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushPython.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushRuby.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushScala.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushSql.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushVb.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shBrushXml.js"></script>--%>
<%--<script type=text/javascript src="./syntaxhighlighter/scripts/shLegacy.js"></script>--%>
<style type=text/css>
.syntaxhighlighter { overflow-y: hidden !important; }
</style>
<%--
<script nonce="NEOCMSSCRIPT">
$(window).resize(sizeContent);
function sizeContent() {
	var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#historyInfo").height() - 50) + "px";
	$("#contentsCn").css("height", newHeight);
}
$(document).ready(sizeContent);
</script>
--%>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap">
    <div id="historyInfo" class="arrangementWrap marginTop_10 marginBottom_10">
        <div class="arrLeft">
            <span class="file_location">수정일 : <span class="eng_text em_red">${cntntsLastUpdusrPnttmYMDHMS}</span></span>
        </div>
        <div class="arrRight">
            <a onclick="moveTreeContents(this.href);return false;" href="./selectContentsHistoryList.do?siteId=${menu.siteId}&amp;menuNo=${menu.menuNo}" class="iconTextButton list"><span>이력 목록</span></a>
        </div>
    </div>
    <div class="form_wrap">
        <div id="contentsCn" class="contentsCn">
            <pre class="brush:xml">
                ${contentsCn}
            </pre>
        </div>
    </div>
</div>

<%--<script nonce="NEOCMSSCRIPT">--%>
<%--	SyntaxHighlighter.defaults['toolbar'] = false;--%>
<%--	SyntaxHighlighter.defaults['gutter'] = true;--%>
<%--	SyntaxHighlighter.defaults['tab-size'] = 4;--%>
<%--	SyntaxHighlighter.defaults['first-line'] = 1;--%>
<%--	SyntaxHighlighter.defaults['auto-links'] = false;--%>
<%--	SyntaxHighlighter.defaults['wrap-lines'] = true;--%>
<%--	SyntaxHighlighter.all();--%>
<%--</script>--%>
