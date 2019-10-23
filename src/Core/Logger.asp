<%
    ' Loglama Sınıfı
    ' Herhangi bir bilginin kaydını tutar.
    class LoggerHandler

        private Folder                                  ' Kayıt Klasörü
    
        Public File                                     '   Kayıt Dosyası
        Public Line                                     '   Kayıt Satırı
       
        '   Kodu            Kategori            Açıklama
        '--------------------------------------------------------------------------------
        '   100             Authentication      Yetkilendirme
        '   200             Convert             Dönüştürme
        '   300             Data                Veri
        '   400             Encytption          Şifreleme
        '   400             Html                Html
        '   500             Logger              Loglama
        '   600             Operator            Kodlama
        '   700             Paginal             Sayfa
        '   800             Pluginal            Eklenti
        '   900             Requisition         Talep
        '   1000            Sql                 Sql
        '   1100            String              String
        
        public Number                                   '   Kayıt Numarası
        Public Description                              '   Kayıt Detayları
        Public Category                                 '   Kayıt Kategorisi
        Public State                                    '   Kayıt Durumu
        public isActive                                 '   Loglama aktif mi?

        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()

            Folder                                      =   config.LogFolder
    
            File                                        =   "0"     '   Kayıt Dosyası
            Line                                        =   0       '   Kayıt Satırı
            Number                                      =   0       '   Kayıt Numarası
            Description                                 =   ""      '   Kayıt Detayları
            Category                                    =   ""      '   Kayıt Kategorisi
            State                                       =   "info"  '   Kayıt Durumu
            isActive                                    =   true
    
        end sub
    
        ' Hatayı Fırlatır.
        public sub WriteFile()
        
            ' Herhangi bir hata olması durumunda devam et
            On Error Resume Next

            if not isActive = true then
                exit sub
            end if
            '--------------------------------------------------------------------------------
            userName                                    =   Identity.UserName
            
            ' Yazılacak değerler hazırlanıyor.
            value                                       =   Tick() & vbTab &_
                                                            userName & vbTab &_
                                                            File & vbTab &_
                                                            Line & vbTab &_
                                                            Number & vbTab &_
                                                            Category & vbTab &_
                                                            State & vbTab &_
                                                            Description & vbTab
    
            ' Dosya Sistemi
            Dim fileSystemObject
    
            ' Dosya
            Dim file
    
            ' Yeni Dosya Objesi
            Set fileSystemObject                        =   CreateObject("Scripting.FileSystemObject")
    
            ' Tam Yol
            fullPath                                    =   Server.MapPath(Folder   &_
                                                            today &_
                                                            "." &_
                                                            State &_
                                                            "." &_
                                                            Category &_
                                                            ".log")
    
            ' Dosya Mevcut mu?
            if fileSystemObject.FileExists(fullPath)    =   false then
                
                ' Yeni dosya oluştur. // Yazma izni gerekli
                Set file                                =   fileSystemObject.CreateTextFile(fullPath, True)
        
                ' Dosyayı Kapat
                file.Close
    
            end if
    
            ' Dosyayı Ekleme Modu ile Aç
            set file                                    =   fileSystemObject.OpenTextFile(fullPath, 8, true)
    
            ' Dosyaya bir satır yaz.
            file.WriteLine(value)
    
            ' Dosyayı Kapat
            file.Close
            '--------------------------------------------------------------------------------
    
            ' Hata Yakalama
            If Err.Number <> 0 Then
        
                ' Tarayıca Hata Modunda olup olmadığını bildiriyor muyuz?.
                if config.Debug = true then
    
                    'Tarayıcıya hata modunda olduğumuzu bildiridik.
                    Response.AddHeader "Debug-" & State & "-" & Category, "Message :" & value
                
                end if
    
                ' Bir Hata Oluştu
                On Error Goto 0 ' Hataları Temizle!
    
            End If
    
            if config.Debug = true then
    
                'Tarayıcıya hata modunda olduğumuzu bildiridik.
                Response.AddHeader "Debug-" & State & "-" & Category, "Message :" & value
            
            end if
    
        end sub
    
    end class    

    Dim Logger   : Set   Logger   =   new LoggerHandler
  
%>