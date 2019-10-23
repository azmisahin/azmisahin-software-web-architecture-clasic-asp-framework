<%
    Dim Svr : Set Svr = Server

    ' Konfigurasyon Tanımları
    class Configuration
    
        ' Konfigurasyon Dosyası
        public ConfigurationLocation

        ' Veritabanı Sağlayıcısı
        public DataProvider

        ' Veritabanı Sunucu adı yada ip adresi
        public Server

        ' Sql Server Kurulumu
        public Instance

        ' Sql Data Source
        public DataSource

        ' Server Kullanıcı Adı
        public ServerUserName

        ' Server Kullanıcı Parolası
        public ServerUserPassword

        ' Oturum Açık Kalma Süresi
        public SessionTimeOut

        ' Uyglama Klasörü
        public AppData

        ' Hesap Bağlantı Terimi
        public AccountConnectionString
        
        ' Veri Bağlantı Terimi
        public DataConnectionString

        ' Giriş Sayfası
        public PageLogin

        ' Error 404
        ' Sayfa Bulunamadı
        public PageError404

        ' Error 403
        ' Erişim Engeli
        public PageError403

        ' Error 500
        ' Servis Hataları
        public PageError500

        ' Giriş Sayfası Kullanıcı Adı Elementi
        public PageLogin_Username_Field

        ' Giriş Sayfası Parola Elementi
        public PageLogin_Password_Field

        ' Log Klasörü
        public LogFolder

        ' Hata Ayıklama Modu Durumu
        public Debug

        ' Hatalı Giriş Deneme Sınırı
        ' Hatalı giriş denemelerinde, hesap geçeci olarak kilitlenecektir.
        ' Kilitlenme sınırını belirtir.
        public AccessFailedCount

        ' Hatalı giriş denemeleri sonucu, Hatalı Giriş Deneme sınırı aşılır ise
        '   ne kadar süre ile kilitli kalacağı bilgisi verilmektedir.
        '   süre dakika cinsinden eklenir.
        public AccessFailedDuration

        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()

            ' Konfigurasyon Dosyası
            ConfigurationLocation               =   "/App_Data/config.inc"
    
            ' Giriş Sayfası
            PageLogin                           =   "hesap-giris"   
                                           
            ' Error 404                    
            ' Sayfa Bulunamadı             
            PageError404                        =   "error-404"
                                           
            ' Error 403                    
            ' Erişim Engeli                
            PageError403                        =   "error-403"
                                           
            ' Error 500                    
            ' Servis Hataları              
            PageError500                        =   "error-500"
                                           
            ' Giriş Sayfası Kullanıcı Adı Elementi
            PageLogin_Username_Field            =   "username"
                                           
            ' Giriş Sayfası Parola Elementi
            PageLogin_Password_Field            =   "password"

            ' Hata Ayıylama Modu        '   Talep Yerel Bir Ortamdan Geldiğinde
            Debug                               =   requisit.IsLocal

            ' Hatalı Giriş Deneme Sınırı
            ' Hatalı giriş denemelerinde, hesap geçeci olarak kilitlenecektir.
            ' Kilitlenme sınırını belirtir.
            AccessFailedCount                   =   5

            ' Hatalı giriş denemeleri sonucu, Hatalı Giriş Deneme sınırı aşılır ise
            '   ne kadar süre ile kilitli kalacağı bilgisi verilmektedir.
            '   süre dakika cinsinden eklenir.
            AccessFailedDuration                =   1            
            
            ' Hata Ayıklama Modunda
            Debug                               =   true
            
            ' Çalışma Ortamı
            AppData                             =   "test"

            ' Log Klasörü
            LogFolder                           =   "/App_Data/" & AppData & "/log/"

            ' Sql Server Sunucusu
            Server                              =   "."

            ' Sql Server Kurulumu
            Instance                            =   "SQLEXPRESS"
            
            ' Server Kullanıcı Adı
            ServerUserName                      =   ""
    
            ' Server Kullanıcı Parolası
            ServerUserPassword                  =   ""

            ' Oturum Açık Kalma Süresi ( Dakika/Default = 5 )
            SessionTimeOut                      =   5

        end sub

        ' configuration
        public sub Init

            ' Yerel Hata Ayıklama Modunda mı çalışıyor?            
            if Debug = true Then
                ' Test Veritabanında çalış
                AppData                         =   "test"
            else
                ' Canlı Ortamda Çalış
                AppData                         =   "app"
            end if
    
            ' Log Klasörü
            LogFolder                           =   "/App_Data/" & AppData & "/log/"
    
            ' Fix instance
            if Instance = "" then
                DataSource = Server
            else
                DataSource = Server + "\" + Instance
            end if

            ' Hesap İşlemleri İçin Bağlantı Terimi.
            '--------------------------------------------------
            AccountConnectionString              =   "Provider = SQLOLEDB ; "
            AccountConnectionString              =   AccountConnectionString & "Data Source = " & DataSource & " ;"
            AccountConnectionString              =   AccountConnectionString & "Initial Catalog = " & AppData & "_" & "account" & " ; "
            AccountConnectionString              =   AccountConnectionString & "MultipleActiveResultSets=true ; "    
    
            ' DATA Model İşlemleri İçin Bağlantı Terimi.
            '--------------------------------------------------         
            DataConnectionString                 =   "Provider = SQLOLEDB ; "
            DataConnectionString                 =   DataConnectionString & "Data Source = " & DataSource & " ;"
            DataConnectionString                 =   DataConnectionString & "Initial Catalog = " & AppData & "_" & "data" & " ; "
            DataConnectionString                 =   DataConnectionString & "MultipleActiveResultSets=true ; "

            ' Güvenli giriş bilgileri ekleniyor
            '--------------------------------------------------
            if ServerUserName = "" or ServerUserPassword = "" then
                AccountConnectionString          =   AccountConnectionString & "Integrated Security=SSPI"
                DataConnectionString             =   DataConnectionString & "Integrated Security=SSPI"
            else
                AccountConnectionString          =   AccountConnectionString & "Persist Security Info = True ; "
                AccountConnectionString          =   AccountConnectionString & "User ID = " & ServerUserName & " ; "
                AccountConnectionString          =   AccountConnectionString & "Password = " & ServerUserPassword & " ; "
                DataConnectionString             =   DataConnectionString & "Persist Security Info = True ; "
                DataConnectionString             =   DataConnectionString & "User ID = " & ServerUserName & " ; "
                DataConnectionString             =   DataConnectionString & "Password = " & ServerUserPassword & " ; "
            end if
            
            ' Data Provider
            select case DataProvider
                
                case "Jet"
                    ' Standart JET 
                    AccountConnectionString             =   "Provider = Microsoft.Jet.OLEDB.4.0;Data Source=" & Svr.MapPath("/App_Data/" & AppData & "/account.mdb")
                    DataConnectionString                =   "Provider = Microsoft.Jet.OLEDB.4.0;Data Source=" & Svr.MapPath("/App_Data/" & AppData & "/data.mdb")

                case "ODBC"
                    'ODBC Yapılandırması
                    AccountConnectionString             =   "DSN = " & config.AppData & "_" & "account" & "; "   &   "Uid = " & ServerUserName & "; " & "Pwd = " & ServerUserPassword & "; "
                    DataConnectionString                =   "DSN = " & config.AppData & "_" & "data"    & "; "   &   "Uid = " & ServerUserName & "; " & "Pwd = " & ServerUserPassword & "; "

                case "Access"
                    ' Access New Version
                    AccountConnectionString             =   "Driver={Microsoft Access Driver (*.mdb, *.accdb)};ExtendedAnsiSQL=1; DBQ=" & Svr.MapPath("/App_Data/" & config.AppData & "/account.mdb")
                    DataConnectionString                =   "Driver={Microsoft Access Driver (*.mdb, *.accdb)};ExtendedAnsiSQL=1; DBQ=" & Svr.MapPath("/App_Data/" & config.AppData & "/data.mdb")
                
                case else
                    ' Tanımsız
                    ' Default sql server
            end select

            ' Oturum Açık Kalma Süresi Kontrol
            '--------------------------------------------------
            if SessionTimeOut = "" then
                SessionTimeOut = 5
            end if
    
            ' Oturum açık kalma süresi
            Session.Timeout = SessionTimeOut
    
        end sub
    
    end class

    Dim config  :   Set config = New Configuration
%>

<!--#include virtual                                        =   "/App_Data/config.inc"-->

<% config.Init() %>