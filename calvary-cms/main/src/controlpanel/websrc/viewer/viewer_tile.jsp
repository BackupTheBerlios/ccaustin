<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>
<bean:define id="viewer" name="viewer" type="org.calvaryaustin.controlpanel.viewer.ViewerForm"/>

	<p>
	<slide:node id="node" uriName='viewer' uriProperty='computedUri' resolveLinks='true'>
		<bean:define id="latestRevision" name="node" property="latestRevision" type="org.apache.slide.taglib.bean.RevisionBean"/>
		<p class="viewerName"><bean:write name='node' property='name'/></p>
		<table width="95%">
			<tr>
				<td width="95%">&nbsp;</td>
				<td nowrap="true">
					<p class="buttonBar"><html:link action='editor' name='viewer' property='parameterMapToFile'>Edit</html:link></p>
				</td>
			</tr>
		</table>
		<p class="tableTitle">Locks</p>
		<display:table width='95%' name='node' property='locks'
			      decorator='org.calvaryaustin.controlpanel.viewer.TableDisplayWrapper'>
		  <display:column property='subjectUri' title='Owner'/>
		  <display:column property='expirationDate' title='Expires'/>
		  <display:column property='lockType' title='Lock Type'/>
		  <display:column property='typeUri' title='Lock URI'/>
		  <display:column property='lockActions' title=''/>
		</display:table>
		<p class="sectionTitle">Latest Revision</p>
		<table width="95%">
			<tr>
				<td width="95%">&nbsp;</td>
				<td nowrap="true">
					<p class="buttonBar"><calvary:viewVersionDetail revisionNumber='<%=latestRevision.getNumber()%>' revisionBranch='<%=latestRevision.getBranch()%>'/></p>
				</td>
			</tr>
		</table>
		<p class="tableTitle">Properties</p>
		<display:table width='95%' name='latestRevision' property='properties'
				  decorator='org.calvaryaustin.controlpanel.viewer.TableDisplayWrapper'>
		  <display:column property='qualifiedName' title='Name'/>
		  <display:column property='value'/>
		</display:table>
	</slide:node>	
</p>
