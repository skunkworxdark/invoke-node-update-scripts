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
    if "%%~nxi" geq "_" if "%%~nxi" leq "_z" (
      echo Ignoring %%~nxi
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
if exist "%~1\.git" (
  echo Pulling %~2
  git -C "%~1" clean -fd
  git -C "%~1" checkout -- .
  git -C "%~1" pull
) else (
  echo Skipping %~2 - No Git Repo found
)
exit /b
