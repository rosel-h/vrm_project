<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 24/01/2018
  Time: 1:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String user_name=(String)request.getParameter("user_name");
    String user_email=(String)request.getParameter("user_email"); %>

<%=user_name %>
<%=user_email %>