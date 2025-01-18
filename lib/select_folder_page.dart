// ignore_for_file: avoid_print

import 'dart:io';
import 'package:batchrenamerv2/rename_files_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macos_ui/macos_ui.dart';

class SelectFolderPage extends StatelessWidget {
  const SelectFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      child: Center(
        child: PushButton(
            secondary: true,
            controlSize: ControlSize.large,
            onPressed: () async {
              FilePickerResult? selectedFiles = await FilePicker.platform.pickFiles(allowMultiple: true);

              if (selectedFiles != null) {
                List<File> files = selectedFiles.paths.map((path) => File(path!)).toList();
                if (context.mounted) Navigator.of(context).push(MaterialPageRoute(builder: (context) => RenameFilesPage(initialValue: files)));
              }
            },
            child: const Text("Select Files")),
      ),
    );
  }
}
