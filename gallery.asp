<%
pageName = "gallery.asp"
%>
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="DbContent/dbConnect.asp" -->
<%
    set images = dbConn.Execute("select * from Gallery")
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
        <%if Session("UserLoggedIn") = "true" then
            if Session("Role") = "Admin" then%>
                <div class="row">
                    <form action='savePhoto.asp'  enctype="multipart/form-data" method="POST">
                        <input type='file' name='file2' class="input-file">
                        <button type="submit" class="btn btn-Add">Fotograf Yükle</button>
                    </form>
                </div>
            <%end if%>
        <%end if%>
        <div class="row">
            <%Do while not images.EOF%>
                <div class="user-container">
                        <a href="photoDetail.asp?ImgId=<%=images("id")%>">
                            <div class="user-card photo-card">
                                <img src="img/gallery/<%=images("imgPath")%>" alt="">
                            </div>
                        </a>
                </div>
            <%images.MoveNext
            loop%>
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
