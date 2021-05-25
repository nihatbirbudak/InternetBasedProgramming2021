<%
Response.Buffer = true
wid = request.querystring("wid")
ht = request.querystring("ht")
yn = Request.QueryString("yn")
xn = Request.QueryString("xn")
If Request.QueryString("zoom") = "in" Then
    width = (wid * 1.3)
    height = (ht * 1.3) 
end if
if Request.QueryString("zoom") = "out" then
    width = (wid * 0.7)
    height = (ht * 0.7) 
end if
if Request.QueryString("zoom") = "" then
    width = (wid * 1)
    height = (ht * 1) 
End if
marginLeft = -(width / 2)
marginTop = -(height / 2)
if Request.QueryString("x") = 2 then
    xn = xn - 150
end if
if Request.QueryString("x") = 1 then
    xn = xn + 150
end if
if Request.QueryString("y") = 2 then
    yn = yn - 150
end if
if Request.QueryString("y") = 1 then
    yn = yn + 150
end if
marginLeft = marginLeft + yn
marginTop = marginTop + xn
%>
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
    <div class="map-container row">
        <div class="top">
            <a href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&x=1&yn=<%=yn%>&xn=<%=xn%>">
                <i  class="fas fa-angle-up fa-2x"></i>
            </a>
        </div>
        <div class="row">
            <div class="col-1 map-left">
                <a href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&y=1&yn=<%=yn%>&xn=<%=xn%>">
                    <i class="fas fa-angle-left fa-2x"></i>
                </a>
            </div>
            <div class="col-10">
                <div id="imagediv">
                    <img id="pic" src="img/map/map.jpg" style="width: <%=CInt(width)%>px; height: <%=CInt(height)%>px; margin-left: <%=CInt(marginLeft)%>px; margin-top: <%=CInt(marginTop)%>px;" />
                </div>
            </div>
            <div class="col-1 map-left">
                    <a href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&y=2&yn=<%=yn%>&xn=<%=xn%>">
                        <i class="fas fa-angle-right fa-2x"></i>
                    </a>
                <div class="map-size">
                    <a class="btn btn-sm btn-edit" href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&yn=<%=yn%>&xn=<%=xn%>&zoom=in">+</a>
                    <a class="btn btn-sm btn-edit" href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&yn=<%=yn%>&xn=<%=xn%>&zoom=out">-</a>
                </div>
            </div>
        </div>
        <div class="top">
            <a href="map.asp?wid=<%=CInt(width)%>&ht=<%=CInt(height)%>&x=2&yn=<%=yn%>&xn=<%=xn%>">
                <i class="fas fa-angle-down fa-2x"></i>
            </a>
        </div>
    </div>
    <!-- Footer -->
    <!-- #include file="Views/Shared/footer.asp" -->
    <!-- JS Script  -->
    <!-- #include file="Views/Shared/script.asp" -->
</body>
</html>