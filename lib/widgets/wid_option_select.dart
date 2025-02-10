import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/data_packet.dart';
import '../utils/util_packet_decode.dart';

class SectionOptionSelect extends StatelessWidget {
  SectionOptionSelect ({super.key});

  final Controller c = Get.put(Controller());


  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height - 140,
        width: context.width/10*4-10,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white,),
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: ListView(
          children: [
             Column(
               children: [
                 Obx(() => screenOption(),)
               ],
             )
          ],
        )
    );
  }

  Widget screenOption() {
    final Controller c = Get.put(Controller());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (c.ret.isNotEmpty) for(var i = 0; i < c.ret.length; i++) Row (
          children: [
            Checkbox(
              value: c.dataUse[i],
              onChanged: (bool ? value) {
                c.dataUse[i] = c.dataUse[i] ? false : true;
                if (c.dataUse[i]) {
                  c.showNeedPacketLength += int.parse(c.ret[i][1].toString());
                }
                else {
                  c.showNeedPacketLength -= int.parse(c.ret[i][1].toString());
                }
                packetDecoding(c.packetData.text);
              },
              activeColor: Colors.blue,
              checkColor: Colors.white,
              hoverColor: Colors.orange,

            ),
            Text("${c.ret[i][0]}", style: TextStyle(fontSize: 14, color: Colors.white),)
          ],
        ),
      ],
    );
  }
}
