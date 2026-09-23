import 'package:flutter/widgets.dart';

/// # LiquidGlassNavItem / نموذج بيانات عنصر التبويب
/// 
/// ## English:
/// Represents a single item within the [LiquidGlassNavBar].
/// Contains configuration for icons, title, route, badges, and colors.
/// 
/// ## العربية:
/// يمثل عنصراً واحداً داخل شريط التنقل الزجاجي المائي [LiquidGlassNavBar].
/// يحتوي على تهيئة الأيقونات، العنوان، مسار الراوت، الشارات، والألوان.
class LiquidGlassNavItem {
  /// [EN] Icon displayed when the tab is active (filled/solid recommended).
  /// [AR] الأيقونة المعروضة عند تنشيط التبويب (يفضل نمط ممتلئ/Solid).
  final IconData activeIcon;

  /// [EN] Icon displayed when the tab is inactive (outline style recommended).
  /// [AR] الأيقونة المعروضة في الحالة غير النشطة (يفضل نمط مفرغ/Outline).
  final IconData inactiveIcon;

  /// [EN] Label text displayed beneath the icon.
  /// [AR] النص التوضيحي المعروض أسفل الأيقونة.
  final String title;

  /// [EN] Optional navigation route path associated with this tab.
  /// [AR] مسار راوت اختياري مقترن بهذا التبويب لتسهيل التنقل.
  final String? route;

  /// [EN] Optional badge widget rendered over the icon (e.g., indicator dot or counter).
  /// [AR] ويدجت شارة اختياري يظهر أعلى الأيقونة (مثل نقطة إشعار أو عداد).
  final Widget? badge;

  /// [EN] Optional active color override specifically for this tab item.
  /// [AR] لون مخصص اختياري للأيقونة النشطة لهذا التبويب بالتحديد.
  final Color? activeColor;

  const LiquidGlassNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.title,
    this.route,
    this.badge,
    this.activeColor,
  });
}
