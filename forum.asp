<%
pageName = "forum.asp"
%>

<!DOCTYPE html>
<html lang="en">
<!-- #include file="function/myFunction.asp" -->
<head>
   <!-- #include file="Views/Shared/header.asp" -->
</head>
<body>
    <!-- Nabvar -->
    <div class="navbar clearfix">
        <!-- #include file="Views/Shared/nav.asp" -->
    </div>
    <!-- Main Context -->
    <div id="main" class="row">
        <!-- Forum Context -->
        <div class="p1 col-9">
            <!-- Sidebar Display None -->
       <div class="p1 sidebar-none col-3">
            <!-- #include file="Views/Shared/forumSidebar.asp" -->    
        </div>
            <div class="form-header row">
                <h2 style="display: inline;">Forum</h2>
                <a href="forumAdd.asp" class="btn btn-edit btn-sm right btn-forum">Yazý Ekle</a>
            </div>
            <!-- #include file="forum-list.asp" -->
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
    <% if Request.Cookies("forumAlert") = "-1" then%>
        <script>
        Swal.fire({
            title: 'Lütfen Giriþ Yapýn!',
            text: 'Foruma Devam Etmek Ýçin Giriþ Yapýn',
            icon: 'warning',
            confirmButtonText: 'Tamam' 
        })
        </script>
    <%Response.cookies("forumAlert") = ""
    end if
    %>
</body>
</html>
