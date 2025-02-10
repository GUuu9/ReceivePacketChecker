import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var showFileName = "".obs;
  var showPacketData = "Waiting Packet...".obs;
  var showPacketLength = 0.obs;
  var showNeedPacketLength = 0.obs;
  var exceptionHex = 0x00.obs;
  var decodingHex = 0x00.obs;

  var dataUse = [].obs;

  var ret = [].obs;


  TextEditingController packetData = TextEditingController();
  TextEditingController xorChecker = TextEditingController();
  TextEditingController decodeChecker = TextEditingController();
}

