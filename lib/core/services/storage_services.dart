// lib/core/services/storage_service.dart
import 'package:get_storage/get_storage.dart';

class StorageService {
  StorageService._();

  static final _box = GetStorage();

  // ── Keys ──
  static const _kFarmId = 'farm_id';
  static const _kFarmName = 'farm_name';
  static const _kProfileId = 'profile_id';
  static const _kAuthId = 'auth_id';
  static const _kRole = 'role';
  static const _kFullName = 'full_name';
  static const _kEmail = 'email';
  static const _kIsLoggedIn = 'is_logged_in';

  // ── Farm ──
  static void saveFarm({required int id, required String name}) {
    _box.write(_kFarmId, id);
    _box.write(_kFarmName, name);
  }

  static int? get farmId => _box.read<int>(_kFarmId);
  static String? get farmName => _box.read<String>(_kFarmName);
  static bool get hasFarm => farmId != null;

  // ── Session ──
  static void saveSession({
    required int profileId,
    required String authId,
    required String role,
    required String fullName,
    required String email,
  }) {
    _box.write(_kProfileId, profileId);
    _box.write(_kAuthId, authId);
    _box.write(_kRole, role);
    _box.write(_kFullName, fullName);
    _box.write(_kEmail, email);
    _box.write(_kIsLoggedIn, true);
  }

  static int? get profileId => _box.read<int>(_kProfileId);
  static String? get authId => _box.read<String>(_kAuthId);
  static String? get role => _box.read<String>(_kRole);
  static String? get fullName => _box.read<String>(_kFullName);
  static String? get email => _box.read<String>(_kEmail);
  static bool get isLoggedIn => _box.read<bool>(_kIsLoggedIn) ?? false;

  // ── Clear session only (keep farm) ──
  static void clearSession() {
    _box.remove(_kProfileId);
    _box.remove(_kAuthId);
    _box.remove(_kRole);
    _box.remove(_kFullName);
    _box.remove(_kEmail);
    _box.remove(_kIsLoggedIn);
  }

  // ── Clear everything (logout + farm reset) ──
  static void clearAll() => _box.erase();
}
