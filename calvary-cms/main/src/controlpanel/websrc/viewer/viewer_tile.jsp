<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>
<p>URI=<bean:write name='viewer' property='computedUri'/></p>
<p>
	<slide:node id="node" uriName='viewer' uriProperty='computedUri' resolveLinks='true'>
		<p>Name: <bean:write name='node' property='name'/></p>
		<p>Type: <bean:write name='node' property='type'/></p>
		<p>Versioned? <bean:write name='node' property='isVersioned'/></p>
		<p>Locked? <bean:write name='node' property='isLocked'/></p>
		<p>Locks</p>
		<display:table width='95%' name='node' property='locks'>
		  <display:column property="subjectUri"/>
		  <display:column property="expirationDate"/>
		  <display:column property="isExclusive"/>
		  <display:column property="isShared"/>
		</display:table>
		<p>Revisions</p>
		<display:table width='95%' name='node' property='revisions'>
		  <display:column property="number"/>
		  <display:column property="branch"/>
		</display:table>
	</slide:node>	
</p>
