<% 
    function sweetAlert(title,text,icon,btnText,bool)
    %>
        <script>
    <% if bool then%>
        Swal.fire({
            title: '<%=title%>',
            text: '<%=text%>',
            icon: '<%=icon%>',
            confirmButtonText: '<%=btnText%>' 
        })
    <%end if%>
        </script>
    <%
    end function
%>
