<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>

<% String uri = (String)request.getAttribute("uri"); %>
<p>uri=<%=uri%></p>
	<slide:node id="node" uri="<%=uri%>">
<p>
		URI:<bean:write name="node" property="uri"/>
</p>
<p>
		Name:<bean:write name="node" property="name"/>
</p>
<p>
  <logic:equal name='node' property='hasChildren' value='true'>
  	<!-- Its a folder, show its contents -->
  	<logic:iterate id='child' name='node' property='children'>
        <p>Child:<bean:write name='child' property='name'/>
        	<br/>has children? <bean:write name='child' property='hasChildren'/>
      	</p>
        
    </logic:iterate>	
  </logic:equal>
  
  <logic:equal name='node' property='hasChildren' value='false'>
  	<!-- Its a file, show details - or should this be another JSP -->
  </logic:equal>
</p>
	</slide:node>
