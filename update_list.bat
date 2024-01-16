@echo off
setlocal enabledelayedexpansion
set target_dir=%~1
set is_single_dir=0
if not defined target_dir (
  set target_dir=*
) else (
  set is_single_dir=1
)
for /D %%i in ("%target_dir%") do (
  if !is_single_dir! equ 0 (
    if "%%~nxi"=="__pycache__" (
      rem echo Ignoring %%~nxi
    ) else (
      call :check_dir "%%~i" "%%~nxi"
    )
  ) else (
    call :check_dir "%%~i" "%%~nxi"
  )
)
pause
exit /b

:check_dir
rem cd "%~1"
echo checking "%~1" ...
if exist "%~1/.git" (
  git -C "%~1" fetch > NUL
  set behind=0
  for /f "delims=" %%s in ('git -C "%~1" status -uno') do (
    echo %%s | findstr /c:"Your branch is behind" >nul
    if not errorlevel 1 (
      for /f "tokens=7" %%a in ("%%s") do set commits=%%a
      set behind=1
    )
  )
  if !behind! equ 1 (
    for /f "delims=" %%u in ('git -C "%~1" config --get remote.origin.url') do (
      set repo_url=%%u
      set repo_url=!repo_url:.git=!
      for /f "delims=" %%h in ('git -C "%~1" rev-parse HEAD') do (
        echo ... !commits! commits behind.
        echo !repo_url!/compare/%%h...main
      )
    )
  ) else (
    echo ... No updates
  )
) else (
  echo ... Skipping - No Git Repo found
)
rem cd ..
exit /b
