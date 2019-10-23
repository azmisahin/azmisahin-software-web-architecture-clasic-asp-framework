<%
    ' Kimlik Doğrulama Otoritesi
    '================================================================================
    
    ' Doğrulama Sınıfı
    ' Kimlik Doğrulama
    class Authentication

        ' SINIF TANIMLARI
        ' ================================================================================
     
        ' Anonim Erişime İzin Var Mı?
        public function AllowAnonyms                                '   bool    [ True  ]   Anonim girişlere izin verilir
            AllowAnonyms = Value("AllowAnonyms")    
        end function

        ' Anonim Erişimi Tanımlar.
        public sub setAllowAnonyms(value)
            call State("AllowAnonyms",value)
        end sub

        ' Kimlik Doğrulandı mı?
        public function IsAuthenticated                             '   bool    [ True ]    Giriş yapan kullanıcı yı doğrular.
            IsAuthenticated = Value("IsAuthenticated")    
        end function

        ' Kullanıcı Doğrulamayı Tanımlar
        public sub setIsAuthenticated(value)
            call State("IsAuthenticated",value)
        end sub

        ' Kullanıcı Yetkili mi?
        ' Kullanıcı giriş bilgilerini sağladı, ancak bu alana yetki mi
        public function IsAuthority                                 '   bool    [ True ]    Giriş yapan kullanıcı, yetkili.
            IsAuthority = Value("IsAuthority")    
        end function

        ' Kullanıcı Yetkili mi, bilgisini tanımlar.
        ' Kullanıcının belirli zamanlarda yetkilerini kapatabilir.
        public sub setIsAuthority(value)
            call State("IsAuthority",value)
        end sub

        ' YETKİLİ KULLANICILARIN ERİŞİMLERİ
        ' ================================================================================
    
        ' Giriş Yapan Kullanıcının ID
        public function UserId                                      '   int     Kullanıcıyı tanımlayan benzersiz numara
            UserId = Value("UserId")    
        end function

        ' Giriş yapan kullanıcının ID sini tanımlar.
        public sub setUserId(value)
            call State("UserId",value)
        end sub

        ' Giriş yapan kullanıcının , kullanıcı adı       
        public function UserName                            '   string  Kullanıcı Adı / Giriş yaparken kullandığı kimlik
            UserName = Value("UserName")
            if UserName =   ""  then
                UserName    =   "---"
            end if
        end function

        ' Giriş yapan kullanıcının, kullanıcı adını tanımlar.
        public sub setUserName(value)
            call State("UserName",value)
        end sub
       
        ' Giriş yapan kullanıcının , giriş yaptığı parola
        public function Password                            '   string  Kullanıcının giriş sırasında girdiği bilgi
            Password = Value("Password")  
        end function

        ' Giriş yapan kullanıcının, giriş yaptığı parolayı tanımlar.
        public sub setPassword(value)
            call State("Password",value)
        end sub

        ' Giriş yapan kullanıcının, giriş yaptığı parolaya karşılık gelen Şifre karması ( crypto parola )
        public function PasswordHash                        '   string  Şifrelenmiş Parola
            PasswordHash = Value("PasswordHash")
        end function

        ' Giriş yapan kullanıcının, Şifre karmasını tanımlar.
        public sub setPasswordHash(value)
            call State("PasswordHash",value)
        end sub

        ' Giriş yapan kullancının, E-Posta adresi
        public function Email                               '   string  Kullanıcı E-Posta        
            Email = Value("Email")
        end function 

        ' Giriş yapan kullanıcının, e-posta adresini tanımlar.
        public sub setEmail(value)
            call State("Email",value)
        end sub

        ' Giriş yapan kullanıcının, Rol bilgisi.
        public function Rol                                 '   string  Kullanıcının Rolü
            Rol = Value("Role")
        end function

        ' Giriş yapan kullanıcının, Rol bilgisi.
        public function RoleName                            '   string  Kullanıcının Rolü
            RoleName = Value("Role")
        end function

        ' Giriş yapan kullanıcının, Rol bilgisini tanımlar.
        public sub setRole(value)
            call State("Role",value)
        end sub

        ' Setter

        ' Giriş yapan kullanıcının, prefixler ile tanımlanmış Kullanıcı yetkisi.
        public sub setRoleClaimsString(value)
            call State("RoleClaimsString",value)
        end sub
    
        ' Giriş yapan kullanıcının, prefixler ile tanımlanmış, kullanıcı yetilerini tanımlar.
        public sub setUserClaimsString(value)
            call State("UserClaimsString",value)
        end sub
    
    
        ' DAHİLİ YARDIMCILAR 
        ' ================================================================================

        ' Giriş yapan kullanıcının, prefixler ile tanımlanmış Rol yetkisi.
        ' Daha sonra public kullanılabilir. şimdi sınıf dahilinde.
        ' public function RoleClaimsString
        private function RoleClaimsString                    '   string  Kullanıcının, prefix ler ile ayrılmış yetkileri.  
            RoleClaimsString = Value("RoleClaimsString")
        end function 

        ' Giriş yapan kullanıcının, prefixler ile tanımlanmış Kullanıcı yetkileri.
        ' Daha sonra public kullanılabilir. Şimdi sınıf dahilinde.
        ' public function UserClaimsString
        private function UserClaimsString                    '   string  Kullanıcının prefix ler ile ayrılmış yetkiler
            UserClaimsString = Value("UserClaimsString")
        end function 


        ' DAHİLİ İŞLEMLER 
        ' ================================================================================
          
        ' Mevcut oturum a bir öge ekler
        private sub State(key, value)        
            Session(Session.SessionID & "_" & key) = value
        end sub

        ' Mevcut oturumdaki anahtarı verilen ögenin değerini verir.
        public function Value(key)
    
            ' Anahtar tanımı kontrol ediliyor.
            if IsEmpty(Session(Session.SessionID & "_" & key)) then
                ' Yapılandırılmamış anahtarlar için empty string döndürülecek.
                Value   =   ""
            else
                Value = Session(Session.SessionID & "_" & key)
            end if

        end function

        ' Kullanıcıların Yetkileri kontrol ediliyor
        private sub checkAuthority(routeString)

            ' İzin yapılandırılıyor
            result       =   false
            
            ' Beklenen  /   Talep Edilen Sayfa
            expected    =   routeString

            ' Savunma   /   Talebe Karşılık Gelen Yetkisi
            assert      =   ""
            
            'işlemler
            for each item in RoleClaims.Items

                for each auth   in item.Values.Items

                    ' Yetkisini savunma olarak aldık.
                    ' auth.Url bilgisindeki alana girebileceğini idda ediyor.   
                    assert      =  auth.Permission 
                    
                    ' İddasında bahsettiği, yetkileri arasında , talep ettiği bilgi var mı?
                    if assert = expected    then
                        ' Evet var. Aramayı bırak. Sonuç a git.
                        exit for
                    else
                        assert = ""
                    end if

                next
                'Gerekçeli Sonuç :)
                if assert = expected    then
                    ' Evet var. Aramayı bırak. Sonuç a git.
                    exit for
                else
                    assert = ""
                end if
            next
            'Sonuç
            result      =   (expected =   assert)

            ' Yetki durumuna göre izin veriliyor 
            setIsAuthority(result)
        
        end sub

        ' SANAL ALANLAR
        ' ================================================================================
        
        ' String dizesinde claim i modele çevirir
        private function getClaimsFromString(stringValue)

            ' Geri dönüş modeli tanımlanıyor
            Dim results      :   Set results    =   Server.CreateObject("Scripting.Dictionary")
            
            'stringValue taranarak, Claim Tipinde Liste oluşturulacak
            claimTypesArray     =   Split(stringValue,"/")
            count               =   uBound(claimTypesArray)
            index               =   0
            for each item in claimTypesArray
                
                ' Claim Tanımlanıyor
                Dim cl  :   Set cl  =   new Claim
                
                ' Claim özellikleri set ediliyor.
                claimTypeNamesArray =   Split(item, "*")
                
                ' Tip Adı
                cl.ClaimType        =   claimTypeNamesArray(0)
                
                ' Tip Değerli
                cl.ClaimValue       =   claimTypeNamesArray(1)
    
                ' Tip Alt Tipleri
                claimTypeValueArray =   Split(cl.ClaimValue,    ",")
    
                ' Alt ogeler taranıyor
                subCount            =   uBound(claimTypeValueArray)
                subIndex            =   0
                for each subItem in claimTypeValueArray
                
                    ' Alt oge tanımlanıyor.
                    Dim subCl   :   Set subCl   =   new Claim

                    ' Alt ogenin Tipi, ana tip ile ile eşitleniyor.
                    subCl.ClaimType =   cl.ClaimType
            
                    ' Alt ogenin değeri yazılıyor.
                    subCl.ClaimValue=   subItem

                    ' Ana ögeye alt öge tipi ekleniyor.
                    cl.Values.Add  subIndex,   subCl
        
                    ' Bir sonraki kayıt için index arttırılıyor.
                    subIndex    =   subIndex    +   1
            
                ' Alt öge tarama sonu
                next

                ' Claim Listeye ekleniyor
                results.Add index,  cl
            
                ' Bir sonraki kayıt için index arttırılıyor.
                index   =   index   +   1
            
            ' Ana öge tarama sonu
            next

            ' Fonksiyon dönüşü tanımlanıyor.
            Set getClaimsFromString = results
    
        end function

        ' Rol Yetkileri
        '
        ' Rol Yetkilerini prefixler ile ayrılmış stringlerden, model listesine çevirir.
        ' Claims List
        public function RoleClaims

            ' Claim Modele çeviriliyor
            Set RoleClaims  =   getClaimsFromString(RoleClaimsString)
    
        end function

        ' Kullanıcı Yetkileri
        '
        ' Kullanıcı Yetkilerini prefixler ile ayrılmış stringlerden, model listesine çevirir.
        ' Claims List
        public function UserClaims

            ' Claim Modele çeviriliyor
            Set UserClaims  =   getClaimsFromString(UserClaimsString)

        end function

        ' Kimlik Doğrulama Yardımcıları
        ' ================================================================================
    
        ' İstek, hedef kaynak için geçerli doğrulama kimlik bilgileri olmadığından uygulanmadı.
        ' 401 Unauthorized
        private sub authenticatedUnauthorized()

            Exception.File          =   "AUTHENTICATION"
            Exception.Line          =   "295"
            Exception.Number        =   1
            Exception.Description   =   Strings.Format("{0} Geçerli kimlik bilgileri olmadığından erişim engellendi ", Array("401"))
            Exception.Category      =   "Unauthorized"
            Exception.State         =   "info"
            Exception.Throw()

            ' Kimlik doğrulama bilgileri yok.
            ' Referans : https://developer.mozilla.org/tr/docs/Web/HTTP/Status
            ' Referans : https://msdn.microsoft.com/en-us/library/ms525844(v=vs.90).aspx
            ' Referans : https://httpstatuses.com/
            Response.Status = 401
            Response.Write("Geçerli kimlik bilgileri olmadığından erişim engellendi.")
            Response.End()    

            ' Transfer Login Page
            ' Response.Redirect(config.PageLogin)

        end sub

        ' İstekte kimlik doğrulama kimlik bilgileri sağlandı 
        ' Fakat, erişim sağlamak için yetersiz olarak kabul eder.
        ' 403 Forbidden
        private sub authenticatedForbidden()

            Exception.File          =   "AUTHENTICATION"
            Exception.Line          =   "321"
            Exception.Number        =   1
            Exception.Description   =   Strings.Format("{3} {0} Kimlik [{1}] bilgileri sağlandı. Fakat, [{2}] erişim sağlamak için yetersiz.", Array("403",UserName,Request.ServerVariables("HTTP_X_ORIGINAL_URL"),Request.ServerVariables("remote_addr")))
            Exception.Category      =   "Forbidden"
            Exception.State         =   "info"
            Exception.Throw()

            ' Erişim sağlamak için yetersiz.
            ' Referans : https://developer.mozilla.org/tr/docs/Web/HTTP/Status
            ' Referans : https://msdn.microsoft.com/en-us/library/ms525844(v=vs.90).aspx
            ' Referans : https://httpstatuses.com/
            Response.Status = 403
            Response.Write("Kimlik bilgileri sağlandı. Fakat, erişim sağlamak için yetersiz.")
            Response.End()

            ' Transfer Home Page
            ' Response.Redirect("/")

        end sub
    
        ' Kimliği doğrulanmış kullanıcılara verilecek cevap.
        private sub authenticatedOk()
    
            ' Erişim sağlamak için yetkili.
            ' Referans : https://developer.mozilla.org/tr/docs/Web/HTTP/Status
            ' Referans : https://msdn.microsoft.com/en-us/library/ms525844(v=vs.90).aspx
            ' Referans : https://httpstatuses.com/
            Response.Status = 200   '   ok.
            
        end sub

        ' SINIF DIŞ ÖZELLİKLERİ
        ' ================================================================================

        ' Kimliği doğrulanmış sayfaları tanımlamak için bu fonksiyon çağrılır.
        '
        '   Identity.Authenticated()
        '
        '   Doğrulanmış yada doğrulanmamış kullanıcılara nasıl tepki verileceğini belirler.
        '
        ' Kimliği Doğrulanmış mı?
        public sub Authenticated()

            ' Kimliği Doğrulanmaış        
            If IsAuthenticated = true Then
    
                ' Kimlik Dorulanmış
                authenticatedOk()
    
            else

                ' Kimlik Dorulanmamış
                authenticatedUnauthorized()
    
            end if

        end sub

        ' Kimliği doğrulanmış kullanıcıların, sayfa yetkilerini kontrol eder.
        public sub Authority(routeString)

            ' Sayfa Erişim Yetkileri Kontrol Ediliyor.
             checkAuthority(routeString)

            ' Kullanıcının kimliği doğrulanmış.
            ' Ancak, erişmeye çalıştığı alana yetisi var mı
            if IsAuthority  =   true    then
    
                ' Yetkili
                
            else

                ' Erişim sağlamak için yetersiz olarak kabul ediliyor.
                authenticatedForbidden()

            end if
        
        end sub

        ' Url i verilen sayfaya erişim kontrolü yapılır.
        public function IsAuthorityUrl(url)

            ' İzin yapılandırılıyor
            result       =   false
            
            ' Beklenen  /   Talep Edilen Sayfa
            expected    =   LCase(url)

            ' Savunma   /   Talebe Karşılık Gelen Yetkisi
            assert      =   ""
            
            'işlemler
            for each item in RoleClaims.Items

                for each auth   in item.Values.Items

                    ' Yetkisini savunma olarak aldık.
                    ' auth.Url bilgisindeki alana girebileceğini idda ediyor.   
                    assert      =  auth.Permission 
                    
                    ' İddasında bahsettiği, yetkileri arasında , talep ettiği bilgi var mı?
                    if assert = expected    then
        
                        ' Evet var. Aramayı bırak. Sonuç a git.
                        IsAuthorityUrl = true

                        exit for
                    else
                        assert = ""
                    end if

                next
                'Gerekçeli Sonuç :)
                if assert = expected    then
                    
                    ' Evet var. Aramayı bırak. Sonuç a git.
                    IsAuthorityUrl = true
                    
                    exit for
                else
                    assert = ""
                end if
            next
            'Sonuç
            result      =   (expected =   assert)

            IsAuthorityUrl = result

        end function

        ' Geçerli oturumu temizler.
        public function Clear()

            Session.Contents.RemoveAll()
            Session.Abandon()

        end function
    
        ' Sınıf Oluşturuluyor...
        public sub Class_Initialize()
            
        end sub

        ' Sınnıf kapsam dışına çıkıyor.
        public sub Class_Terminate
        
        end sub
    

    ' Sınıf Sonu
    end class

    ' Yetki Sınıfı
    class Claim

        public Id
        public ClaimType
        public ClaimValue
        public Values  'List<Claim>

        ' Yetkili Olunan Tam Yer
        public function Permission
            Permission  =   Strings.Format("/{0}-{1}", Array(ClaimType,ClaimValue))
            Permission  =   LCase(Permission)
        end function

        ' Sınıf Oluşturuluyor...
        public sub Class_Initialize()
            Set Values    =   Server.CreateObject("Scripting.Dictionary")     
        end sub

        ' Sınnıf kapsam dışına çıkıyor.
        public sub Class_Terminate
        
        end sub

    end class

    Dim Identity : Set Identity = new Authentication
%>