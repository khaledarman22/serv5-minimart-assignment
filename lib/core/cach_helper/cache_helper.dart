import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheHelper {
  static final Map<String, Box> _boxes = {};

  /// تهيئة Hive
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
    } catch (e, stack) {
      debugPrint("Error initializing Hive: $e\n$stack");
    }
  }

  /// تهيئة Hive وفتح Box
  static Future<void> initBox(String boxName) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _boxes[boxName] = await Hive.openBox(boxName);
      } else {
        _boxes[boxName] = Hive.box(boxName);
      }
    } catch (e, stack) {
      debugPrint("Error opening box '$boxName': $e\n$stack");
    }
  }

  /// حفظ قيمة في Box
  static Future<bool> save<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    try {
      final box = _boxes[boxName];
      if (box == null) throw Exception("Box '$boxName' not initialized");
      await box.put(key, value);
      return true;
    } catch (e, stack) {
      debugPrint("Error saving key '$key' in box '$boxName': $e\n$stack");
      return false;
    }
  }

  /// قراءة قيمة من Box
  static T? get<T>({required String boxName, required String key}) {
    try {
      final box = _boxes[boxName];
      if (box == null) throw Exception("Box '$boxName' not initialized");
      final value = box.get(key);
      if (value is T) return value;
      return null;
    } catch (e, stack) {
      debugPrint("Error getting key '$key' from box '$boxName': $e\n$stack");
      return null;
    }
  }

  /// حذف قيمة
  static Future<bool> remove({required String boxName, required String key}) async {
    try {
      final box = _boxes[boxName];
      if (box == null) throw Exception("Box '$boxName' not initialized");
      await box.delete(key);
      return true;
    } catch (e, stack) {
      debugPrint("Error deleting key '$key' from box '$boxName': $e\n$stack");
      return false;
    }
  }

  /// مسح Box كامل
  static Future<bool> clearBox(String boxName) async {
    try {
      final box = _boxes[boxName];
      if (box == null) throw Exception("Box '$boxName' not initialized");
      await box.clear();
      return true;
    } catch (e, stack) {
      debugPrint("Error clearing box '$boxName': $e\n$stack");
      return false;
    }
  }

  /// التحقق إذا Box مفتوح
  static bool isBoxOpen(String boxName) {
    try {
      final box = _boxes[boxName];
      return box?.isOpen ?? false;
    } catch (e, stack) {
      debugPrint("Error checking if box '$boxName' is open: $e\n$stack");
      return false;
    }
  }

  /// استرجاع كل القيم
  static List<T> getAll<T>({required String boxName}) {
    try {
      final box = _boxes[boxName];
      if (box == null) return [];
      return box.values.whereType<T>().toList();
    } catch (e, stack) {
      debugPrint("Error getting all values from box '$boxName': $e\n$stack");
      return [];
    }
  }

  /// Deep Search في Box
  static List<T> deepSearch<T>({
    required String boxName,
    required bool Function(T element) predicate,
  }) {
    final results = <T>[];
    try {
      final box = _boxes[boxName];
      if (box == null) return [];

      for (var value in box.values) {
        try {
          if (value is T) {
            if (predicate(value)) results.add(value);
          } else if (value is List<T>) {
            results.addAll(value.where(predicate));
          } else if (value is Map) {
            value.values.whereType<T>().forEach((e) {
              if (predicate(e)) results.add(e);
            });
          }
        } catch (inner) {
          debugPrint("Error processing value in deepSearch: $inner");
        }
      }
    } catch (e, stack) {
      debugPrint("Error in deepSearch for box '$boxName': $e\n$stack");
    }
    return results;
  }
}
