<%
    ' Sql Helper Sınıfı
    ' Sql işlemleri.
    class SqlHelper
    
        ' Sql Operant
        ' ================================================================================

        ' Select Table
	    public function SelectTable(value)

            ' Bir tablo seç
		    SelectTable = Strings.Format("SELECT * FROM {0} ", Array(value) )

	    end function

	    ' Delete Table
	    public function DeleteTable(value)

            ' Bir tablo sil Değer ile
		    DeleteTable = Strings.Format("DELETE FROM {0} ", Array(value) )

	    end function

	    ' Update Table
	    public function UpdateTable(value)

            ' Tablo üzerinde bir alan güncelle
		    UpdateTable = Strings.Format("UPDATE {0} ", Array(value) )

	    end function

	    ' Insert Table
	    public function InsertTable(value)

            ' Tabloya yeni kayıt ekle
		    InsertTable = Strings.Format("INSERT INTO {0} ", Array(value) )

	    end function
    
        ' Insert Table Params
        ' Model Parametrelerini hazırlar.
	    public function InsertTableParams(value, fields)

            ' Komut metni başlangıcı
            results     =   Strings.Format("INSERT INTO {0} ", Array(value) )

            results     =   results &   " ( "

            count       =   UBound(fields)
            index       =   -1
            line        =   ","

            ' Veri Alanları
            For Each name in fields
                            index   =   index   +   1
                            if  index   =   count   then
                                line    =   ""   
                            end if
                results =   results & Strings.Format("  [{0}]   {1} ", Array(name,  line))   
            Next

            results     =   results &   " ) "
            results     =   results &   " VALUES "
            results     =   results &   " ( "
    
            index       =   -1
            line        =   ","

            ' Veri Değerleri
            For Each item in fields
                            index   =   index   +   1
                            if  index   =   count   then
                                line    =   ""   
                            end if
                ' Sql sağlayıcı named parametre desteklemiyo
                'results =   results & Strings.Format("  @{0}   {1} ", Array(item,  line))
                results =   results & Strings.Format("  ?   {1} ", Array(item,  line)) 
            Next
    
            results     =   results &   " ) "

            ' Fonksiyon Dönüş Kodu
            InsertTableParams   =   results

	    end function

        ' Uodate Table Params
        ' Model Parametrelerini hazırlar.
	    public function UpdateTableParams(value, fields, where)

            ' Komut metni başlangıcı
            results     =   Strings.Format("UPDATE {0} ", Array(value) )

            results     =   results &   " SET "

            count       =   UBound(fields)
            index       =   -1
            line        =   ","

            ' Veri Alanları
            For Each name in fields
                            index   =   index   +   1
                            if  index   =   count   then
                                line    =   ""   
                            end if
                            ' Sql sağlayıcı named parametre desteklemiyo
                            'results =   results & Strings.Format("  [{0}]   =   @{0}    {1} ", Array(name,  line))   
                            results =   results & Strings.Format("  [{0}]   =   ?    {1} ", Array(name,  line))   
            Next

            results     =   results &   " WHERE  "
            'results     =   results &  where
            
            ' Named Parametre dönüştür
            paramPosition                           =   InStr(1,where,"@")
            where                                   =   Left(where,paramPosition-1)
            results     =   results &  where & "?"

            ' Fonksiyon Dönüş Kodu
            UpdateTableParams   =   results

	    end function

        ' Delete Table Params
        ' Model Parametrelerini hazırlar.
	    public function DeleteTableParams(value, fields, where)

            ' Komut metni başlangıcı
            results     =   Strings.Format("DELETE FROM {0} ", Array(value) )

            results     =   results &   " WHERE  "
            results     =   results &  where           

            ' Fonksiyon Dönüş Kodu
            DeleteTableParams   =   results

	    end function

        ' Sql Parametresi tiplerine güncellemeyi hazırlar.
        public function UpdateParameter(name, value)

            ' Bir hata olur ise devam et.
            On Error Resume Next

            ' Değer yok yada boş mu
            If IsNothing(value) or (value = "")  Then
                ' Sql parametre yok
                UpdateParameter = NULL
            else
                ' Parametre tiplerine göre seçim
                typeNameString  =   TypeName(value)

                'Tip e Göre seçim
                select case typeNameString

                    ' Sql Parametesini Sayısal Değer olarak iletir.
                    case "Integer"                          :   UpdateParameter    =   value

                    ' Sql Parametresini String Değer olarak iletir.
                    case "String"                           :   UpdateParameter    =   CStr(value)

                    ' Sql Parametresini Boolean Değer olarak iletir.
                    case "Boolean"                          :   UpdateParameter    =   CBool(value)

                    ' Sql Parametresini Tarih Değer olarak iletir.
                    case "Date"                             :   UpdateParameter    =   CDate(value)

                    ' Sql Parametresini Uzun Sayı Değer olarak iletir.
                    case "Long"                             :   UpdateParameter    =   value

                    ' Sql Parametresini Para Birimi Değer olarak iletir.
                    case "Currency"                         :   UpdateParameter    =   value

                    ' Sql Parametresini Double Değer olarak iletir.
                    case "Double"                           :   UpdateParameter    =   value
        
                    ' Sql Parametresinde bir hata meydaba gelir.
                    ' Daha önceden tanımlanmamış bir veri tipi.
                    case else:
                        
                        Exception.File          =   "SQL"
                        Exception.Line          =   "78"
                        Exception.Number        =   1
                        Exception.Description   =   Strings.Format("Geçersiz veri tipi. Parametre Ad: {0} Tip: {1} Değer: {2}", Array(name, typeNameString, value))
                        Exception.Category      =   "UpdateParameter"
                        Exception.State         =   "info"
                        Exception.Throw()

                    end select

            end if

            ' Bir hata oluştur
            If Err.Number <> 0 Then

                ' Bir hata başlat
                Exception.File          =   "SQL"
                Exception.Line          =   "91"
                Exception.Number        =   2
                Exception.Description   =   Strings.Format("Parametre veya parametreler geçersiz. {1} {2}",    Array(Err.number,   Err.Description))
                Exception.Category      =   "UpdateParameter"
                Exception.State         =   "info"
                Exception.Throw()

            End If

        end function

        ' Sql Parametresini tipleri ile hazırlar.
        public function SetParameter(param, value)

            ' Türü bir sql parametresi değil mi?
            if  not TypeName(param) = "Parameter" Then
                ' Fonksiyonu terket
                Exit Function
            End If

            ' Bir hata olur ise devam et.
            On Error Resume Next

            ' Değer yok yada boş mu
            If IsNothing(value) or (value = "")  Then
                ' Sql parametre yok
                SetParameter = null
            else
                ' Parametre tiplerine göre seçim
                ' Veri Türleri
                select case param.Type

                ' Parametre bilgileri
                ' Referans : https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/datatypeenum

                '   Sabit               Değer   Açıklama
                '   --------------------------------------------------------------------------------
                '   adEmpty	            0	    Hiçbir değer belirtir (DBTYPE_EMPTY).
                '   adSmallInt	        2	    İki baytlık işaretli tamsayıyı (DBTYPE_I2) gösterir.
                '   adInteger	        3	    Dört baytlık işaretli tamsayıyı (DBTYPE_I4) gösterir.
                '   adSingle	        4	    Tek duyarlıklu kayan nokta değerini (DBTYPE_R4) gösterir.
                '   adDouble	        5	    Çift duyarlık kayan nokta değerini (DBTYPE_R8) gösterir.
                '   adCurrency	        6	    Bir para birimi değerini (DBTYPE_CY) gösterir. Para birimi, ondalık noktanın sağında dört basamaklı bir sabit sayıdır. 10.000 ile ölçeklendirilmiş sekiz baytlı bir tamsayıda saklanır.
                '   adDate	            7	    Bir tarih değerini (DBTYPE_DATE) gösterir. Bir tarih çift olarak saklanır ve bunların tümü 30 Aralık 1899'dan bu yana geçen gün sayısını ve kesirli kısmı bir günde kesir.
                '   adBSTR	            8	    Neseli sonlandırılmış bir karakter dizesini (Unicode) (DBTYPE_BSTR) gösterir.
                '   adIDispatch	        9	    Bir COM nesnesinde (DBTYPE_IDISPATCH) bir IDispatch arabirimine işaretçi belirtir .
                '                               -Not Bu veri türü şu anda ADO tarafından desteklenmiyor. Kullanım, öngörülemeyen sonuçlara neden olabilir.
                '   adError	            10	    32 bit hata kodunu (DBTYPE_ERROR) gösterir.
                '   adBoolean	        11	    Bir Boolean değeri (DBTYPE_BOOL) gösterir.
                '   adVariant	        12	    Bir Otomasyon Değişkeni (DBTYPE_VARIANT) gösterir.             '
                '                               -Not Bu veri türü şu anda ADO tarafından desteklenmiyor. Kullanım, öngörülemeyen sonuçlara neden olabilir.
                '   adIUnknown	        13	    Bir COM nesnesinde (DBTYPE_IUNKNOWN) bir IUnknown arabirimine işaret eden gösterir .             '
                '                               -Not Bu veri türü şu anda ADO tarafından desteklenmiyor. Kullanım, öngörülemeyen sonuçlara neden olabilir.
                '   adDecimal	        14	    Sabit bir duyarlık ve ölçeğe sahip kesin bir sayısal değeri (DBTYPE_DECIMAL) gösterir.
                '   adTinyInt	        16	    Bir baytlık işaretli tamsayıyı (DBTYPE_I1) gösterir.
                '   adUnsignedTinyInt	17	    Bir baytlık işaretsiz tam sayı (DBTYPE_UI1) gösterir.
                '   adUnsignedSmallInt	18	    İki baytlık işaretsiz tam sayı (DBTYPE_UI2) gösterir.
                '   adUnsignedInt	    19	    Dört baytlık işaretsiz bir tam sayı (DBTYPE_UI4) gösterir.
                '   adBigInt            20	    Sekiz baytlık işaretli tamsayıyı (DBTYPE_I8) gösterir.
                '   adUnsignedBigInt	21	    Sekiz baytlık işaretsiz bir tam sayı (DBTYPE_UI8) gösterir.
                '   adFileTime	        64	    1 Ocak 1601'den (DBTYPE_FILETIME) bu yana 100 nanosaniye aralığı sayısını temsil eden 64 bitlik bir değeri gösterir.
                '   adGUID	            72	    Küresel olarak benzersiz bir tanımlayıcı (GUID) (DBTYPE_GUID) belirtir.
                '   adBinary	        128 	İkili bir değeri (DBTYPE_BYTES) gösterir.
                '   adChar	            129 	Bir dize değeri (DBTYPE_STR) gösterir.
                '   adWChar	            130 	Null sonlandırılmış bir Unicode karakter dizesini (DBTYPE_WSTR) gösterir.
                '   adNumeric	        131 	Sabit bir hassas ve ölçekli (DBTYPE_NUMERIC) kesin bir sayısal değeri gösterir.
                '   adUserDefined	    132 	Kullanıcı tanımlı bir değişkeni gösterir (DBTYPE_UDT).
                '   adDBDate	        133 	Bir tarih değeri (yyyymmdd) (DBTYPE_DBDATE) gösterir.
                '   adDBTime	        134 	Bir zaman değerini (hhmmss) (DBTYPE_DBTIME) gösterir.
                '   adDBTimeStamp	    135 	Bir tarih / zaman damgasını (yyyymmddhhmmss artı milyardırdaki bir kesir) (DBTYPE_DBTIMESTAMP) gösterir.
                '   adChapter	        136 	Bir alt satır kümesindeki satırları tanımlayan dört baytlık bir bölüm değeri belirtir (DBTYPE_HCHAPTER).
                '   adPropVariant	    138 	Bir Otomasyon PROPVARIANT (DBTYPE_PROP_VARIANT) gösterir.
                '   adVarNumeric	    139 	Sayısal bir değeri belirtir.
                '   adVarChar	        200 	Bir dize değeri belirtir.
                '   adLongVarChar	    201 	Uzun bir dize değeri belirtir.
                '   adVarWChar	        202 	Null sonlandırılmış bir Unicode karakter dizesini belirtir.
                '   adLongVarWChar	    203 	Null sonlandırılmış uzun bir Unicode dize değeri belirtir.
                '   adVarBinary	        204 	İkili bir değeri belirtir.
                '   adLongVarBinary	    205 	Uzun bir ikili değeri belirtir.
                '   AdArray             0x2000	Her zaman başka bir veri türü sabitiyle birleştirilen, diğer veri türündeki bir diziyi belirten bayrak değeri. ADOX için geçerli değildir.
                '   --------------------------------------------------------------------------------


                '   adSingle	        4	    Tek duyarlıklu kayan nokta değerini (DBTYPE_R4) gösterir.
                '   adDouble	        5	    Çift duyarlık kayan nokta değerini (DBTYPE_R8) gösterir.
                '   adCurrency	        6	    Bir para birimi değerini (DBTYPE_CY) gösterir. Para birimi, ondalık noktanın sağında dört basamaklı bir sabit sayıdır. 10.000 ile ölçeklendirilmiş sekiz baytlı bir tamsayıda saklanır.
                '   adDecimal	        14	    Sabit bir duyarlık ve ölçeğe sahip kesin bir sayısal değeri (DBTYPE_DECIMAL) gösterir.
                case    4,  5,  6,  14          :   SetParameter    =   CDbl(value)

                '   adBoolean	        11	    Bir Boolean değeri (DBTYPE_BOOL) gösterir.
                case    11                      :   SetParameter    =   CBool(value)

                '   adDate	            7	    Bir tarih değerini (DBTYPE_DATE) gösterir. Bir tarih çift olarak saklanır ve bunların tümü 30 Aralık 1899'dan bu yana geçen gün sayısını ve kesirli kısmı bir günde kesir.
                '   adDBTimeStamp	    135 	Bir tarih / zaman damgasını (yyyymmddhhmmss artı milyardırdaki bir kesir) (DBTYPE_DBTIMESTAMP) gösterir.
                case    7,  135                 :   SetParameter    =   CDate(value)

                '   adSmallInt	        2	    İki baytlık işaretli tamsayıyı (DBTYPE_I2) gösterir.
                '   adInteger	        3	    Dört baytlık işaretli tamsayıyı (DBTYPE_I4) gösterir.
                '   adUnsignedTinyInt	17	    Bir baytlık işaretsiz tam sayı (DBTYPE_UI1) gösterir.
                '   adBigInt            20	    Sekiz baytlık işaretli tamsayıyı (DBTYPE_I8) gösterir.
                '   adNumeric	        131 	Sabit bir hassas ve ölçekli (DBTYPE_NUMERIC) kesin bir sayısal değeri gösterir.
                case    2,  3,  17, 20, 131     :   SetParameter    =   CLng(value)

                '   adGUID	            72	    Küresel olarak benzersiz bir tanımlayıcı (GUID) (DBTYPE_GUID) belirtir.
                case    72                      :   SetParameter    =   CStr(value)

                '   adChar	            129 	Bir dize değeri (DBTYPE_STR) gösterir.
                '   adWChar	            130 	Null sonlandırılmış bir Unicode karakter dizesini (DBTYPE_WSTR) gösterir.
                '   adVarChar	        200 	Bir dize değeri belirtir.
                '   adLongVarChar	    201 	Uzun bir dize değeri belirtir.
                '   adVarWChar	        202 	Null sonlandırılmış bir Unicode karakter dizesini belirtir.
                '   adLongVarWChar	    203 	Null sonlandırılmış uzun bir Unicode dize değeri belirtir.
                case 129,   130,    200,    201,    202,    203:

                    ' Parametre büyüklüğü > hedef parametreden büyük mü?
                    if (param.Size <> -1) and (Len(CStr(value)) > param.Size) Then

                        ' Bir hata başlat
                        Exception.File          =   "SQL"
                        Exception.Line          =   "208"
                        Exception.Number        =   1
                        Exception.Description   =   Strings.Format("String çok uzun. Tip: {0} Değer: {1}", Array(param.Type, value)  )
                        Exception.Category      =   "SetParameter"
                        Exception.State         =   "info"
                        Exception.Throw()
                    
                    End If

                    ' Varsayılan String
                    SetParameter    =   CStr(value)

                case else:
                
                    ' Bir hata başlat
                    Exception.File          =   "SQL"
                    Exception.Line          =   "222"
                    Exception.Number        =   2
                    Exception.Description   =   Strings.Format("Geçersiz veri tipi. Tip: {0} Değer: {1}", Array(param.Type, value)  )
                    Exception.State         =   "info"
                    Exception.Throw()
                
                End select

            End If

            ' Bir hata oluştur
            If Err.Number <> 0 Then

                ' Bir hata başlat
                Exception.File          =   "SQL"
                Exception.Line          =   "236"
                Exception.Number        =   3
                Exception.Description   =   Strings.Format("{0} {1} {2}", Array("Parametre veya parametreler geçersiz.",    Err.number,   Err.Description)   )
                Exception.Category      =   "SetParameter"
                Exception.State         =   "info"
                Exception.Throw()

            End If

        End Function

        ' Sql Parametresi Sql Tipi Çevriliyor.
        public function ConvertParameter(name, value)
            
            ConvertParameter                =   value
            name                            =   name

            If IsNothing(value) or (value = "")  Then
                
                ConvertParameter             =   null
                exit function
            end if
    
            if value = True Then
                ConvertParameter             =   1
            end if
        
            if value = False Then
                ConvertParameter             =   0
            end if

        end function
    
    end class

    Dim Sql :   Set Sql =   new SqlHelper
%>