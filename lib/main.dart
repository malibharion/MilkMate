// lib/main.dart
import 'package:dairy_farm_app/core/services/supabase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init persistent storage
  await GetStorage.init();

  await SupabaseService.initialize();

  runApp(const MyApp());
}
