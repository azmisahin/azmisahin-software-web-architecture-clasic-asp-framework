<!--#include virtual                                        =   "/Core/Init.asp"-->
<%
    ' Kimlik Doğrulama kullanılmıyor.
    ' Halka açık bilgiler paylaşılıyor.
    ' Bu alana kimlik doğrulayarak giriş yapmak için bu yetkilendirme betiğini kullanın.
    ' Identity.Authenticated()

     ' Database Hazırlanıyor.
    Set db                                  =   New Database
    
    ' Bağlantı terimi, konfigurasyon dosyasından alınıyor.
    db.ConnectionString                     =   config.DataConnectionString
    
    ' Bağlantı açıldı.
    value                                   =   db.Open()

 ' Database Hazırlanıyor.
    Set db                                  =   New Database
    
    ' Bağlantı terimi, konfigurasyon dosyasından alınıyor.
    db.ConnectionString                     =   config.DataConnectionString
    
    ' Bağlantı açıldı.
    value                                   =   db.Open()
    
    ' Başlanacak Satır
    Index                                   =   0

    ' Uzunluk
    Length                                  =   100

    ' Listeyi Json Data Olarak Döner
    public function ListJson(startIndex, displayLenth)
    
        ' Tanımlanıyor.
        
        ' index
        if  startIndex                      =   0   then
            startIndex                      =   Index
        end if
    
        ' Kayıt uzunluğu
        if  displayLenth                    =   0   then
            displayLenth                    =   Length
        end if
    
        ' Geri dönüş nesnesi
        results                             =   ""
    
        ' Json Data Yapısı
        results                             =   results &   "{"
        results                             =   results &   "'data': ["        

        ' Aramaya Başlanıyor
        while not data.eof

            ' Modeli Json Ogesine Çevirisin
            results                         =   results +   Json(fields)

            ' Sonraki
            data.MoveNext

            if not data.eof then
                ' Json Kaydını İşlemeye Devam Ediliyoruz.
                results                     =   results &   ","
            end if
        wend
    
        ' Json Kapatma tagları ekleniyor.
        results                             =   results &   "]"
        results                             =   results &   "}"
    
        ' Kullandığım boşlukları temizleyelim.
        'results     = replace(results,  " ",    "")
    
        ' Json nesnesinde tek tırnak kullanılamadığı için çift tırnak olarak değiştiriyoruz.
        results     = replace(results,  "'",    """")
    
        ' Fonksiyon geri dönüş bilgisi
        ListJson    =   results

    end function

    ' Json model döner
    private function Json(fields)

        ' Nesneler json tipine çevriliyor.
        results     =   results &   "{"
        
        ' Global tablo için başlıklar ve içerik hazırlanıyor.
        For intLoop = 0 To (fields.Count - 1)
       
            results     =   results &   "'" & fields.Item(intLoop).Name & "':'" & fields.Item(intLoop)  & "'"
            if intLoop = fields.Count - 1 then
                
            else
                results = results & ","
            end if

        Next

        results     =   results &   "}"

        Json        =   results
    
    end function    
    
    '-------------------------------------------------------------------------Request
    ' Table Name
    t   =   Request.QueryString("t")

    ' Start Index
    s   =   Request.QueryString("s")
    
    ' Display Length
    l   =   Request.QueryString("l")

    ' Sayısal Değere çevriliyor.
    s   =   Convert.ToInt(s)
    l   =   Convert.ToInt(l)

    '----------------------------------------------------------------------------Data
    query                                   =   "SELECT * FROM " & t

    ' Çalıştır
    Set data                                =   db.Selec(query)
    
    ' Veri Alanları
    Set fields                              =   data.Fields

    ' ------------------------------------------------------------------------Response
    ' HTML başlık ayarlar adını için değer .
    Response.ContentType    =   "application/json"

    ' HTML başlık ayarlar adını için değer .
    Response.AddHeader          "Content-Type", "application/json"

    ' Yazdırılıyor
    Response.Write ListJson(s,l)

    ' Son
    Response.End()
%>