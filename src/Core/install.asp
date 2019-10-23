<%
    dim fs
    set fs  =   Server.CreateObject("Scripting.FileSystemObject")

    ' Uygulama data klasörü bulunmuyor ise.
    if fs.FolderExists(Server.MapPath("/App_Data")) = false then fs.CreateFolder(Server.MapPath("/App_Data"))    
    ' Uygulama çalışma alanı klasörünü oluştur.
    if fs.FolderExists(Server.MapPath("/App_Data/app")) = false then fs.CreateFolder(Server.MapPath("/App_Data/app"))
    if fs.FolderExists(Server.MapPath("/App_Data/test")) = false then fs.CreateFolder(Server.MapPath("/App_Data/test"))
    ' Uygulama log klasörünü oluştur.
    if fs.FolderExists(Server.MapPath("/App_Data/app/log")) = false then fs.CreateFolder(Server.MapPath("/App_Data/app/log"))
    if fs.FolderExists(Server.MapPath("/App_Data/test/log")) = false then fs.CreateFolder(Server.MapPath("/App_Data/test/log"))

    ' Configurasyon dosyası bulunmuyor ise.
    if fs.FileExists(Server.MapPath("/App_Data/config.inc")) = false then
        ' Konfigurasyon dosyası örneğini kopyala.
        fs.CopyFile Server.MapPath("/Core/config.inc"), Server.MapPath("/App_Data/config.inc")
    end if

    ' Uygulama file klasörü bulunmuyor ise.
    if fs.FolderExists(Server.MapPath("/Files")) = false then fs.CreateFolder(Server.MapPath("/Files")) 
    
    set fs  =   nothing
%>