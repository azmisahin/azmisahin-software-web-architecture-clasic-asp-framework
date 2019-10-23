<%
    ' Proje referansları
    ' Tüm referanslar, proje dahilinde ortak çağrılarda bulunulacak sınıflardır.
    ' ================================================================================
%>

<%
    ' Event
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/event.asp"                                    -->

<%
    ' Install
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/install.asp"                                   -->

<%
    ' Helper
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/Helper.asp"                                   -->

<%
    ' Kullanıcı Doğrulama Hizmeti                                                 
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/Authentication.asp"                           -->

<%
    ' System
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/System.asp"                                     -->

<%
    ' Çekirdek Veritabanı Hizmeti                                                 
    ' --------------------------------------------------------------------------------
%>
<!--#include virtual    =   "Core/Data.asp"                                     -->