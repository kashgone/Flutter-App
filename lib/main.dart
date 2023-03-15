import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('note_databox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
