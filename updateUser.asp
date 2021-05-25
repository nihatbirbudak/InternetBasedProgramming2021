<!-- #include file="function/myFunction.asp" -->
<!-- #include file="DbContent/dbConnect.asp" -->
<%
    sql = "Update Users Set Name='"&request("Name")&"',Surname='"&request("Surname")&"',Email='"&request("Email")&"',Job='"&request("Job")&"',University='"&request("University")&"',Role='"&request("Role")&"' where id="&Request("id")
    dbConn.Execute(sql)
    response.redirect("admin.asp")
%>