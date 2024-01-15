echo off
for /D %%i in (*) do (
    REM If the directory begins with _, or does not contain a .git directory, skip it
    if "%%i" geq "_" if "%%i" leq "_z" (
        echo Ignoring %%i
    ) else (
        if exist "%%i\.git" (
            echo Pulling %%i
            git -C "%%i" clean -fd
            git -C "%%i" checkout -- .
            git -C "%%i" pull
        ) else (
            echo Skipping %%i - No repository found
        )
    )
)
pause