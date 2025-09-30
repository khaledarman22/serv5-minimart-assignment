import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/cach_helper/cache_boxs.dart';
import 'package:minimart/core/cach_helper/cache_helper.dart';
import 'package:minimart/core/cach_helper/cache_keys.dart';
import 'package:minimart/core/errors/failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  // ---------- Login ----------
  void login(String email, String password) async {
    emit(AuthLoading());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          debugPrint('User logged in: ${value.user?.uid}');
          await CacheHelper.save(
            boxName: CacheBoxs.authBox,
            key: CacheKeys.isLoggedIn,
            value: true,
          );
          emit(AuthLoggedIn());
        })
        .catchError((error, stacktrace) {
          emit(AuthError(ServerFailure.handle(error, stacktrace)));
        });
  }

  // ---------- Register ----------
  void registerUser(String email, String password) async {
    emit(AuthLoading());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((credential) {
          print('User registered: ${credential.user?.uid}');
          emit(AuthRegistered());
        })
        .catchError((error, stacktrace) {
          emit(AuthError(ServerFailure.handle(error, stacktrace)));
        });
  }

  // ---------- Logout ----------
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await CacheHelper.save(
        boxName: CacheBoxs.authBox,
        key: CacheKeys.isLoggedIn,
        value: false,
      );
    } catch (e) {
      // ignore
    }
  }
}
