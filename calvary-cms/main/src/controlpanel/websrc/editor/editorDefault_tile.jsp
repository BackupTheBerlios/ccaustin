<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>

<html:form action="/editor">
	<p>
		<html:text property="contentType"/>
	</p>
	<p>
		<html:textarea property="content" rows="40" cols="80"/>
	</p>
</html:form>
