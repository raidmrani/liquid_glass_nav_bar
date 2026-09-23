import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/nav_item.dart';

/// # NavBarItemWidget / زر التبويب الداخلي التفاعلي
/// 
/// ## English:
/// Internal interactive navigation item supporting scale spring animations,
/// dual active/inactive icon transitions, custom text styling, and badges.
/// 
/// ## العربية:
/// عنصر التبويب التفاعلي الداخلي، يدعم الحركات الفيزيائية المرنة عند اللمس،
/// والتبديل الانسيابي بين الأيقونة النشطة وغير النشطة، مع الشارات والخطوط المخصصة.
class NavBarItemWidget extends StatefulWidget {
  /// [EN] Navigation item configuration data.
  /// [AR] بيانات وخصائص التبويب.
  final LiquidGlassNavItem item;

  /// [EN] Indicates whether this tab is currently selected.
  /// [AR] يشير إلى ما إذا كان هذا التبويب محدداً ونشطاً حالياً.
  final bool isSelected;

  /// [EN] Color for active icon and text label.
  /// [AR] لون الأيقونة والنص في الحالة النشطة.
  final Color activeColor;

  /// [EN] Color for inactive icon and text label.
  /// [AR] لون الأيقونة والنص في الحالة غير النشطة.
  final Color inactiveColor;

  /// [EN] Custom text style for active state.
  /// [AR] نمط الخط المخصص عند التنشيط.
  final TextStyle? activeTextStyle;

  /// [EN] Custom text style for inactive state.
  /// [AR] نمط الخط المخصص في الحالة غير النشطة.
  final TextStyle? inactiveTextStyle;

  /// [EN] Size of the active icon.
  /// [AR] حجم الأيقونة في الحالة النشطة.
  final double activeIconSize;

  /// [EN] Size of the inactive icon.
  /// [AR] حجم الأيقونة في الحالة غير النشطة.
  final double inactiveIconSize;

  /// [EN] Whether haptic click feedback is enabled.
  /// [AR] تفعيل الاهتزاز اللمسي الخفيف عند النقر.
  final bool enableHaptics;

  /// [EN] Callback invoked when the user taps on this item.
  /// [AR] دالة تُستدعى عند نقر المستخدم على هذا التبويب.
  final VoidCallback onTap;

  const NavBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
    required this.activeIconSize,
    required this.inactiveIconSize,
    required this.enableHaptics,
    required this.onTap,
  });

  @override
  State<NavBarItemWidget> createState() => _NavBarItemWidgetState();
}

class _NavBarItemWidgetState extends State<NavBarItemWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final activeStyle = widget.activeTextStyle ??
        TextStyle(
          fontSize: 9.8,
          fontWeight: FontWeight.w700,
          color: widget.activeColor,
          fontFamily: 'sans-serif',
          letterSpacing: -0.2,
        );

    final inactiveStyle = widget.inactiveTextStyle ??
        TextStyle(
          fontSize: 8.4,
          fontWeight: FontWeight.w500,
          color: widget.inactiveColor,
          fontFamily: 'sans-serif',
          letterSpacing: -0.3,
        );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.enableHaptics) {
          HapticFeedback.selectionClick();
        }
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Center(
        child: AnimatedScale(
          scale: _isPressed ? 0.84 : (widget.isSelected ? 1.00 : 0.86),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: anim,
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: Icon(
                      widget.isSelected
                          ? widget.item.activeIcon
                          : widget.item.inactiveIcon,
                      key: ValueKey<bool>(widget.isSelected),
                      size: widget.isSelected
                          ? widget.activeIconSize
                          : widget.inactiveIconSize,
                      color: widget.isSelected
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                  ),
                  if (widget.item.badge != null)
                    Positioned(
                      top: -4,
                      right: -8,
                      child: widget.item.badge!,
                    ),
                ],
              ),
              const SizedBox(height: 1.5),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                style: widget.isSelected ? activeStyle : inactiveStyle,
                child: Text(
                  widget.item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
