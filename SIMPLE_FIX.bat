@echo off
chcp 65001 >nul
setlocal

REM =============================================================================
REM الحل البسيط لمشكلة Gradle Wrapper المفقود - Windows
REM =============================================================================

echo.
echo 🔥 إصلاح مشكلة Gradle Wrapper المفقود
echo =========================================
echo.

REM التحقق من الموقع
if not exist "pubspec.yaml" (
    echo ❌ خطأ: شغّل السكريبت من مجلد flutter_app
    echo    cd flutter_app ^&^& SIMPLE_FIX.bat
    pause
    exit /b 1
)

REM 1. تنظيف Flutter
echo ▶ الخطوة 1/3: تنظيف Flutter...
call flutter clean
echo ✓ تم
echo.

REM 2. تحديث dependencies
echo ▶ الخطوة 2/3: تحديث dependencies...
call flutter pub get
echo ✓ تم
echo.

REM 3. البناء (سيحمل gradle-wrapper.jar تلقائياً)
echo ▶ الخطوة 3/3: البناء (سيحمل الملفات المفقودة)...
echo.
echo ⏳ قد يستغرق عدة دقائق في المرة الأولى...
echo.

call flutter build apk --debug

if %ERRORLEVEL% equ 0 (
    echo.
    echo ╔═══════════════════════════════════════════════════════════╗
    echo ║          🎉 نجح البناء! المشكلة تم حلها! 🎉            ║
    echo ╚═══════════════════════════════════════════════════════════╝
    echo.
    
    echo ✅ الملفات المطلوبة:
    if exist "android\gradlew" echo    ✓ gradlew موجود
    if exist "android\gradlew.bat" echo    ✓ gradlew.bat موجود
    if exist "android\gradle\wrapper\gradle-wrapper.jar" echo    ✓ gradle-wrapper.jar موجود
    if exist "android\gradle\wrapper\gradle-wrapper.properties" echo    ✓ gradle-wrapper.properties موجود
    
    echo.
    if exist "build\app\outputs\flutter-apk\app-debug.apk" (
        echo ✓ APK: build\app\outputs\flutter-apk\app-debug.apk
    )
    
    echo.
    echo ▶ الخطوات التالية:
    echo    1. اختبر: flutter run
    echo    2. بناء release: flutter build apk --release
    echo    3. بناء bundle: flutter build appbundle --release
    
) else (
    echo.
    echo ╔═══════════════════════════════════════════════════════════╗
    echo ║                  ❌ فشل البناء                           ║
    echo ╚═══════════════════════════════════════════════════════════╝
    echo.
    
    echo 🔧 جرب هذا:
    echo.
    echo 1. تأكد من Java 17:
    echo    java -version
    echo.
    echo 2. جرب تحميل wrapper يدوياً:
    echo    cd android
    echo    gradle wrapper --gradle-version 8.7
    echo.
    echo 3. اقرأ: 🔥_FIX_GRADLE_WRAPPER.md
    echo.
    
    pause
    exit /b 1
)

echo.
echo ✅ انتهى!
pause
