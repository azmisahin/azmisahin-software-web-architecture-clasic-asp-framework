(function () {

    // Geri dönüş verisi
    var data = null;

    // Servisin Bulunduğu adres
    let server = document.location.origin;

    // Api Servis Adresi
    let api = 'api/?t=Configurations';

    // Servis Parametresi
    let parameter = window.location.search;

    // İstekte bulunulancak Tam URL
    let uri = server + '/' + api + parameter;

    // Http İsteği
    new HTTP()

        // Sync Bağlantı
        .GetSync(uri)

        // Bağlantı gerçekleştirildikten sonra
        .then((response) => {

            // Geri dönüş cevabındaki veri alınıyor.
            this.data = response.data;

            // Verileri Html e Aktar
            renderData(response.data);

        });

    /// Örnek Veriyi HTML e aktarır
    function renderData(data) {

        // Yeni  Element
        var table = "<table class='table'>"

        table += '<thead>'
        table += "<tr>"
        table += "<th>" + "Id" + "</th>"
        table += "<th>" + "Key" + "</th>"
        table += "<th>" + "Value" + "</th>"
        table += "<th>" + "Description" + "</th>"
        table += '</thead>'

        table += '<tbody>'

        // Veri ögeleri taranıyor.
        data.forEach(function (item) {
            table += "<tr>" 
            table += "<td>" + item.Id + "</td>"
            table += "<td>" + item.Key + "</td>"
            table += "<td>" + item.Value + "</td>"
            table += "<td>" + item.Description + "</td>"
            table += "<tr>"
        });
        
        table += '</tbody>'
        table += '</table>'

        // Mevcut Bölüm seçiliyor.
        var currentSection = document.getElementById("report")

        var body = '<header is="section-header">'
        body += '<h1>Configurations</h1>'
        body += '</header>'
        body += '<p is="section-description">' + table + '</p>'

        // Hazırlanmış içerik aktarılıyor.
        currentSection.innerHTML = body;
    }
})();