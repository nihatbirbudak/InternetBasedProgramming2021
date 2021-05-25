<%
pageName = "photoDetail.asp?ImgId="&request.QueryString("ImgId")
%>
<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<%
set image = dbConn.Execute("select * from Gallery where ID="&request.QueryString("ImgId"))
set Comment = dbConn.Execute("select * from GalleryComment where GalleryId="&request.QueryString("ImgId"))

if request.form("commentSubmit") then
    Set GalleryComment = server.CreateObject("ADODB.Recordset")
    GalleryComment.Open "GalleryComment", dbConn, 1, 3
    GalleryComment.AddNew
    GalleryComment("Context") =  trim(request("Context"))
    GalleryComment("GalleryId") = request.QueryString("ImgId")
    GalleryComment("WriterId") = Session("id")
    GalleryComment("LoadTime") = request("LoadTime")
    GalleryComment.Update
    GalleryComment.close
    set GalleryComment = Nothing
end if

if request("delete") = "delete" then
    dbConn.Execute("delete * from GalleryComment where ID="& request.QueryString("DeleteId"))
end if

if request("update") then
    sqlUpdate = "Update GalleryComment Set Context='"&request("Context")&"' , LoadTime='"& request("LoadTime")&"' where ID="&request("id")
    dbConn.Execute(sqlUpdate)
end if
%>

<!DOCTYPE html>
<html lang="en">

<!-- #include file="Views/Shared/header.asp" -->
<body>
    <!-- Nabvar -->
    <div class="navbar clearfix">
        <!-- #include file="Views/Shared/nav.asp" -->
    </div>
    <!-- Main Context -->
    <div id="main" class="row forum-container">
        <!-- Forum Context -->
        <div class="p1">
            <!-- Main Forum Context -->
            <div class="row comment-container">
                <div>
                    <div class="user-card">
                        <img src="img/gallery/<%=image("imgPath")%>" alt="">
                    </div>
                </div>
            </div>
            <div class="comment-container">
                <!-- Comment Area -->
                <%if Session("UserLoggedIn") <> "" then%>
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <form action="photoDetail.asp?ImgId=<%=image("id")%>" method='post'>
                            <textarea class="comment-textarea" name="Context" id="" cols="30" rows="10"></textarea>
                            <input type='hidden' value="<%=date()%>" name='LoadTime'>
                            <button type="submit" value="true" name="commentSubmit" class="btn btn-outline btn-primary right">Gönder</button>
                        </form>
                    </div>
                </div>
                <%end if%>
                <!-- Comment Card -->
                <%
                do while not Comment.EOF
                set dbUser = dbConn.Execute("select * from Users where id="&Comment("WriterId"))
                writerName = allFirstUpper(dbUser("Name")&" "&dbUser("Surname"))
                if CInt(request("edit")) = CInt(Comment("id")) then%>
                    <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <form action="photoDetail.asp?ImgId=<%=image("id")%>" method='post'>
                            <input type='hidden' name='id' value="<%=Comment("id")%>">
                            <textarea class="comment-textarea" name="Context" id="" cols="30" rows="10"><%=Comment("Context")%></textarea>
                            <input type='hidden' value="<%=date()%>" name='LoadTime'>
                            <button type="submit" value="true" name="update" class="btn btn-outline btn-primary right">Gönder</button>
                        </form>
                    </div>
                </div>
                <%Else%>
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="forum-detail-left col-3">
                        <h3><%=writerName%></h3>
                        <ul>
                            <li>
                                <img class="forum-detail-user-img" src="img/pp/<%=dbUser("ImgPath")%>" alt="">
                            </li>
                            <%
                            if Session("UserLoggedIn") = "true" then
                                if Session("Role") = "Admin" or Session("id") = dbUser("id") then%>
                            <li>
                                <form action="photoDetail.asp?ImgId=<%=request.QueryString("ImgId")%>&DeleteId=<%=Comment("id")%>" method='post'>
                                    <div class="comment-edit-area">
                                        <button type="submit" value="delete" name="delete" class="btn-sm btn-danger" >Sil</button>
                                        <button value="<%=Comment("id")%>" name="edit" class="btn-sm btn-edit">Düzenle</button>
                                    </div>
                                </form>
                            </li>
                                <%end if
                            end if%>
                        </ul>
                    </div>
                    <div class="forum-detail-rihgt col-9">
                        <div class="forum-detail-top-context row">
                            <span><%=Comment("LoadTime")%></span>
                        </div>
                        <div class="forum-detail-main-context">
                            <p>
                                <%=Comment("Context")%>
                            </p>

                        </div>
                    </div>
                </div>
                <%end if
                Comment.MoveNext
                loop
                %>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%
%>


