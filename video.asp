<%
pageName = "video.asp"
%>
<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<%
    set video = dbConn.Execute("select * from Video")

    if request("saveVideo") = "true" then
        dbConn.Execute("INSERT INTO Video (VideoUrl) VALUES ('"&request("videoUrl")&"')")
        response.redirect("video.asp")
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
    <div id="main">
        <!-- User List -->
        <div class="row">
            <%if Session("UserLoggedIn") = "true" then
                if Session("Role") = "Admin" then%>
                    <form action='video.asp' method='post'>
                        <input type='text' placeholder="Video Url Giriniz" class="input-file" name='videoUrl'>
                        <button type="submit" value="true" name="saveVideo" class="btn btn-Add">Kaydet</button>
                    </form>
                <%end if%>
            <%end if%>
        </div>
        <div class="row">
            <%do while not video.EOF%>
                <div class="user-container">
                    <div class="user-card photo-card">
                        <iframe width="" height="" src="<%=video("VideoUrl")%>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                        <a href="videoDetail.asp?id=<%=video("ID")%>">Ýncele</a>
                    </div>
                </div>
            <%video.MoveNext
            loop
            %>
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
