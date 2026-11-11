@echo off
title SmoothLauncher - Первоначальная настройка
echo ===========================================
echo     SmoothLauncher - Настройка проекта
echo ===========================================
echo.
echo [1/2] Скачиваем Gradle Wrapper JAR...

if not exist "gradle\wrapper" mkdir gradle\wrapper

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol='Tls12'; (New-Object Net.WebClient).DownloadFile('https://github.com/gradle/gradle/raw/v8.3.0/gradle/wrapper/gradle-wrapper.jar','gradle\wrapper\gradle-wrapper.jar')}" 2>nul

if exist "gradle\wrapper\gradle-wrapper.jar" (
    echo [OK] gradle-wrapper.jar скачан
) else (
    echo [INFO] Не удалось скачать автоматически.
    echo Вариант A: Откройте проект в Android Studio - он сделает всё сам.
    echo Вариант B: Скачайте вручную:
    echo   https://github.com/gradle/gradle/raw/v8.3.0/gradle/wrapper/gradle-wrapper.jar
    echo   Положите в папку: gradle\wrapper\gradle-wrapper.jar
    echo.
    pause
    exit /b 0
)

echo.
echo [2/2] Проверка Java...
java -version 2>nul
if %errorlevel% neq 0 (
    echo [!] Java не найдена. Скачайте JDK 17:
    echo     https://adoptium.net/
) else (
    echo [OK] Java найдена
)

echo.
echo ==========================================
echo  Готово! Теперь запустите build.bat
echo ==========================================
pause
