<%
    ' Version Control Test
    ' I Am Develop Branch
    ' Ok I Am Feature Branch
%>
<!--#include virtual                                        =   "Core/Init.asp"-->

<%
    'Encryption Tests
    '================================================================================  
    Set encription      =   New MD5
    parameter           =   "admin"
    value               =   encription.hash(parameter)
    '================================================================================
%>
<div class="panel panel-default">
    <div class="panel-heading">Encryption Tests</div>
    <div class="panel-body">
        <table class="table table-bordered">

            <tbody>
                <tr>
                    <td>Parameter</td>
                    <td><%=parameter %></td>
                </tr>
                <tr>
                    <td>Value</td>
                    <td><%=value %></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<%
    'Encryption Tests
    '================================================================================  
    Set encription      =   New MD5
    parameter           =   "123456"
    value               =   Hash("md5",parameter)
    '================================================================================
%>
<div class="panel panel-default">
    <div class="panel-heading">Encryption Tests HASH</div>
    <div class="panel-body">
        <table class="table table-bordered">

            <tbody>
                <tr>
                    <td>Parameter</td>
                    <td><%=parameter %></td>
                </tr>
                <tr>
                    <td>Value</td>
                    <td><%=value %></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<%
    'Html Hepler Tests
    '================================================================================  
    parameter           =   ""
    value               =   parameter
    '================================================================================
%>