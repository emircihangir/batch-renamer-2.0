// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesList extends ChangeNotifier {
  final List<File> _files;

  FilesList({required List<File> initialValue}) : _files = List.from(initialValue);

  List<File> get files => _files;

  /// p: parameter. example value = [[file_index, new_value], [file_index, new_value]]
  void editFileNames(List<List<dynamic>> p) {
    //* Edit the file names.
    notifyListeners();
  }
}

class RenameFilesPage extends StatelessWidget {
  const RenameFilesPage({super.key, required this.initialValue});
  final List<File> initialValue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilesList(initialValue: initialValue),
      child: _RenameFilePage(),
    );
  }
}

class _RenameFilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FilesList>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.files.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value.files[index].path),
                );
              });
        },
      ),
    );
  }
}
