<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld"   prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"   prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"  prefix="slide" %>

<p>
  <html:errors/>
</p>
<html:form action='/addUserCreate' focus='username'>
  <table border='0'>
    <tr>
      <td align='right' class='fieldLabel'>
        <bean:message key='userForm.label.username'/>:
      </td>
      <td align='left'>
        <html:text property='username' size='32'/>
      </td>
    </tr>
    <tr>
      <td align='right' class='fieldLabel'>
        <bean:message key='userForm.label.password'/>:
      </td>
      <td align='left'>
        <html:password property='password' size='32' redisplay='false'/>
      </td>
    </tr>
    <tr>
      <td align='right' class='fieldLabel'>
        <bean:message key='userForm.label.roles'/>
      </td>
      <td align='left'>
        <html:checkbox property='hasRootRole'/>:
        <span><bean:message key='userForm.label.rootRole'/></span>
      </td>
    </tr>
    <tr>
      <td colspan='2' class='buttonBar'>
		<input type="Submit" name="Create" value="Create"/>
      </td>
    </tr>
  </table>
</html:form>
