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
            onTap: () {},
            child: SvgPicture.asset(
              "assets/select_folder_illustration.svg",
            ),
          ),
        ),
      ),
    );
  }
}
