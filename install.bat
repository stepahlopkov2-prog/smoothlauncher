@echo off
title SmoothLauncher - Установка

echo ===========================================
echo      SmoothLauncher - Установка на устройство
echo ===========================================
echo.

REM Проверка APK
if not exist "release\SmoothLauncher.apk" (
    echo [ОШИБКА] Файл release\SmoothLauncher.apk не найден!
    echo Сначала запустите build.bat для сборки.
    pause
    exit /b 1
)

REM Проверка ADB
adb version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] ADB не найден!
    echo Убедитесь что Android Studio установлен, и добавьте в PATH:
    echo   %%LOCALAPPDATA%%\Android\Sdk\platform-tools
    pause
    exit /b 1
)
echo [OK] ADB найден

REM Проверка устройства
echo [INFO] Ищем подключённые устройства...
adb devices
echo.

set /p confirm=Устройство подключено и USB-отладка включена? (y/n): 
if /i "%confirm%" neq "y" (
    echo Подключите устройство, включите USB-отладку и запустите снова.
    pause
    exit /b 0
)

echo.
echo [INFO] Устанавливаем SmoothLauncher...
adb install -r "release\SmoothLauncher.apk"

if %errorlevel% == 0 (
    echo.
    echo ==========================================
    echo  [УСПЕХ] SmoothLauncher установлен!
    echo ==========================================
    echo.
    echo Следующие шаги:
    echo  1. Нажмите кнопку HOME на устройстве
    echo  2. Выберите SmoothLauncher
    echo  3. Нажмите "Всегда" чтобы сделать его по умолчанию
    echo  4. Долгое нажатие на рабочем столе = настройки
    echo  5. Свайп вверх = все приложения
) else (
    echo.
    echo [ОШИБКА] Установка не удалась.
    echo Убедитесь что:
    echo  - USB-отладка включена в настройках разработчика
    echo  - Разрешена установка через USB
    echo  - Устройство разблокировано
)
echo.
pause
