import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

/// This method initializes macos_window_utils and styles the window.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> main() async {
  await _configureMacosWindowUtils();
  runApp(const MyApp());
}

class FileListModel extends ChangeNotifier {
  List<File> _files = [];

  set files(List<File> newValue) {
    _files = List.from(newValue);
    notifyListeners();
  }

  List<File> get files => _files;

  List<String> get fileNames {
    return _files
        .map(
          (e) => e.path.split("/").last,
        )
        .toList();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      debugShowCheckedModeBanner: false,
      home: MacosWindow(
        child: ChangeNotifierProvider(
            create: (context) => FileListModel(),
            builder: (context, child) {
              return MacosScaffold(
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
                          if (context.mounted) Provider.of<FileListModel>(context, listen: false).files = files;
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
                              maxSize: MediaQuery.of(context).size.width * 0.7,
                              resizableSide: ResizableSide.right,
                              startSize: MediaQuery.of(context).size.width * 0.5),
                          Expanded(
                            child: Consumer<FileListModel>(
                              builder: (context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: value.files.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Original Name",
                                                style: MacosTheme.of(context).typography.title3,
                                              ),
                                              Text(
                                                "Resulting Name",
                                                style: MacosTheme.of(context).typography.title3,
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(color: (index % 2 == 1) ? const Color.fromARGB(15, 255, 255, 255) : Colors.transparent, borderRadius: const BorderRadius.all(Radius.circular(5))),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    value.fileNames[index - 1],
                                                    style: MacosTheme.of(context).typography.body,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    value.fileNames[index - 1],
                                                    style: MacosTheme.of(context).typography.body,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              );
            }),
      ),
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
