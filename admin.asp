<%
pageName = "admin.asp"
%>
<%if Session("UserLoggedIn") <> "" and Session("Role") = "Admin" then%>
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="DbContent/dbConnect.asp" -->
<%
    sql = "select * from Users"
    if Request.QueryString("orderBy") <> "" then
        sql = sql & " ORDER BY " & Request.QueryString("orderBy")
    end if
    set Users = dbConn.Execute(sql)
%>
<!DOCTYPE html>
<html lang="en">
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
                    <th><a href="admin.asp?orderBy=id">ID</a></th>
                    <th><a href="admin.asp?orderBy=Name">Ad</a></th>
                    <th><a href="admin.asp?orderBy=Surname">Soyad</a></th>
                    <th><a href="admin.asp?orderBy=Email">Email</a></th>
                    <th><a href="admin.asp?orderBy=Birthday">Dogum Günü</a></th>
                    <th><a href="admin.asp?orderBy=University">Üniversite</a></th>
                    <th><a href="admin.asp?orderBy=Job">Ýþ</a></th>
                    <th><a href="admin.asp?orderBy=Gender">Cinsiyet</a></th>
                    <th><a href="admin.asp?orderBy=City">Þehir</a></th>
                    <th><a href="admin.asp?orderBy=Role">Rol</a></th>
                    <th>Ýþlemler</th>
                </tr>
                <%do while not Users.eof%>
                <tr>
                <%if CInt(Request.QueryString("id")) = CInt(Users("id")) then%>
                <form action='updateUser.asp' method='post'>
                    <td><%=Users("id")%></td>
                    <input type='hidden' name='id' value="<%=Users("id")%>">
                    <td><input type='text' name='Name' value="<%=Users("Name")%>"></td>
                    <td><input type='text' name='Surname' value="<%=Users("Surname")%>"></td>
                    <td><input type="email" name='Email' value="<%=Users("Email")%>"></td>
                    <td><%=Users("Birthday")%></td>
                    <td><input type='text' name='University' value="<%=Users("University")%>"></td>
                    <td><input type='text' name='Job' value="<%=Users("Job")%>"></td>
                    <td><%=Users("Gender")%></td>
                    <td><% set CityName = dbConn.Execute("select CityName from Citys where id="&Users("CityId")) 
                    Response.Write (CityName("CityName"))%></td>
                    <td>
                        <select name="Role">
                        <%roles = array("Admin","User","Editör")
                        for each role in roles
                            if role = Users("Role") then %>
                                <option selected ><%=role%></option>
                            <%else%>
                                <option><%=role%></option>
                            <%end if%>
                        <%next%>
                        </select>
                    </td>
                    <td>
                        <a class="btn btn-sm btn-danger" href="admin.asp">Ýptal</a>
                        <button class="btn btn-sm btn-edit">güncelle</button>
                    </td>
                </form>
                <%Else%>
                    <td><%=Users("id")%></td>
                    <td><%=Users("Name")%></td>
                    <td><%=Users("Surname")%></td>
                    <td><%=Users("Email")%></td>
                    <td><%=Users("Birthday")%></td>
                    <td><%=Users("University")%></td>
                    <td><%=Users("Job")%></td>
                    <td><%=Users("Gender")%></td>
                    <td><% set CityName = dbConn.Execute("select CityName from Citys where id="&Users("CityId")) 
                    Response.Write (CityName("CityName"))%></td>
                    <td><%=Users("Role")%></td>
                    <td>
                        <a class="btn btn-sm btn-danger" href="delUser.asp?id=<%=Users("id")%>">sil</a>
                        <a class="btn btn-sm btn-edit" href="admin.asp?id=<%=Users("id")%>&<%=Request.ServerVariables("QUERY_STRING")%>">güncelle</a>
                    </td>
                </tr>
                <%end if%>
                <%Users.MoveNext
                loop%>
            </table>
        </div>
        
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>
<%Else
    Response.redirect("index.asp")
end if
%>
