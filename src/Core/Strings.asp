<%
    ' Strings Sınıfı
    ' String işlemleri.
    class StringHelper    
    
        ' String Biçimlendirme
        function Format(value, params)

            ' Dönüş değeri
            result              =   ""

            ' Başlangıç ayracı
            startingSeparator   =   "{"

            ' Bitiş ayracı
            endSeparator        =   "}"

            ' Parametre uzunluğu
            length              =   UBound(params)
    
            ' String i biçimlendir
            for position        =   0   to  length
    
                ' Bulunacak nesne
                find            =   startingSeparator & CStr(position) & endSeparator

                ' Değiştirilecek nesne
                replacement      =   params(position)

                ' Aranacak yer
                expression      =   value

                ' Değerin içindeki  {position} değerlerini parametre değerleri ile değiştir.
                result          =   Replace(expression, find,   replacement )

                ' Yeni Değer, Birden fazla expression için
                value           =   result
            next
    
            ' Dönüş değeri yapılandırılıyor.
            Format        =   result
    
        end function

    end class

    Dim Strings :   Set Strings =   new StringHelper
%>