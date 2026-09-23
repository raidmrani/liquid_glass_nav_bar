# Fluid Glass Navigation Bar 🌊

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x%20%7C%20Ready-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.x%20%7C%20Sound%20Null%20Safety-0175C2?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-blue" alt="Platform">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/raidmrani/liquid_glass_nav_bar/main/assets/liquid_glass_nav_bar.gif" alt="Fluid Glass Navigation Bar Preview" width="340"/>
</p>

---

## 🌟 Overview / نظرة عامة

### English:
**Fluid Glass Navigation Bar** is a luxury, modern liquid glass bottom navigation bar with fluid gooey water physics and an intelligent companion floating action widget (`LiquidGlassFab`) for Flutter applications.

### العربية:
**شريط التنقل الزجاجي السائل (Fluid Glass Navigation Bar)** هو شريط تنقل سفلي زجاجي فاخر وعصري بتأثيرات السوائل المرنة واللزوجة المائية (Gooey Water Droplet) مع زر عائم ذكي متكامل (`LiquidGlassFab`) لتطبيقات Flutter.

---

## 📊 Tab Capacity Specifications / مواصفات سعة التبويبات الهندسية

### English:
Rigorous stress tests have established clear capacity guidelines:
- **Full Capacity:** Supports **2 to 10 tabs** with zero crashes, mathematically guarded against division-by-zero (`safeDivisor`).
- **Recommended Range:** **4 to 7 tabs** for optimal typography clarity and comfortable touch accuracy.
- **Optimal Standard:** **5 tabs** representing the finest balance between fluid gooey dynamics and visual elegance.

### العربية:
أظهرت اختبارات الضغط الهندسية الدقيقة المعايير التالية:
- **السعة الكاملة:** يستقبل من **2 إلى 10 تبويبات** بثبات برمجي فائق دون أي انهيار، ومحصن رياضياً ضد القسمة على صفر (`safeDivisor`).
- **المدى المفضل بصرياً:** من **4 إلى 7 تبويبات** لوضوح الحروف ودقة اللمس المريحة.
- **الرقم الذهبي المثالي:** **5 تبويبات** للانسجام التام بين فيزياء قطرة الماء وفخامة المظهر.

| Metric / المعيار | Specification / القيمة | Evaluation / التقييم الهندسي |
| :--- | :---: | :--- |
| **Full Capacity / السعة الكاملة** | **2 – 10 Tabs** | Highly stable & crash-free. / ثبات كامل دون أي أخطاء. |
| **Recommended / المفضل بصرياً** | **4 – 7 Tabs** | Perfect text clarity & ergonomics. / وضوح بصري ومساحة لمس مريحة. |
| **Optimal Standard / الرقم الذهبي** | **5 Tabs** | Pure perfection in proportions & aesthetics. / التوازن المطلق في الأبعاد والمظهر. |

---

## 🚀 Getting Started / التثبيت والبدء السريع

### 1. Installation / التثبيت
Add the package to your `pubspec.yaml`:
```yaml
dependencies:
  fluid_glass_nav_bar: ^1.0.0
```
Or run:
```bash
flutter pub add fluid_glass_nav_bar
```

### 2. Import / الاستيراد
```dart
import 'package:fluid_glass_nav_bar/fluid_glass_nav_bar.dart';
```

---

## 💻 Minimal Quick Start / الحد الأدنى الإلزامي للتشغيل

### English:
Only **3 parameters** are mandatory for the navigation bar (`items`, `currentIndex`, `onTap`), and **3 parameters** for each navigation item (`activeIcon`, `inactiveIcon`, `title`). Everything else is optional and defaults to the premium light-glass aesthetic:

### العربية:
تحتاج فقط إلى **3 مدخلات إلزامية** للشريط (`items`, `currentIndex`, `onTap`)، و **3 مدخلات إلزامية** لكل عنصر تبويب (`activeIcon`, `inactiveIcon`, `title`). كل ما عدا ذلك اختياري تماماً ويعمل تلقائياً بالقيم الافتراضية الفاخرة:

```dart
import 'package:flutter/material.dart';
import 'package:fluid_glass_nav_bar/fluid_glass_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<LiquidGlassNavItem> _navItems = const [
    LiquidGlassNavItem(
      activeIcon: Icons.home_rounded,
      inactiveIcon: Icons.home_outlined,
      title: 'الرئيسية',
    ),
    LiquidGlassNavItem(
      activeIcon: Icons.explore_rounded,
      inactiveIcon: Icons.explore_outlined,
      title: 'استكشف',
    ),
    LiquidGlassNavItem(
      activeIcon: Icons.chat_bubble_rounded,
      inactiveIcon: Icons.chat_bubble_outline_rounded,
      title: 'الرسائل',
      badge: CircleAvatar(radius: 4, backgroundColor: Colors.red),
    ),
    LiquidGlassNavItem(
      activeIcon: Icons.person_rounded,
      inactiveIcon: Icons.person_outline_rounded,
      title: 'ملفي',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Text('Active Page Index: $_currentIndex'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Companion Floating Action Widget / الزر العائم الذكي
          LiquidGlassFab(
            icon: Icons.add_rounded,
            onTap: () => debugPrint('FAB Tapped!'),
          ),

          // 2. Core Liquid Glass Navigation Bar / شريط التنقل الزجاجي المائي
          LiquidGlassNavBar(
            items: _navItems,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
          ),
        ],
      ),
    );
  }
}
```

---

## 🎨 Advanced Customization / التخصيص الكامل والمتقدم

### English:
Fine-tune every visual and physical aspect of the navigation bar: glass gradients, droplet styling, blur intensity, shadows, typography, and physics toggles:

### العربية:
تحكم كامل في كافة التفاصيل الجمالية والفيزيائية للشريط: تدرجات الزجاج، كبسولة قطرة الماء، شدة الضبابية (Blur)، الظلال، الخطوط، وتفعيل/تعطيل الفيزياء:

```dart
LiquidGlassNavBar(
  items: _navItems,
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  
  // Custom Dimensions & Blur / الأبعاد والبلور
  height: 62.0,
  blurSigma: 30.0,
  
  // Custom Glass Background / خامة الزجاج
  backgroundGradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white.withOpacity(0.90),
      Colors.white.withOpacity(0.65),
    ],
  ),
  borderColor: Colors.white,
  borderWidth: 1.5,
  
  // Custom Droplet Capsule / كبسولة الماء المنسابة
  dropletGradient: const LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
  ),
  dropletBorderColor: Colors.white,
  
  // Custom Colors & Typography / الألوان والخطوط
  activeColor: Colors.white,
  inactiveColor: const Color(0xFF64748B),
  enableFluidPhysics: true, // تفعيل لزوجة الماء
  enableDrag: true,         // تفعيل السحب المباشر
  enableHaptics: true,      // تفعيل الاهتزاز اللمسي
)
```

---

## 📖 API Reference / التوثيق الكامل للخصائص

### 1. `LiquidGlassNavBar` Properties:

| Property | Type | Status | Default | Description (English / عربي) |
| :--- | :---: | :---: | :---: | :--- |
| `items` | `List<LiquidGlassNavItem>` | **Required / إلزامي** | — | List of 2 to 10 tab items. / قائمة التبويبات (2 إلى 10). |
| `currentIndex` | `int` | **Required / إلزامي** | — | Active tab index. / مؤشر التبويب النشط حالياً. |
| `onTap` | `ValueChanged<int>` | **Required / إلزامي** | — | Callback when a tab is tapped or released. / دالة استدعاء عند النقر أو رفع الإصبع. |
| `onDragUpdate` | `ValueChanged<double>?` | Optional / اختياري | `null` | Continuous fractional drag progress. / مؤشر التقدم الكسري أثناء السحب المباشر. |
| `height` | `double` | Optional / اختياري | `60.0` | Height of the navigation bar. / ارتفاع الشريط السفلي. |
| `width` | `double?` | Optional / اختياري | `352.0` | Total bar width (adapts to small screens). / العرض الإجمالي للشريط. |
| `blurSigma` | `double` | Optional / اختياري | `25.0` | BackdropFilter glass blur intensity. / درجة ضبابية الزجاج الخلفي. |
| `backgroundGradient` | `Gradient?` | Optional / اختياري | *Light Glass* | Background glass gradient. / تدرج خلفية الزجاج. |
| `borderColor` | `Color?` | Optional / اختياري | `White (0.95)` | Outer glass border color. / لون إطار الشريط الخارجي. |
| `borderWidth` | `double` | Optional / اختياري | `1.2` | Outer border thickness. / سمك إطار الشريط. |
| `shadows` | `List<BoxShadow>?` | Optional / اختياري | *Soft Deep Shadows* | Outer box shadows. / ظلال الشريط الخارجية. |
| `dropletGradient` | `Gradient?` | Optional / اختياري | *Specular White* | Gradient for the gooey droplet. / تدرج كبسولة قطرة الماء. |
| `dropletBorderColor` | `Color?` | Optional / اختياري | `Colors.white` | Droplet border color. / لون إطار قطرة الماء. |
| `dropletBorderWidth` | `double` | Optional / اختياري | `1.1` | Droplet border thickness. / سمك إطار كبسولة الماء. |
| `activeColor` | `Color?` | Optional / اختياري | `Color(0xFF0F172A)` | Active icon and text color. / لون الأيقونة والنص عند التنشيط. |
| `inactiveColor` | `Color?` | Optional / اختياري | `Color(0xFF64748B)` | Inactive icon and text color. / لون الأيقونة والنص في الحالة غير النشطة. |
| `activeIconSize` | `double` | Optional / اختياري | `20.0` | Active icon size. / حجم الأيقونة النشطة. |
| `inactiveIconSize` | `double` | Optional / اختياري | `16.5` | Inactive icon size. / حجم الأيقونة غير النشطة. |
| `enableFluidPhysics` | `bool` | Optional / اختياري | `true` | Enables dynamic gooey water wave deformation. / تفعيل فيزياء السوائل واللزوجة. |
| `enableDrag` | `bool` | Optional / اختياري | `true` | Enables interactive horizontal drag gesture. / تفعيل سحب قطرة الماء بالأصبع. |
| `enableHaptics` | `bool` | Optional / اختياري | `true` | Haptic feedback on touch & snap. / تفعيل الاهتزاز الفيزيائي عند اللمس. |

---

### 2. `LiquidGlassNavItem` Properties:

| Property | Type | Status | Default | Description (English / عربي) |
| :--- | :---: | :---: | :---: | :--- |
| `activeIcon` | `IconData` | **Required / إلزامي** | — | Filled/Solid icon for active state. / أيقونة الحالة النشطة. |
| `inactiveIcon` | `IconData` | **Required / إلزامي** | — | Outlined icon for inactive state. / أيقونة الحالة غير النشطة. |
| `title` | `String` | **Required / إلزامي** | — | Label displayed below the icon. / النص الظاهر أسفل الأيقونة. |
| `route` | `String?` | Optional / اختياري | `null` | Associated navigation route name. / مسار الراوت المقترن بالتبويب. |
| `badge` | `Widget?` | Optional / اختياري | `null` | Notification badge widget. / ويدجت شارة التنبيه أو العداد. |
| `activeColor` | `Color?` | Optional / اختياري | `null` | Custom active color for this specific tab. / تخصيص لون خاص لهذا التبويب. |

---

### 3. `LiquidGlassFab` Properties:

| Property | Type | Status | Default | Description (English / عربي) |
| :--- | :---: | :---: | :---: | :--- |
| `icon` | `IconData` | **Required / إلزامي** | — | Icon displayed inside FAB. / أيقونة الزر العائم. |
| `onTap` | `VoidCallback` | **Required / إلزامي** | — | Tap callback. / دالة النقر على الزر. |
| `onLongPress` | `VoidCallback?` | Optional / اختياري | `null` | Long press callback with heavy haptics. / دالة الضغط المطول. |
| `size` | `double` | Optional / اختياري | `56.0` | FAB diameter size. / قطر الزر العائم. |
| `alignment` | `AlignmentGeometry` | Optional / اختياري | `centerEnd` | Automatic RTL / LTR directional alignment. / محاذاة تلقائية مع اتجاه الشاشة. |
| `waterEffectColor` | `Color?` | Optional / اختياري | `Color(0xFF38BDF8)` | Color of water ripple effect on tap. / لون التفاعل المائي الدائري عند اللمس. |
| `bottomMargin` | `double` | Optional / اختياري | `12.0` | Space between FAB and bottom bar. / المسافة الفاصلة فوق الشريط السفلي. |

---

## 📄 License / الرخصة
Distributed under the **MIT License**. See `LICENSE` for more information.  
مرخصة تحت رخصة **MIT مفتوحة المصدر**.
