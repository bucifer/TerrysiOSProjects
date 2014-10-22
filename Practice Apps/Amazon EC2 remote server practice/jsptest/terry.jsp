<html>
<head>
<title>Terry BU JSP Test</title>
</head>
<body>

<%-- START --%>
<%
    out.println("HELLO WORLD TERRY BU");
%>

<% out.println("Running first program in JSP."); %>
<%= new String("Instantiated String") %>

  Today is: <%= new java.util.Date().toString() %>

<%-- END --%>

</body>
</html>