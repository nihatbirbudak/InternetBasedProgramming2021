<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<!-- #include file="function/ShadowUpload.asp" -->
<%
    Response.Buffer = true
    dim HobiesCookies
    Dim objUpload
    Set objUpload=New ShadowUpload
    'Db Set Users UserHobies and UserControl
    Set Users = server.CreateObject("ADODB.Recordset")
    set UserHobies = server.CreateObject("ADODB.Recordset")
    set UserContol = dbConn.Execute("SELECT * FROM Users WHERE Email="& "'" & objUpload("Email") & "'")
    'Has User registered before with this email
    redirectAsp = "register.asp"
    '�f is not saved save new User
    If UserContol.EOF = true Then
        if (IsValidName(Trim(objUpload("Name"))) and IsValidName(Trim(objUpload("Surname"))) and IsValidMail(Trim(objUpload("Email"))) and IsValidPass(Trim(objUpload("Password"))) ) Then
            'Open User Table
            Users.Open "Users", dbConn, 1, 3
            'Add a new User
            Users.AddNew
            Users("Email") = Trim(objUpload("Email"))
            Users("Name") = Trim(objUpload("Name"))
            Users("Surname") = Trim(objUpload("Surname"))
            Users("Birthday") = objUpload("Birthday")
            Users("Password") = Trim(objUpload("Password"))
            Users("University") = Trim(objUpload("University"))
            Users("Job") = Trim(objUpload("Job"))
            Users("Gender") = Trim(objUpload("Gender"))
            Users("Role") = "User"
            Users("CityId") = objUpload("CityId")
            st = ""
            if VarType(objUpload("Desc")) > 36 then
                for Each s in objUpload("Desc")
                    st = st & s
                next
            else
                st = objUpload("Desc")
            end if
            Users("Desc") = st
            If objUpload.FileCount = 0 Then
                if objUpload("Gender") = "K" then
                    Users("ImgPath") = "img_avatar_k.png"
                Else
                    Users("ImgPath") = "img_avatar_e.png"
                end if
            Else
                Response.Write ("Girdim")  
                fileName = RandomName(10)
                fileType = Split(objUpload.File(0).ContentType,"/")
                fileName = fileName&"."&fileType(1)
                if fileType(1) = "jpeg" or fileType(1) = "png" then
                    objUpload.File(0).FileName = fileName
                    Users("ImgPath") = fileName
                    Call objUpload.File(0).SaveToDisk(Server.MapPath("img/pp"), "")
                end if    
            end if
            'Update Users Table
            Users.Update
            'Open Hobies Table For Save Habies
            UserHobies.Open "UserHobies", dbConn,1,3
            'Take a CurrentUser id for match hobi and user
            set CurrentUser = dbConn.Execute("SELECT id FROM Users WHERE Email="& "'" & objUpload("Email") & "'")
            if IsCollection(objUpload("Hobies")) then
                For Each hobi in objUpload("Hobies")
                    UserHobies.AddNew
                    for Each id in CurrentUser.Fields
                        UserHobies("UserID") = id
                    next 
                    UserHobies("HobiesID") = hobi
                    UserHobies.Update
                Next
            else
                UserHobies.AddNew
                    for Each id in CurrentUser.Fields
                        UserHobies("UserID") = id
                    next 
                    UserHobies("HobiesID") = objUpload("Hobies")
                    UserHobies.Update
            end if
            'Users Close
            Users.close
            set Users= Nothing
            'UserHobies Close
            UserHobies.close
            set UserHobies= Nothing
            redirectAsp = "index.asp"

        Else
            'if Valid is false send register.asp this variables
            for each itm in objUpload("Hobies")
                if HobiesCookies = "" then
                    HobiesCookies = itm
                else
                    HobiesCookies = HobiesCookies &","&itm
                end if
            next 
            Response.Cookies("Name") = objUpload("Name")
            Response.Cookies("Surname") = objUpload("Surname")
            Response.Cookies("Email") = objUpload("Email")
            Response.Cookies("Birthday") = objUpload("Birthday")
            Response.Cookies("University") = objUpload("University")
            Response.Cookies("Job") = objUpload("Job")
            Response.Cookies("Gender") = objUpload("Gender")
            Response.Cookies("Desc") = objUpload("Desc")
            Response.Cookies("CityId") = objUpload("CityId")
            Response.Cookies("Hobies") = HobiesCookies
        end if
    Else
        for each itm in objUpload("Hobies")
            if HobiesCookies = "" then
                HobiesCookies = itm
            else
                HobiesCookies = HobiesCookies &","&itm
            end if
        next
        Response.Cookies("Name") = objUpload("Name")
        Response.Cookies("Surname") = objUpload("Surname")
        Response.Cookies("Email") = objUpload("Email")
        Response.Cookies("Birthday") = objUpload("Birthday")
        Response.Cookies("University") = objUpload("University")
        Response.Cookies("Job") = objUpload("Job")
        Response.Cookies("Gender") = objUpload("Gender")
        Response.Cookies("Desc") = objUpload("Desc")
        Response.Cookies("CityId") = objUpload("CityId")
        Response.Cookies("Hobies") = HobiesCookies
        Response.Cookies("IsNotSaved") = false
        response.redirect(redirectAsp)
    End if
    'Db Close
    dbConn.close
    set dbConn= Nothing
    response.redirect(redirectAsp)
%>