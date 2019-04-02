@echo off
SETLOCAL EnableDelayedExpansion
rem EnableDelayedExpansion serve a riconoscere la sintassi !var! la quale accede al valore corrente di var. Quindi se abilitato non si può fare "echo ciao!" perché lo gestirebbe come "echo ciao"

color 0
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

echo ********************************************************************************************
echo  * P I N G   - C h e c k e r
echo ********************************************************************************************
echo * Non chiudere la finestra. Test di connessione in corso.
echo * Verificare l'esito in c:\temp\ping\
echo * Ricorda di impostarmi tra le esecuzioni automatiche e di togliermi quando non serviro' piu'!
echo * percorso esecuzione automatica: %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\
rem evito il new line di echo
echo|set /p="* "
call :colorEcho 0C "per eliminare il file dall'esecuzione automatica premi CTRL + C e digita N"
echo.
echo ********************************************************************************************

mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\pingChecker.lnk" "%~dpnx0" 2> nul 1> nul

mkdir c:\temp\ 2> NUL
mkdir "%~dp0\ping\" 2> NUL
cd "%~dp0\ping\" 2> NUL
IF EXIST dest.txt (
  set /p dest=<dest.txt
) else (
  set /p dest=target:||set dest="www.google.it"
  echo !dest!>dest.txt
pause
)

echo Ping in esecuzione verso !dest!...
rem :REPEAT
 @echo. %date% at %time% >> "ping_%dest%-20%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%-%TIME:~0,2%_%TIME:~3,2%.txt"
 rem ping %dest% -n 20 >> "ping_%dest%-20%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%-%TIME:~0,2%_%TIME:~3,2%.txt"
 rem if %ERRORLEVEL%==1 goto :elimina
rem goto REPEAT
ping -t !dest! >> "ping_!dest!-20%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%-%TIME:~0,2%_%TIME:~3,2%.txt"
goto elimina

:elimina
 del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\pingChecker.lnk" "%~dpnx0"
 del /F "%~dpnx0"
 exit /B
exit

:colorEcho
 echo off
 <nul set /p ".=%DEL%" > "%~2"
 findstr /v /a:%1 /R "^$" "%~2" nul
 del "%~2" > nul 2>&1i
rem Non mettere nulla dopo di questo!
rem ------------------------------------------------------------------------------------------------------------

rem da fare:
rem - HTML
rem  echo <p> Username : %username% > info.html
rem  echo         Section : %section% >> info.html
rem  echo         phone# : %phone#% </p> >> info.html
