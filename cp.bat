@echo off
SETLOCAL enableDelayedExpansion

set flag=%1
set D_USR=D:\dev\.resources\.vscode
set CODE_USR=%AppData%\Code\User

IF "%flag%"=="sett" ( GOTO:proc_sett )
IF "%flag%"=="kb" ( GOTO:proc_kb )
IF "%flag%"=="ext" ( GOTO:proc_ext )
IF "%flag%"=="snip" ( GOTO:proc_snip )

:Syntax
    echo Syntax:
    echo    cp ^<flag^> [^<option^>] [^<xcopy_flags^>]
    echo.
    echo    flag    Specifies what to copy
    echo      sett  Copy 'settings.json'
    echo      kb    Copy 'keybindings.json'
    echo      ext   Copy extentions from 'G:' to %%AppData%% (slow^)
    echo      snip [option ^<py/vba/my^>] ...
    echo            Copy snippets. ^If no option is provided, all snippets are copied
    echo    xcopy_flags ...
    echo            Additional flags to pass to 'xcopy'. See xcopy /?
    
GOTO:EOF

:proc_sett
    xcopy %2/y %D_USR%\settings.json %CODE_USR%\settings.json
    GOTO:EOF

:proc_kb
    xcopy %2/y %D_USR%\keybindings.json %CODE_USR%\keybindings.json
    GOTO:EOF

:proc_ext
    SET /P sure=This might take a long time, are you sure (y/n)?

    IF /I "%sure%" NEQ "y" (
        echo Operation cancelled...
    ) ELSE (
        echo Copying...
        xcopy %2/s/y/j %D_USR%\extensions %USERPROFILE%\.vscode\extensions
    )
    GOTO:EOF

:proc_snip
    set op=
    for %%G in ("py" "vba" "my") DO (
        IF /I "%~2"=="%%~G" (
            set "op=%~2"
            SHIFT /2
            GOTO:match
        )
    )
    :match
    xcopy %D_USR%\snippets\%op%* %CODE_USR%\snippets\%op%* %2/s/y
    GOTO:EOF

:End