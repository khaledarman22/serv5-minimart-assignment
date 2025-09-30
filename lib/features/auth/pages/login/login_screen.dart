import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/features/auth/cubit/auth_cubit.dart';
import 'package:minimart/features/auth/pages/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.s16),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
