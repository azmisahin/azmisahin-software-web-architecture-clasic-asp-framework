<!--#include virtual    =   "Core/System.asp"                                     -->

<%
    file        =   Request.QueryString("file")
    folder      =   config.LogFolder
    fullPath    =   Server.MapPath(folder & file)
%>

<div class="well-sm"><%=file %></div>
<div class="pull-right">Server Time: <%=Now() %></div>

<%
    Dim lineData
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    set fs = fso.OpenTextFile(fullPath, 1, true)
%>
<table class="table table-striped">
    <thead>
        <tr>
            <th>SISTEM SAATI</th>
            <th>KULLANICI</th>
            <th>DOSYA</th>
            <th>NUMARA</th>
            <th>KATEGORY</th>
            <th>DURUM</th>
            <th>ACIKLAMA</th>
        </tr>
    </thead>
    <tbody>
        <%Do Until fs.AtEndOfStream %>
        <%lineData = fs.ReadLine%>
        <tr>
            <%colums = split(lineData,chr(9))%>
            <%for each row in colums %>
            <td><%=row%></td>
            <%next%>
        </tr>
        <%Loop%>
    </tbody>
</table>
<%fs.close: set fs = nothing%>