import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/utils/validators.dart';
import 'package:minimart/features/auth/cubit/auth_cubit.dart';
import 'package:minimart/features/auth/pages/sign_up/sign_up_screen.dart';
import 'package:minimart/features/auth/widgets/auth_form.dart';
import 'package:minimart/features/auth/widgets/toggle_auth_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: "login".tr(),
      buttonText: "login".tr(),
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
      ],
      onSubmit: (controllers) async {
        context.read<AuthCubit>().login(
          controllers['email']!.text.trim(),
          controllers['password']!.text.trim(),
        );
      },
      linkBelow: ToggleAuthText(
        prefixText: "dontHaveAccount".tr(),
        linkText: "createAccount".tr(),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
        },
        linkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
