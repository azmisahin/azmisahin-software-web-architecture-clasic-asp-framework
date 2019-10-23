<%
    ' İşlem talep gerekli talepleri
    ' Form yada QuerysString Neslerini Birlikte Kapsar
    ' Gelen verileri doğrular, geliş biçimlerini tutar.
    class Requisition
    
        ' Başlık
        Public Title

        ' Kontrolör Adı
        public Name

        ' Kontrolör İşlemi
        Public Action
    
        ' Kontrolör İşlemi
        Public Method

        ' Query String Nesneleri
        Public Variable
    
        ' Doğrulama
        Public Validation

        ' Mesaj
        Public Message

        ' Yerel Çalışma
        public IsLocal

        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()
    
            ' Form Adı
            Name                                        =   "form"

            ' Form İşlemi
            Action                                      =   ""

            ' İstek Methodu
            ' Referans : https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
            ' Referans : https://msdn.microsoft.com/en-us/library/ms524602(v=vs.90).aspx
            Method                                      =   Request.ServerVariables("REQUEST_METHOD")

            ' Query String Nesneleri
            Variable                                    =   Request.QueryString("id")
            if  Variable                                <>   "" then
                Variable                                =   Variable    'Convert.ToInt32(Variable)
            end if
           
            ' Doğrulama
            Validation                                  =   true

            ' Mesaj
            Message                                     =   ""

            ' Yerel ortamdamı çalışılıyor?
            if Request.ServerVariables("SERVER_NAME")   =   "localhost" then
                IsLocal                                 =   true
            else
                IsLocal                                 =   false
            end if

        end sub

        ' Error Control [ Err ]
        public function ErrorControl(uri)
    
            ' Sorun oluştuğunda,
            if Err.Number <> 0 then
    
                ' Bir hata meydana geldi.
                Validation                          =   false

                ' Oluşan Hataları İncele
                Errors()
    
            else           

                ' İstek İşlendi.
                Validation                          =   true

                ' Yönlendirme Talebi Var mı?
                if uri <> "" then
                    ' Bu sayfanın index ine dön
                    Response.Redirect(uri)
                end if
            
            end if
    
            ' Geri Dönüş
            ' Set ErrorControl                            =   requisit
        
        end function

        ' Tüm Hatalar
        private sub Errors()
    
            ' Hata Kodu Inceleniyor
            Select Case Err.Number
                Case 424
                    Message                         =   "Geçerli bir kayıt gerekli. Yada aynı tanıma sahip bir kayıt tanımlanıyor!."
                Case 438
                    Message                         =   "Kayıtlar eşleşmiyor. Özellik desteklenmiyor!"
                Case else
                    Message                         =   Err.number & " " & Err.Description
            End Select

            Exception.File          =   "REQUISITION"
            Exception.Line          =   "97"
            Exception.Number        =   1
            Exception.Description   =   Strings.Format("{0} {1} {2}", Array(Err.number, Err.Description,Request.ServerVariables("HTTP_X_ORIGINAL_URL")))
            Exception.Category      =   "Controller"
            Exception.State         =   "warning"
            Exception.Throw()
        
        end sub
    
    end class

    Set requisit = New Requisition
%>