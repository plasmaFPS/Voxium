@echo off
echo Starting Voxium...

:: Start Backend in a new window
echo Starting Backend...
start "Voxium Backend" cmd /k "cd backend && cargo run --bin backend"

:: Start Frontend in a new window
echo Starting Frontend...
cd discord-app
start "Voxium App" cmd /k "npm run tauri dev"

echo Done! Backend and Frontend are launching in separate windows.
pause
