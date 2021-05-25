<!--Nav Header -->
<div class="nav-header">
    <h1>Hasan Ali Yücel Etüt Merkezi</h1>
    <p>2012</p>
</div>
<!-- Nav Toggle For Media 650px-850px -->
<div id="nav-links">
    <div class="nav-icon">
        <ul>
            <li id="go" class="nav-item">
                <a href="javascript:slimMenuGo()" id="menü" class="nav-link">
                    <i class="fas fa-bars"></i>
                </a>
            </li>
            <li id="back" class="nav-item">
                <a href="javascript:slimMenuBack()" id="menü" class="nav-link">
                    <i class="fas fa-times"></i>
                </a>
            </li>
            <%if Session("UserLoggedIn") = "true" then%>
                <li class="nav-item s650li">
                    <a id="menü" class="nav-link s650">
                        <i>
                            <form action='logout.asp' method='post'>
                                <input type='hidden' name='login' value="logout">
                                <button type="submit" class="btn btn-logout">Çýkýþ</button>
                            </form>
                        </i>
                    </a>
                </li>
            <%end if%>
        </ul>
    </div>
    <!-- Nav Left -->
    <div id="nav-left" class="nav-left">
        <ul>
            <li class="nav-item">
                <a href="index.asp" class="nav-link text-uppercase">
                    Ana Sayfa
                </a>
            </li>
            <li class="nav-item">
                <a href="user.asp" class="nav-link text-uppercase">
                    Kiþiler
                </a>
            </li>
            <li class="nav-item">
                <a href="gallery.asp" class="nav-link text-uppercase">
                    Fotoðraflar
                </a>
            </li>
            <li class="nav-item">
                <a href="video.asp" class="nav-link text-uppercase">
                    Videolar
                </a>
            </li>
            <li class="nav-item">
                <a href="forum.asp" class="nav-link text-uppercase">
                    Forum
                </a>
            </li>
            <li class="nav-item">
                <a href="map.asp?wid=9653&ht=5291&yn=0&xn=0" class="nav-link text-uppercase">
                    Harita
                </a>
            </li>
            <%if Session("UserLoggedIn") = "" then%>
                <li class="nav-item right">
                    <a href="register.asp" class="nav-link text-uppercase">
                        Kayýt Ol
                    </a>
                </li>
                <li class="nav-item right">
                    <a href="login.asp" class="nav-link text-uppercase">
                        Giriþ
                    </a>
                </li>
            <%Else%>
                <li class="nav-item right">
                    <form action='login.asp' method='post'>
                        <input type='hidden' name='login' value="logout">
                        <button type="submit" class="btn btn-logout" >Çýkýþ</button>
                    </form>
                </li>
                    <li class="nav-item right" id="login">
                    <span><%=allFirstUpper(Session("UserName")&" "&Session("UserSurname"))%></span>
                </li>
                <%if  Session("Role") = "Admin" then%>
                <li class="nav-item right">
                    <a href="admin.asp" class="nav-link text-uppercase">
                        Admin Sayfasý
                    </a>
                </li>
                <%end if%>
            <%end if%>
        </ul>
    </div>
</div>