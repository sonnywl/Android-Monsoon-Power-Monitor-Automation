#include <Array.au3>
#include <Date.au3>
#include <File.au3>
#include <FileConstants.au3>
#include "Common.au3"

Local Const $saveData = True
Local $counter = 0
Local $testsFile = FileOpen($INPUT_FILE, $FO_READ );
Local $sFileRead = FileReadToArray($testsFile)

Local $IS_LOGGING = false;
Local $hWnd = activiatePowerTool()

Func startBenchmark($msg)

	If Not FileExists($OUTPUT_FILE) Then
		createFile($OUTPUT_FILE)
	EndIf
	; For Each Test
	For $i = 1 To UBound($sFileRead) - 1 ; Loop through the tests
		$test = StringSplit($sFileRead[$i], ",",$STR_NOCOUNT)
		If $IS_LOGGING Then
			RunWait(".\benchmark-logger.bat RESET");
		EndIf
		; For Test Iteration

		For $j = $TEST_INTERVALS To UBound($test) - 1
			FileWriteLine($OUTPUT_FILE, $test[$TEST_NAME] & " option " & $test[$j])
			$counter = 0;
			While $counter < $test[$NUM_TEST]
				activiatePowerTool()
				checkParameter($hWnd)

				If $IS_LOGGING Then
					RunWait(".\benchmark-logger.bat START")
				EndIf

				RunWait(".\benchmark-start.bat " _
						& $test[$TEST_FILE_NAME_START] &" " _
						& StringLower($test[$TEST_NAME]) & " " _
						& $test[$j] & " " _
						& inData($test[$TOGGLE_INTERVAL], $TOGGLE_FLAGS))

				$hWnd = activiatePowerTool()
				ControlClick($hWnd, "", "[NAME:buttonRun]")
				Sleep(($test[$TEST_TIME] * 1000))

				activiatePowerTool()
				ControlClick($hWnd, "", "[NAME:buttonStop]")
				Sleep(50)
				activiatePowerTool()
				$consumedEnergy = ControlGetText($hWnd, "", "[NAME:labelStatsConsEnergy]")
				$avgPower = ControlGetText($hWnd, "", "[NAME:labelStatsAvgPower]")
				$avgCurrent = ControlGetText($hWnd, "", "[NAME:labelStatsAvgCur]")
				$avgVoltage = ControlGetText($hWnd, "", "[NAME:labelStatsAvgVout]")
				$expectLife = ControlGetText($hWnd, "", "[NAME:labelBattery]")
				$tCur = _Date_Time_GetLocalTime()

				RunWait(".\benchmark-end.bat " _
					& $test[$TEST_FILE_NAME_END] & " " _
					& StringLower($test[$TEST_NAME]))

				If $IS_LOGGING Then
					RunWait(".\benchmark-logger.bat STOP")
				EndIf

				FileWriteLine($OUTPUT_FILE, _Date_Time_SystemTimeToDateTimeStr($tCur) _
					& " " & $consumedEnergy & " " & $avgPower & " " _
					& $expectLife & " " & $avgCurrent & " " & $avgVoltage)

				activiatePowerTool()
				If $saveData Then
					saveData($hWnd, $test[$TEST_NAME] & "-" & $test[$j])
				EndIf

				$counter = $counter + 1
			WEnd
		Next
	Next
	If $IS_LOGGING Then
		RunWait(".\benchmark-logger.bat SHUTDOWN");
	EndIf
	MsgBox(0, "", "Completed Benchmarks")
EndFunc
