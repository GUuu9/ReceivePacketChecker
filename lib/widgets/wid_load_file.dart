import 'dart:io';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';

import 'package:csv/csv.dart';
import 'package:cp949_codec/cp949_codec.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/data_packet.dart';
import '../utils/util_packet_decode.dart';
import '../utils/util_set_windows.dart';

class refreshPage extends GetxController {
  @override
  void onInit() {
    runWindowFunctions();
    super.onInit();
  }

}

class SectionLoadFile extends StatelessWidget {
  SectionLoadFile ({super.key});

  Color defaultColor = Colors.white;
  // final List<XFile> _list = [];
  RxBool _dragging = false.obs;

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {

    return DropTarget(
      onDragDone: (detail) async {
        debugPrint("Drag Done");
        if (detail.files.isNotEmpty) {
          String fileName = detail.files.first.name;
          // print("FILE NAME : $fileName");
          c.showFileName.value = fileName;
          File file = File(detail.files.single.path!);
          print("File INFO : $file");

          Uint8List fileBytes = await detail.files.first.readAsBytes();
          var ret = "";
          try {
            ret = utf8.decode(fileBytes);
            print("decode : UTF8");
          }
          catch (e) {
            ret = cp949.decode(fileBytes);
            print("decode : CP-949");
          }


          List<List<dynamic>> _listData = const CsvToListConverter().convert(ret);
          c.ret.value = _listData;
          c.ret.removeAt(0);

          c.showNeedPacketLength.value = 0;
          c.dataUse.value = [];

          for (var i = 0; i < c.ret.length; i++) {
            c.showNeedPacketLength.value += int.parse(c.ret[i][1].toString());
            c.dataUse.add(true);
          }
          print("OPEN SUCCESS");
          packetDecoding(c.packetData.text);
        }
      },
      onDragEntered: (detail) {
        _dragging.value = true;
      },
      onDragExited: (detail) {
        _dragging.value = false;
      },
      child: Container(
          height: 100,
          width: context.width-10,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white,),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              InkWell(
                onTap: () async {
                  c.ret.value = [];

                  try {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      withData: true, // Allow Read Bytes
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );


                    // print(result);
                    if (result != null && result.files.isNotEmpty) {
                      String fileName = result.files.first.name;
                      // print("FILE NAME : $fileName");
                      c.showFileName.value = fileName;
                      File file = File(result.files.single.path!);
                      print("File INFO : $file");

                      Uint8List fileBytes = result.files.first.bytes!;
                      var ret = "";
                      try {
                        ret = utf8.decode(fileBytes);
                        print("decode : UTF8");
                      }
                      catch (e) {
                        ret = cp949.decode(fileBytes);
                        print("decode : CP-949");
                      }


                      List<List<dynamic>> _listData = const CsvToListConverter().convert(ret);
                      c.ret.value = _listData;
                      c.ret.removeAt(0);

                      c.showNeedPacketLength.value = 0;
                      c.dataUse.value = [];
                      for (var i = 0; i < c.ret.length; i++) {
                        c.showNeedPacketLength.value += int.parse(c.ret[i][1].toString());
                        c.dataUse.add(true);
                      }
                      print("OPEN SUCCESS");
                      packetDecoding(c.packetData.text);

                    }
                  } catch (e) {
                    c.showFileName.value = "FILE OPEN FAIL.";
                    print("ERR");
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Drop File Or Open File Load", style: TextStyle(fontWeight: FontWeight.bold, color: defaultColor, fontSize: 20,),),
                    Icon(Icons.upload_rounded, color: defaultColor),
                  ],
                ),
              ),
              Text("(*.csv)", style: TextStyle(color: defaultColor,),),
              Obx(() => Text("OPEN FILE NAME : ${c.showFileName.value}", style: TextStyle(color: defaultColor,),),),

            ],
          )
      )
    );
  }
}