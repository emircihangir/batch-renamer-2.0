// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesList extends ChangeNotifier {
  final List<File> _files;

  FilesList({required List<File> initialValue}) : _files = List.from(initialValue);

  List<File> get files => _files;
  List<String> get fileNames {
    return _files
        .map(
          (e) => e.path.split("/").last,
        )
        .toList();
  }

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
    TextStyle listHeaderTextStyle = TextStyle(fontSize: 16, color: Colors.blue.shade600);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          tooltip: "Back",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              tooltip: "Save",
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Edit Names",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          const VerticalDivider(
            indent: 16,
            endIndent: 16,
          ),
          Consumer<FilesList>(
            builder: (context, value, child) {
              return Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: value.files.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          leading: Text(
                            "Original Name",
                            style: listHeaderTextStyle,
                          ),
                          trailing: Text("Resulting Name", style: listHeaderTextStyle),
                        );
                      } else {
                        return ListTile(
                          title: Text(value.fileNames[index - 1]),
                        );
                      }
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
