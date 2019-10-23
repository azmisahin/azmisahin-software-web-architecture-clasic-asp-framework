<%
    ' Sayfa Sınıfı
    ' Sayfalara ait bilgileri taşımak amaçlı kullanılmaktadır.
    class Paginal
    
        ' Başlık
        Public Title

        ' Sayfayı tanımlayan açıklama
        Public Description

        ' Kontrolör Adı
        public Controller

        ' Kontrolör İşlemi
        Public Action
    
        ' Index
        Public Index

        ' Sınıf İlk Yapılandırması.
        public sub Class_Initialize()
    
            Title                                       =   "Ana Sayfa"

            Controller                                  =   "Home"

            Action                                      =   "Index"
    
            Index                                       =   "Page"
        end sub

        public function Route
            Route   =   Strings.Format("/{0}-{1}",Array(Controller,Action))
            Route   =   LCase(Route)
        end function
    
    end class
%>