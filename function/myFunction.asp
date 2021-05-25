<%
function firstUpper(str)
k = mid(str,1,1)
kUp = Ucase(k)
firstUpper = replace(str,k,kUp,1,1)
end function

function allFirstUpper(str)
words = Split(str," ")
for Each w in words 
    temp = temp & " " & firstUpper(w)
next
allFirstUpper = trim(temp)
end function

Function IsValidName(str)
    IsValidName = true
    char = array("!", "'", "^", "+", "%", "&", "/", "(", ")", "=", "*", "-", "_", "?", "}", "]", "[", "{", "$", "#", "£", ">", "<",",", ".", "@")
    for Each c in char
        if InStr(1,str,c) > 0 Then
            IsValidName = false
            exit function
        end if
    next
    for i=1 to len(str)
        k = mid(str,i,1)
        if IsNumeric(k) Then
            IsValidName = false
            exit function
        end if
    next
End Function
Function IsValidMail(str)
    IsValidMail = false
    char = array("!", "'", "^", "+", "%", "&", "/", "(", ")", "=", "*", "-", "_", "?", "}", "]", "[", "{", "$", "#", "£", ">", "<",","," ")
    for Each c in char
        if InStr(1,str,c) > 0 Then
            exit function
        end if
    next
    sp = split(str,"@",2)
    str = sp(1)
    dot = 0
    at = 0
    for i = 1 to len(str)
        k = mid(str,i,1)
        if k = "." Then
            dot = dot + 1
        end if
        if k = "@" then
            at = at + 1
        end if
    next
    if dot = 1 and at = 0 then
        IsValidMail = true
    end if
End Function
Function IsValidPass(str)
    IsValidPass = true
    char = array("!", "'", "^", "+", "%", "&", "/", "(", ")", "=", "*", "-", "_", "?", "}", "]", "[", "{", "$", "#", "£", ">", "<"," ")
    for Each c in char
        if InStr(1,str,c) > 0 Then
            IsValidPass = false
            exit function
        end if
    next
End Function
Function RandomNumber(LowNumber, HighNumber)
    RANDOMIZE
    RandomNumber = Round((HighNumber - LowNumber ) * Rnd + LowNumber)
End Function
Function RandomName(letterSize)
    dim temp
    for i=1 to letterSize
        temp = temp & CHR(RandomNumber(97,122))
        temp = temp & (RandomNumber(0,9))
    next
    RandomName = temp
End Function
Function IsCollection(param)
    On Error Resume Next
    For Each p In param
        Exit For
    Next
    If Err Then
        If Err.Number = 451 Then
            IsCollection = False
        Else
            WScript.Echo "Unexpected error (0x" & Hex(Err.Number) & "): " & _
                Err.Description
            WScript.Quit 1
        End If
    Else
        IsCollection = True
    End If
End Function
%>
