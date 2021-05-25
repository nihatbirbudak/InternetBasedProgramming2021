<!-- #include file="DbContent/dbConnect.asp" -->
<!-- #include file="function/myFunction.asp" -->
<%
    set Forums = dbConn.Execute("select * from Forum")
%>
<div class="forum">
                <ul class=" forum-list">
                <%do while not Forums.eof%>
                    <li class="forum-item row">
                        <div class="form-main col-8">
                            <h4 class="forum-topic">
                                <a href="forum-detail.asp?id=<%=Forums("ID")%>">
                                    <%=Forums("Title")%>
                                </a>
                            </h4>
                            <div class="forum-meta">
                                <p>
                                <%=Left(Forums("Content"),100)&"..."%>
                                </p>
                            </div>
                        </div>
                        <ul class="forum-item-stats col-2">
                            <li>
                                <span><%=Forums("Views")%></span>
                                <span>Görümtülenme</span>
                            </li>
                            <li>
                                <span>
                                <% 
                                SQL = "SELECT COUNT(*) AS TotalRecords FROM ForumComment WHERE ForumId="&Forums("ID")
                                set rsRecordCount = dbConn.Execute(SQL)
                                if not rsRecordCount.Eof then
                                iTotalRecords = rsRecordCount.Fields("TotalRecords")
                                else
                                iTotalRecords = 0
                                end if
                                Response.Write (iTotalRecords)
                                rsRecordCount.Close
                                set rsRecordCount = nothing
                                %>
                                </span>
                                <span>Yorum</span>
                            </li>
                        </ul>
                        <ul class="forum-item-last col-2">
                            <li>
                            <%set Writer = dbConn.Execute("select * from Users where id="&Forums("WriterId"))%>
                                <a href="userPage.asp?UserId=<%=Writer("ID")%>"><%

                                name = allFirstUpper(Writer("Name")&" "&Writer("Surname"))
                                Response.Write (name)
                                %></a>
                            </li>
                            <li>
                                <a href=""><%=Forums("LoadTime")%></a>
                            </li>
                        </ul>
                    </li>
                <%Forums.MoveNext
                loop%>
                </ul>
            </div>

<%
    dbConn.close
%>