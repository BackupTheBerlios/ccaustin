<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>
<%@ taglib uri="/WEB-INF/display.tld"          prefix="display" %>
<%@ taglib uri="/WEB-INF/calvary.tld"          prefix="calvary" %>
<p>Tips:</p>
<ul>
  <li>All XML tags must end properly (i.e. &lt;p&gt;My text&lt;/p&gt;</li>
  <li>Keep your editing time short to ensure others can edit the same file as well</li>
  <li>Check the <a href="http://ccaustin.berlios.de/tag-guide.html" target="_new">Tag Reference</a> for guides on creating standard text markup tags</li>\
  <li>Some files use special tags not covered in the reference. Refer to the notes at the top of the file or a content administrator for more information</li>
  <li>Remember - feedback to the Control Panel staff helps ensure this application's ease of use improves</li>
</ul>
<html:form action="/editor">
	<html:hidden property="site"/>
	<html:hidden property="path"/>
	<html:hidden property="file"/>
	<html:hidden property="contentType"/>
	<p>
		<bean:message key="editorForm.contentType.displayname"/>: <bean:write name="editor" property="contentType"/>
	</p>
	<p class="fieldLabel"><bean:message key="editorForm.content.displayname"/>:</p>
	<p class="error"><html:errors property="content"/></p>
	<p>
		<html:textarea property="content" rows="40" cols="80"/>
	</p>
	<p class="fieldLabel"><bean:message key="editorForm.reasonForChange.displayname"/>:</p>
	<p class="error"><html:errors property="reasonForChange"/></p>
	<p>
		<html:textarea property="reasonForChange" rows="10" cols="80"/>
	</p>
	<p class="buttonBar">
		<!--<input type="submit" name="Preview" value="Preview"/>-->  
		<input type="Submit" name="Cancel" value="Cancel"/>
		<input type="Submit" name="Save" value="Save"/>
	</p>
	 
</html:form>
