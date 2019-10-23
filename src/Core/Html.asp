<%
    ' Html Yardımcısı
    ' Bir görünümde HTML denetimlerinin oluşturulmasını yardımcı olur.
    ' Referansta belirtilen yapı örneklenmeye çalışılmıştır.
    ' Refarans  : https://msdn.microsoft.com/en-us/library/system.web.mvc.htmlhelper(v=vs.118).aspx
    class HTMLHelper
    
        ' Kodlama
        public Function Encode (elementValue)
            
            if Not IsNothing(elementValue) Then
                Encode = Server.HTMLEncode(elementValue)
                'Encode = elementValue
            End If

        end function
    
        ' Etiket
        public Function Label (elementValue, objfor, attribs)
            
            Label = "<label for='" + objfor + "'" + " " & attribs + " >" + Encode(elementValue) + "</label>"
    
        end function
    
        ' Gizli input
        public Function Hidden ( elementID, elementValue, attribs)
            elementID   =   Trim(elementID)
            Hidden =  "<input id='" + elementID + "' name='" + elementID + "' type='hidden' value='" + Encode(elementValue) + "' " + attribs + " />"
	
        end function
    
        ' Textbox
        public Function TextBox (elementId, elementValue, attribs)
		    
            TextBox = "<input id='" + elementID + "' name='" + elementID + "' type='text' value='" + Encode(elementValue) + "' " + attribs + " />"
	
        end function

        ' Number Box
        public Function NumberBox (elementId, elementValue, min, max, attribs)
		
            NumberBox   =   "<input id='" + elementID + "' name='" + elementID + "' type='number' min='" & min & "' max='" & max & "' value='" + Encode(elementValue) + "' "  & attribs & " />"
  
	    end function

        ' Decimal Box
        public Function DecimalBox (elementId, elementValue, min, max, precision, attribs)
            
            DecimalBox   =   "<input id='" + elementID + "' name='" + elementID + "' type='number' step='0."+precision+"' min='" & min & "' max='" & max & "' value='" + elementValue + "' "  & attribs & " />"
  
	    end function

        ' DateBox
        public Function DateBox (elementId, elementValue, attribs)
		    
            'DateBox = "<input id='" + elementID + "' name='" + elementID + "' type='text' value='" + Encode(elementValue) + "' " + attribs + " />"

            DateBox =   "<div class='input-group date' data-provide='datepicker'><input id='" + elementID + "' name='" + elementID + "'  value='" + Encode(elementValue) + "' " + attribs + " type='text' ><div class='input-group-addon'><span class='glyphicon glyphicon-th'></span></div></div>"

            DateBox = DateBox & " <script>  $( document ).ready(function() { $('.date').datepicker({language: 'tr'}); }); </script>"

   
        end function

        ' Password Box
        public Function PasswordBox (elementId, elementValue, attribs)
		    
            PasswordBox = "<input id='" + elementID + "' name='" + elementID + "' type='password' value='" + Encode(elementValue) + "' " + attribs + " />"
	
        end function

        ' Email Box
        public Function EmailBox (elementId, elementValue, attribs)
		    
            EmailBox = "<input id='" + elementID + "' name='" + elementID + "' type='email' value='" + Encode(elementValue) + "' " + attribs + " />"
	
        end function
    
        ' Text Area
        public Function TextArea (elementId, elementValue, cols, rows, attribs)
		
            TextArea = "<textarea id='" + elementID + "' name='" + elementID + "' cols='" + Encode(cols) + "' rows='" + Encode(rows) + "' " + attribs + " >" & _
		 
            Encode(elementValue) & "</textarea>"

	    end function

        ' Check Box
	    public Function CheckBox( elementId, elementValue, attribs )
	    
            Dim checked 
	    
            if (elementValue = 1) or (elementValue = true) or (LCase(elementValue) = "true") Then
			    checked = "CHECKED"
		    else
			    checked = ""
		    end If
		
            CheckBox = "<input type='checkbox' id='" + elementID + "' name='" + elementID + "' " + checked + " " + attribs + " />" 
		
            Encode(elementValue)
    
	    end function

        ' Radio Box
	    public Function RadioBox( elementId, elementValue, checkedText, uncheckedText, attribs )

            RadioBox = RadioBox & "<label class='radio-inline'>"

                if (elementValue = 1) or (elementValue = true) or (LCase(elementValue) = "true") Then
			        RadioBox = RadioBox & "<input type='radio' name='" & elementId & "' value='" & elementValue & "' " & " CHECKED " & " " & attribs & " >"
                else
                    RadioBox = RadioBox & "<input type='radio' name='" & elementId & "' value='" & elementValue & "' " & "         " & " " & attribs & " >"
		        end If
                
                RadioBox = RadioBox & "<span>" & checkedText & "</span>"
            RadioBox = RadioBox & "</label>"

            RadioBox = RadioBox & "<label class='radio-inline'>"
    
                if (elementValue = 1) or (elementValue = true) or (LCase(elementValue) = "true") Then
	                RadioBox = RadioBox & "<input type='radio' name='" & elementId & "' value='" & elementValue & "' " & "         " & " " & attribs & " >"		           
                else
                   RadioBox = RadioBox & "<input type='radio' name='" & elementId & "' value='" & elementValue & "' " & " CHECKED " & " " & attribs & " >"
		        end If

            RadioBox = RadioBox & "<span>" & uncheckedText & "</span>"
            RadioBox = RadioBox & "</label>"
    
	    end function
    
        ' Dropdown List
        public Function DropDownList (elementId, elementValue, list , idName, valueName, attribs)
		
            Dim result, lisItem
    
            result= "<select id='" + elementID + "' name='" + elementID + "'" + attribs + ">"
    
            result = result + "<option value='0'>-----</option>"
        
            optText = ""
        
            For Each listItem in List                
                Dim optValue, optText
                optValue = Eval("listItem." + idName)
    
                ' Multi Value
                'isMulti = split(valueName,",")
                'for each item in isMulti
                '    optText = optText & " " & Eval("listItem." + item)
                'next

                optText  = Eval("listItem." + valueName)

                if elementValue = optValue Then                            
                    result = result + "<option selected='selected' value='" + Encode(optValue) + "'" + attribs + "'>" + Encode(optText) + "</option>"
			    else    
                    result = result + "<option value='" + Encode(optValue) + "'>" + Encode(optText) + "</option>"
			     End If    
            Next
    
            result = result & "</select>"

            'result = result & "<script>$(document).ready(function() {$('#" & elementID & "').select2();});</script>"

            result = result & scriptString
    
            DropDownList = result
    
        end function

        ' Data List
        public Function DataList (elementId, elementValue, list , idName, valueName, attribs)
		
            Dim result, lisItem

            result = "<input  list='" & elementID & "' " & attribs & " >"

            result = result + "<datalist id='" + elementID + "' name='" + elementID + ">"
    
            result = result + "<option value='0'>-----</option>"

            For Each listItem in List                
                Dim optValue, optText
                optValue = Eval("listItem." + idName)
                optText  = Eval("listItem." + valueName)
    
                if elementValue = optValue Then                            
                    result = result + "<option selected='selected' value='" + Encode(optValue) + "'" + attribs + "'>" + Encode(optText) + "</option>"
			    else    
                    result = result + "<option value='" + Encode(optValue) + "'>" + Encode(optText) + "</option>"
			     End If    
            Next
    
            result = result & "</datalist>"
    
            DropDownList = result
    
        end function
    
        ' Link / Yönlendirme Linki
        public Function ActionLink(linkText, linkController, linkAction , linkVars, attribs)	
    
            results =   Cstr(linkVars)
            if results<>"" then
                results = "-" & results
            end if

            ActionLink  = "<a href='" & Encode(linkController) + "-" + Encode(linkAction) +   Encode(results) + "' " + attribs + ">" + linkText + "</a>"

        end function

    
        ' Link / Yönlendirme Linki Icon
        public Function IconLink(linkText, linkController, linkAction , linkVars, attribs, iconClass ) 
		
            results =   Cstr(linkVars)
            if results<>"" then
                results = "-" & results
            end if
    
            IconLink  = "<a title='"& linkText &"' href='" & Encode(linkController) + "-" + Encode(linkAction) +   Encode(results) + "' " + attribs + ">" &_
            "<span class='glyphicon "& iconClass     &"' aria-hidden='true'></span>" &_
            "</a>"

        end function

        ' Url / Linki
        public Function Url(linkController, linkAction) 
		
            Url = Encode(linkController) + "-" + Encode(linkAction)
	
        end function

        ' Uyarı
        public Function Alert(elementValue, state)
		
            if state = false then
                Alert = "<div class='alert' role='alert'>" & Encode(elementValue) &"</div>"
	        end if

        end function

    
        ' Modal
        public Function Modal(title, body)
                Modal = "<div class=""modal"" role=""dialog"" tabindex=""-1""> <div class=""modal-dialog"" role=""document""> <div class=""modal-content""> <div class=""modal-header""> <button type=""button"" class=""close"" data-dismiss=""modal"" aria-label=""Close""><span aria-hidden=""true"">×</span></button> <h4 class=""modal-title"">" & title & "</h4> </div> <div class=""modal-body""> <p>" & body & "</p> </div> <div class=""modal-footer""> <button type=""button"" class=""btn btn-default"" data-dismiss=""modal"">Tamam</button>  </div> </div> </div> </div>"
                Modal = Modal & "<script>$('.modal').modal('show');</script>"
        end function

        ' Modal
        public Function ModalValidation(body,state)

            value = ""
        
            if state = false then
                 value = Modal("Hata",body)
            end if

            ModalValidation = value
        
        end function
    
        ' Submit
        public Function Submit(elementId, elementValue, attribs)
		    
            Submit = "<input id='" + elementID + "' name='" + elementID + "' type='submit' value='" + Encode(elementValue) + "' " + attribs + " />"
	
        end function

        ' Button
        public Function Button(elementId, elementValue, attribs)
		    
            Button = "<button id='" + elementID + "' name='" + elementID + "' type='button' "  + attribs + " >" & elementValue & "<button>"
	
        end function
    
    end class
    
    ' HtmlHelper Class
    public Html : Set Html = new HTMLHelper
%>