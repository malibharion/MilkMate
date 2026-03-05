// lib/main.dart
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize any services here if needed (Supabase, Storage, etc.)
  // await SupabaseService.init();

  runApp(const MyApp());
}
