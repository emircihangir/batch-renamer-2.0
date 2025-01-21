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
            actions: [
              ToolBarIconButton(
                label: "Select Files",
                tooltipMessage: "Select Files",
                icon: const MacosIcon(CupertinoIcons.folder_badge_plus),
                showLabel: false,
                onPressed: () {},
              )
            ],
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Text("asd");
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
