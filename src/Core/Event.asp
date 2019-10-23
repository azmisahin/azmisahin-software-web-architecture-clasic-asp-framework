<%
    ' Uygulama belleğine a bir öge ekler
    private sub setEvent(key, value)
        Application("event" & "_" & key) = value
    end sub

    ' Uygulama belleğine anahtarı verilen ögenin değerini döndürür.
    public function getEvent(key)
    
        Value = ""

        ' Anahtar tanımı kontrol ediliyor.
        if IsEmpty(Application("event" & "_" & key)) then
        ' Yapılandırılmamış anahtarlar için empty string döndürülecek.
            Value   =   ""
        else
            Value = Application("event" & "_" & key)
        end if

        getEvent = Value
        
    end function
%>