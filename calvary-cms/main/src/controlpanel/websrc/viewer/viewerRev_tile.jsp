<%@ page import="org.calvaryaustin.controlpanel.viewer.ViewerForm" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>
<%
	// get our values that the taglibs won't let you ref via a xxxName, xxxProperty set
	ViewerForm viewer = (ViewerForm)request.getAttribute("viewer");
	String number = viewer.getRev();
	String branch = viewer.getBranch();
%>
<p>
	<slide:node id="node" uriName='viewer' uriProperty='computedUri' resolveLinks='true'>
		<slide:revision id='revision' number='<%=number%>' branch='<%=branch%>'>
			<slide:content id='content'/>
			<p class="tableTitle">Properties</p>
			<display:table width='95%' name='revision' property='properties'
					  decorator='org.calvaryaustin.controlpanel.viewer.TableDisplayWrapper'>
			  <display:column property="qualifiedName" title="Name"/>
			  <display:column property="value"/>
			</display:table>
		</slide:revision>
	</slide:node>	
</p>
