import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class AppDialogs {
  /// ===== Loading Dialog =====
  static void showLoading(BuildContext context, {Color? color}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: color ?? AppColors.primaryLight),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// ===== Error Dialog =====
  static void showError(
    BuildContext context, {
    required String message,
    VoidCallback? onRetry,
    bool showRetry = true,
  }) {
    _showDialog(
      context,
      title: "خطأ",
      icon: Icons.error_outline,
      iconColor: Colors.red,
      message: message,
      actions: [
        if (showRetry && onRetry != null)
          _DialogButton(
            text: "إعادة المحاولة",
            onPressed: onRetry,
          ),
      ],
    );
  }

  /// ===== Success Dialog =====
  static void showSuccess(
    BuildContext context, {
    required String message,
    VoidCallback? onOk,
    String okText = "تم",
  }) {
    _showDialog(
      context,
      title: "نجاح",
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      message: message,
      actions: [
        _DialogButton(
          text: okText,
          onPressed: onOk,
        ),
      ],
    );
  }

  /// ===== Private Generic Dialog Builder =====
  static void _showDialog(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required String message,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r16),
          ),
          titlePadding: const EdgeInsets.only(top: AppSizes.s12, left: AppSizes.s12, right: AppSizes.s12),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.s20, vertical: AppSizes.s12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: AppSizes.s8),
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(color: iconColor),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondaryLight),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: "إغلاق",
              ),
            ],
          ),
          content: Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: AppSizes.s12, vertical: AppSizes.s8),
          actions: actions ?? [],
        );
      },
    );
  }
}

/// ===== Custom Dialog Button =====
class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _DialogButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressed != null) onPressed!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        padding: AppSizes.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r12)),
        textStyle: AppTextStyles.button,
      ),
      child: Text(text),
    );
  }
}
