<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->

<%
pageName = "user.asp"
%>
<%
    set Users = dbConn.Execute("select * from Users;")
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
    <div id="main">
        <!-- User List -->
        <%Do while not Users.EOF%>
        <div class="user-container">
            <div class="user-card">
                <img src="img/pp/<%=Users("ImgPath")%>" alt="">
                <h1><a href="userPage.asp?UserId=<%=Users("id")%>"><%= allFirstUpper(Users("Name") & " " & Users("Surname"))%></a></h1>
                <p class="title"><%=allFirstUpper(Users("Job"))%></p>
                <p><%=Users("University")%></p>
            </div>
        </div>
        <%
        Users.MoveNext
        loop
        %>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%

%>
