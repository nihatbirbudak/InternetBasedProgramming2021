<%
pageName = "admin.asp"
%>
<%'if Session("UserLoggedIn") <> "" and Session("Role") = "Admin" then%>
<!DOCTYPE html>
<html lang="en">
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="Views/Shared/header.asp" -->
<body>
    <!-- Nabvar -->
    <div class="navbar clearfix">
        <!-- #include file="Views/Shared/adminNav.asp" -->
    </div>
    <!-- Main Context -->
    <div id="main">
        <div class="admin-container">
            <table id="userAdmin">
                <tr>
                    <th>ID</th>
                    <th>Ad</th>
                    <th>Soyad</th>
                    <th>Email</th>
                    <th>Dogum G�n�</th>
                    <th>�niversite</th>
                    <th>��</th>
                    <th>Cinsiyet</th>
                    <th>�ehir</th>
                    <th>Rol</th>
                </tr>
                <tr>
                    <td>ID</td>
                    <td>Ad</td>
                    <td>Soyad</td>
                    <td>Email</td>
                    <td>Dogum G�n�</td>
                    <td>�niversite</td>
                    <td>��</td>
                    <td>Cinsiyet</td>
                    <td>�ehir</td>
                    <td>Rol</td>
                </tr>
            </table>
        </div>
        <%Response.Write (Request.ServerVariables("QUERY_STRING"))%>
        
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%'Else
    'Response.redirect("index.asp")
'end if
%>
