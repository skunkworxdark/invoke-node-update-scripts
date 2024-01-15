@echo off
setlocal enabledelayedexpansion
echo The following directories have updates to download: > updates.txt
for /d %%d in (*) do (
  if "%%d"=="__pycache__" (
    echo Skipping __pycache__ directory
  ) else (
    cd "%%d"
    if exist .git (
      echo checking... "%%d"
      git fetch > NUL
      set behind=0
      for /f "delims=" %%s in ('git status -uno') do (
        echo %%s | findstr /c:"Your branch is behind" >nul
        if not errorlevel 1 (
          for /f "tokens=7" %%a in ("%%s") do set commits=%%a
          set behind=1
        )
      )
      if !behind! equ 1 (
        echo %%d is !commits! commits behind >> ..\updates.txt
      ) else (
        REM echo No updates for "%%d"
      )
    ) else (
      echo "%%d" is not a git repository
    )
    cd ..
  )
)
type updates.txt
pause
