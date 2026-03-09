// lib/core/services/supabase_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static const _url = 'https://noprjkrspsarjxvvsuli.supabase.co';
  static const _anonKey = 'sb_publishable_OeK6kN5kZfS76SadnYGXng_CiuiQ7GP';

  static Future<void> initialize() async {
    await Supabase.initialize(url: _url, anonKey: _anonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
