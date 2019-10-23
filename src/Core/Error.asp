<%
    ' Hata Sınıfı
    ' Herhangi bir hatanın bilgisini Tutar.
    class ErrorHandler
    
        Public File                                     '   Hata Dosyası
        Public Line                                     '   Hata Satırı
       

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
        
        public Number                                   '   Hata Numarası
        public Description                              '   Hata Detayları
        public Category                                 '   Hata Kategorisi
        public State                                    '   Hata Durumu

        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()
    
            File                                =   "0"     '   Hata Dosyası
            Line                                =   0       '   Hata Satırı
            Number                              =   500     '   Hata Numarası
            Description                         =   ""      '   Hata Detayları
            Category                            =   ""      '   Hata Kategorisi
            State                               =   "error" '   Hata Durumu
        end sub
    
        ' Hatayı Fırlatır.
        public sub Throw()

            ErrorLog()
  
            if State = "error" then
                'Response.Clear
                'Response.Status             =   Number
                Response.Write                  Description
                Response.End
            end if

        end sub

        public sub ErrorLog()

            Logger.File        =    File            
            Logger.Line        =    Line                               
            Logger.Number      =    Number                             
            Logger.Description =    Description                        
            Logger.Category    =    Category
            Logger.State        =   State
            
            if config.Debug = false and State = "debug" then
                'Log kaydı gerçekleştirme.
            else
                Logger.WriteFile()
            end if

        end sub
    
    end class

    Dim Exception   : Set   Exception   =   new ErrorHandler  
%>