import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluid_glass_nav_bar/fluid_glass_nav_bar.dart';

void main() {
  testWidgets('LiquidGlassNavBar renders items and handles tap', (WidgetTester tester) async {
    int tappedIndex = -1;

    final items = const [
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
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LiquidGlassNavBar(
            items: items,
            currentIndex: 0,
            onTap: (index) {
              tappedIndex = index;
            },
          ),
        ),
      ),
    );

    // Verify all titles are rendered
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('استكشف'), findsOneWidget);
    expect(find.text('الرسائل'), findsOneWidget);

    // Tap on the second item ('استكشف')
    await tester.tap(find.text('استكشف'));
    await tester.pump();

    // Verify tap callback was fired with correct index
    expect(tappedIndex, 1);
  });

  testWidgets('LiquidGlassFab triggers onTap callback', (WidgetTester tester) async {
    bool fabTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: LiquidGlassFab(
            icon: Icons.add_rounded,
            onTap: () {
              fabTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump();

    expect(fabTapped, isTrue);
  });
}
