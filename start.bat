@echo off
title Portfolio Dev Server
cd /d "%~dp0"

:: Add Node.js to PATH for this session
set "PATH=C:\Program Files\nodejs;%PATH%"

echo ========================================
echo    Starting Portfolio Dev Server
echo ========================================
echo.

:: Check if node_modules exists, if not run npm install
if not exist "node_modules" (
    echo Installing dependencies...
    echo This may take a minute...
    echo.
    call npm install
    if errorlevel 1 (
        echo.
        echo ERROR: npm install failed!
        pause
        exit /b 1
    )
    echo.
    echo Dependencies installed successfully!
    echo.
)

echo Starting development server...
echo The browser will open automatically.
echo.
echo Press Ctrl+C to stop the server.
echo ========================================
echo.

:: Start the dev server
call npm run dev -- --open

:: If we get here, something went wrong
echo.
echo ========================================
echo Server stopped or an error occurred.
echo ========================================
pause
