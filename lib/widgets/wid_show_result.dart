import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/data_packet.dart';


class SectionShowInfo extends StatelessWidget {
  SectionShowInfo ({super.key});

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: context.width/10*4-10,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white,),
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          children: [
            Obx(() => Text("PACKET LENGTH [${c.showPacketLength}] ", style: TextStyle(fontSize: 16, color: Colors.white),)),
            Obx(() => Text("NEED PACKET LENGTH [${c.showNeedPacketLength}]", style: TextStyle(fontSize: 16, color: Colors.white),)),
          ],
        )
    );
  }
}

class SectionShowResult extends StatelessWidget {
  SectionShowResult ({super.key});

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height - 200,
        width: context.width/10*4-10,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white,),
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: ListView(
          padding: EdgeInsets.all(1),
          children: [
            Obx(() => SelectableText("${c.showPacketData}", style: TextStyle(fontSize: 14, color: Colors.white),)),
          ],
        )
    );
  }
}