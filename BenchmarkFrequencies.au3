#include <File.au3>
#include <FileConstants.au3>
#include "Benchmarks.au3"
; Frequency testing
Local Const $CPUS = 'cpus'
Local Const $ONLINE = 'online'
Local Const $FREQS = 'freqs'
Local Const $CUR = 'cur'
Local Const $MAX = 'max'
Local Const $MIN = 'min'
Local Const $GETP = 'getp'
Local Const $SETF = 'setf'
Local Const $SETMAX = 'setmax'
Local Const $SETMIN = 'setmin'
Local Const $SETP = 'setp'

Func cpuControl($firstParam, $secondParam, $thirdParam)
	$iPid = Run("benchmark-frequencies.bat " _
			& $firstParam & " " _
			& $secondParam & " " _
			& $thirdParam, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPid)
	Return StdoutRead($iPid);
EndFunc

$totalCpu = cpuControl($CPUS, 0, 0)
$frequenciesData = cpuControl($FREQS, 0, 0)

$frequencies = StringSplit(StringStripWS($frequenciesData, $STR_STRIPTRAILING), " ",$STR_NOCOUNT)
For $freq = 0 To UBound($frequencies) - 1
	For $cpu = 0 To $totalCpu
		cpuControl($SETF, $cpu, $frequencies[$freq])
	Next
	startBenchmark($frequencies[$freq])
Next
