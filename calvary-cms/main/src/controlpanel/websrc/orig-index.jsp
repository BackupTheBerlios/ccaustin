<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld"   prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"   prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"  prefix="slide" %>

<html:html locale='true'>
  <slide:namespace id='namespace'>
    
    <head>
      <title><bean:message key="app.title"/></title>
      <link rel='stylesheet' type='text/css' href='<html:rewrite page="/style.css"/>'>
      <html:base/>
    </head>
    
    <body bgcolor='#ffffff' marginwidth='0' marginheight='0'>
      <table border='0' cellpadding='10' cellspacing='0' width='100%' height='100%'>
        <tr>
          <td class='panel' align='right' bgcolor='#023264' colspan='2' width='100%'>
            <h1 class='headline'><font color='#ffffff' size='3'><bean:message key="app.title"/></font></h1>
            <h2 class='headline'><font color='#eeeeee' size='1'><bean:message key="namespace.label"/> <i><bean:write name='namespace' property='name'/></i></font></h2>
          </td>
        </tr>
        <tr>
          <td class='panel' align='center' bgcolor='#023264' height='100%' valign='top'>
            <hr>
            <table border='0' cellpadding='0' cellspacing='0' class='panelMenu'>
              <tr>
                <td align='left' valign='middle' class='panelMenuItem'>
                  <html:link page='/index.jsp'><bean:message key="home.title"/></html:link>
                </td>
              </tr>
              <tr>
                <td align='left' valign='middle' class='panelMenuItem'>
                  <html:link page='/users.jsp'><bean:message key="users.title"/></html:link>
                </td>
              </tr>
              <tr>
                <td align='left' valign='middle' class='panelMenuItem'>
                  <html:link page='/locks.jsp'><bean:message key="locks.title"/></html:link>
                </td>
              </tr>
            </table>
            <hr>
            <br>
            <br>
          </td>
          <td class='content' align='left' valign='top' width='100%' height='100%'>
            <br>
            <span class='contentText'>
              <bean:message key="app.welcome"/>
            </span>
          </td>
        </tr>
      </table>
    </body>
    
  </slide:namespace>
</html:html>
