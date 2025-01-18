// ignore_for_file: avoid_print

import 'dart:io';
import 'package:batchrenamerv2/rename_files_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectFolderPage extends StatelessWidget {
  const SelectFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: InkWell(
            onTap: () async {
              FilePickerResult? selectedFiles = await FilePicker.platform.pickFiles(allowMultiple: true);

              if (selectedFiles != null) {
                List<File> files = selectedFiles.paths.map((path) => File(path!)).toList();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RenameFilesPage(initialValue: files)));
              }
            },
            child: SvgPicture.asset(
              "assets/select_folder_illustration.svg",
            ),
          ),
        ),
      ),
    );
  }
}
