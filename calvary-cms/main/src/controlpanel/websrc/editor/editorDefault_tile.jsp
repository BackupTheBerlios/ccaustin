<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>

<html:form action="/editor">
	<html:hidden property="site"/>
	<html:hidden property="path"/>
	<html:hidden property="file"/>
	<html:hidden property="contentType"/>
	<p>
		Content Type: <bean:write name="editor" property="contentType"/>
	</p>
	<p>
		<html:textarea property="content" rows="40" cols="80"/>
	</p>
	<p class="buttonBar">
		<!--<input type="submit" name="Preview" value="Preview"/>-->  
		<input type="Submit" name="Cancel" value="Cancel"/>
		<input type="Submit" name="Save" value="Save"/></p>
	 
</html:form>
