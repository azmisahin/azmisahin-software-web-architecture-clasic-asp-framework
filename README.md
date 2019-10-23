# Clasic Asp MVC Framework

## Usage

Uygulamayı kullanmak / geliştirmek için gerekli olacak bilgi ve alt yapılar.

* And code editor
* IIS
* Access Database Engine

## Proje Tecnology

Projede kullanılan teknolojiler.

* [HTML 5](https://www.w3.org/html)
* [Css Framework (Bootstrap)](https://getbootstrap.com/docs/3.3/getting-started/)
* [Java Script Library (JQuery 3)](http://api.jquery.com/)
* [Server Side (Active Server Page)](https://msdn.microsoft.com/en-us/library/aa286483.aspx)
* [Database (Acces Database Engine)](https://www.microsoft.com/en-us/download/details.aspx?id=13255)

## Proje Tecnology Helper

Projede kullanılan teknoloji yardımcıları.

* [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) 'This File'
* [HTML (Hypertext Markup Language) Basic Guide](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics)
* [Html 5 Guide](https://developer.mozilla.org/tr/docs/Web/HTML/HTML5)
* [Css (Cascading Stylesheets) Basic Guide](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics)
* [Java Script Basic Guide](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics/)
* [Server Side (Active Server Page) Guide](https://msdn.microsoft.com/en-us/library/ms524929.aspx)
* [Database (Microsoft OLE DB 4.0)](https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/ado-code-examples-vbscript)
* [Database (Connection String For Access 97)](https://www.connectionstrings.com/access-97/)

## Folder Design

Uygulamanın klasör mimari dizayn bilgileri.

```
.
+-- build						'	Projeyi visual studio ortam�nda başlatır yada inşa eder.
+-- data						'	Proje Veritabanı Yapıları
+-- docs						'	Proje Dökümanları
+-- src							'	Proje Kaynak Dosyaları
|   +-- api						'	Uygulama dışı servisleri
|   +-- app_data				'	Uygulama veritabanları
|   |   +-- test				'	Test veritabanının yer aldığı alan.
|   |   |   +-- log 			'	Uygulama çalışma zamanında metin bazlı loglama yapar. [ Yazma izni gereklidir. ]
|   +-- assets					'	Tasarım varlıkları
|   |   +-- css					'	Tasarım sitilleri
|   |   +-- js					'	Tasarım Scripleri
|   |   +-- img					'	Tasarımda kullanılan resimler
|   |   +-- fonts				'	Tasarımda kullanılan fontlar
|   |   +-- lib					'	Tasarım Kütüphaneleri
|   |   |   +-- jquery			'	JavaScript Kütüphanesi
|   |   |   +-- bootstrap		'	Tasarım Kütüphanesi
|   +-- core					'	Uygulama çekirdeği.
|   +-- data					'	Veri katmanı
|   +-- files					'	Kullanıcı ierikleri
|   +-- models					'	Kullanıcı arayüzüne Kontrolörden ayıran görünüm nesneleri.
|   +-- scripts					'	Gürünümleri, kontolör yada servislere düzenli başlamasını sağlayan JavaScript kodları
|   +-- service					'	Uygulama iç servisleri
|   +-- tests					'	Uygulama kontrolörleri yada servislerini test eden alan.
|   +-- views					'	Kullanıcıların modeller ile görüntüledikleri alan.
|   |   +-- favicon.ico			'	Varsayılan Html nesleri için beklenen .ico dosyası
|   |   +-- index.html			'	Varsayılan giriş belgesi
|   |   +-- web.config			'	Uygulama alt yapı hizmetlerini tanımlar.

```
## Uygulama konfigurasyon dosyas� �rne�i
```ASP
<%
    ' Veritabanı configurasyon dosyasıdır.
    ' Aşağıdaki bilgileri veri erişim bilgilerinize göre güncelleyiniz.
    ' /App_DATA/config.inc
    '====================================================================================================
    
	' false	:	Canlı Ortam veritabanı
	' true	:	Test Ortamı veritabanı
	config.Debug						=	true

	' Jet	:	Jet Engine Technology
	' ODBC	:	Dsn 
	' Access:	new version
	' Sql 	:	Default
	config.DataProvider					=	"Jet"

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
```

## Debug Mode

Hata ayıklama modunu etkinleştirmek için.

%USERPROFILE%\Documents\IISExpress\config\applicationhost.config

```
.

    <system.webServer>
    
        <serverRuntime />

        <asp scriptErrorSentToBrowser="true" enableParentPaths="true" bufferingOn="true" errorsToNTLog="true" appAllowDebugging="true" appAllowClientDebug="true">
            <cache diskTemplateCacheDirectory="%TEMP%\iisexpress\ASP Compiled Templates" />
            <session allowSessionState="true" />
            <limits />
        </asp>

```