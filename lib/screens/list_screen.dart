import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../states/app_state.dart';
import '../widgets/list_card.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            '${'app_peak'.tr}${Get.find<AppState>().currentPeak!.peak}',
            overflow: TextOverflow.fade,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
          ),
        ),
        body: Obx(
          () => ListView.builder(
            // here we use our demo procuts list
            itemCount: (Get.find<AppState>().listStory.length),
            itemBuilder: (context, index) => ListCard(
              itemIndex: index,
              storyItem: Get.find<AppState>().listStory[index],
              press: () {
                Get.find<AppState>().currentStory =
                    Get.find<AppState>().listStory[index];
                Get.toNamed('/detail-screen');
                Get.find<AppState>().ads.showInterstitialAd();
              },
            ),
          ),
        ));
  }
}
