<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld"   prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"  prefix="slide" %>

<html>
  <slide:namespace id='namespace'>
    
    <head>
      <title>Slide Tag Library for Struts - Example</title>
    </head>
    
    <body bgcolor='#ffffff'>
      <h1>Slide Tag Library for Struts - Example</h1>
      <hr>
      
      <h2>&lt;slide:domain&gt;</h2>
      <slide:domain id='domain'>
        <h3>Namespaces Iteration:</h3>
        <ul><logic:iterate id='ns' name='domain' property='namespaces'>
          <li><bean:write name='ns' property='name'/></li>
        </logic:iterate></ul>
      </slide:domain>
      
      <hr>
      
      <h2>&lt;slide:namespace&gt;</h2>
      <slide:namespace id='defaultNamespace'>
        <h3>Default namespace:</h3>
        <ul>
          <li>name: <b><bean:write name='defaultNamespace' property='name'/></b></li>
          <li>filesPath: <b><bean:write name='defaultNamespace' property='filesPath'/></b></li>
          <li>usersPath: <b><bean:write name='defaultNamespace' property='usersPath'/></b></li>
          <li>guestPath: <b><bean:write name='defaultNamespace' property='guestPath'/></b></li>
        </ul>
      </slide:namespace>
      
      <hr>
      
      <h2>&lt;slide:node&gt;, &lt;slide:revision&gt;, &lt;slide:property&gt;</h2>
      <form method='GET'>
        <logic:present parameter='uri'>
          URI: <input type='text' name='uri' value='<%= request.getParameter("uri") %>'>
        </logic:present>
        <logic:notPresent parameter='uri'>
          URI: <input type='text' name='uri' value=''>
        </logic:notPresent>
        <input type='submit'>
      </form>
      <logic:present parameter='uri'>
        <slide:node id='node' uri='<%= request.getParameter("uri") %>'>
          
          <h3>Node:</h3>
          <ul>
            <li>name: <b><bean:write name='node' property='name'/></b></li>
            <li>uri: <b><bean:write name='node' property='uri'/></b></li>
            <li>hasChildren: <b><bean:write name='node' property='hasChildren'/></b></li>
            <li>hasRevisions: <b><bean:write name='node' property='hasRevisions'/></b></li>
            <li>isLocked: <b><bean:write name='node' property='isLocked'/></b></li>
            <li>isVersioned: <b><bean:write name='node' property='isVersioned'/></b></li>
            <li>parent: <b><bean:write name='node' property='parent'/></b></li>
            <li>type: <b><bean:write name='node' property='type'/></b></li>
          </ul>
          
          <h3>Children:</h3>
          <logic:equal name='node' property='hasChildren' value='true'>
            <ul><logic:iterate id='child' name='node' property='children'>
              <li><bean:write name='child' property='name'/></li>
            </logic:iterate></ul>
          </logic:equal>
          
          <h3>Revisions:</h3>
          <logic:equal name='node' property='hasRevisions' value='true'>
            <ul><logic:iterate id='revision' name='node' property='revisions'>
              <li><bean:write name='revision'/></li>
                <h3>Properties:</h3>
                <ul><logic:iterate id='property' name='revision' property='properties'>
                  <li>
                    <ul>
                      <li>namespace: <b><bean:write name='property' property='namespace'/></b></li>
                      <li>name: <b><bean:write name='property' property='name'/></b></li>
                      <li>value: <b><bean:write name='property' property='value'/></b></li>
                    </ul>
                  </li>
                </logic:iterate></ul>
            </logic:iterate></ul>
          </logic:equal>
          
          <h3>Locks:</h3>
          <logic:equal name='node' property='isLocked' value='true'>
            <ul><logic:iterate id='lock' name='node' property='locks'>
              <li>
                <ul>
                  <li>objectUri: <b><bean:write name='lock' property='objectUri'/></b></li>
                  <li>subjectUri: <b><bean:write name='lock' property='subjectUri'/></b></li>
                  <li>typeUri: <b><bean:write name='lock' property='typeUri'/></b></li>
                  <li>expirationDate: <b><bean:write name='lock' property='expirationDate'/></b></li>
                  <li>isExclusive: <b><bean:write name='lock' property='isExclusive'/></b></li>
                  <li>isShared: <b><bean:write name='lock' property='isShared'/></b></li>
                </ul>
              </li>
            </logic:iterate></ul>
          </logic:equal>
          
          <h3>Permissions:</h3>
          <ul><logic:iterate id='permission' name='node' property='permissions'>
            <li>
              <ul>
                <li>objectUri: <b><bean:write name='permission' property='objectUri'/></b></li>
                <li>subjectUri: <b><bean:write name='permission' property='subjectUri'/></b></li>
                <li>actionUri: <b><bean:write name='permission' property='actionUri'/></b></li>
                <li>isInheritable: <b><bean:write name='permission' property='isInheritable'/></b></li>
                <li>isNegative: <b><bean:write name='permission' property='isNegative'/></b></li>
              </ul>
            </li>
          </logic:iterate></ul>
          
        </slide:node>
      </logic:present>
      
    </body>
    
  </slide:namespace>
</html>
