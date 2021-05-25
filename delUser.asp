<!-- #include file="function/myFunction.asp" -->
<!-- #include file="DbContent/dbConnect.asp" -->
<%
    dbConn.Execute("delete * from Forum where WriterId="&request.QueryString("id"))
    dbConn.Execute("delete * from ForumComment where WriterId="&request.QueryString("id"))
    dbConn.Execute("delete * from GalleryComment where WriterId="&request.QueryString("id"))
    dbConn.Execute("delete * from UserComment where WriterId="&request.QueryString("id"))
    dbConn.Execute("delete * from VideoComment where WriterId="&request.QueryString("id"))
    dbConn.Execute("delete * from UserHobies where UserId="&request.QueryString("id"))
    dbConn.Execute("delete * from Users where id="&request.QueryString("id"))
    response.redirect("admin.asp")
%>