<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>
<p>
	<slide:node id="node" uriName='viewer' uriProperty='computedUri' resolveLinks='true'>
		<p class="viewerName"><bean:write name='node' property='name'/></p>
		<p class="tableTitle">Locks</p>
		<display:table width='95%' name='node' property='locks'
			      decorator='org.calvaryaustin.controlpanel.viewer.TableDisplayWrapper'>
		  <display:column property="subjectUri" title="Owner"/>
		  <display:column property="expirationDate" title="Expires"/>
		  <display:column property="lockType" title="Lock Type"/>
		  <display:column property="typeUri" title="Lock URI"/>
		  <display:column property="lockActions" title=""/>
		</display:table>
		<p class="tableTitle">Revisions</p>
		<display:table width='95%' name='node' property='revisions'
			      decorator='org.calvaryaustin.controlpanel.viewer.TableDisplayWrapper'>
		  <display:column property="linkedNumber" title="Version" width="25%"/>
		  <display:column property="branch" width="25%"/>
		  <display:column property="viewActions" title="Actions" width="50%"/>
		</display:table>
	</slide:node>	
</p>
