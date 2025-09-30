import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';

class HomeSearchBar extends StatelessWidget {
  final bool showBackToTop;
  final String searchQuery;
  final ValueChanged<String> onChanged;

  const HomeSearchBar({
    super.key,
    required this.showBackToTop,
    required this.searchQuery,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: showBackToTop ? 0 : 60,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12, vertical: AppSizes.s8),
        child: showBackToTop
            ? null
            : TextField(
                decoration: InputDecoration(
                  hintText: 'searchPlaceholder'.tr(),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
                ),
                onChanged: onChanged,
              ),
      ),
    );
  }
}
