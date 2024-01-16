@echo off
setlocal enabledelayedexpansion
echo The following directories have updates to download: > updates.txt
for /d %%d in (*) do (
  if "%%d"=="__pycache__" (
    rem echo Skipping __pycache__ directory
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
        for /f "delims=" %%u in ('git config --get remote.origin.url') do (
          set repo_url=%%u
          set repo_url=!repo_url:https://github.com/=https://github.com/!
          set repo_url=!repo_url:.git=!
          for /f "delims=" %%h in ('git rev-parse HEAD') do (
            echo %%d is !commits! commits behind. >> ..\updates.txt
            echo !repo_url!/compare/%%h...main >> ..\updates.txt
          )
          rem echo %%d is !commits! commits behind. (%%u^) >> ..\updates.txt
        )
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
