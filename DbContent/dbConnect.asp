<%
    Set dbConn = Server.CreateObject("ADODB.Connection")
    dbConn.Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("DB.mdb"))
%>