import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/themes/cubit/theme_cubit.dart';
import 'package:minimart/features/auth/cubit/auth_cubit.dart';
import 'package:minimart/features/auth/pages/login/login_screen.dart';
import 'package:minimart/service_locator.dart';

class HomeAppBar extends StatelessWidget {
  final bool showBackToTop;
  final String selectedCategory;

  const HomeAppBar({super.key, required this.showBackToTop, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: kToolbarHeight,
      backgroundColor: AppColors.primaryLight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            showBackToTop ? selectedCategory : '',
            key: ValueKey(showBackToTop ? selectedCategory : 'empty'),
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.white),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () async{
          AuthCubit().logout();
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
        },
        icon: const Icon(Icons.login_outlined, color: AppColors.white),
      ),
      actions: [
        IconButton(
          onPressed: () {
            sl<ThemeCubit>().toggleTheme();
          },
          icon: const Icon(Icons.brightness_6, color: AppColors.white),
        ),
        IconButton(
          onPressed: () {
            context.setLocale(
              context.locale == const Locale('en') ? const Locale('ar') : const Locale('en'),
            );
          },
          icon: Row(
            children: [
              const Icon(Icons.language, color: AppColors.white),
              const SizedBox(width: 4),
              Text(
                context.locale == const Locale('ar') ? 'English' : 'العربيه',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
