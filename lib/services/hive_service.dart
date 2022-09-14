import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveKeys {
  static const BOX = "my_note";
  static const AUTH_EMAIL = "auth_email";
  static const NOTES = "notes";
  static const AUTH_PASSWORD = "auth_password";
  static const AUTH_TOKEN = "auth_token";
  static const AUTH_BIOMETRIC = "auth_biometric";
  static const AUTH_ASK_BIOMETRIC = "auth_ask_biometric";
}

class HiveService {
  Box? _box;

  Future<void> assertBox() async {
    if (_box != null && (_box?.isOpen ?? false)) return;
    return await init();
  }

  Future<String?> getEmail() async {
    await assertBox();
    return await _box?.get(HiveKeys.AUTH_EMAIL);
  }

  Future<String?> getPassword() async {
    await assertBox();
    return await _box?.get(HiveKeys.AUTH_PASSWORD);
  }

  Future<String?> getToken() async {
    await assertBox();
    return await _box?.get(HiveKeys.AUTH_TOKEN);
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive..init(dir.path);
    await Hive.openBox(HiveKeys.BOX).then((b) => _box = b);
  }

  Future<void> logout({bool reset = false}) async {
    await assertBox();
    await _box?.delete(HiveKeys.AUTH_TOKEN);
    if (reset) {
      await _box?.delete(HiveKeys.AUTH_PASSWORD);
    }
  }

  Future<void> setBioAuth(bool status) async {
    await assertBox();
    return await _box?.put(HiveKeys.AUTH_BIOMETRIC, status);
  }

  Future<void> setBioAuthReminder(bool ask) async {
    await assertBox();
    return await _box?.put(HiveKeys.AUTH_ASK_BIOMETRIC, ask);
  }

  Future<void> setEmail(String email) async {
    await assertBox();
    return await _box?.put(HiveKeys.AUTH_EMAIL, email);
  }

  Future<void> setLoginCredentials(String email, {String? password}) async {
    await assertBox();
    if (password != null) await _box?.put(HiveKeys.AUTH_PASSWORD, password);
    return await _box?.put(HiveKeys.AUTH_EMAIL, email);
  }

  Future<void> setToken(String token) async {
    await assertBox();
    return await _box?.put(HiveKeys.AUTH_TOKEN, token);
  }

  Future<void> saveNotes(String notes) async {
    await assertBox();
    return await _box?.put(HiveKeys.NOTES, notes);
  }

  Future<String> readNotes() async {
    await assertBox();
    return await _box?.get(HiveKeys.NOTES);
  }
}
