import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_nav_bar/liquid_glass_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liquid Glass Navigation Bar Example',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        fontFamily: 'sans-serif',
      ),
      home: const ExampleHomeScreen(),
    );
  }
}

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({super.key});

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  int _currentIndex = 0;

  final List<LiquidGlassNavItem> _items = const [
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
      activeIcon: Icons.notifications_rounded,
      inactiveIcon: Icons.notifications_outlined,
      title: 'الإشعارات',
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
      appBar: AppBar(
        title: const Text(
          'Liquid Glass Nav Bar',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                'التبويب النشط: ${_items[_currentIndex].title}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidGlassFab(
            icon: Icons.add_rounded,
            tooltip: 'إضافة',
            onTap: () {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم النقر على الزر العائم!'),
                  duration: Duration(milliseconds: 1200),
                ),
              );
            },
          ),
          LiquidGlassNavBar(
            items: _items,
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
