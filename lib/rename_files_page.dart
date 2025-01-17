// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesList extends ChangeNotifier {
  List<String> _files = [];

  List<String> get files => _files;

  /// p: parameter. example value = [[file_index, new_value], [file_index, new_value]]
  void editFileNames(List<List<dynamic>> p) {
    //* Edit file names.
    notifyListeners();
  }
}

class RenameFilesPage extends StatelessWidget {
  const RenameFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => FilesList());
  }
}
