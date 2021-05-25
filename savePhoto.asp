<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="function/ShadowUpload.asp" -->

<%
Dim objUpload
Set objUpload=New ShadowUpload
set Gallery = server.CreateObject("adodb.Recordset")
If objUpload.FileCount = 0 Then
    response.redirect("gallery.asp")
Else
    fileName = RandomName(10)
    fileType = Split(objUpload.File(0).ContentType,"/")
    fileName = fileName&"."&fileType(1)
    if fileType(1) = "jpeg" or fileType(1) = "png" then
        objUpload.File(0).FileName = fileName
        dbConn.Execute("INSERT INTO Gallery (imgPath) VALUES ('"&fileName&"')")
        Call objUpload.File(0).SaveToDisk(Server.MapPath("img/gallery"), "")
    end if
    response.redirect("gallery.asp")
end if
%>
<%
    'Db Close
    dbConn.close
    set dbConn= Nothing
%>