<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>

<calvary:browserBreadcrumb/>

<p>
	<slide:node id="node" uriName='browser' uriProperty='computedUri'>
	  <logic:equal name='node' property='hasChildren' value='true'>
		  <!-- Its a folder, show its contents -->
		<display:table width='95%' name='node' property='children'
				 decorator='org.calvaryaustin.controlpanel.browser.TableDisplayWrapper'>
		  <display:column property="typeIcon" width="32" title=""/>
		  <display:column property="linkedName" title="Folder Listing" styleClass='browserTableCell'/>
		</display:table>
	  </logic:equal>
	  
	  <logic:equal name='node' property='hasChildren' value='false'>
		  <!-- Its a file, show details - or should this be another JSP -->
	  </logic:equal>
	</slide:node>
</p>
