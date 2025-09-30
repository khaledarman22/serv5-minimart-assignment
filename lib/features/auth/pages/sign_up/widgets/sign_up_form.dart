import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/utils/validators.dart';
import 'package:minimart/features/auth/cubit/auth_cubit.dart';
import 'package:minimart/features/auth/widgets/auth_form.dart';
import 'package:minimart/features/auth/widgets/toggle_auth_text.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: "signup".tr(),
      buttonText: "signup".tr(),
      fields: [
        AuthField(
          key: 'email',
          label: "email".tr(),
          hint: "email".tr(),
          prefixIcon: const Icon(Icons.email),
          validator: Validators.email,
        ),
        AuthField(
          key: 'password',
          label: "password".tr(),
          hint: "password".tr(),
          prefixIcon: const Icon(Icons.lock),
          obscureText: true,
          validator: Validators.password,
        ),
        AuthField(
          key: 'confirmPassword',
          label: "confirmPassword".tr(),
          hint: "confirmPassword".tr(),
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: true,
          validator: Validators.password,
        ),
      ],
      onSubmit: (controllers) {
        if (controllers['password']!.text != controllers['confirmPassword']!.text) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
          return;
        }
        context.read<AuthCubit>().registerUser(
          controllers['email']!.text,
          controllers['password']!.text,
        );
      },
      linkBelow: ToggleAuthText(
        prefixText: "alreadyHaveAccount".tr(),
        linkText: "login".tr(),
        onTap: () => Navigator.pop(context),
        linkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
