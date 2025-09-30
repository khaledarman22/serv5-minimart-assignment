import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/widgets/app_button.dart';
import 'package:minimart/core/widgets/app_dialogs.dart';
import 'package:minimart/core/widgets/app_text_field.dart';
import 'package:minimart/core/widgets/main_navigation.dart';
import 'package:minimart/features/auth/cubit/auth_cubit.dart';

class AuthForm extends StatefulWidget {
  final String title;
  final List<AuthField> fields;
  final String buttonText;
  final void Function(Map<String, TextEditingController>) onSubmit;
  final Widget? linkBelow;

  const AuthForm({
    super.key,
    required this.title,
    required this.fields,
    required this.buttonText,
    required this.onSubmit,
    this.linkBelow,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late Map<String, TextEditingController> _controllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllers = {for (var field in widget.fields) field.key: TextEditingController()};

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_controllers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: AppSizes.s40),
              Text(widget.title, style: AppTextStyles.titleLarge),
              SizedBox(height: AppSizes.s32),
              ...widget.fields.map(
                (field) => Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.s20),
                  child: AppTextField(
                    label: field.label,
                    hint: field.hint,
                    controller: _controllers[field.key],
                    keyboardType: field.keyboardType,
                    obscureText: field.obscureText,
                    prefixIcon: field.prefixIcon,
                    validator: field.validator,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.s32),
              SizedBox(
                width: double.infinity,
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      AppDialogs.showLoading(context);
                    } else if (state is AuthError) {
                      AppDialogs.hideLoading(context);
                      AppDialogs.showError(context, message: state.error.message);
                    } else if (state is AuthLoggedIn) {
                      AppDialogs.hideLoading(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => MainNavigation()),
                      );
                    } else if (state is AuthRegistered) {
                      AppDialogs.hideLoading(context);
                    }
                  },
                  child: AppButton(onPressed: _submit, label: widget.buttonText),
                ),
              ),
              if (widget.linkBelow != null) ...[SizedBox(height: AppSizes.s20), widget.linkBelow!],
            ],
          ),
        ),
      ),
    );
  }
}

class AuthField {
  final String key;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  AuthField({
    required this.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
  });
}
