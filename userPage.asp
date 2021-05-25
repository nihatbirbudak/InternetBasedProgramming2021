<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->

<%
response.Buffer = true
Response.Expires = -100
pageName = "userPage.asp?UserId="&request.QueryString("UserId")
%>

<%
    set User = dbConn.Execute("select * from Users where id="& request.QueryString("UserId"))

    if request.form("commentSubmit") then
        Set UserComment = server.CreateObject("ADODB.Recordset")
        UserComment.Open "UserComment", dbConn, 1, 3
        UserComment.AddNew
        UserComment("Context") =  trim(request("Context"))
        UserComment("UserId") = request.QueryString("UserId")
        UserComment("WriterId") = Session("id")
        UserComment("LoadTime") = request("LoadTime")
        UserComment.Update
        UserComment.close
        set UserComment = Nothing
    end if

    if request("delete") = "delete" then
        dbConn.Execute("delete * from UserComment where ID="& request.QueryString("DeleteId"))
        response.redirect(pageName)
    end if

    if request("update") then
        sqlUpdate = "Update UserComment Set Context='"&request("Context")&"' , LoadTime='"& request("LoadTime")&"' where ID="&request("id")
        dbConn.Execute(sqlUpdate)
    end if
    set Comment = dbConn.Execute("select * from UserComment where UserId="& request.QueryString("UserId"))

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
            <div class="row ContainerBox">
                <div class="col-4 col-4-sm" >
                    <div class="user-container">
                        <div class="user-card">
                            <img src="img/pp/<%=User("ImgPath")%>" alt="">
                            <h1><%=allFirstUpper(User("Name")& " " & User("Surname"))%></h1>
                            <p class="title"><%=allFirstUpper(User("Job"))%></p>
                            <p><%=allFirstUpper(User("University"))%></p>
                        </div>
                    </div>
                </div>
                <div class="col-8 col-8-sm">
                    <div class="description-area">
                        <p>
                            <%=User("Desc")%>
                        </p>
                    </div>
                </div>
            </div>
            <div class="comment-container">
                <!-- Comment Area -->
                <%if Session("UserLoggedIn") <> "" then%>
                    <%if Request.QueryString("DeleteId") = "" then%>
                <div class="forum-detail-card row forum-detail-comment">
                    <div class="comment-items">
                        <form action="userPage.asp?UserId=<%=User("id")%>" method='post'>
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
                        <form action="userPage.asp?UserId=<%=User("id")%>" method='post'>
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
                                <form action="userPage.asp?UserId=<%=request.QueryString("UserId")%>&DeleteId=<%=Comment("id")%>" method='post'>
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
