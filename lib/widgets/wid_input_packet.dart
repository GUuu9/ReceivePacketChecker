import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/data_packet.dart';
import '../utils/util_packet_decode.dart';

class SectionInputException extends StatelessWidget {
  SectionInputException ({super.key});

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: context.width/10*1-10,
          margin: EdgeInsets.all(5),
          child: TextField(
            maxLength: 4,
            controller: c.xorChecker,
            maxLines: 1,
            onChanged: (text) => xorHex(text, 0),
            style: TextStyle(fontSize: 15, color: Colors.white),
            decoration: const InputDecoration(
              counterText: '',
              labelText: "Exception HEX",
              labelStyle: TextStyle(fontSize: 12, color: Colors.white),
              hintText: "0x00 or 00",
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
          )
        ),
        Container(
          height: 50,
          width: context.width/10*1-10,
          margin: EdgeInsets.all(5),
          child: TextField(
            maxLength: 4,
            controller: c.decodeChecker,
            maxLines: 1,
            onChanged: (text) => xorHex(text, 1),
            style: TextStyle(fontSize: 15, color: Colors.white),
            decoration: const InputDecoration(
              counterText: '',
              labelText: "Decoding HEX",
              labelStyle: TextStyle(fontSize: 12, color: Colors.white),
              hintText: "0x00 or 00",
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
          )
        ),
      ],
    );
  }
}


class SectionInputPacket extends StatelessWidget {
  SectionInputPacket ({super.key});

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height - 200,
      width: context.width/10*2-10,
      margin: EdgeInsets.all(5),
      child: TextField(
        controller: c.packetData,
        onChanged: (text) => packetDecoding(text),
        maxLines: 999,
        style: TextStyle(fontSize: 15, color: Colors.white),
        decoration: const InputDecoration(
          labelText: "insert PACKET HEX",
          labelStyle: TextStyle(color: Colors.white),
          hintText: "0x00 or 00",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
      )
    );
  }
}