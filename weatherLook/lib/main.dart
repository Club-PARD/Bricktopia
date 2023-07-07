import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_summary/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('ko_KR', null).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

Future<void> initializeFirebase() async {
  await FirebaseFirestore.instance.enablePersistence();
}
