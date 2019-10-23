<!--#include virtual                                        =   "/Core/Init.asp"-->
<%
    ' Kimlik Doğrulama kullanılmıyor.
    ' Halka açık bilgiler paylaşılıyor.
    ' Bu alana kimlik doğrulayarak giriş yapmak için bu yetkilendirme betiğini kullanın.
    ' Identity.Authenticated()

    ' Listeyi Json Data Olarak Döner
    public function ListJson()
    
        ' Geri dönüş nesnesi
        results =   ""
    
        ' Json Data Yapısı
        results             =   results &   "{"
        results             =   results &   "'data': ["        

        ' Modeli Json Ogesine Çevirisin
        results             =   results +   Json()
    
        ' Json Kapatma tagları ekleniyor.
        results             =   results &   "]"
        results             =   results &   "}"
    
        ' Json nesnesinde tek tırnak kullanılamadığı için çift tırnak olarak değiştiriyoruz.
        results             =   replace(results,  "'",    """")
    
        ' Fonksiyon geri dönüş bilgisi
        ListJson            =   results

    end function

    private function Json()

        ' Nesneler json tipine çevriliyor.
        results             =   results &   "{"
        results             =   results &   "'KEY':'"      & getEvent("KEY") & "'" & ","
        results             =   results &   "'NAME':'"      & getEvent("NAME") & "'"    
        results             =   results &   "}"
        Json                =   results
    
    end function

    ' ------------------------------------------------------------------------Response
    ' HTML başlık ayarlar adını için değer .
    Response.ContentType    =   "application/json"

    ' HTML başlık ayarlar adını için değer .
    Response.AddHeader          "Content-Type", "application/json"
    
    ' İçerik Yazdırılıyor
    Response.Write              ListJson

    ' Son
    Response.End()
%>