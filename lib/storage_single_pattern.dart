import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageSinglePattern {
  static final StorageSinglePattern _instance = StorageSinglePattern._internal();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  factory StorageSinglePattern() {
    return _instance;
  }

  // 构造函数私有化，防止被误创建
  StorageSinglePattern._internal();

  Future<String?> read(String key) {
    return storage.read(key: key);
  }

  Future<void> write(String key, String value) {
    return storage.write(key: key, value: value);
  }
}
// var storage = StorageSinglePattern();
// storage.write('key', 'value');
// storage.read('key').then((value) => print(value));
// var storage2 = StorageSinglePattern();
// identical(storage, storage2); // true