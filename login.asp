<%
pageName = "layout.asp"
Response.Buffer=True
Response.Expires = -100
%>
<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->

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
        <!-- Top Col-12 Context -->
<%


login = request.form("login")

if login = "logout" Then
    Session("UserLoggedIn") = ""
    response.redirect ("index.asp")
Else
    if Session("UserLoggedIn") = "true" then
        UserLoggined
    Else
        if login = "true" then
            CheckLogin
        Else
            ShowLogin
        end if
    end if
end if


'ShowLogin = Kullýcýný login olmasý icin gereken kartý göseter
Sub ShowLogin
%>
<div>
    <div class="card-section">
        <form action="login.asp" method="post">
            <div class="pt-4 ">
                <label for="Email">E-Mail </label>
                <input type="text" name="Email" placeholder="E-Mail">
                <label for="pass">Þifre: </label>
                <input type="Password" placeholder="Þifre" name="Password" id="">
                <input type=hidden name=login value=true>
                <div class="text-align-center">
                    <button class="btn btn-outline btn-primary btn-login" type="submit">Giriþ</button>
                    <div class="sing-up">
                        <a href="register.asp">Kayýt ol</a>
                        <a style="padding: 0 5px;"> | </a>
                        <a href="">Þifremi Unuttum</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<%
End Sub

'UserLoggined = Kullanýcý login olmuþ bilgilerini gösters
Sub UserLoggined
    response.redirect("index.asp")
%>
<%
end sub

sub CheckLogin
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("DB.mdb"))
userEmail = request.form("Email")
userPass = request.form("Password")

sql = "SELECT * FROM Users WHERE Email='"& userEmail & "' AND Password='"& userPass & "'"
set CurrentUser = db.Execute(sql)

set Rs = Server.CreateObject("adodb.recordset")

rs.open sql, db, 1, 3
if rs.eof and rs.BOF then
    ShowLogin
Else
    name = CurrentUser("Name")
    surname = CurrentUser("Surname")
    role = CurrentUser("Role")
    id = CurrentUser("id")
    Session("UserLoggedIn") = "true"
    Session("UserName") = name
    Session("UserSurname") = surname
    Session("Role") = role
    Session("id") = id
    response.redirect("index.asp")
end if

end sub

%>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>