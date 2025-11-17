#!/bin/bash

# =============================================================================
# سكريبت إصلاح شامل لخطأ OutputFile
# VisCend Studio Flutter App
# =============================================================================

set -e  # إيقاف عند أي خطأ

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # بدون لون

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║   🔧 سكريبت إصلاح خطأ OutputFile - VisCend Studio       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# التحقق من الموقع الحالي
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}❌ خطأ: يجب تشغيل السكريبت من مجلد flutter_app${NC}"
    echo "cd flutter_app && ./fix_outputfile.sh"
    exit 1
fi

echo -e "${YELLOW}⚠️  هذا السكريبت سيقوم بـ:${NC}"
echo "   1. حذف جميع cache و build files"
echo "   2. إعادة تحميل Gradle wrapper"
echo "   3. تحديث dependencies"
echo "   4. محاولة البناء"
echo ""
read -p "هل تريد المتابعة؟ (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}تم الإلغاء${NC}"
    exit 1
fi

# =============================================================================
# الخطوة 1: توقيف Gradle Daemon
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 1/8: توقيف Gradle daemon...${NC}"
cd android 2>/dev/null || { echo -e "${RED}مجلد android غير موجود${NC}"; exit 1; }
./gradlew --stop 2>/dev/null || echo "لا توجد عمليات Gradle نشطة"
cd ..
echo -e "${GREEN}✓ تم توقيف Gradle${NC}"

# =============================================================================
# الخطوة 2: حذف Build Files المحلية
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 2/8: حذف build files المحلية...${NC}"
rm -rf build/ 2>/dev/null || true
rm -rf android/.gradle/ 2>/dev/null || true
rm -rf android/app/.gradle/ 2>/dev/null || true
rm -rf android/app/build/ 2>/dev/null || true
rm -rf android/build/ 2>/dev/null || true
rm -rf .dart_tool/ 2>/dev/null || true
echo -e "${GREEN}✓ تم حذف build files المحلية${NC}"

# =============================================================================
# الخطوة 3: حذف Gradle Cache العام
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 3/8: حذف Gradle cache العام...${NC}"
GRADLE_HOME="${GRADLE_USER_HOME:-$HOME/.gradle}"
echo "   موقع cache: $GRADLE_HOME"
rm -rf "$GRADLE_HOME/caches/" 2>/dev/null || true
rm -rf "$GRADLE_HOME/wrapper/" 2>/dev/null || true
echo -e "${GREEN}✓ تم حذف Gradle cache العام${NC}"

# =============================================================================
# الخطوة 4: Flutter Clean
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 4/8: تنظيف Flutter...${NC}"
flutter clean
echo -e "${GREEN}✓ تم تنظيف Flutter${NC}"

# =============================================================================
# الخطوة 5: تحديث Dependencies
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 5/8: تحديث Flutter dependencies...${NC}"
flutter pub get
echo -e "${GREEN}✓ تم تحديث dependencies${NC}"

# =============================================================================
# الخطوة 6: التحقق من الإصدارات
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 6/8: التحقق من الإصدارات...${NC}"

# Flutter version
echo -n "   Flutter: "
flutter --version | head -n 1

# Java version
echo -n "   Java: "
java -version 2>&1 | head -n 1 | cut -d'"' -f2

# Gradle version في الملفات
AGP_VERSION=$(grep "com.android.tools.build:gradle:" android/build.gradle | sed 's/.*gradle://' | tr -d "'\" ")
echo "   AGP في build.gradle: $AGP_VERSION"

GRADLE_VERSION=$(grep "distributionUrl" android/gradle/wrapper/gradle-wrapper.properties | sed 's/.*gradle-//' | sed 's/-all.zip//')
echo "   Gradle wrapper: $GRADLE_VERSION"

# التحقق من التوافق
if [ "$AGP_VERSION" != "8.5.0" ]; then
    echo -e "${YELLOW}   ⚠️  AGP يجب أن يكون 8.5.0${NC}"
fi

if [ "$GRADLE_VERSION" != "8.7" ]; then
    echo -e "${YELLOW}   ⚠️  Gradle يجب أن يكون 8.7${NC}"
fi

# =============================================================================
# الخطوة 7: إعادة إنشاء Gradle Wrapper
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 7/8: إعادة إنشاء Gradle wrapper...${NC}"
cd android

# حذف wrapper القديم
rm -rf gradle/wrapper/gradle-wrapper.jar 2>/dev/null || true

# إعادة إنشاء wrapper
if command -v gradle &> /dev/null; then
    echo "   استخدام gradle command..."
    gradle wrapper --gradle-version=8.7 --distribution-type=all
else
    echo "   استخدام gradlew..."
    ./gradlew wrapper --gradle-version=8.7 --distribution-type=all
fi

# التحقق من التحميل
echo "   تحميل Gradle 8.7..."
./gradlew --version | head -n 10

cd ..
echo -e "${GREEN}✓ تم إعادة إنشاء Gradle wrapper${NC}"

# =============================================================================
# الخطوة 8: البناء
# =============================================================================
echo ""
echo -e "${BLUE}▶ الخطوة 8/8: محاولة البناء...${NC}"
cd android

echo "   تنظيف المشروع..."
./gradlew clean --no-daemon

echo ""
echo "   بناء APK debug..."
echo -e "${YELLOW}   (قد يستغرق عدة دقائق في المرة الأولى...)${NC}"
echo ""

if ./gradlew assembleDebug \
    --refresh-dependencies \
    --recompile-scripts \
    --no-build-cache \
    --no-configuration-cache \
    --info; then
    
    cd ..
    echo ""
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║               🎉 نجح البناء بدون أخطاء! 🎉              ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # معلومات الـ APK
    APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"
    if [ -f "$APK_PATH" ]; then
        APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
        echo -e "${GREEN}✓ APK تم إنشاؤه: $APK_PATH${NC}"
        echo -e "${GREEN}✓ الحجم: $APK_SIZE${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}▶ الخطوات التالية:${NC}"
    echo "   1. اختبر التطبيق: flutter run"
    echo "   2. بناء release: flutter build apk --release"
    echo "   3. بناء bundle: flutter build appbundle --release"
    
else
    cd ..
    echo ""
    echo -e "${RED}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  ❌ فشل البناء                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${YELLOW}▶ جرب الحلول التالية:${NC}"
    echo ""
    echo "1️⃣ تحقق من Java version:"
    echo "   java -version"
    echo "   يجب أن يكون: openjdk version \"17\""
    echo ""
    echo "2️⃣ جرب Gradle 8.6 بدلاً من 8.7:"
    echo "   عدّل android/gradle/wrapper/gradle-wrapper.properties"
    echo "   distributionUrl=...gradle-8.6-all.zip"
    echo ""
    echo "3️⃣ جرب AGP 8.4.0:"
    echo "   عدّل android/build.gradle"
    echo "   classpath 'com.android.tools.build:gradle:8.4.0'"
    echo ""
    echo "4️⃣ شغّل مع stacktrace للمزيد من المعلومات:"
    echo "   cd android"
    echo "   ./gradlew assembleDebug --stacktrace --info --debug"
    echo ""
    echo "5️⃣ اقرأ الوثائق:"
    echo "   📄 🚨_OUTPUTFILE_ALL_CAUSES_SOLUTIONS.md"
    echo ""
    
    exit 1
fi

echo ""
echo -e "${GREEN}✅ انتهى السكريبت بنجاح!${NC}"
