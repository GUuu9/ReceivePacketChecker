import 'package:get/get.dart';
import '../models/data_packet.dart';

void packetDecoding(String receivePacket) {
  final Controller c = Get.put(Controller());

  var packetList = List<String>.filled(0, "00", growable: true);
  var exceptionHex = c.exceptionHex.value;
  var decodingHex = c.decodingHex.value;

  receivePacket = receivePacket.toUpperCase().replaceAll('0X', '').replaceAll(' ', '').replaceAll(RegExp('[^a-fA-F0-9]'), '');

  if (receivePacket.isEmpty) {
    c.showPacketData.value = "Waiting Packet...";
    c.showPacketLength.value = 0;
    return;
  }

  if (receivePacket.length % 2 != 0) {
    c.showPacketData.value = "DATA ERR";
    c.showPacketLength.value = 0;
    return;
  }

  for (var i = 0; i < receivePacket.length; i+=2) {
    packetList.add("${receivePacket[i]}${receivePacket[i+1]}");
  }

  if(exceptionHex != 0x00 && decodingHex != 0x00) {
    for (var i = 1; i < packetList.length - 1; i++) {
      if (int.parse(packetList[i], radix: 16) == exceptionHex) {
        packetList[i] = (int.parse(packetList[i + 1], radix: 16) ^ decodingHex)
            .toRadixString(16);
        packetList.removeAt(i + 1);
      }
    }
  }



  if (c.ret == []) {
    var tmp = packetList.toString().replaceAll(RegExp('[^a-fA-F0-9]'), ' ').trim();

    c.showPacketLength.value = packetList.length;
    c.showPacketData.value = tmp;
  }
  else {
    c.showPacketLength.value = packetList.length;
    c.showPacketData.value = "";
    var cnt = 0;
    for(var i = 0; i < c.ret.length; i++) {
      if(c.dataUse[i]) {
        c.showPacketData.value += "[Bytes:${c.ret[i][1]}] ${c.ret[i][0]}\n";
        for (var j = 0; j < int.parse(c.ret[i][1].toString()); j++) {
          try {
            c.showPacketData.value += "${packetList[cnt++].toString().replaceAll(RegExp('[^a-fA-F0-9]'), ' ').trim()} ";
          }
          catch (e) {
            print("length ERR");
            break;
          }
        }
        c.showPacketData.value += "\n";
      }
    }
  }
}

void xorHex(String receiveValue, int target) {
  final Controller c = Get.put(Controller());
  receiveValue = receiveValue.toUpperCase().replaceAll('0X', '').replaceAll(' ', '').replaceAll(RegExp('[^a-fA-F0-9]'), '');

  if(receiveValue.length % 2 != 0 || receiveValue.isEmpty) {
    switch (target) {
      case 0: c.exceptionHex.value = 0x00; break;
      case 1: c.decodingHex.value = 0x00; break;
      default: break;
    }

    return;
  }

  switch (target) {
    case 0: c.exceptionHex.value = int.parse(receiveValue, radix: 16); break;
    case 1: c.decodingHex.value = int.parse(receiveValue, radix: 16); break;
    default: break;
  }

  packetDecoding(c.packetData.text);
}

