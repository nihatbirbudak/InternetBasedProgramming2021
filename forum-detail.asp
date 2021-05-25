<%
pageName = "forum-detail.asp?id="&request.querystring("id")
%>
<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<%if Session("UserLoggedIn") <> "" then%>
<%
    Response.Buffer = true
    set Forum = dbConn.Execute("select * from Forum where ID="&request.querystring("id"))
    dim views 
    views = Forum("Views") + 1
    set User = dbConn.Execute("select * from Users where id="&Forum("WriterId"))
    set Comment = dbConn.Execute("select * from ForumComment where ForumId="&request.querystring("id"))
    dbConn.Execute("Update Forum Set Views="&views&" where ID="&request.querystring("id"))

    if request.form("commentSubmit") then
        Set ForumComment = server.CreateObject("ADODB.Recordset")
        ForumComment.Open "ForumComment", dbConn, 1, 3
        ForumComment.AddNew
        ForumComment("Content") =  trim(request("Content"))
        ForumComment("ForumId") = request.QueryString("id")
        ForumComment("WriterId") = Session("id")
        ForumComment("LoadTime") = request("LoadTime")
        ForumComment.Update
        ForumComment.close
        set ForumComment = Nothing
    end if

    if request("delete") = "delete" then
        dbConn.Execute("delete * from ForumComment where ID="& request.QueryString("DeleteId"))
        response.redirect(pageName)
    end if

    if request("update") then
        sqlUpdate = "Update ForumComment Set Content='"&request("Content")&"' , LoadTime='"& request("LoadTime")&"' where ID="&request("id")
        dbConn.Execute(sqlUpdate)
    end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
   <!-- #include file="Views/Shared/header.asp" -->
</head>
<body>
    <!-- Nabvar -->
    <div class="navbar clearfix">
        <!-- #include file="Views/Shared/nav.asp" -->
    </div>
    <!-- Main Content -->
    <div id="main" class="row forum-container">
        <!-- Sidebar Display None -->
        <div class="p1 sidebar-none col-3">
            <!-- #include file="Views/Shared/forumSidebar.asp" --> 
        </div>
        <!-- Forum Content -->
        <div class="p1 col-9">
            <!-- Main Forum Content -->
            <div class="forum-detail-card row">
                <div class="forum-detail-left col-3">
                    <h3><%=allFirstUpper(User("Name")&" "&User("Surname"))%></h3>
                    <ul>
                        <li>
                            <img class="forum-detail-user-img" src="img/pp/<%=User("ImgPath")%>" alt="">
                        </li>
                        <li >
                            <p class="italic"><%=allFirstUpper(User("Job"))%></p>
                        </li>
                    </ul>
                </div>
                <div class="forum-detail-rihgt col-9">
                    <div class="forum-detail-top-context row">
                        <span><%=Forum("LoadTime")%></span>
                    </div>
                    <div class="forum-detail-main-context">
                        <h3>
                            <%=Forum("Title")%>
                        </h3>
                        <p>
                            <%=Forum("Content")%>
                        </p>
                    </div>
                </div>
            </div>
            <!-- Comment Area -->
                <%if Session("UserLoggedIn") <> "" then%>
                    <%if Request.QueryString("DeleteId") = "" then%>
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <form action="forum-detail.asp?id=<%=Forum("id")%>" method='post'>
                            <textarea class="comment-textarea" name="Content" id="" cols="30" rows="10"></textarea>
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
                            <form action="forum-detail.asp?id=<%=Forum("id")%>" method='post'>
                                <input type='hidden' name='id' value="<%=Comment("id")%>">
                                <textarea class="comment-textarea" name="Content" id="" cols="30" rows="10"><%=Comment("Content")%></textarea>
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
                                <form action="forum-detail.asp?id=<%=request.QueryString("id")%>&DeleteId=<%=Comment("id")%>" method='post'>
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
                                <%=Comment("Content")%>
                            </p>

                        </div>
                    </div>
                </div>
                <%end if
                Comment.MoveNext
                loop
                %>
        </div>
        <!-- Sidebar -->
        <div class="p1 col-3 sidebar-wis">
            <!-- #include file="Views/Shared/forumSidebar.asp" --> 
        </div>
    </div>
    <!-- Login Page Card Designe -->
    
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%
Else
    ' response.cookies("forumAlert") = true
    response.redirect("forum.asp")
end if
%>
