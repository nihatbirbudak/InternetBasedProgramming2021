<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/ShadowUpload.asp" -->

<%
pageName = "index.asp"
%>

<%
    Set Citys = dbConn.Execute("select * from Citys; ")
    Set Hobies = dbConn.Execute("select * from Hobies; ")
%>

<%if Session("UserLoggedIn") = "" then%>
<!DOCTYPE html>
<html lang="tr">
<!-- #include file="Views/Shared/header.asp" -->
<body>
    <!-- Nabvar -->
    <div class="navbar clearfix">
        <!-- #include file="Views/Shared/nav.asp" -->
    </div>
    <!-- Main Context -->
    <div id="main" class="container">
        <div class="card-register">
            <h1>Kay�t Ol</h1>
            <div class="register-items">
                <form action="saveUser.asp" onsubmit="return validForm()" id="user" name="user" enctype="multipart/form-data" method="POST">
                    <div class="row">
                        <div class="col-6 register-item">
                            <label for="">Ad</label>
                            <input value="<%=Request.Cookies("Name")%>" placeholder="Ad�n�z" type="text" name="Name">
                            <span id="NameValid" class="validSapn"></span>

                        </div>
                        <div class="col-6 register-item">
                            <label for="">Soyad</label>
                            <input value="<%=Request.Cookies("Surname")%>" name="Surname"  placeholder="Soyad�n�z" type="text">
                            <span id="SurnameValid" class="validSapn"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item">
                            <label for="">E Mail</label>
                            <input value="<%=Request.Cookies("Email")%>" placeholder="Mail Adresi" type="email" name="Email" >
                            <span id="EmailValid" class="validSapn">
                              
                            </span>
                        </div>
                        <div class="col-6 register-item">
                            <label for="">Do�um Tarihi</label>
                            <input value="<%=Request.Cookies("Birthday")%>" type="date" name="Birthday" id="Birthday">
                            <span id="BDValid" class="validSapn">

                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item">
                            <label for="">�ifre</label>
                            <input placeholder="�ifre" type="password" name="Password" id="pass">
                            <span class="validSapn" id="passSpan"></span>
                        </div>
                        <div class="col-6 register-item">
                            <label for="">�ifre Tekrar</label>
                            <input placeholder="�ifre Do�rulama" type="password" name="Password2" id="pass2">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item">
                            <label for="">�niversite</label>
                            <input value="<%=Request.Cookies("University")%>" placeholder="Okudu�unuz �niiversite" type="text" name="University" >
                            
                        </div>
                        <div class="col-6 register-item">
                            <label for="">��</label>
                            <input value="<%=Request.Cookies("Job")%>" placeholder="Hangi i� de �al���yorunuz" type="text" name="Job" >

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item radio-box">
                            <label for="">
                                <span class="display-block">
                                    Cinsiyet
                                </span>
                            </label>
                            <label >Kad�n</label>
                            <input type="radio" Checked <%if request.Cookies("Gender") = "K" then
                            Response.Write ("Checked") 
                            end if%> name="Gender" value="K" >
                            <label >Erkek</label>
                            <input type="radio" <%if request.Cookies("Gender") = "E" then
                            Response.Write ("Checked") 
                            end If %> name="Gender" value="E" >
             
                        </div>
                        <div class="col-6 register-item check-box">
                            <label for="">
                                <span class="display-block">
                                    Hobiler
                                </span>
                            </label>
                            <%
                            Do While NOT Hobies.EOF
                                if request.Cookies("Hobies") = "" then%>
                                    <span class="check-item">
                                        <input type="checkbox" name="Hobies" value="<%=Hobies("ID")%>">
                                        <label for=""><%=Hobies("HobiName")%></label>
                                    </span>
                                <%Else
                                    id = split(request.Cookies("Hobies"),",")%>
                                    <span class="check-item">
                                        <input type="checkbox" <%
                                        for i=0 to ubound(id)
                                            if CInt(Hobies("ID")) = CInt(id(i)) then
                                                Response.Write ("Checked")
                                            end if
                                        next
                                        %> name="Hobies" value="<%=Hobies("ID")%>">
                                        <label for=""><%=Hobies("HobiName")%></label>
                                    </span>  
                                <%end if    
                            Hobies.MoveNext
                            loop        
                            %>   
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item option-box">
                            <label for="">�ehir</label>
                            <select name="CityId" >
                                <option disabled selected value="">Se�iniz</option>
                                <%
                                Do While NOT Citys.EOF
                                    if request.Cookies("CityId") = "" then %>
                                        <option value="<%=Citys("id")%>"><%=Citys("CityName")%></option>
                                    <%Else%>
                                        <option <%
                                            if CInt(Citys("id")) = CInt(Request.Cookies("CityId")) then
                                                Response.Write ("selected")
                                            end if
                                        %> value="<%=Citys("id")%>"><%=Citys("CityName")%></option>
                                <%end if
                                Citys.MoveNext
                                Loop
                                %> 
                            </select>
           
                        </div>
                        <div class="col-6 register-item file-box">
                            <label for="">Profil Foto�raf�</label>
                            <input type="file" name="file1">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 register-item">
                            <label for="">Ac�klama</label>
                            <textarea name="Desc" value="<%=Request.Cookies("Desc")%>" cols="30" rows="3"  placeholder="Kendiniz hakk�nda k�sa a��klama giriniz"></textarea>
                   
                        </div>
                    </div>
                    <div class="text-align-center">
                        <button type="submit" onClick="comparePass()" id="save" class="btn btn-primary btn-outline">Kay�t Ol</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
    <script>
    <% if Request.Cookies("IsNotSaved") = "0" then%>
        Swal.fire({
            title: 'Kay�tl� Kullan�c�!',
            text: 'Bu Mail Adresi �le Kay�t Bulunmakta',
            icon: 'warning',
            confirmButtonText: 'Tamam' 
        })
    <%end if%>
    </script>
</body>
</html>
<%
Else
    Response.redirect("index.asp")
end if
'Db Close
dbConn.close
set dbConn= Nothing
set Citys = Nothing
set Hobies = Nothing
Response.Cookies("Name") = ""
Response.Cookies("Surname") =""
Response.Cookies("Email") = ""
Response.Cookies("Birthday") = ""
Response.Cookies("University") =""
Response.Cookies("Job") = ""
Response.Cookies("Gender") = ""
Response.Cookies("Desc") = ""
Response.Cookies("CityId") = ""
Response.Cookies("Hobies") = ""
Response.Cookies("IsNotSaved") = ""
%>