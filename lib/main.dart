import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Googlesheetcode/gsheet.dart';
import 'Database/synctoserver.dart';
import 'Screens/Home_page.dart';

void main() {
  runApp(const MyApp());
 Site1.init();
 Site2.init();
 Site3.init();
 Site4.init();
 Site5.init();
 Site6.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_)=>SynctoServer())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage()
      ),
    );
  }
}

