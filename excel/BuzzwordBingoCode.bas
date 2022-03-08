Attribute VB_Name = "BuzzwordBingoCode"
Function getTotalWords() As Integer
'
' count the number of word in the DataEntry sheet first column
'

Row = 2
TotalWords = 0
Do
    If Len(Trim(Sheets("DataEntry").Cells(Row, 1).Value)) > 0 Then
        TotalWords = TotalWords + 1
        Row = Row + 1
    Else
        Exit Do
    End If
Loop
getTotalWords = TotalWords

End Function

Sub BuildCardData()
'
' BuildCardData Macro
' Macro recorded 5/14/2000 by Douglas P Schveninger
'
Dim MaxValue As Integer
Dim Steps As Integer
Dim TotalWords As Integer
Dim RandomWord As Integer

' Count the number of Words
TotalWords = getTotalWords()
RandomWord = 0
MaxValue = 5000

' Build the CardData Worksheet with 24 rows
'    column 1 with random word from DataEntry
'    column 2 random number
For Steps = 1 To 24 Step 1
  Randomize RandomWord + Steps
  RandomWord = Int((TotalWords) * Rnd + 1)
  Sheets("CardData").Cells(Steps, 1).Value = _
          Sheets("DataEntry").Cells(RandomWord + 1, 1).Value
  Sheets("CardData").Cells(Steps, 2).Value = Int((MaxValue) * Rnd + 1)
Next Steps

' insert free spot with a random number at the end of the CardData
Sheets("CardData").Cells(Steps, 1).Value = "FREE SPOT"
Randomize
Sheets("CardData").Cells(25, 2).Value = Int((MaxValue) * Rnd + 1)

' sort the data according to the Random Value
Worksheets("CardData").Range("A1:B25").Sort _
    Key1:=Worksheets("CardData").Range("B1"), _
    Key2:=Worksheets("CardData").Range("A1")
End Sub

Sub AssignDataToCard()

Dim Rows As Integer
Dim Words As Integer
Dim Columns As Integer
Words = 1

For Rows = 3 To 8 Step 1
    For Columns = 2 To 6 Step 1
        Sheets("PlayingCard").Cells(Rows, Columns).Value = _
            Sheets("CardData").Cells(Words, 1).Value
        Words = Words + 1
    Next Columns
Next Rows

End Sub

Sub CreateCard()
Attribute CreateCard.VB_Description = "Macro recorded 5/14/2000 by Douglas P Schveninger"
Attribute CreateCard.VB_ProcData.VB_Invoke_Func = " \n14"

BuildCardData
AssignDataToCard

End Sub

Sub CreateAndPrintCard()

' PrintCard Macro
' Macro recorded 5/14/2000 by Douglas P Schveninger
CreateCard
Application.CutCopyMode = False
Sheets("PlayingCard").PrintOut Copies:=1, Collate:=True

End Sub

Sub SendCards()

Dim Row As Integer
Dim awb As Workbook
Dim sh As Worksheet
Dim address As String
Row = 2

' loop through DataEntry list of emails
Do
    If Sheets("Participants").Cells(Row, 1).Value Like "*@*" Then
        address = Sheets("Participants").Cells(Row, 1).Value
        CreateCard
        fileName = generateWorkbook
        ' todo method to email the PlayingCard only
        ' send filename to address

        Dim OutlookApp As Object
        Dim OutlookMail As Object
        Set OutlookApp = CreateObject("Outlook.Application")
        Set OutlookMail = OutlookApp.CreateItem(0)
        On Error Resume Next
        With OutlookMail
            .To = address
            .CC = ""
            .BCC = ""
            .Subject = "Buzzword Bingo Card"
            .Body = "Attached is your bingo card for the meeting."
            .Attachments.Add fileName
            '.Attachments.Add Application.ActiveWorkbook.FullName
            .Send
        End With
        Set OutlookMail = Nothing
        Set OutlookApp = Nothing
                
        ' delete filename
        Kill fileName
        Application.ScreenUpdating = True
        MsgBox "Email Sent to " + address + " using filename : " + fileName + "."
        Row = Row + 1
    Else
        Exit Do
    End If
Loop

End Sub

Function generateWorkbook()
    
    Dim fileName As String
    Dim sh_array() As String
    Dim wbTemp As Workbook
    Dim sh As Worksheet
    Dim i As Long
    
    On Error GoTo errorHandler
    
    'Turn off events
    Application.EnableEvents = False
    'Set calculation to manual
    Application.Calculation = xlCalculationManual
    'Turn off screen updating
    Application.ScreenUpdating = False
 
     'Define name to  the new the where the sheets will be copied, this will be the attachment name in the mail
     fileName = ThisWorkbook.Path & "\BingoCard - " & Format(Now(), "yyyymmdd - hhmmss") & ".xlsx"
 
     'Add a new workbook
     Set wbTemp = Workbooks.Add(1)
 
     'Turn off alerts
     Application.DisplayAlerts = False
 
     'Copy sheets given on Email Settings sheet (Attachment column)
     'NOTE: if the workbook is protected and/or sheet(s) is hidden handle that before copying
     ThisWorkbook.Sheets("PlayingCard").Copy after:=wbTemp.Sheets(1)

     'Delete first sheet
     wbTemp.Sheets(1).Delete
 
     'Save the new workbook
     wbTemp.SaveAs fileName
     wbTemp.Close

     'Function return value is the fileName
     generateWorkbook = fileName

exitSub:
    'Turn back on things
    Application.DisplayAlerts = True
    Application.EnableEvents = True
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic
    Exit Function

errorHandler:
    MsgBox Err.Number & vbCrLf & Err.Description & vbCrLf & "Something went wrong. Check Attachment Settings."
    'In case of an error function return "empty" string
    generateWorkbook = ""
    On Error GoTo 0
    Resume exitSub

End Function

