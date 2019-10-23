<%
    ' VBasic Operators
    ' Referans : https://docs.microsoft.com/en-us/dotnet/visual-basic/language-reference/operators/operator-precedence
    ' ================================================================================
    
    ' Hiçlik Kontrolü
    public function IsNothing(value)
    
        ' Bu bir obje mi
        if(IsObject(value)) then
            ' Hiçbirşey yok, yada deperi yok ise, yada tanımlanmamış ise
            IsNothing = (value is nothing) or IsEmpty(value) or IsNull(value)
        else
            'Diğer durumlarda bir tanım var.
            IsNothing = IsEmpty(value) or IsNull(value)
        end if
    
    end function
    
    ' Tick 01.01.2020 00:00:00
    function Tick()

        Dim dd, mm, yy, hh, nn, ss
        Dim datevalue, timevalue, dtsnow, dtsvalue

        dtsnow = Now()

        dd = Right("00" & Day(dtsnow), 2)
        mm = Right("00" & Month(dtsnow), 2)
        yy = Year(dtsnow)
        hh = Right("00" & Hour(dtsnow), 2)
        nn = Right("00" & Minute(dtsnow), 2)
        ss = Right("00" & Second(dtsnow), 2)

        datevalue = dd & "." & mm & "." & yy

        timevalue = hh & ":" & nn & ":" & ss

        dtsvalue = datevalue & "." & timevalue
        ' 
        tick    =   datevalue & " " & timevalue
    
    end function

    ' Today 01.01.2020
    function today()

        Dim dd, mm, yy, hh, nn, ss
        Dim datevalue, timevalue, dtsnow, dtsvalue

        dtsnow = Now()

        dd = Right("00" & Day(dtsnow), 2)
        mm = Right("00" & Month(dtsnow), 2)
        yy = Year(dtsnow)

        datevalue = dd & "." & mm & "." & yy
        
        ' 
        today    =   datevalue
    
    end function
  
%>