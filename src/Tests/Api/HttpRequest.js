/// HTTP
/// Test HTTP Request
/// <returns type="HTTP" />
function HTTP() { }

/*
    ════════════════════════════════════════════════════════════════════════════════════════════════════
    * HTTP: Uygulama Ana Katmanı
    ════════════════════════════════════════════════════════════════════════════════════════════════════

    Kullanımı:

    var newHttp = new HTTP();
*/
HTTP.prototype = (function () {

    /// Genel Erişim
    var public =
        {
            Version: "0.0.0.1"
            , constructor: HTTP
        };

    /*
    Public Functions
    ────────────────────────────────────────────────────────────────────────────────────────────────────*/
    return public;
})();

/*
 * Standat XML Http Request 
 * Ref : https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests * 
 * */
HTTP.prototype.GetSync = function (url, callback) {

    // Ref: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
    return new Promise((resolve, reject) => {

        // Yükleme başarılı gerçekleştiğinde
        function xhrSuccess() {

            // Geridönüş nesnesi uygulanıyor.
            this.callback.apply(this, this.arguments);
        }

        // Yükleme başarısız gerçeklşerğinde
        function xhrError() {

            // consolda hata oluşturuluyor.
            console.log("App GetSync Error");
            console.error(this.statusText);
        }

        // Http Nesnesi örnekleniyor.
        var xhr = new XMLHttpRequest();

        // Cevap Türü json yapılandılıyor
        xhr.responseType = "json";

        // Geridönüş bilgidiliyor
        xhr.callback = callback;

        // Argumanlar ayrıştırılıyor.
        xhr.arguments = Array.prototype.slice.call(arguments, 2);

        // Yükleme başarılı gerçekleştiğinde, başarılı(success) Çözümleme.
        xhr.onload = () => resolve(xhr.response);

        // Yükleme başarısız gerçeklşerğinde, başarısız(error) Reddiliyor.
        xhr.onerror = () => reject(xhr.response);

        // Adres açılıyor
        xhr.open("GET", url, true);

        // Istek iletildi.
        xhr.send(null);

    });
}