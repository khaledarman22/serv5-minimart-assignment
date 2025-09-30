import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final bool showBackToTop;
  final ValueChanged<String> onSelected;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.showBackToTop,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: showBackToTop ? 0 : 50,
        child: showBackToTop
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.s8),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final selected = category == selectedCategory;
                      return GestureDetector(
                        onTap: () => onSelected(category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: selected
                                ? LinearGradient(
                                    colors: [AppColors.primaryLight, AppColors.secondaryLight],
                                  )
                                : LinearGradient(
                                    colors: [AppColors.surfaceLight, AppColors.surfaceLight],
                                  ),
                            borderRadius: BorderRadius.circular(AppSizes.r20),
                            boxShadow: selected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryLight.withOpacity(0.3),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: selected ? AppColors.white : AppColors.textPrimaryLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
