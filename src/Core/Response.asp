<%
    ' Yanıt Nesnesi
    ' Çıktıyı istemciye göndermek için Yanıt nesnesini kullanabilirsiniz .
    ' Referans : https://msdn.microsoft.com/en-us/library/ms525405(v=vs.90).aspx

    ' Yöntemler

    ' HTML başlık ayarlar adını için değer .
    ' Response.AddHeader      "Content-Type", "text/html;charset=UTF-8"
    
    ' Özellikler

    ' Sayfa çıktısının arabelleğe alınmış olup olmadığını gösterir.
    Response.Buffer             =   true
    Response.Expires            =   -1
    Response.ExpiresAbsolute    =   Now() -1 
    Response.AddHeader              "pragma", "no-store"
    Response.AddHeader              "cache-control","no-store, no-cache, must-revalidate"

    ' ASP tarafından üretilen çıktıyı önbelleğe alıp önleyemeyeceklerini proxy sunucularına veya diğer önbellek mekanizmalarına bildirmek için bir üstbilgi ayarlar.
    ' Private       Bir önbellek mekanizması, bu sayfayı özel önbellekte önbelleğe alabilir ve yalnızca tek bir müşteriye yeniden gönderebilir. Bu varsayılan değerdir. Çoğu proxy sunucusu, bu ayarı içeren sayfaları önbelleğe almaz.
    ' Public        Proxy sunucuları gibi paylaşılan önbellekler, bu ayarı kullanarak sayfaları önbelleğe alır. Önbellek sayfası herhangi bir kullanıcıya gönderilebilir.
    ' No-cache      Bu sayfayı aynı istemci tarafından kullanılsa bile önbelleğe almayın.
    ' No-store      Yanıt ve onu oluşturan istek paylaşılan veya gizli olmak üzere herhangi bir önbellekte saklanmamalıdır. Burada tayin edilen depolama alanı, teyp yedekleri gibi kalıcı olmayan bir saklama alanıdır. Bu, inanılmaz bir güvenlik önlemi değildir.
     Response.CacheControl   =   "No-cache"

    ' Karakter kümesinin adını içerik türü başlığına ekler. Karakter kümesi, tarayıcıya karakterlerin nasıl gösterileceğini belirtir.
    Response.CharSet        =   "UTF-8"

    ' Tek bir yanıt için intrinsic nesnelerdeki veriler için kod sayfasını ayarlar. Kod sayfası, sunucunun farklı dillerdeki karakterlerin nasıl kodlanacağını belirtir.
    ' Referans : https://msdn.microsoft.com/en-us/library/windows/desktop/dd317756(v=vs.85).aspx
    ' 65001 utf-8	Unicode (UTF-8)
    Response.CodePage       =   65001

    ' Server
    'Session.CodePage        =   1254
    
    ' Server
    ' Referans : https://msdn.microsoft.com/en-us/library/ms912047(v=winembedded.10).aspx
    Session.LCID            =   1055    ' Türkish    
%>