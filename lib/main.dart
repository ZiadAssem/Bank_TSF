import 'package:bank_tsf/Database/sampledb.dart';
import 'package:flutter/material.dart';
import 'srctwo/MyApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = DatabaseHelper.instance;
  print(await database.queryAllRows());
  runApp(MyApp());
}
