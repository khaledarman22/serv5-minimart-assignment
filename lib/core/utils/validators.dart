//TODO : add more validators and translations
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (value.length < 6) return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    return null;
  }
}
