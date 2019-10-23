<%
    ' Colleksiyon
    Class Collection
    
        Private m_next
        Private m_len
        Private m_dic
    
        ' Kolleksiyona Ekle
        Public Sub Add(Item)
    
            m_dic.Add   "K" & m_next , Item
            m_next      =   m_next  +   1
            m_len       =   m_len   +   1

    	End Sub
    
        ' Kolleksiyonu Temizle
        Public Sub Clear
            m_dic.RemoveAll
        End Sub
    
        ' Kolleksiyon Uzunluğu
        Public Function Length
            Length  =   m_len
        End Function
    
        ' Kolleksiyon Ögesi
        Public Default Function Item(Index)
    
            Dim tempItem
            Dim i
    
            For Each tempItem In m_dic.Items
    
                If i=Index Then
    
                    Set Item=tempItem
                    Exit Function
                End If
    
                i   =   i   +   1
            Next
    
        End Function
    
        ' Kolleksiyondan Öge Çıkar
        Public Sub Remove(ByVal Index)
    
            Dim Item
            Dim i
    
            For Each Item In m_dic.Items
    
                If i    =   Index Then
                    m_dic.Remove(Item)
                    m_len   =   m_len   -   1
    
                    Exit Sub
                End If
    
                i   =   i   +   1
    
            Next
    
        End Sub
    
        ' Sınıf Yapılandırması
        Private Sub Class_Initialize
            
            m_len       =   0
    
            Set m_dic   =   Server.CreateObject("Scripting.Dictionary")
    
        End Sub
    
        ' Sınıf Sonlanıyor
        Private Sub Class_Terminate
    
            Set m_dic   =   Nothing

        End Sub

    End Class
    
    ' Öge Sınıfı
    Class Node
    
	    Public ID
	    Public ParentID
	    Public Text
	    Public Value
        Public ChildNodes
	
        ' Öge Ekle
        Public Sub Add(item)
    
            ChildNodes.Add(item)
    
        End Sub
	
        ' Sınıf Yapılandırması
	    Private Sub Class_Initialize
		    Set ChildNodes  =   New Collection
        End Sub
    
        ' Sınıf Sonlanıyor
        Private Sub Class_Terminate
		    Set ChildNodes  =   Nothing
        End Sub
    
    End Class
    
    ' Öz yineleme Sınıfı
    Class Recursive
    
        ' Veritabanı Sorgusu
        public Query

        ' Tüm Ögeler
        Public Nodes

        ' Bu yinelemenin ID si
        Public ID

        ' Koşul
        Public WHERE
    
        ' Sınıf Yapılandırılıyor
        Private Sub Class_Initialize
    
            Set Nodes = New Collection
    
        End Sub
    
        ' Sınıf Sonlandırılıyor
        Private Sub Class_Terminate
            Set Nodes   =   Nothing
        End Sub
    
        ' Veritabanı üzerinden öz yinelemeli kayıtları yapılandırır.
        '
        ' Örnekler Kullanım
    
        '   Islem Yinelemeli Listesi
        '   ================================================================================  
        '   Dim Yineleme
        '   Set Yineleme                    =   New Recursive
        '   connectionString                =   config.DataConnectionString
        '   tableName                       =   "MODUL"
        '   parentIDString                  =   "ParentID"
        '   parentID                        =   0
        '   idFieldString                   =   "ID"
        '   valueFieldString                =   "AD"
        '   textFieldString                 =   "BASLIK"
        '   Yineleme.HtmlElementName        =   "ClaimType"
        '   Yineleme.HtmlElementAttribute   =   "class='form-control' tabindex='2' "
        '   Yineleme.SelectedID             =   Model.ClaimType
        ' 
        ' Yineleme.FromDB(connectionString, tableName, parentIDString, parentID, idFieldString, valueFieldString, textFieldString)
        Public Sub FromDB(connectionString, tableName, parentIDString, parentID, idFieldString, valueFieldString, textFieldString)
    
            ' Bağlantı Tanımlanıyor.
            Set Connection              =   CreateObject("ADODB.Connection")
    
            ' Bağlantı Modu
            Connection.Mode             =   2       ' Sadece Okuma amaçlı
    
            ' Bağlantının, bağlantı terimi tanımlanıyor.
            Connection.ConnectionString =   connectionString
    
            ' Bağlantı açılıyor.
            Connection.Open

            Query   =   "SELECT * FROM " & tableName & " " & WHERE & " ORDER BY " & parentIDString 
    
            ' Çalıştır
            Dim data    :   Set data    =   Connection.Execute(query)        
    
            ' Çarılan Ögenin Üst Ögesi
            Dim parentNode

            ' Kayıt Sonu Kontrolü
            If Not data.EOF Then
    
                ' Tarama Başla
                Do While Not data.EOF
    
                    ' Node Hazırlanıyor
                    Dim child
                    Set child           =   new Node
            
	                child.ID            =   data(idFieldString)
	                child.ParentID      =   data(parentIDString)
	                child.Text          =   data(textFieldString)
	                child.Value         =   data(valueFieldString)
    
                    ' Bu öge , ana öge mi
                    If child.ParentID   =   parentID then

                        ' Evet Ana Ögeler Ekleniyor
					    Nodes.Add(child)
				    Else
    
                        ' Hayır, Alt ögeler yükleniyor
                        ' Tüm nodeyi aramaya gönder, bu parent Id ile
                        Set parentNode      =   FindNode(Nodes, child.ParentID)
    
                        ' Üst ögede veriler var ise
                        If Not (parentNode is Nothing) Then
                            ' Üst ögenin nodelerini ( alt nodelerini ) ekle
                            parentNode.Add(child)
                        End If
    
                ' Kayıt var ise yapılacaklar
                End If
            
            ' Aramaya devam et
            data.MoveNext
    
            Loop
    
            data.Close
    
        End If
		
        Set data        =    Nothing
    
        Connection.Close
    
        Set Connection  =   Nothing		

	End Sub

    ' Bir done ara
	Private Function FindNode (items,   ID)
		
        Dim i
        Dim tempNode		
		
        ' Ögeleri bir tarayalım
        For i   =   0 To items.Length-1
			
            Set tempNode        =   items(i)
			
            ' istenilen Öge Ana node içerisinde mi
            if tempNode.Id      =   ID then
            
                ' Öge Bulundu
                Set FindNode    =   tempNode
    
                ' Fonksitonu Terket
                Exit Function
    
            ' Alt nodelerinde olabilir.
            Else
    
                ' Alt Nodesi var mı ki?
                If tempNode.ChildNodes.length   >   0 Then
    
                    ' Varmış, o zaman arayalım.
                    Set tempNode    =   FindNode(tempNode.ChildNodes,   ID)
    
                    ' Bulundu mu
                    If Not (tempNode is Nothing) Then
    
                        ' Öge Bulundu
                        Set FindNode    =   tempNode
                
                        ' Fonksiyonu terket
                        Exit Function
                    End If
    
                end if
    
            End If
    
        Next
    
        ' Buraya erişildi ise, hiç bir şey olmamaıştır.
        Set FindNode = Nothing
    
    End Function

    ' Yineleme.DropDownList("test")
    public function DropDownList()

        HtmlString  =   "<option value='0'>-----</option>"

        ' HtmlList("islem", "select", "option")
        call HtmlList(HtmlElementName, HtmlElementAttribute, "select", "option")

        ' Optional Javascript Library Requared

        'HtmlResult = HtmlResult & "<script> $(document).ready(function() { $('#" & HtmlElementName & "').select2(); }); </script>"
    
        DropDownList        =   HtmlResult

    end function

    public HtmlResult
    public HtmlString
    public HtmlElement
    public HtmlElementName
    public HtmlElementAttribute
    public HtmlElementChild

    public SelectedID

    ' call Yineleme.HtmlList("islem", "select", "option")
    public function HtmlList(elementName, elementAttribute, element, elementChild)
    
        HtmlElementName         =   elementName
        HtmlElementAttribute    =   elementAttribute
        HtmlElement             =   element
        HtmlElementChild        =   elementChild
    
    
        Flags   =   Array("►","├","─"," ","╠","═")
        ' Flags
        ' Flags(0)          '   ►   16
        ' Flags(1)          '   ├   195
        ' Flags(2)          '   ─   196
        ' Flags(3)          '       197
        ' Flags(4)          '   ╠   204
        ' Flags(5)          '   ═   205 

        call HtmlList_Loop(Nodes,0)
    
        HtmlResult          =   "<" & HtmlElement & " id='" & HtmlElementName & "' name='" & HtmlElementName & "' " & HtmlElementAttribute & " '>" & HtmlString & "</select>"
    
        HtmlList            =   HtmlResult

    end function

    public Flags

    public Deep
    
    ' Html List Ozyinelemesi
    ' HtmlList_Loop(Nodes,    ParentID)
    private sub HtmlList_Loop(items,    parentId)

        ' Derine gidiliyor
        Deep    =   Deep    +   1
        
        ' Ana öge mi
        if parentId = 0 then
            ' Evet Bu bir Ana Öge

        else
            ' Hayır Alt Öge

        end if

        ' Alt ögesi var mı              :   Yok
        Dim hasChild    :   hasChild    =   false
        
        For i   =   0 To items.Length   -   1
            
            Set item    =   items(i)
    
            ' Alt Ögesi var mı?
            If (item.ChildNodes.Length  >   0) Then

                ' Evet
                hasChild    =   true

                ' Ana ögeyi yaz
                writeString(item)
                
                ' Öz Yineleme Yapılıyor...
                call HtmlList_Loop(item.ChildNodes,parentId)

            else
                ' Hayır
                hasChild    =   false
    
                ' Alt ögeyi yaz
                writeString(item)
    
            end if

        Next
    
        ' Yukarı çıkılıyor
        Deep    =   Deep    -   1

    end sub

    ' String olarak veriyi yazar
    private sub writeString(item)
    
        ' Flags
        ' Flags(0)          '   ►   16
        ' Flags(1)          '   ├   195
        ' Flags(2)          '   ─   196
        ' Flags(3)          '       197
        ' Flags(4)          '   ╠   204
        ' Flags(5)          '   ═   205
    
        ' Oge Derinligi İşaretleniyor
        deepString  =   String(1    ,   Flags(1)    ) & String(Deep ,   Flags(2)    ) & String( 1   ,   Flags(0)    )
    
        ' işaretlenmiş öge text halinde
        text        =   deepString & item.Text
    
        ' Seçili id işaretlenecekmi?
        if SelectedID   =   item.Value Then
        
            HtmlString  =   HtmlString + "<" & HtmlElementChild & " value='" & item.Value & "'" & " selected " & ">" & text & "</" & HtmlElementChild & ">"
        
        else
    
            HtmlString  =   HtmlString + "<" & HtmlElementChild & " value='" & item.Value & "'" & "          " & ">" & text & "</" & HtmlElementChild & ">"
        
        end if

    end sub

End Class
    
        ' Gün Sınıfı
        class DayObject
                    
            public Id                                               '   int         Gün Sırası
            
            public Index                                            '   int         Index Sırası

            public Date                                             '   Date        Gün Tarihi
                
            public Name                                             '   string      Gün Adı           

        
        end class
        
        ' Bu hafta
        ' Aktif hafta içerisindeki tarih bilgilerini hazırlar.
        '
        '   #	Index	Date	    Name
        '   1	2	    4.03.2018	Pazartesi
        '   2	3	    5.03.2018	Salı
        '   3	4	    6.03.2018	Çarşamba
        '   4	5	    7.03.2018	Perşembe
        '   5	6	    8.03.2018	Cuma
        function ThisWeek
            
            ' Geri Dönüş bilgileri Hazırlanıyor.
            Dim results,today
            Set results             =   Server.CreateObject("Scripting.Dictionary")
        
        
            ' Günler Yeniden Hespalanıyor...
            
            for id                  =   1   to  5                   '   Örnek                    2018.3.4
                                                                        
                today               =   Date()                      '   Bugün                           4   5   6   7   8   9   10   11

                daysOfTheWeek       =   Weekday(today)              '   Haftanın Kaçını Günü            1   2   3   4   5   6   7   1

                daysStartTheWeek    =   today - daysOfTheWeek + 1   '   Haftanın Başlangıç Tarihi       3+1 3+1 3+1 3+1 3+1 3+1 3+1 10+1

                dayName             =   WeekdayName(daysOfTheWeek)  '   Bugünün ismi                    Pazar                

                Dim item
                Set item            =   new DayObject
                item.Id             =   id
                item.Date           =   (today - daysOfTheWeek + 1) +   id
                item.Index          =   Weekday(item.Date)              
                item.Name           =   WeekdayName(item.Index)           
                results.Add             item.Id,  item
            next

            ' Geri Dönüş bilgileri
            Set ThisWeek        =   results
        
        end function

%>