import 'package:hive_flutter/adapters.dart';
import 'package:masrofatak/core/helpers/hive_helper/adapters.dart';

abstract class HiveHelper {
  static late final Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    await registerAdapters();
    box = await Hive.openBox(HiveConstants.box);
  }

  static Future<void> registerAdapters() async {
    for (final adapter in HiveAdapters.adapters) {
      Hive.registerAdapter(adapter);
    }
  }

  static bool isContainesKey(String key) {
    return box.containsKey(key);
  }

  static Future<void> putData<T>(
      {required String key, required T value}) async {
    await box.put(key, value);
  }

  static Future<dynamic> getData({required String key}) async {
    return box.get(key);
  }
}

abstract class HiveConstants {
  static const box = 'box';
  static const categories = 'categories';
}
