@echo off
title SmoothLauncher - Build

echo ===========================================
echo       SmoothLauncher - Сборка APK
echo ===========================================
echo.

REM Проверка наличия Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Java не найдена!
    echo Установите Java JDK 17+ или Android Studio
    echo https://developer.android.com/studio
    pause
    exit /b 1
)
echo [OK] Java найдена

REM Проверка gradlew
if not exist "gradlew.bat" (
    echo [INFO] gradlew.bat не найден — пробуем скачать через gradle wrapper...
    gradle wrapper --gradle-version 8.3 >nul 2>&1
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Gradle не найден. Откройте проект в Android Studio:
        echo   File - Open - выберите папку SmoothLauncher
        echo   Нажмите Build - Build APK
        pause
        exit /b 1
    )
)

echo [INFO] Начинаем сборку Release APK...
echo.
call gradlew.bat assembleRelease --no-daemon
if %errorlevel% neq 0 (
    echo.
    echo [ОШИБКА] Сборка не удалась.
    echo Откройте проект в Android Studio для просмотра ошибок.
    pause
    exit /b 1
)

REM Копируем APK в папку release
if not exist "release" mkdir release
copy /Y "app\build\outputs\apk\release\app-release.apk" "release\SmoothLauncher.apk" >nul
if %errorlevel% == 0 (
    echo.
    echo [УСПЕХ] APK собран: release\SmoothLauncher.apk
    echo.
    echo Теперь запустите install.bat для установки на устройство.
) else (
    REM Try debug apk too
    copy /Y "app\build\outputs\apk\debug\app-debug.apk" "release\SmoothLauncher.apk" >nul 2>&1
    echo [INFO] Скопирован debug APK: release\SmoothLauncher.apk
)
echo.
pause
