<%@ page language="java" %>
<%
  // immediately forward to home page
  request.getRequestDispatcher(request.getContextPath() + "/index.do").forward(request, response);
%>
