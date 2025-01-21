import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

/// This method initializes macos_window_utils and styles the window.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> main() async {
  await _configureMacosWindowUtils();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      debugShowCheckedModeBanner: false,
      home: MacosWindow(
        child: MacosScaffold(
          toolBar: ToolBar(
            title: const Text("Batch Renamer"),
            centerTitle: true,
            actions: [
              ToolBarIconButton(
                label: "Select Files",
                tooltipMessage: "Select Files",
                icon: const MacosIcon(CupertinoIcons.folder_badge_plus),
                showLabel: false,
                onPressed: () async {
                  FilePickerResult? selectedFiles = await FilePicker.platform.pickFiles(allowMultiple: true);
                  if (selectedFiles != null) {
                    List<File> files = selectedFiles.paths.map((path) => File(path!)).toList();
                    //* Files are selected.
                  }
                },
              )
            ],
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Row(
                  children: [
                    ResizablePane(
                        builder: (context, scrollController) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Edit Names",
                              style: MacosTheme.of(context).typography.title2,
                            ),
                          );
                        },
                        minSize: 200,
                        resizableSide: ResizableSide.right,
                        startSize: 500),
                  ],
                );
              },
            )
          ],
        ),
      ),
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
