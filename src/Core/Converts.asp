<%
    ' Dönüştürme Sınıfı
    ' Veri Dönüştürme işlemleri.
    ' Referans  :   https://docs.microsoft.com/en-us/dotnet/visual-basic/language-reference/functions/type-conversion-functions
    class ConvertHelper

        ' Veri Decimal
        function ToDecimal(value)
            'ToDecimal     =   FormatNumber(value,2)
            ToDecimal     =   FormatNumber(value)
        end function
    
        ' Veri Money
        function ToMoney(value)
            ToMoney     =   value
        end function

        ' Veri Long
        function ToLong(value)
            ToLong      =   value
        end function

        ' Veri String
        function ToString(value)
            ToString    =   value
        end function

        ' Veri Sayı
        function ToInt(value)
            if  (value  =   "") or  isEmpty(value) or isNULL(value)  then
                ToInt   =   Empty
            else
                ToInt  =   value
            end if

        end function

            ' Veri Sayı
        function ToInt32(value)
            if  (value  =   "") or  isEmpty(value) or isNULL(value)  then
                ToInt32   =   0
            else
                ToInt32  =   Clng(value)
            end if

        end function

        ' Veri Açık Kapalı
        function ToBool(value)
            ToBool  =   (value =   "on")   or (value    =   "True"  )   or  (value  =   "true") or  (value  =   "1")  or  (value  =   "Yes")  or  (value  =   "Evet") or  (value  =   "Doğru")    
        end function

        ' Veri Ondalıklı
        function ToDouble(value)
            ToDouble  =   CDbl(value)   
        end function

        ' Veri Zaman
        function ToStamp(value)
            ToStamp  =   NULL
        end function

        ' Veri Tarih
        function ToDate(value)

            if  (value  =   "") or  isEmpty(value)  or isNULL(value)  then
                ToDate   =   Empty
            else
                ToDate  =   CDate(value)
            end if
            
        end function

    end class

    Dim Convert :   Set Convert =   new ConvertHelper
%>