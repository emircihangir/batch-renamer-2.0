import 'package:flutter/material.dart';

//* Pages
import 'select_folder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, appBarTheme: AppBarTheme(backgroundColor: Colors.white, surfaceTintColor: Colors.blue.shade200, iconTheme: IconThemeData(color: Colors.blue))),
      debugShowCheckedModeBanner: false,
      home: const SelectFolderPage(),
    );
  }
}
