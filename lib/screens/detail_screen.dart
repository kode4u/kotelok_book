import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kode4u/configs/k_config.dart';
import '../states/app_state.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double fontSizeDetailScreen = 14;

  @override
  void initState() {
    super.initState();
    try {
      double? size = GetStorage().read('fontSizeDetailScreen') ?? 14;
      fontSizeDetailScreen = size;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'app_title'.tr,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  if (fontSizeDetailScreen > 8) {
                    fontSizeDetailScreen--;
                  }
                });
                GetStorage()
                    .write('fontSizeDetailScreen', fontSizeDetailScreen);
              },
              icon: const Icon(CupertinoIcons.minus)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (fontSizeDetailScreen < 20) {
                    fontSizeDetailScreen++;
                  }
                });
                GetStorage()
                    .write('fontSizeDetailScreen', fontSizeDetailScreen);
              },
              icon: const Icon(CupertinoIcons.plus)),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(KConfig.margin),
                      child: Text(
                        Get.find<AppState>().currentStory!.title,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontFamily: 'Sr',
                          fontSize: fontSizeDetailScreen,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      child: Text(
                        Get.find<AppState>().currentStory!.story,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: fontSizeDetailScreen),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(KConfig.margin),
                      padding: EdgeInsets.all(KConfig.margin),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(KConfig.radius + 300),
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        "[${'app_peak'.tr}${Get.find<AppState>().currentStory!.peak}]",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Get.find<AppState>().ads.bannerWidget(),
          ],
        ),
      ),
    );
  }

  Widget webHTML(String data, BuildContext context) {
    return Html(
      data: data,
    );
  }

  getDictionaryFromText(String text) {
    var listTitle = text.split("<font>");
    var render = [];

    for (int i = 0; i < listTitle.length; i++) {
      var item = listTitle[i].trim().split("</font>");
      if (item.length == 1) {
        var item1 = {"type": "content", "text": item[0].trim()};
        if (item[0].trim() != "") render.add(item1);
      } else {
        var item1 = {"type": "title", "text": item[0].trim()};
        if (item[0].trim() != "") render.add(item1);
        var item2 = {"type": "content", "text": item[1].trim()};
        if (item[1].trim() != '') render.add(item2);
      }
    }
    return render;
  }
}
