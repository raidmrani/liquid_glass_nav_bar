import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// # LiquidGlassFab / الزر العائم الزجاجي التفاعلي
/// 
/// ## English:
/// A companion floating action button designed to sit seamlessly above the bottom
/// navigation bar. Features elastic squish-and-stretch fluid feedback, specular
/// glass blur, radial water ripple on touch, and automatic directional alignment (RTL/LTR).
/// 
/// ## العربية:
/// زر عمل عائم مصاحب ومصمم ليعلو شريط التنقل السفلي بتناغم تام.
/// يتميز بفيزياء التمدد والانضغاط المائي، البلور الزجاجي العاكس، وتأثير التموج
/// المائي المشع عند اللمس، مع محاذاة اتجاهية ذكية تلقائياً (RTL / LTR).
class LiquidGlassFab extends StatefulWidget {
  /// [EN] Icon displayed within the button.
  /// [AR] رمز الأيقونة بداخل الزر.
  final IconData icon;

  /// [EN] Tap callback action.
  /// [AR] دالة استدعاء عند النقر على الزر.
  final VoidCallback onTap;

  /// [EN] Optional long-press callback action with heavier haptics.
  /// [AR] دالة اختيارية عند الضغط المطول مصحوبة باهتزاز لمسي أعمق.
  final VoidCallback? onLongPress;

  /// [EN] Diameter size of the button (defaults to 56.0).
  /// [AR] قطر الزر العائم (افتراضياً: 56.0).
  final double size;

  /// [EN] Optional custom solid background color.
  /// [AR] لون خلفية صلب اختياري مخصص.
  final Color? backgroundColor;

  /// [EN] Optional custom gradient decoration.
  /// [AR] تدرج لوني مخصص للخلفية الزجاجية.
  final Gradient? gradient;

  /// [EN] Optional glass specular border color.
  /// [AR] لون إطار الزجاج العاكس الخارجي.
  final Color? borderColor;

  /// [EN] Optional icon color (adapts to contrast by default).
  /// [AR] لون مخصص للأيقونة (يتبع التباين افتراضياً).
  final Color? iconColor;

  /// [EN] Optional glowing water ripple color on tap.
  /// [AR] لون التوهج المائي الدائري عند اللمس.
  final Color? waterEffectColor;

  /// [EN] Horizontal alignment relative to the bar (defaults to [AlignmentDirectional.centerEnd]).
  /// [AR] الموضع والمحاذاة بالنسبة للشريط (افتراضياً: AlignmentDirectional.centerEnd ليتوافق مع اتجاه الشاشة RTL/LTR).
  final AlignmentGeometry alignment;

  /// [EN] Reference bottom bar width used to calculate boundaries (defaults to 352.0).
  /// [AR] عرض الشريط المرجعي لضبط حدود ومحاذاة الزر (افتراضياً: 352.0).
  final double? barWidth;

  /// [EN] Separation gap margin between FAB and the navigation bar (defaults to 12.0).
  /// [AR] المسافة الفاصلة بين الزر وشريط التنقل السفلي (افتراضياً: 12.0).
  final double bottomMargin;

  /// [EN] Optional tooltip string for accessibility.
  /// [AR] نص التلميح التوضيحي السريع (Tooltip).
  final String? tooltip;

  /// [EN] Whether tactile haptic feedback is triggered on interaction.
  /// [AR] تفعيل الاهتزاز الفيزيائي عند لمس أو ضغط الزر.
  final bool enableHaptics;

  const LiquidGlassFab({
    super.key,
    required this.icon,
    required this.onTap,
    this.onLongPress,
    this.size = 56.0,
    this.backgroundColor,
    this.gradient,
    this.borderColor,
    this.iconColor,
    this.waterEffectColor,
    this.alignment = AlignmentDirectional.centerEnd,
    this.barWidth,
    this.bottomMargin = 12.0,
    this.tooltip,
    this.enableHaptics = true,
  });

  @override
  State<LiquidGlassFab> createState() => _LiquidGlassFabState();
}

class _LiquidGlassFabState extends State<LiquidGlassFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _physicsController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _waterRippleAnimation;

  @override
  void initState() {
    super.initState();
    _physicsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.88)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.88, end: 1.12)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.12, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 25,
      ),
    ]).animate(_physicsController);

    _waterRippleAnimation = CurvedAnimation(
      parent: _physicsController,
      curve: Curves.easeOutQuad,
    );
  }

  @override
  void dispose() {
    _physicsController.dispose();
    super.dispose();
  }

  void _triggerWaterPhysics() {
    if (widget.enableHaptics) {
      HapticFeedback.mediumImpact();
    }
    _physicsController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double effectiveBarWidth =
        widget.barWidth ?? (screenWidth < 380 ? screenWidth - 32 : 352.0);

    return Container(
      width: effectiveBarWidth,
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      alignment: widget.alignment,
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: AnimatedBuilder(
          animation: _physicsController,
          builder: (context, child) {
            final double scale = _scaleAnimation.value;
            final double waterProgress = _waterRippleAnimation.value;

            return Transform.scale(
              scale: scale,
              child: _buildFabBody(context, waterProgress),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFabBody(BuildContext context, double waterProgress) {
    final hasCustomBg = widget.backgroundColor != null;

    final defaultGradient = widget.gradient ??
        (hasCustomBg
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.88),
                  Colors.white.withValues(alpha: 0.65),
                ],
              ));

    final effectiveBorderColor = widget.borderColor ??
        (hasCustomBg
            ? Colors.white.withValues(alpha: 0.35)
            : Colors.white.withValues(alpha: 0.95));

    final effectiveWaterColor = widget.waterEffectColor ??
        (hasCustomBg
            ? Colors.white
            : const Color(0xFF38BDF8));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _triggerWaterPhysics(),
      onTap: widget.onTap,
      onLongPress: () {
        if (widget.enableHaptics) {
          HapticFeedback.heavyImpact();
        }
        _triggerWaterPhysics();
        widget.onLongPress?.call();
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E293B).withValues(alpha: 0.15),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: (widget.backgroundColor ?? Colors.white)
                  .withValues(alpha: 0.20),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: defaultGradient,
                border: Border.all(
                  width: 1.2 + (waterProgress * 0.5),
                  color: effectiveBorderColor,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (waterProgress > 0.05)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              effectiveWaterColor.withValues(
                                alpha: waterProgress * 0.45,
                              ),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  Icon(
                    widget.icon,
                    color: widget.iconColor ??
                        (hasCustomBg
                            ? Colors.white
                            : const Color(0xFF0F172A)),
                    size: widget.size * 0.46,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
