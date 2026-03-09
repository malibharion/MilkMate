// lib/core/services/auth_service.dart
import 'package:dairy_farm_app/core/services/storage_services.dart';
import 'package:dairy_farm_app/core/services/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static SupabaseClient get _db => SupabaseService.client;

  // ────────────────────────────────────────────
  // FARM LOOKUP
  // Called on Farm Screen — user types farm name
  // Returns true and saves farm_id if found
  // ────────────────────────────────────────────
  static Future<({bool found, String? error})> lookupFarm(
    String farmName,
  ) async {
    try {
      final trimmed = farmName.trim();
      if (trimmed.isEmpty)
        return (found: false, error: 'Please enter farm name');

      final res = await _db
          .from('farms')
          .select('id, name, is_active')
          .ilike('name', trimmed)
          .maybeSingle();

      if (res == null) {
        return (found: false, error: 'Farm not found. Contact your owner.');
      }

      if (res['is_active'] == false) {
        return (
          found: false,
          error: 'This farm is inactive. Contact your owner.',
        );
      }

      StorageService.saveFarm(
        id: res['id'] as int,
        name: res['name'] as String,
      );

      return (found: true, error: null);
    } catch (e) {
      return (found: false, error: 'Connection error. Try again.');
    }
  }

  static Future<({bool success, String? error, String? role})> login({
    required String email,
    required String password,
  }) async {
    try {
      final trimmedEmail = email.trim().toLowerCase();

      // Step 1 — Supabase Auth sign in
      final authRes = await _db.auth.signInWithPassword(
        email: trimmedEmail,
        password: password,
      );

      if (authRes.user == null) {
        return (
          success: false,
          error: 'Invalid email or password.',
          role: null,
        );
      }

      final authId = authRes.user!.id;

      // Step 2 — fetch profile
      final profile = await _db
          .from('profiles')
          .select('id, farm_id, full_name, email, role, status')
          .eq('auth_id', authId)
          .maybeSingle();

      if (profile == null) {
        await _db.auth.signOut();
        return (
          success: false,
          error: 'Profile not found. Contact your owner.',
          role: null,
        );
      }

      // Step 3 — check farm matches
      final savedFarmId = StorageService.farmId;
      if (profile['farm_id'] != savedFarmId) {
        await _db.auth.signOut();
        return (
          success: false,
          error: 'You do not belong to this farm.',
          role: null,
        );
      }

      // Step 4 — check approval
      if (profile['status'] != 'approved') {
        await _db.auth.signOut();
        return (
          success: false,
          error: 'Your account is pending approval.',
          role: null,
        );
      }

      // Step 5 — save session
      StorageService.saveSession(
        profileId: profile['id'] as int,
        authId: authId,
        role: profile['role'] as String,
        fullName: profile['full_name'] as String,
        email: profile['email'] as String,
      );

      return (success: true, error: null, role: profile['role'] as String);
    } on AuthException catch (e) {
      return (success: false, error: e.message, role: null);
    } catch (e) {
      return (
        success: false,
        error: 'Connection error. Try again.',
        role: null,
      );
    }
  }

  // ────────────────────────────────────────────
  // LOGOUT
  // ────────────────────────────────────────────
  static Future<void> logout() async {
    await _db.auth.signOut();
    StorageService.clearAll();
  }
}
