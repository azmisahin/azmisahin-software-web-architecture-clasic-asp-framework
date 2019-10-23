<%
    ' Veritabanı configurasyon dosyasıdır.
    ' Aşağıdaki bilgileri sunucu erişim bilgilerinize göre güncelleyiniz.
    ' /App_DATA/config.inc
    '====================================================================================================
    
	' false	:	Canlı Ortam veritabanı
	' true	:	Test Ortamı veritabanı
	config.Debug						=	true

	' Jet	:	Jet Engine Technology
	' ODBC	:	Dsn 
	' Access:	new version
	' Sql 	:	Default
	config.DataProvider					=	"Sql"

    ' Sql Server Sunucusu
    config.Server                       =   "."
    
    ' Sql Server Kurulumu
    config.Instance                     =   "SQLEXPRESS"
    
    ' Server Kullanıcı Adı
    config.ServerUserName               =   ""
    
    ' Server Kullanıcı Parolası
    config.ServerUserPassword           =   ""

    ' Oturum Açık Kalma Süresi
	' Varsayılan Değer/Dakika = 5
    config.SessionTimeOut				=   5
%>