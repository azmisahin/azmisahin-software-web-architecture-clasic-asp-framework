<%
    ' Veritabanı Modeli.
    ' Veritabanına ve sağlayıcıyla nasıl ileteşim kurulacağını tanımlar.
    ' T-SQL sorgulama dili ile iletişim kurar.
    '================================================================================

    ' Database Sınıfı.
    class Database

        ' Veritabanı Access 200 ve üzeri için planlanmıştır.
        ' Sql Server Önerilen.
        public ActiveConnection 

        ' Bir veri kaynağına bağlantı kurmak için kullanılan bilgileri gösterir.
        ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/connectionstring-property-ado
        public ConnectionString             'Bağlantı terimi.
    
        ' Bir Bağlantı , Kayıt veya Akış nesnesindeki verileri değiştirmeye yönelik mevcut izinleri belirtir.
        ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/mode-property-ado
        private mode                        'Balantı Modu.
    
    
        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()            
    
            ' İlk Yapılandırma.
            Set ActiveConnection                        =   Nothing
    
            ' Mode özelliği yalnızca Connection nesnesi kapatıldığında ayarlanabilir .
            ' Referans : https://www.w3schools.com/asp/prop_rec_mode.asp
            mode                                        =   0
    
                                'adModeUnknown          0	        İzinler ayarlanmadı veya belirlenemedi.
                                'adModeRead             1	        Salt Okunur.
                                'adModeWrite            2	        Salt Yazma.
                                'adModeReadWrite	    3	        Okuma / Yazma.
                                'adModeShareDenyRead	4           Diğerlerinin okuma izinleriyle bir bağlantı açmasını engeller.
                                'adModeShareDenyWrite	8	        Başkalarının yazma izinleriyle bağlantı açmasını engeller.
                                'adModeShareExclusive	12	        Başkalarının bağlantı kurmasını engeller.
                                'adModeShareDenyNone	16	        Başkalarının herhangi bir izinle bir bağlantı kurmasına izin verir.
                                'adModeRecursive        0x400000	Geçerli Kaydın tüm alt kayıtlarında izinleri ayarlamak için adModeShareDenyNone, adModeShareDenyWrite veya adModeShareDenyRead ile birlikte kullanılır.
        
        end sub

        ' Veritabanı Açılıyor.
        public function Open
    
            ' Bağlantı kontrol ediliyor.
            if ActiveConnection is nothing then
    
                ' Bağlantı Tanımlanıyor. 
                Set ActiveConnection                    =   CreateObject("ADODB.Connection")
    
                ' Bağlantı Modu
                ActiveConnection.Mode                   =   mode
    
                ' Bağlantının, bağlantı terimi tanımlanıyor.
                ActiveConnection.ConnectionString       =   ConnectionString
    
                ' Bağlantı açılıyor.
                ActiveConnection.Open
            end if
    
            ' Aktif bağlantı
            Set Open                                    =   ActiveConnection
    
        end function
    
        ' Veritabanı Kapatılıyor.
        public function Close
    
            ' Bağlantı kontrol ediliyor.
            if not ActiveConnection is nothing then
    
                ' Bağlantı Tanımlanıyor.
                ' İlişkili sistem kaynaklarını boşaltmak için Close yöntemini kullanarak bir Connection , Record , Recordset veya Stream nesnesini kapatın 
                ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/close-method-ado
                ActiveConnection.Close
    
                ' Balantı Nothing
                ' Bir nesneyi bellekten tamamen ortadan kaldırmak için nesneyi kapatın ve nesne değişkenini Nothing olarak ayarlayın.
                ActiveConnection                        =   nothing
    
            end if
    
            ' Aktif bağlantı
            Set Close                                   =   ActiveConnection
    
        end function

        ' Transact-SQL (T-SQL) kullanılan, SQL sorgulama dilindeki komut dizisini çalıştırır.
        public function Run(tSQL)

            On Error Resume Next                        ' Herhangi bir hata olması durumunda devam et
            '--------------------------------------------------------------------------------

            ' Bağlantı açılarak, tanımlanıyor.
            Set ActiveConnection                        =   Open
    
            ' Belirtilen sorguyu, SQL deyimini, saklı yordamı veya sağlayıcıya özgü metni yürütür
            ' Transact-SQL olarak sağlayıcaya iletir.
            ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/execute-method-ado-connection
            Set Run                                     =   ActiveConnection.Execute(tSQL)
            
            '--------------------------------------------------------------------------------
            ' Hata Yakalama
            If Err.Number                               <>  0 Then
                ' Bir Hata Oluştu
                
                ' Hata String Verisi
                connectionErrorString                   =   ""
                
                ' Aktif Bağlantıda hatalar aranıyor.
                for each connectionError in ActiveConnection.Errors
                    
                    ' Aktif bağlantıdaki hata 
                    connectionErrorString               =   connectionErrorString   &   connectionError 
                next
                
                ' Hata Fırlatmaya hazırlanıyor.
                Exception.File                          =   "DATA"
                Exception.Line                          =   "117"
                Exception.Number                        =   1
                Exception.Description                   =   Strings.Format("{0} {1} {2}", Array(Err.number, Err.Description, connectionErrorString))
                Exception.Category                      =   "Run"
                Exception.State                         =   "info"

                ' Hata fırlatılıyor.
                Exception.Throw()
            else
                ' Loglama Başla
                Exception.File                              =   "DATA"
                Exception.Line                              =   "92"
                Exception.Number                            =   1
                Exception.Description                       =   tSQL
                Exception.Category                          =   "Run"
                Exception.State                             =   "debug"
                Exception.Throw()

            End If

        end function

        ' Selec İşlemleri
        public function Selec(tSQL)
    
            ' Seçim sorgusu
            Set Selec                                   =   Run(tSQL)
            
        end function

        ' Query İşlemleri
        public function Query(tSQL)
    
            ' Sorgu çalıştırılıyor.
            Set Query                                   =   Run(tSQL)
            
        end function

        ' Ekleme İşlemleri
        public function Insert(tSQL)
    
            ' Ekleme sorgusu çalıştırılıyor.
            Set Insert                                  =   Run(tSQL)
            
            ' işlem sonrası sorgusu
            ' Dikkat paylaşımlı bağlantı için geçerlidir.
            ' Aktif bağlantı yeniden açıldığında sorgu negatif dönüş gerçekleştir.
            Set Insert                                  =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function

        ' Update İşlemleri
        public function Update(tSQL)
    
            ' Güncelleme Sorgusu çalıştırılıyor.
            Set Update                                  =   Run(tSQL)
    
            ' işlem sonrası sorgusu
            ' Dikkat paylaşımlı bağlantı için geçerlidir.
            ' Aktif bağlantı yeniden açıldığında sorgu negatif dönüş gerçekleştir.
            Set Update                                  =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function

        ' Delete İşlemleri
        public function Delete(tSQL)
    
            ' Silme sorgusu çalıştırılıyor.
            Set Delete                                  =   Run(tSQL)
    
            ' işlem sonrası sorgusu
            ' Dikkat paylaşımlı bağlantı için geçerlidir.
            ' Aktif bağlantı yeniden açıldığında sorgu negatif dönüş gerçekleştir.
            Set Delete                                  =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function

            
        ' SQL İŞLEMLERİ Dahili
        ' --------------------------------------------------------------------------------
       
        ' Komut parametreleri tanımlanıyor
        private function setCommandParameters( ByRef command,  params)

                On Error Resume Next                        ' Herhangi bir hata olması durumunda devam et
            '--------------------------------------------------------------------------------

            ' Parametreler Dizisi kontrol ediliyor.
	        If Not IsArray( params) Then

	            ' Parametreler dizi olarak tanımlanmalıdırı.
                setCommandParameters                    =   false
	
                ' Fonksiyonu terket
                Exit Function

	        End If
	
            ' Parametre dizisi uzunluğu kadar parametre eklenecek
            commandParametersCount                      =   command.Parameters.Count

            ' Parametre Uzunluğu
            paramsCount                                 =   UBound (params)   +   1

            ' Uzunluklar eşleşiyor mu?
            if commandParametersCount                   =   paramsCount Then
	            
                For i                                   =   0   to  commandParametersCount    -   1

	                ' Parametreler Güncelleniyor.
                    command.Parameters(i)               =   Sql.UpdateParameter(command.Parameters(i).Name, params(i))

	            Next

                ' Tüm parametreler eklendi.
	            setCommandParameters                    =   True
	
            Else
                ' Ref: https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/namedparameters-property-ado
                ' Ref: https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/append-and-createparameter-methods-example-vb
                '   İsim Parametreleri hazırlanıyor 
                '   Sql Yapılandırması
    
                ' Named Parametresi yeniden yapılandırılacaktır.( Sql Server )
                cmdText                                 =   command.CommandText
  
                ' Komut Text VALUES Alanları aranıyor.
                valuesPosition                          =   InStr(1,cmdText,"(")

                ' Komut Text VALUES Alanları temizleniyo.
                valuesText                              =   Replace(cmdText," ", "",valuesPosition)

                ' Komut Text Başlığı Alanları aranıyo
                HeaderText                              =   Left(cmdText,valuesPosition-1)
            
                ' Yeniden Birleştiriliyor
                cmdText                                 =   HeaderText & valuesText

                ' Parametre isim listesi
                paramPosition                           =   InStr(1,valuesText,"VALUES(")  
                paramText                               =   Replace(valuesText,"VALUES(", "",paramPosition)   
                paramText                               =   Replace(paramText,")", "")   
                paramText                               =   Replace(paramText,",", "")                
                paramText                               =   Replace(paramText,"@", "",1,1)                
                paramNames                              =   Split(paramText,"@")

                For i                                   =   0   to  paramsCount    -   1
    
                    ' Named Parametresi Uyumlu Hale Getiriliyor.( Sql Server )
                    ' cmdText = Replace (cmdText ,"@" & paramNames(i+1),"?" )

                    ' Parametre Değeri yok ise , işleme alınmıyor
                    paramValue                          =   params(i)
                    paramName                           =   paramNames(i)

                    if IsNothing(paramValue)                Then
           
                        ' Komutlar arasından çıkartılıyor
                        cmdText = Replace (cmdText ,    ",[" & paramName & "]"  ,   " " )

                        ' Komut değerleri arasından çıkartılıyor
                        cmdText = Replace (cmdText ,    ",@" & paramName        ,   " " )
                    else
                        
                        ' Named Parametresi Uyumlu Hale Getiriliyor.( Sql Server )
                        cmdText = Replace (cmdText ,    "@" & paramName         ,   "?" )

                    end if
                Next
    
                ' Named Parametresi yeniden Tanımlanıyor.( Sql Server )
                command.CommandText = cmdText
                jumpData    =   0
                For i                                   =   0   to  paramsCount    -   1

                    ' Parametre Değeri yok ise , işleme alınmıyor
                    paramValue                          =   params(i)
                    paramName                           =   paramNames(i)

                    if IsNothing(paramValue)                Then
                        ' Herhnagi bir işlem yapma
                        jumpData   =   jumpData   +   1
                    else
    
                        ' Parametreler Güncelleniyor.
                        command.Parameters(i-jumpData)                  =   Sql.UpdateParameter(paramName, paramValue)

	                    ' Parametreler Sql Tipine Çevriliyor.                    
                        command.Parameters(i-jumpData)                  =   Sql.ConvertParameter(paramName,paramValue)
                    end if
        
                Next

                ' Alan sayıları eşleşmiyor.
	            setCommandParameters                    =   True

	        End If

            ' Hata Yakalama
            If Err.Number                               <>  0 Then
                ' Bir Hata Oluştu
                
                Exception.File                          =   "DATA"
                Exception.Line                          =   "204"
                Exception.Number                        =   1
                Exception.Description                   =   Strings.Format("{0} {1} {2}", Array(Err.number, Err.Description, SqlCommand.CommandText))
                Exception.Category                      =   "setCommandParameters"
                Exception.State                         =   "err"
                Exception.Throw()

            end if
	
	
        End Function

        ' Sql Komut nesnesi hazırlar.
        ' Referans : https://docs.microsoft.com/en-us/sql/ado/guide/data/command-object-parameters
        private function setCommand(sql, params)
        
            ' Komut oluşturuluyor
            Set item                                    =   Server.CreateObject("ADODB.Command")
            
            ' Varsayılan Bağlantı tanımlanıyor.
            item.ActiveConnection                       =   Open

            ' Parametre adlarının sağlayıcıya geçip geçmeyeceğini belirtir.
            item.NamedParameters                        =   false

            ' Komut Türü                    'sql String
            '   adCmdUnspecified            -1	Bu değer, CommandType özelliğinin belirtilmediğini gösterir.
            '   adCmdText                   1	Bu değer, CommandText özelliğini bir komut veya saklı yordam çağrısının metinsel bir tanımı olarak değerlendirir .
            '   adCmdTable                  2	Bu değer, CommandText özelliğini bir tablo adı olarak değerlendirir . Bu değer, AS / 400 ve VSAM için OLE DB Sağlayıcısı veya DB2 için OLE DB Sağlayıcısı tarafından desteklenmiyor.
            '   adCmdStoredProc             4	Bu değer, CommandText özelliği, bir saklı yordam olarak değerlendirir . Bu değer, AS / 400 ve VSAM için OLE DB Sağlayıcısı veya DB2 için OLE DB Sağlayıcısı tarafından desteklenmiyor.
            '   adCmdUnknown                8	Bu değer, CommandText özelliğinde komut türünün bilinmediğini gösterir. Bu varsayılan değerdir.
            '   Referans : https://msdn.microsoft.com/en-us/library/ee266308(v=bts.10).aspx
            item.CommandType                            =   1
            
            ' Komut
            item.CommandText                            =   sql 

            ' Parametreleri Tanımla
            setCommandParameters item, params
    
            ' Öge Geri Dönüyor
            Set setCommand                              =   item

        end function

        ' SQL İŞLEMLERİ Public
        ' --------------------------------------------------------------------------------
    
        ' T-SQL Sorgusunu , SQL üzerinde Parametre ile çalıştır.
        public function RunCommand(tSQL,tPARAMS)
    
            On Error Resume Next                        ' Herhangi bir hata olması durumunda devam et
            '--------------------------------------------------------------------------------

            ' Bağlantı açılarak, tanımlanıyor.
            Set SqlCommand                              =   setCommand(tSQL, tPARAMS)

            ' Belirtilen sorguyu, SQL deyimini, saklı yordamı veya sağlayıcıya özgü metni
            ' KOMUT olarak sağlayıcaya iletir.
            Set RunCommand                              =   SqlCommand.Execute
    
            ' Geçerli Recordset nesnesini siler ve bir dizi komut boyunca ilerleyerek sonraki Recordset'i döndürür .
            ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/nextrecordset-method-ado
            ' Set RunCommand                            =   SqlCommand.NextRecordSet()
                
            '--------------------------------------------------------------------------------
            ' Hata Yakalama
            If Err.Number                               <>  0 Then
                ' Bir Hata Oluştu
                
                ' Hata string
                connectionErrorString                   =   ""
                
                ' Hata içeriği
                for each connectionError in ActiveConnection.Errors
            
                    ' Bir hata
                    connectionErrorString               =   connectionErrorString   &   connectionError 

                next
                
                paramString = Join(tPARAMS," # ")
                
                Exception.File                          =   "DATA"
                Exception.Line                          =   "301"
                Exception.Number                        =   1
                Exception.Description                   =   Strings.Format("{0} {1} {2} {3} {4}", Array(Err.number, Err.Description, connectionErrorString, SqlCommand.CommandText, paramString))
                Exception.Category                      =   "RunCommand"
                Exception.State                         =   "err"
                Exception.Throw()
        
            else

                ' Loglama Başla
                Exception.File                              =   "DATA"
                Exception.Line                              =   "252"
                Exception.Number                            =   1
                Exception.Description                       =   SqlCommand.CommandText
                Exception.Category                          =   "RunCommand"
                Exception.State                             =   "debug"
                Exception.Throw()    

            End If

        end function

        ' T-SQL Sorgusunu , SQL üzerinde Parametre ile çalıştır.
        public function RunCommandNonQuery(tSQL,tPARAMS)
    
            On Error Resume Next                        ' Herhangi bir hata olması durumunda devam et
            '--------------------------------------------------------------------------------

            ' Bağlantı açılarak, tanımlanıyor.
            Set SqlCommand                              =   setCommand(tSQL, tPARAMS)

            ' Belirtilen sorguyu, SQL deyimini, saklı yordamı veya sağlayıcıya özgü metni
            ' KOMUT olarak sağlayıcaya iletir.
            Set RunCommand                              =   SqlCommand.Execute(adExecuteNoRecords)
    
            ' Geçerli Recordset nesnesini siler ve bir dizi komut boyunca ilerleyerek sonraki Recordset'i döndürür .
            ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/nextrecordset-method-ado
            ' Set RunCommand                            =   SqlCommand.NextRecordSet()
                
            '--------------------------------------------------------------------------------
            ' Hata Yakalama
            If Err.Number                               <>  0 Then
                ' Bir Hata Oluştu
                
                ' Hata string
                connectionErrorString                   =   ""
                
                ' Hata içeriği
                for each connectionError in ActiveConnection.Errors
            
                    ' Bir hata
                    connectionErrorString               =   connectionErrorString   &   connectionError 

                next
                
                Exception.File                          =   "DATA"
                Exception.Line                          =   "301"
                Exception.Number                        =   1
                Exception.Description                   =   Strings.Format("{0} {1} {2}", Array(Err.number, Err.Description, connectionErrorString))
                Exception.Category                      =   "RunCommand"
                Exception.State                         =   "info"
                Exception.Throw()
        
            else

                ' Loglama Başla
                Exception.File                              =   "DATA"
                Exception.Line                              =   "252"
                Exception.Number                            =   1
                Exception.Description                       =   tSQL
                Exception.Category                          =   "RunCommand"
                Exception.State                             =   "debug"
                Exception.Throw()    

            End If

        end function

        ' Seçme İşlemleri Komut İle
        public function SqlQuery(tSQL,tPARAMS)
    
            Set SqlQuery                                =   RunCommand(tSQL,tPARAMS)
            
        end function

        ' Ekleme İşlemleri Komut İle
        public function SqlInsert(tSQL,tPARAMS)
    
            Dim Insert  :   Set Insert                  =   RunCommand(tSQL,tPARAMS)
            
            Set SqlInsert                               =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function
    
        ' Güncelleme İşlemleri Komut İle
        public function SqlUpdate(tSQL,tPARAMS)
    
            Dim Update  :   Set Update                  =   RunCommand(tSQL,tPARAMS)
            
            Set SqlUpdate                               =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function

        ' Silme İşlemleri Komut İle
        public function SqlDelete(tSQL,tPARAMS)
    
            Dim Delete  :   Set Delete                  =   RunCommand(tSQL,tPARAMS)
            
            Set SqlDelete                               =   Run("SELECT @@IDENTITY AS RecordID")
            
        end function
    
    ' Sınıf Sonu
    end class
%>