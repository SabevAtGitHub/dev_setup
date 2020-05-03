Dim objResult

Set objShell = WScript.CreateObject("WScript.Shell")
i = 30 * 6 ' 30 x 2min x 6hours

Do While i > 0
	objResult = objShell.SendKeys("{NUMLOCK}{NUMLOCK}")
	WScript.Sleep 120000 ' 2min
	i = i - 1
Loop
