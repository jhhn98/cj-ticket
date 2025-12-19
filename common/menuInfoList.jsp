<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="kr.co.hanshinit.NeoCMS.sym.sit.mnu.service.MenuService" %>
<%@ page import="kr.co.hanshinit.NeoCMS.sym.sit.mnu.service.Menu" %>
<%@ page import="kr.co.hanshinit.NeoCMS.cmm.util.StringUtil" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<%!

    public String getPath(String path) {

        StringBuffer sbNavi = new StringBuffer("");
        if( !StringUtil.isEmpty(path) ) {
            String[] arrNavi = path.split("\\^");
            if( null != arrNavi ) {
                for( int j=0; j<arrNavi.length; j++ ) {
                    if( StringUtil.isEmpty(arrNavi[j]) ) continue;
                    String[] arrMenuInfo = arrNavi[j].split("\\|");
                    if( null == arrMenuInfo || arrMenuInfo.length < 2) continue;
                    if( !StringUtil.isEmpty(sbNavi.toString()) ) {
                        sbNavi.append(" > ");
                    }
                    sbNavi.append(arrMenuInfo[1]);
                }
            }
        }

        return sbNavi.toString();

    }

    public Integer getBestMenu(List<Menu> menuInfoList) {
        Integer menuBestKey = null;
        int menuInfoListCo = menuInfoList.size();
        for (int i = 0; i < menuInfoListCo; i++) {
            Menu menu = menuInfoList.get(i);
            if ( null == menu.getUpperMenuNo() ) {
                menuBestKey = menu.getMenuNo();
                break;
            }
        }
        return menuBestKey;
    }

    public void getLwprtMenu(List<Menu> menuInfoList, int menuNo, StringBuffer sb, AtomicInteger co) {
        int menuInfoListCo = menuInfoList.size();
        for (int i = 0; i < menuInfoListCo; i++) {
            Menu menuInfo = menuInfoList.get(i);
            if( null == menuInfo.getUpperMenuNo() ) continue;
            if( menuNo == menuInfo.getUpperMenuNo() ) {
                String menuTy = menuInfo.getMenuTy();
                if( null == menuInfo.getMenuTy() ) continue;
                if( "MNTY02".equals(menuTy) || "MNTY03".equals(menuTy)
                        || "MNTY04".equals(menuTy) || "MNTY05".equals(menuTy) || "MNTY06".equals(menuTy) ) {
                    sb.append(", {");
                    sb.append("\"menuNm\" : \"").append(menuInfo.getMenuNm()).append("\",");
                    sb.append("\"menuPath\" : \"").append(getPath(menuInfo.getNavi())).append("\",");
                    sb.append("\"menuUrl\" : \"").append(menuInfo.getMenuUrl()).append("\",");
                    sb.append("\"menuTy\" : \"").append(menuInfo.getMenuTy()).append("\",");
                    sb.append("\"menuShowAt\" : \"").append("Y".equals(menuInfo.getMenuShowAt()) ? "true" : "false").append("\"");
                    sb.append("}\n");
                    co.incrementAndGet();
                }
                getLwprtMenu(menuInfoList, menuInfo.getMenuNo(), sb, co);
            }
        }
    }

%>
<%

    String siteId = (String)request.getParameter("siteId");

    ServletContext servletContext = request.getSession().getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);

    MenuService menuService = (MenuService)wac.getBean("menuService");
    Menu menu = new Menu();
    menu.setSiteId(siteId);
    List<Menu> menuInfoList = menuService.selectMenuList(menu);

    Integer menuKey = getBestMenu(menuInfoList);
    if( null != menuKey ) {
        AtomicInteger co = new AtomicInteger(1);
        StringBuffer sb = new StringBuffer();
        getLwprtMenu(menuInfoList, menuKey, sb, co);
%>
{
"siteId" : "<%= siteId %>",
"menuInfoList" : [
{
"menuNm" : "메인 페이지",
"menuPath" : "메인 페이지",
"menuUrl" : "/<%= siteId %>/index.do",
"menuTy" : "MNTY02",
"menuShowAt" : "true"
}
<%= sb.toString() %>
],
"menuInfoListCo" : <%= co.get() %>
}
<%
    }
%>