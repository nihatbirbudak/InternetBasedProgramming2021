<%
pageName = "forum-detail.asp"
%>
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="DbContent/dbConnect.asp" -->
<%if Session("UserLoggedIn") <> "" then%>
<%
    if Request("add") then
        set Forum = server.CreateObject("adodb.recordset")
        Forum.Open "Forum",dbConn, 1,3
        Forum.AddNew
        Forum("Title") = request("Title")
        Forum("Content") = request("Content")
        Forum("WriterId") = Session("id")
        Forum("LoadTime") = request("LoadTime")
        Forum.Update
        Forum.close
        set Forum = Nothing
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
    <!-- Main Context -->
    <div id="main" class="row forum-container">
        <!-- Sidebar Display None -->
        <div class="p1 sidebar-none col-3">
                    <!-- #include file="Views/Shared/forumSidebar.asp" -->

           
        </div>
        <!-- Forum Context -->
        <div class="p1 col-9">
            <!-- Main Forum Context -->
            
            <!-- Comment Area -->
            <div class="forum-detail-card row forum-detail-comment">
                <div class="comment-items"> 
                    <form action='forumAdd.asp' method='post'>
                        <input type='text' name='Title' placeholder="Baþlýk">
                        <textarea class="comment-textarea" name="Content" cols="30" rows="10"></textarea>
                        <input type='hidden' value="<%=date()%>" name='LoadTime'>
                        <button class="btn btn-outline btn-primary right" value="true" name="add">Gönder</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- Sidebar -->
        <div class="p1 col-3 sidebar-wis">
                        <!-- #include file="Views/Shared/forumSidebar.asp" -->

        </div>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%
Else
    response.cookies("forumAlert") = true
    response.redirect("forum.asp")
end if

%>