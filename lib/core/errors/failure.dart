import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message: message);

  // معالجة أخطاء المصادقة (Firebase Auth)
  factory ServerFailure.fromAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return ServerFailure("البريد الإلكتروني مستخدم بالفعل");
      case 'invalid-email':
        return ServerFailure("بريد إلكتروني غير صالح");
      case 'operation-not-allowed':
        return ServerFailure("عملية غير مسموحة");
      case 'weak-password':
        return ServerFailure("كلمة المرور ضعيفة");
      case 'user-disabled':
        return ServerFailure("تم تعطيل هذا المستخدم");
      case 'user-not-found':
        return ServerFailure("لم يتم العثور على المستخدم");
      case 'wrong-password':
        return ServerFailure("كلمة المرور خاطئة");
      case 'invalid-credential':
        return ServerFailure("بيانات الاعتماد غير صالحة");
      case 'account-exists-with-different-credential':
        return ServerFailure("الحساب موجود ببيانات اعتماد مختلفة");
      case 'network-request-failed':
        return ServerFailure("فشل في الاتصال بالشبكة");
      case 'too-many-requests':
        return ServerFailure("تم إجراء طلبات كثيرة جداً، حاول لاحقاً");
      case 'invalid-verification-code':
        return ServerFailure("رمز التحقق غير صالح");
      case 'invalid-verification-id':
        return ServerFailure("معرف التحقق غير صالح");
      case 'quota-exceeded':
        return ServerFailure("تم تجاوز الحصة المسموحة");
      default:
        return ServerFailure("حدث خطأ غير متوقع: ${e.code}");
    }
  }

  // معالجة أخطاء الفايرستور (Firestore)
  factory ServerFailure.fromFirestore(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return ServerFailure("ليس لديك صلاحية للقيام بهذه العملية");
      case 'not-found':
        return ServerFailure("لم يتم العثور على المستند");
      case 'already-exists':
        return ServerFailure("المستند موجود بالفعل");
      case 'resource-exhausted':
        return ServerFailure("تم استنفاد الموارد، حاول لاحقاً");
      case 'failed-precondition':
        return ServerFailure("فشل في الشرط المسبق");
      case 'aborted':
        return ServerFailure("تم إلغاء العملية");
      case 'out-of-range':
        return ServerFailure("القيمة خارج النطاق المسموح");
      case 'unimplemented':
        return ServerFailure("هذه العملية غير مدعومة");
      case 'internal':
        return ServerFailure("خطأ داخلي في الخادم");
      case 'unavailable':
        return ServerFailure("الخدمة غير متاحة حالياً");
      case 'data-loss':
        return ServerFailure("فقدان في البيانات");
      case 'unauthenticated':
        return ServerFailure("يجب تسجيل الدخول أولاً");
      default:
        return ServerFailure("حدث خطأ في قاعدة البيانات: ${e.code}");
    }
  }
  factory ServerFailure.dromDio(Object e, StackTrace stackTrace) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
        case DioExceptionType.badCertificate:
          return ServerFailure("حدث خطاء في الاتصال");

        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          if (e.response?.data is Map) {
            return ServerFailure(e.response?.data["message"]?.toString() ?? "حدث خطأ غير متوقع");
          } else {
            return ServerFailure(e.response?.data?.toString() ?? "حدث خطأ غير متوقع");
          }
      }
    }
    return ServerFailure("حدث خطأ غير متوقع");
  }

  factory ServerFailure.handle(Object e, StackTrace stackTrace) {
    if (e is FirebaseAuthException) {
      return ServerFailure.fromAuth(e);
    } else if (e is FirebaseException) {
      return ServerFailure.fromFirestore(e);
    } else if (e is DioException) {
      return ServerFailure.dromDio(e, stackTrace);
    } else {
      return ServerFailure("حدث خطأ غير متوقع");
    }
  }
}
