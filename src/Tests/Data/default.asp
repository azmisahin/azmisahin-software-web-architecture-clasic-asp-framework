<!--#include virtual                                        =   "Core/Init.asp"-->

<h1>Proje dahilinde basit bağlantı Örneği</h1>
<ul>
    <li>Tüm işlemler mevcut proje içerisinde çağrılabilir</li>
    <li>Farklı bir projeye dahil edilicek ise, include edilmiş referans bağlantıları ile alınmalıdır.</li>
    <li>Yönetilebilir.</li>
</ul>


<!-- ÖRNEK 1 -->

<%
    ' Yeni bir veritabanı nesnesi oluşturuluyor
    ' Veritabanına ve sağlayıcıyla nasıl ileteşim kurulacağını tanımlayan ana veri modeli.
    Set db                      =   New Database
    
    ' Konfigurasyon Tanımları
    ' Proje içerisinde tanımlanacak tüm değişkenlerx tek bir alan üzerinden yapılandırıyor
    parameter                   =   config.AccountConnectionString

    ' Veritabanının bağlanacağı veri kataloğu gerekli parametreleri ile set ediliyor.
    ' /Core/config.asp icerisindeki parametre taşınıyor.
    db.ConnectionString         =   parameter

    ' Bağlantı güvenli bir şekilde açıldı.
    ' Bağlantı oturum süresince önbelleklenedek kullanılacak
    ' value değerinde sağlayıcı bilgileri geridönecektir.
    value                       =   db.Open()
%>
<%

    ' Veri kataloğu üzerinde bir tablo, görünüm yada fonksiyona erişilecek sorgu hazırlanıyor.
    query                       =   "SELECT * FROM Users"

    ' Transact-SQL (T-SQL) kullanılan, SQL sorgulama dilindeki komut dizisini çalıştırır.
    ' Geri dönüşte standart kayıt Seti Bilgileri Nesnesi yer alır
    Set data                    =   db.Run(query)

    ' Kayıt Setinde gelen alanlar ( array )
    Set fields                  =   data.Fields

    ' Mayıt setinin uzunluğu
    fieldsCount                 =   fields.Count  
    
%>

<h1>Bağlantı Başlık Bilgileri * 1</h1>

<table class="table table-bordered">
    <tbody>
        <tr>
            <td>Parameter</td>
            <td><%=parameter %></td>
        </tr>
        <tr>
            <td>Value</td>
            <td><%=value %></td>
        </tr>
        <tr>
            <td>Query</td>
            <td><%=query %></td>
        </tr>
        <tr>
            <td>Run</td>
            <td>Fields : <%=fieldsCount%></td>
        </tr>
    </tbody>
</table>

<h1>Bağlantı İçeriği * 1</h1>

<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover table-condensed">
        <thead>
            <tr>
                <%For intLoop = 0 To (fields.Count - 1)  %>
                <th><%=fields.Item(intLoop).Name%></th>
                <%Next%>
            </tr>
        </thead>
        <tbody>
            <%
            ' Data Taramaya Başlıyor
            While Not data.EOF
            %>
            <tr>
                <%For intLoop = 0 To (fields.Count - 1)  %>
                <td><%=fields.Item(intLoop)%></td>
                <%Next%>
            </tr>
            <%
            ' Aramaya devam ediyot. ( Kursörü bir sonraki kayda konumlandır )
            data.MoveNext
            
            ' Index Arrtıtılıyor
            index   =   index   +   1
            %>
            <%
            ' Tüm kayıtlar tarandı.
            Wend
            %>
        </tbody>
    </table>
</div>

<hr />

<!-- ÖRNEK 2 -->

<%
    ' Yeni bir veritabanı nesnesi oluşturuluyor
    ' Veritabanına ve sağlayıcıyla nasıl ileteşim kurulacağını tanımlayan ana veri modeli.
    Set db                      =   New Database
    
    ' Konfigurasyon Tanımları
    ' Proje içerisinde tanımlanacak tüm değişkenlerx tek bir alan üzerinden yapılandırıyor
    parameter                   =   config.DataConnectionString

    ' Veritabanının bağlanacağı veri kataloğu gerekli parametreleri ile set ediliyor.
    ' /Core/config.asp icerisindeki parametre taşınıyor.
    db.ConnectionString         =   parameter

    ' Bağlantı güvenli bir şekilde açıldı.
    ' Bağlantı oturum süresince önbelleklenedek kullanılacak
    ' value değerinde sağlayıcı bilgileri geridönecektir.
    value                       =   db.Open()
%>
<%

    ' Veri kataloğu üzerinde bir tablo, görünüm yada fonksiyona erişilecek sorgu hazırlanıyor.
    query                       =   "SELECT * FROM Configurations"

    ' Transact-SQL (T-SQL) kullanılan, SQL sorgulama dilindeki komut dizisini çalıştırır.
    ' Geri dönüşte standart kayıt Seti Bilgileri Nesnesi yer alır
    Set data                    =   db.Run(query)

    ' Kayıt Setinde gelen alanlar ( array )
    Set fields                  =   data.Fields

    ' Mayıt setinin uzunluğu
    fieldsCount                 =   fields.Count  
    
%>

<h1>Bağlantı Başlık Bilgileri * 2</h1>

<table class="table table-bordered">
    <tbody>
        <tr>
            <td>Parameter</td>
            <td><%=parameter %></td>
        </tr>
        <tr>
            <td>Value</td>
            <td><%=value %></td>
        </tr>
        <tr>
            <td>Query</td>
            <td><%=query %></td>
        </tr>
        <tr>
            <td>Run</td>
            <td>Fields : <%=fieldsCount%></td>
        </tr>
    </tbody>
</table>

<h1>Bağlantı İçeriği * 2</h1>

<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover table-condensed">
        <thead>
            <tr>
                <%For intLoop = 0 To (fields.Count - 1)  %>
                <th><%=fields.Item(intLoop).Name%></th>
                <%Next%>
            </tr>
        </thead>
        <tbody>
            <%
            ' Data Taramaya Başlıyor
            While Not data.EOF
            %>
            <tr>
                <%For intLoop = 0 To (fields.Count - 1)  %>
                <td><%=fields.Item(intLoop)%></td>
                <%Next%>
            </tr>
            <%
            ' Aramaya devam ediyot. ( Kursörü bir sonraki kayda konumlandır )
            data.MoveNext
            
            ' Index Arrtıtılıyor
            index   =   index   +   1
            %>
            <%
            ' Tüm kayıtlar tarandı.
            Wend
            %>
        </tbody>
    </table>
</div>

<hr />