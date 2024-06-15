import 'package:dictionary/screens/main_screen.dart';
import 'package:dictionary/states/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> keys = GlobalKey();

    return Scaffold(
      key: keys,
      appBar: AppBar(
        title: Text('app_name'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 20)),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/setting');
              },
              icon: Icon(
                CupertinoIcons.settings,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ))
        ],
      ),
      body: MainScreen(),
      bottomNavigationBar: Get.find<AppState>().ads.bannerWidget(),
    );
  }
}
