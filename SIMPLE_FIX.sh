#!/bin/bash

# =============================================================================
# الحل البسيط لمشكلة Gradle Wrapper المفقود
# =============================================================================

echo ""
echo "🔥 إصلاح مشكلة Gradle Wrapper المفقود"
echo "========================================="
echo ""

# التحقق من الموقع
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ خطأ: شغّل السكريبت من مجلد flutter_app"
    echo "   cd flutter_app && ./SIMPLE_FIX.sh"
    exit 1
fi

# 1. إعطاء صلاحيات التنفيذ لـ gradlew
echo "▶ الخطوة 1/4: إعطاء صلاحيات التنفيذ..."
chmod +x android/gradlew 2>/dev/null || true
chmod +x android/gradlew.bat 2>/dev/null || true
echo "✓ تم"

# 2. تنظيف Flutter
echo ""
echo "▶ الخطوة 2/4: تنظيف Flutter..."
flutter clean
echo "✓ تم"

# 3. تحديث dependencies
echo ""
echo "▶ الخطوة 3/4: تحديث dependencies..."
flutter pub get
echo "✓ تم"

# 4. البناء (سيحمل gradle-wrapper.jar تلقائياً)
echo ""
echo "▶ الخطوة 4/4: البناء (سيحمل الملفات المفقودة)..."
echo ""
echo "⏳ قد يستغرق عدة دقائق في المرة الأولى..."
echo ""

flutter build apk --debug

if [ $? -eq 0 ]; then
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║          🎉 نجح البناء! المشكلة تم حلها! 🎉            ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    
    # التحقق من الملفات
    echo "✅ الملفات المطلوبة:"
    [ -f "android/gradlew" ] && echo "   ✓ gradlew موجود"
    [ -f "android/gradlew.bat" ] && echo "   ✓ gradlew.bat موجود"
    [ -f "android/gradle/wrapper/gradle-wrapper.jar" ] && echo "   ✓ gradle-wrapper.jar موجود"
    [ -f "android/gradle/wrapper/gradle-wrapper.properties" ] && echo "   ✓ gradle-wrapper.properties موجود"
    
    echo ""
    if [ -f "build/app/outputs/flutter-apk/app-debug.apk" ]; then
        APK_SIZE=$(du -h build/app/outputs/flutter-apk/app-debug.apk | cut -f1)
        echo "✓ APK: build/app/outputs/flutter-apk/app-debug.apk ($APK_SIZE)"
    fi
    
    echo ""
    echo "▶ الخطوات التالية:"
    echo "   1. اختبر: flutter run"
    echo "   2. بناء release: flutter build apk --release"
    echo "   3. بناء bundle: flutter build appbundle --release"
    
else
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  ❌ فشل البناء                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    
    echo "🔧 جرب هذا:"
    echo ""
    echo "1. تأكد من Java 17:"
    echo "   java -version"
    echo ""
    echo "2. جرب تحميل wrapper يدوياً:"
    echo "   cd android"
    echo "   gradle wrapper --gradle-version 8.7"
    echo ""
    echo "3. أو حمّل gradle-wrapper.jar:"
    echo "   cd gradle/wrapper"
    echo "   curl -L -o gradle-wrapper.jar \\"
    echo "     https://raw.githubusercontent.com/gradle/gradle/v8.7.0/gradle/wrapper/gradle-wrapper.jar"
    echo ""
    echo "4. اقرأ: 🔥_FIX_GRADLE_WRAPPER.md"
    echo ""
    
    exit 1
fi

echo ""
echo "✅ انتهى!"
