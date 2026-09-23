import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/nav_item.dart';
import 'widgets/nav_bar_item.dart';

/// # LiquidGlassNavBar / شريط التنقل الزجاجي المائي
/// 
/// ## English:
/// A luxury modern liquid glass bottom navigation bar with gooey water physics.
/// 
/// ### Tab Capacity Specifications:
/// - **Full Capacity:** Supports **2 to 10 tabs** with zero crashes, mathematically guarded against division-by-zero (`safeDivisor`).
/// - **Recommended:** **4 to 7 tabs** for optimal legibility and touch targets.
/// - **Optimal Standard:** **5 tabs** for the finest balance of liquid dynamics and visual prestige.
/// 
/// ## العربية:
/// شريط تنقل سفلي زجاجي مائي فاخر بتأثيرات السوائل المرنة واللزوجة المائية.
/// 
/// ### مواصفات سعة التبويبات الهندسية:
/// - **المدى المدعوم كلياً:** يستقبل من **2 إلى 10 تبويبات** بثبات برمجي فائق دون أي انهيار، ومحصن رياضياً ضد القسمة على صفر (`safeDivisor`).
/// - **المدى المفضل بصرياً وظيفياً:** من **4 إلى 7 تبويبات** لوضوح مثالي ومساحة لمس مريحة.
/// - **الرقم الذهبي المثالي:** **5 تبويبات** للانسجام الكامل بين الفخامة وحجم الكبسولة المائية.
class LiquidGlassNavBar extends StatefulWidget {
  /// [EN] List of navigation tab items (supports 2 to 10 tabs, optimal: 5).
  /// [AR] قائمة التبويبات (تدعم من 2 إلى 10 تبويبات، والأمثل: 5).
  final List<LiquidGlassNavItem> items;

  /// [EN] Index of the currently active tab.
  /// [AR] مؤشر ورقم التبويب النشط حالياً.
  final int currentIndex;

  /// [EN] Callback invoked upon tapping or releasing a tab.
  /// [AR] دالة تُستدعى عند الضغط أو رفع الإصبع على أي تبويب.
  final ValueChanged<int> onTap;

  /// [EN] Optional continuous callback during interactive drag with fractional progress.
  /// [AR] دالة اختيارية تُستدعى أثناء السحب المباشر مع قيمة التقدم الكسري.
  final ValueChanged<double>? onDragUpdate;

  /// [EN] Overall bar width (defaults to 352.0 or adapts to small screens).
  /// [AR] العرض الإجمالي للشريط (افتراضياً: 352.0 أو متكيف مع الشاشات الصغيرة).
  final double? width;

  /// [EN] Height of the navigation bar (defaults to 60.0).
  /// [AR] ارتفاع الشريط (افتراضياً: 60.0 للرشاقة والأناقة).
  final double height;

  /// [EN] Outer corner border radius (defaults to BorderRadius.circular(30)).
  /// [AR] نصف قطر استدارة الحواف الخارجية (افتراضياً: 30.0).
  final BorderRadiusGeometry? borderRadius;

  /// [EN] BackdropFilter gaussian blur sigma intensity (defaults to 25.0).
  /// [AR] درجة ضبابية الزجاج الخلفي البلوري (افتراضياً: 25.0).
  final double blurSigma;

  /// [EN] Glass background gradient for the bar container.
  /// [AR] تدرج خلفية الزجاج للشريط.
  final Gradient? backgroundGradient;

  /// [EN] Outer glass border color.
  /// [AR] لون إطار الزجاج الخارجي للشريط.
  final Color? borderColor;

  /// [EN] Outer glass border thickness (defaults to 1.2).
  /// [AR] سمك إطار الشريط الخارجي (افتراضياً: 1.2).
  final double borderWidth;

  /// [EN] Outer shadows rendered beneath the glass bar.
  /// [AR] ظلال الشريط الخارجية العميقة والناعمة.
  final List<BoxShadow>? shadows;

  /// [EN] Internal padding within the bar.
  /// [AR] الحشو الداخلي للشريط.
  final EdgeInsetsGeometry padding;

  /// [EN] Gradient of the animated gooey water droplet capsule.
  /// [AR] تدرج كبسولة قطرة الماء المتحركة.
  final Gradient? dropletGradient;

  /// [EN] Border color of the water droplet capsule.
  /// [AR] لون إطار كبسولة قطرة الماء.
  final Color? dropletBorderColor;

  /// [EN] Border thickness of the water droplet capsule (defaults to 1.1).
  /// [AR] سمك إطار كبسولة قطرة الماء (افتراضياً: 1.1).
  final double dropletBorderWidth;

  /// [EN] Box shadows for the moving water droplet capsule.
  /// [AR] ظلال كبسولة قطرة الماء.
  final List<BoxShadow>? dropletShadows;

  /// [EN] Active state color for icon and text label (defaults to Color(0xFF0F172A)).
  /// [AR] لون الأيقونة والنص عند التنشيط (افتراضياً: Color(0xFF0F172A)).
  final Color? activeColor;

  /// [EN] Inactive state color for icon and text label (defaults to Color(0xFF64748B)).
  /// [AR] لون الأيقونة والنص في الحالة غير النشطة (افتراضياً: Color(0xFF64748B)).
  final Color? inactiveColor;

  /// [EN] Typography style for active tab title.
  /// [AR] نمط خط النص النشط.
  final TextStyle? activeTextStyle;

  /// [EN] Typography style for inactive tab title.
  /// [AR] نمط خط النص غير النشط.
  final TextStyle? inactiveTextStyle;

  /// [EN] Size of the active icon (defaults to 20.0).
  /// [AR] حجم الأيقونة النشطة (افتراضياً: 20.0).
  final double activeIconSize;

  /// [EN] Size of the inactive icon (defaults to 16.5).
  /// [AR] حجم الأيقونة غير النشطة (افتراضياً: 16.5).
  final double inactiveIconSize;

  /// [EN] Enables tactile haptic feedback on touch & snap (defaults to true).
  /// [AR] تفعيل الاهتزاز الفيزيائي اللمسي عند الضغط والاستقرار (افتراضياً: true).
  final bool enableHaptics;

  /// [EN] Enables dynamic gooey water wave deformation (defaults to true).
  /// [AR] تفعيل فيزياء السوائل واللزوجة المائية للقطرة (افتراضياً: true).
  final bool enableFluidPhysics;

  /// [EN] Enables interactive horizontal dragging on the bar (defaults to true).
  /// [AR] تفعيل السحب الأفقي المباشر على الشريط بالأصبع (افتراضياً: true).
  final bool enableDrag;

  const LiquidGlassNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.onDragUpdate,
    this.width,
    this.height = 60.0,
    this.borderRadius,
    this.blurSigma = 25.0,
    this.backgroundGradient,
    this.borderColor,
    this.borderWidth = 1.2,
    this.shadows,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
    this.dropletGradient,
    this.dropletBorderColor,
    this.dropletBorderWidth = 1.1,
    this.dropletShadows,
    this.activeColor,
    this.inactiveColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.activeIconSize = 20.0,
    this.inactiveIconSize = 16.5,
    this.enableHaptics = true,
    this.enableFluidPhysics = true,
    this.enableDrag = true,
  }) : assert(
          items.length >= 2 && items.length <= 10,
          'LiquidGlassNavBar supports between 2 and 10 items. Recommended: 4 to 7. Optimal: 5.',
        );

  @override
  State<LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<LiquidGlassNavBar> {
  late double _pageProgress;
  bool _isDragging = false;
  double _dragVelocity = 0.0;

  @override
  void initState() {
    super.initState();
    _pageProgress = widget.currentIndex.toDouble();
  }

  @override
  void didUpdateWidget(covariant LiquidGlassNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDragging && oldWidget.currentIndex != widget.currentIndex) {
      _pageProgress = widget.currentIndex.toDouble();
    }
  }

  void _onDragStart(DragStartDetails details, double effectiveWidth, bool isRtl) {
    if (!widget.enableDrag) return;
    _isDragging = true;
    _dragVelocity = 0.0;
    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }
    _handleDrag(details.localPosition.dx, effectiveWidth, isRtl);
  }

  void _onDragUpdate(DragUpdateDetails details, double effectiveWidth, bool isRtl) {
    if (!widget.enableDrag) return;
    _dragVelocity = (details.primaryDelta ?? 0.0).abs();
    _handleDrag(details.localPosition.dx, effectiveWidth, isRtl);
  }

  void _handleDrag(double localX, double effectiveWidth, bool isRtl) {
    final double normalizedX = isRtl ? (effectiveWidth - localX) : localX;
    final double itemWidth = effectiveWidth / widget.items.length;
    final double targetPage = ((normalizedX - (itemWidth / 2)) / itemWidth)
        .clamp(0.0, (widget.items.length - 1).toDouble());

    setState(() {
      _pageProgress = targetPage;
    });

    widget.onDragUpdate?.call(targetPage);
  }

  void _onDragEnd(DragEndDetails details, bool isRtl) {
    if (!widget.enableDrag) return;
    final double rawVx = details.primaryVelocity ?? 0.0;
    final double vx = isRtl ? -rawVx : rawVx;
    int targetIndex = _pageProgress.round();

    if (vx > 250) {
      targetIndex = (_pageProgress + 0.35).ceil();
    } else if (vx < -250) {
      targetIndex = (_pageProgress - 0.35).floor();
    }

    targetIndex = targetIndex.clamp(0, widget.items.length - 1);

    setState(() {
      _isDragging = false;
      _dragVelocity = 0.0;
      _pageProgress = targetIndex.toDouble();
    });

    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }

    widget.onTap(targetIndex);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double effectiveWidth =
        widget.width ?? (screenWidth < 380 ? screenWidth - 32 : 352.0);

    final safeRadius = widget.borderRadius ?? BorderRadius.circular(30);

    // [EN] Horizontal capsule alignment calculation with safe division-by-zero protection.
    // [AR] حساب موضع الكبسولة الأفقي مع حماية رياضية من القسمة على صفر.
    final int safeDivisor = math.max(1, widget.items.length - 1);
    final double targetAlignX =
        -1.0 + (_pageProgress * (2.0 / safeDivisor));

    // [EN] Fluid wave stretch and squish calculations.
    // [AR] حساب فيزياء اللزوجة وتمدد السوائل.
    double stretchX = 1.0;
    double squishY = 1.0;

    if (widget.enableFluidPhysics) {
      final double delta = (_pageProgress - _pageProgress.roundToDouble()).abs();
      final double fluidWave = math.sin(delta * math.pi);
      final double dynamicDragStretch =
          _isDragging ? (_dragVelocity * 0.08).clamp(0.0, 0.40) : 0.0;

      stretchX = 1.0 + (fluidWave * 0.36) + dynamicDragStretch;
      squishY = (1.0 - ((fluidWave * 0.12) + (dynamicDragStretch * 0.24)))
          .clamp(0.80, 1.0);
    }

    // [EN] Default luxury light glass gradients.
    // [AR] التدرجات الافتراضية النهارية الراقية.
    final effectiveBgGradient = widget.backgroundGradient ??
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.82),
            Colors.white.withValues(alpha: 0.58),
          ],
        );

    final effectiveDropletGradient = widget.dropletGradient ??
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.98),
            Colors.white.withValues(alpha: 0.78),
          ],
        );

    final effectiveShadows = widget.shadows ??
        [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 12),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ];

    final effectiveDropletShadows = widget.dropletShadows ??
        [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ];

    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (d) => _onDragStart(d, effectiveWidth, isRtl),
      onHorizontalDragUpdate: (d) => _onDragUpdate(d, effectiveWidth, isRtl),
      onHorizontalDragEnd: (d) => _onDragEnd(d, isRtl),
      child: Container(
        width: effectiveWidth,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: safeRadius,
          boxShadow: effectiveShadows,
        ),
        child: ClipRRect(
          borderRadius: safeRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                gradient: effectiveBgGradient,
                borderRadius: safeRadius,
                border: Border.all(
                  width: widget.borderWidth,
                  color: widget.borderColor ?? Colors.white.withValues(alpha: 0.95),
                ),
              ),
              child: Stack(
                children: [
                  // [EN] Specular animated gooey water droplet capsule with directional alignment (RTL/LTR).
                  // [AR] فقاعة قطرة الماء الزجاجية المنسابة بمحاذاة اتجاهية ذكية (RTL / LTR).
                  Align(
                    alignment: AlignmentDirectional(targetAlignX, 0.0),
                    child: FractionallySizedBox(
                      widthFactor: (1 / widget.items.length) * 1.04,
                      heightFactor: 0.92,
                      child: Transform.scale(
                        scaleX: stretchX,
                        scaleY: squishY,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: effectiveDropletGradient,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: widget.dropletBorderColor ?? Colors.white,
                              width: widget.dropletBorderWidth,
                            ),
                            boxShadow: effectiveDropletShadows,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // [EN] Navigation tab items row.
                  // [AR] صف أزرار التبويبات التفاعلية.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(widget.items.length, (index) {
                      final bool isSelected = (_isDragging
                              ? _pageProgress.round()
                              : widget.currentIndex) ==
                          index;

                      final item = widget.items[index];

                      return Expanded(
                        child: NavBarItemWidget(
                          item: item,
                          isSelected: isSelected,
                          activeColor: item.activeColor ??
                              widget.activeColor ??
                              const Color(0xFF0F172A),
                          inactiveColor: widget.inactiveColor ??
                              const Color(0xFF64748B),
                          activeTextStyle: widget.activeTextStyle,
                          inactiveTextStyle: widget.inactiveTextStyle,
                          activeIconSize: widget.activeIconSize,
                          inactiveIconSize: widget.inactiveIconSize,
                          enableHaptics: widget.enableHaptics,
                          onTap: () {
                            setState(() {
                              _pageProgress = index.toDouble();
                            });
                            widget.onTap(index);
                          },
                        ),
                      );
                    }),
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
