<%
    ' Version Control Test
    ' I Am Develop Branch
    ' Ok I Am Feature Branch
%>
<!--#include virtual                                        =   "Core/Init.asp"-->

<div class="panel panel-default">
    <div class="panel-heading">Html Yardımcı Testleri</div>
    <div class="panel-body">
        <form>

            <div class="form-group">
                <%=Html.Label("Metin Kutusu", "Text", "class=''") %>
                <%=Html.TextBox("Text", Text, "   class='form-control' placeholder='Text' title= 'Text'  required minlength='3' maxlength='50' size='50' ")%>
            </div>

            <div class="form-group">
                <%=Html.Label("Email Kutusu", "Email", "class=''") %>
                <%=Html.EmailBox("Email", "", "class='form-control'  placeholder='E-Posta Adresi'") %>
            </div>

            <div class="form-group">
                <%=Html.Label("Parola Kutusu", "Password", "class=''") %>
                <%=Html.PasswordBox("Password", "", "class='form-control' placeholder='Parola' required minlength='1' maxlength='8' size='8' ")%>
            </div>

            <div class="form-group">
                <%=Html.Label("Tarih Kutusu", "Date", "class=''") %>
                <%=Html.DateBox("Date", "", "class='form-control' placeholder='Tarih' required ")%>
            </div>

            <div class="checkbox">
                <label>
                    <%=Html.CheckBox( "isActive", true, "")%>
                    İşaretleme 
                </label>
            </div>

            <div class="form-group">
                <%=Html.Label("İkon Linki", "Aciklama", "class='form-control' ") %>
                <%=Html.IconLink("Yeni"        , "#" ,   "Ekle"           ,   ""  ,   "class='btn btn-primary btn-xs dropdown-toggle'", "glyphicon-file"       ) %>
            </div>

            <div class="form-group">
                <%=Html.Label("Açıklama Alanı", "Aciklama", "class='form-control' ") %>
                <%=Html.TextArea ("Aciklama", "", 80, 3, "") %>
            </div>

            <%=Html.Submit("submit", "Gönder"," class='btn btn-success' ") %>
        </form>
    </div>
</div>
