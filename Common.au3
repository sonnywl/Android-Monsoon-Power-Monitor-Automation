Local Const $OUTPUT_FILE = "values.txt"
Local Const $INPUT_FILE = "tests.txt"
Local Const $TEST_NAME = 0; Test Name
Local Const $TEST_TIME = 1; Test Time in Seconds
Local Const $NUM_TEST = 2; Test Iterations
Local Const $TOGGLE_INTERVAL = 3 ; Interval Toggling
Local Const $TEST_INTERVALS = 4;
; Other Tests are intervals

Local Const $TOGGLE_FLAGS[2] = ["1", "toggle"]

Func activiatePowerTool()
	Return WinActivate("Power Tool")
EndFunc

Func createFile($sFilePath)
	If Not FileExists($sFilePath) Then
		If Not _FileCreate($sFilePath) Then
			MsgBox($MB_SYSTEMMODAL, _
					"File Create", "An error occurred whilst writing the temporary file.")
		EndIf
		FileWriteLine($sFilePath, _
				"Test No, Time, Energy, Avg Power, Expected Battery, Avg Current, Avg Voltage")
	EndIf
EndFunc

Func inData($checkData, $flagArray)
	For $data = 0 To UBound($flagArray) - 1
		If StringCompare($checkData, $flagArray[$data], $STR_NOCASESENSE) == 0 Then
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>inData

Func checkParameter($hWnd)
	ControlClick($hWnd, "", "[NAME:buttonParameters]")
	Sleep(1000)
	ControlClick(WinActivate("Set Parameters"), "", "[NAME:buttonGetFactoryDefaults]")
	Sleep(50)
	ControlClick(WinActivate("Set Parameters"), "", "[NAME:buttonApply]")
	Sleep(50)
	ControlClick(WinActivate("Set Parameters"), "", "[NAME:buttonCancel]")
	Sleep(50)
EndFunc   ;==>checkParameter


Func saveData($hWnd, $description)
	ControlClick($hWnd, "", "[NAME:buttonExport]")
	Sleep(500)
	ControlClick(WinActivate("Export Options"), "", "[NAME:okButton]")
	Sleep(500)
	$tCur = _Date_Time_GetLocalTime()
	$dateString = _Date_Time_SystemTimeToDateTimeStr($tCur)
	$output = StringReplace(StringReplace(StringReplace($dateString, ":", "-"), "/", "-"), " ", "-")
	Send($output & "-" & $description)
	ControlClick(WinActivate("Save As"), "", "[CLASS:Button; INSTANCE:1]")
	; "Exporting data to file (this could take a while"
	Sleep(1000)
	Do
		Sleep(500)
	Until WinGetState("Exporting data to file (this could take a while)") == 0
EndFunc   ;==>saveData

Func checkTriggerTime($triggerTestTime)
	ControlClick($hWnd, "", "[NAME:buttonSetTrigger]")
	$tWnd = WinActivate("Trigger Settings")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	;	Send("{TAB}") ; Windows 8
	Send("^C")
	$value = ClipGet()
	If Number($value) <> $triggerTestTime Then
		Send($triggerTestTime)
	EndIf
	ControlClick($tWnd, "", "[NAME:buttonOk]")
EndFunc   ;==>checkTriggerTime
