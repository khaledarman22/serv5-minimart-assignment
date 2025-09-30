import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/cach_helper/cache_boxs.dart';
import 'package:minimart/core/cach_helper/cache_helper.dart';
import 'package:minimart/core/cach_helper/cache_keys.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/widgets/main_navigation.dart';
import 'package:minimart/features/auth/pages/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _checkLogin());
      }
    });

    _controller.forward();
  }

  void _checkLogin() async {
    await CacheHelper.initBox(CacheBoxs.authBox);

    final isLoggedIn = CacheHelper.get<bool>(boxName: CacheBoxs.authBox, key: CacheKeys.isLoggedIn);
    if (!mounted) return;
    if (isLoggedIn == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNavigation()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: AppSizes.s120,
                width: AppSizes.s120,

                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.white, size: AppSizes.icon50),
              ),
            ),
            const SizedBox(height: AppSizes.s16),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text("welcome".tr(), style: AppTextStyles.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}
