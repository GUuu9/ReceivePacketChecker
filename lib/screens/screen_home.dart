import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../utils/util_set_windows.dart';
import '../widgets/wid_input_packet.dart';
import '../widgets/wid_load_file.dart';
import '../widgets/wid_option_select.dart';
import '../widgets/wid_show_result.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {

  @override
  void initState() {
    if(kIsWeb) {

    }
    else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      runWindowFunctions();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 23, 117, 91), //fromRGB(23, 117, 91, ),

        // appBar: titleAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SectionLoadFile(),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Column(
                    children: [
                      SectionInputException(),
                      SectionInputPacket(),
                    ],
                  ),
                  Column(
                    children: [
                      SectionShowInfo(),
                      SectionShowResult(),
                    ],
                  ),
                  Column (
                    children: [
                      SectionOptionSelect(),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}