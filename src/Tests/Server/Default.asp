<%
    ' Version Control Test
    ' I Am Develop Branch
    ' Ok I Am Feature Branch
%>
<!--#include virtual                                        =   "Core/Init.asp"-->

<%
            'Sunucu Değişkenleri
            '================================================================================  
            parameter   =   "/App_Data"
            value       =   Server.MapPath(parameter)
            '================================================================================
%>
<div class="panel panel-default">
    <div class="panel-heading">Sunucu Değişkenleri</div>
    <div class="panel-body">
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <td><%=parameter %></td>
                    <td><%=value %></td>
                </tr>
                <%for each variable in Request.ServerVariables%>
                <tr>
                    <td><%=variable %></td>
                    <td><%=Request.ServerVariables(variable) %></td>
                </tr>
                <%next %>
            </tbody>
        </table>
    </div>
</div>
