@echo off
REM =============================================================================
REM سكريبت إصلاح شامل لخطأ OutputFile - Windows
REM VisCend Studio Flutter App
REM =============================================================================

chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║   🔧 سكريبت إصلاح خطأ OutputFile - VisCend Studio       ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

REM التحقق من الموقع الحالي
if not exist "pubspec.yaml" (
    echo ❌ خطأ: يجب تشغيل السكريبت من مجلد flutter_app
    echo cd flutter_app ^&^& fix_outputfile.bat
    pause
    exit /b 1
)

echo ⚠️  هذا السكريبت سيقوم بـ:
echo    1. حذف جميع cache و build files
echo    2. إعادة تحميل Gradle wrapper
echo    3. تحديث dependencies
echo    4. محاولة البناء
echo.
set /p confirm="هل تريد المتابعة؟ (y/n) "
if /i not "%confirm%"=="y" (
    echo تم الإلغاء
    pause
    exit /b 1
)

REM =============================================================================
REM الخطوة 1: توقيف Gradle Daemon
REM =============================================================================
echo.
echo ▶ الخطوة 1/8: توقيف Gradle daemon...
cd android 2>nul
if exist "gradlew.bat" (
    call gradlew.bat --stop 2>nul
)
cd ..
echo ✓ تم توقيف Gradle

REM =============================================================================
REM الخطوة 2: حذف Build Files المحلية
REM =============================================================================
echo.
echo ▶ الخطوة 2/8: حذف build files المحلية...
if exist "build\" rmdir /s /q "build\" 2>nul
if exist "android\.gradle\" rmdir /s /q "android\.gradle\" 2>nul
if exist "android\app\.gradle\" rmdir /s /q "android\app\.gradle\" 2>nul
if exist "android\app\build\" rmdir /s /q "android\app\build\" 2>nul
if exist "android\build\" rmdir /s /q "android\build\" 2>nul
if exist ".dart_tool\" rmdir /s /q ".dart_tool\" 2>nul
echo ✓ تم حذف build files المحلية

REM =============================================================================
REM الخطوة 3: حذف Gradle Cache العام
REM =============================================================================
echo.
echo ▶ الخطوة 3/8: حذف Gradle cache العام...
set GRADLE_HOME=%USERPROFILE%\.gradle
echo    موقع cache: %GRADLE_HOME%
if exist "%GRADLE_HOME%\caches\" rmdir /s /q "%GRADLE_HOME%\caches\" 2>nul
if exist "%GRADLE_HOME%\wrapper\" rmdir /s /q "%GRADLE_HOME%\wrapper\" 2>nul
echo ✓ تم حذف Gradle cache العام

REM =============================================================================
REM الخطوة 4: Flutter Clean
REM =============================================================================
echo.
echo ▶ الخطوة 4/8: تنظيف Flutter...
call flutter clean
echo ✓ تم تنظيف Flutter

REM =============================================================================
REM الخطوة 5: تحديث Dependencies
REM =============================================================================
echo.
echo ▶ الخطوة 5/8: تحديث Flutter dependencies...
call flutter pub get
echo ✓ تم تحديث dependencies

REM =============================================================================
REM الخطوة 6: التحقق من الإصدارات
REM =============================================================================
echo.
echo ▶ الخطوة 6/8: التحقق من الإصدارات...
echo    Flutter:
call flutter --version | findstr "Flutter"
echo    Java:
java -version 2>&1 | findstr "version"

REM =============================================================================
REM الخطوة 7: إعادة إنشاء Gradle Wrapper
REM =============================================================================
echo.
echo ▶ الخطوة 7/8: إعادة إنشاء Gradle wrapper...
cd android

REM حذف wrapper القديم
if exist "gradle\wrapper\gradle-wrapper.jar" del /f /q "gradle\wrapper\gradle-wrapper.jar" 2>nul

REM إعادة إنشاء wrapper
echo    إعادة إنشاء wrapper...
call gradlew.bat wrapper --gradle-version=8.7 --distribution-type=all

REM التحقق من التحميل
echo    تحميل Gradle 8.7...
call gradlew.bat --version

cd ..
echo ✓ تم إعادة إنشاء Gradle wrapper

REM =============================================================================
REM الخطوة 8: البناء
REM =============================================================================
echo.
echo ▶ الخطوة 8/8: محاولة البناء...
cd android

echo    تنظيف المشروع...
call gradlew.bat clean --no-daemon

echo.
echo    بناء APK debug...
echo    (قد يستغرق عدة دقائق في المرة الأولى...)
echo.

call gradlew.bat assembleDebug --refresh-dependencies --recompile-scripts --no-build-cache --no-configuration-cache --info

if %ERRORLEVEL% equ 0 (
    cd ..
    echo.
    echo ╔═══════════════════════════════════════════════════════════╗
    echo ║               🎉 نجح البناء بدون أخطاء! 🎉              ║
    echo ╚═══════════════════════════════════════════════════════════╝
    echo.
    
    if exist "build\app\outputs\flutter-apk\app-debug.apk" (
        echo ✓ APK تم إنشاؤه: build\app\outputs\flutter-apk\app-debug.apk
    )
    
    echo.
    echo ▶ الخطوات التالية:
    echo    1. اختبر التطبيق: flutter run
    echo    2. بناء release: flutter build apk --release
    echo    3. بناء bundle: flutter build appbundle --release
    
) else (
    cd ..
    echo.
    echo ╔═══════════════════════════════════════════════════════════╗
    echo ║                  ❌ فشل البناء                           ║
    echo ╚═══════════════════════════════════════════════════════════╝
    echo.
    
    echo ▶ جرب الحلول التالية:
    echo.
    echo 1️⃣ تحقق من Java version:
    echo    java -version
    echo    يجب أن يكون: openjdk version "17"
    echo.
    echo 2️⃣ جرب Gradle 8.6 بدلاً من 8.7:
    echo    عدّل android\gradle\wrapper\gradle-wrapper.properties
    echo    distributionUrl=...gradle-8.6-all.zip
    echo.
    echo 3️⃣ جرب AGP 8.4.0:
    echo    عدّل android\build.gradle
    echo    classpath 'com.android.tools.build:gradle:8.4.0'
    echo.
    echo 4️⃣ شغّل مع stacktrace للمزيد من المعلومات:
    echo    cd android
    echo    gradlew.bat assembleDebug --stacktrace --info --debug
    echo.
    echo 5️⃣ اقرأ الوثائق:
    echo    📄 🚨_OUTPUTFILE_ALL_CAUSES_SOLUTIONS.md
    echo.
    
    pause
    exit /b 1
)

echo.
echo ✅ انتهى السكريبت بنجاح!
pause
