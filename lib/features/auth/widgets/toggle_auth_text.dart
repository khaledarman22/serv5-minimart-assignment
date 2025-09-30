import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class  ToggleAuthText extends StatelessWidget {
  final String prefixText;
  final String linkText;
  final VoidCallback onTap;
  final Color? linkColor;

  const  ToggleAuthText({
    super.key,
    required this.prefixText,
    required this.linkText,
    required this.onTap,
    this.linkColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = linkColor ?? Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixText, style: AppTextStyles.bodyMedium),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
