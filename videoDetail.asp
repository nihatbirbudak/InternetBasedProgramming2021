<%
pageName = "videoDetail.asp?id="&request.querystring("id")
%>
<!-- #include file="DbContent/dbConnect.asp"-->
<!-- #include file="function/myFunction.asp" -->
<%
    set video = dbConn.Execute("select * from Video where ID="&request.querystring("id"))

    if request.form("commentSubmit") then
        Set VideoComment = server.CreateObject("ADODB.Recordset")
        VideoComment.Open "VideoComment", dbConn, 1, 3
        VideoComment.AddNew
        VideoComment("Context") =  trim(request("Context"))
        VideoComment("VideoId") = request.QueryString("id")
        VideoComment("WriterId") = Session("id")
        VideoComment("LoadTime") = request("LoadTime")
        VideoComment.Update
        VideoComment.close
        set VideoComment = Nothing
    end if
    if request("delete") = "delete" then
        dbConn.Execute("delete * from VideoComment where ID="& request.QueryString("DeleteId"))
        response.redirect("videoDetail.asp?id="&request.querystring("id"))
    end if

    if request("update") then
        sqlUpdate = "Update VideoComment Set Context='"&request("Context")&"' , LoadTime='"& request("LoadTime")&"' where ID="&request("id")
        dbConn.Execute(sqlUpdate)
    end if

    set Comment = dbConn.Execute("select * from VideoComment where VideoId="&request.QueryString("id"))
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
            <div class="comment-container">
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <div>
                            <iframe width="100%" height="420" src="<%=video("VideoUrl")%>" frameborder="0" allowfullscreen></iframe>
                    </div>
                    </div>
                </div>
                <!-- Comment Area -->
                <%if Session("UserLoggedIn") <> "" then%>
                    <%if Request.QueryString("DeleteId") = "" then%>
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <form action="videoDetail.asp?id=<%=Video("id")%>" method='post'>
                            <textarea class="comment-textarea" name="Context" id="" cols="30" rows="10"></textarea>
                            <input type='hidden' value="<%=date()%>" name='LoadTime'>
                            <button type="submit" value="true" name="commentSubmit" class="btn btn-outline btn-primary right">Gönder</button>
                        </form>
                    </div>
                </div>
                    <%end if%>
                <%end if%>
                <!-- Comment Card -->
                <%
                do while not Comment.EOF
                set dbUser = dbConn.Execute("select * from Users where id="&Comment("WriterId"))
                writerName = allFirstUpper(dbUser("Name")&" "&dbUser("Surname"))
                if CInt(request("edit")) = CInt(Comment("id")) then%>
                    <div class="forum-detail-card row forum-detail-comment">
                        <div class="comment-items">
                            <form action="videoDetail.asp?id=<%=Video("id")%>" method='post'>
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
                                <form action="videoDetail.asp?id=<%=request.QueryString("id")%>&DeleteId=<%=Comment("id")%>" method='post'>
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
