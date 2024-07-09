import 'package:dictionary/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode4u/utils/k_utils.dart';

import 'list_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AppState>().fetchMain();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          Get.find<AppState>().listPeak.length,
          (index) {
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 2.0,
              clipBehavior: Clip.antiAlias,
              child: Material(
                child: InkWell(
                  onTap: () async {
                    KUtil.showMoreAppIOS();
                    AppState app = Get.find<AppState>();
                    app.currentPeak = app.listPeak[index];
                    await app.fetchTitles(bookno: app.currentPeak!.peak);
                    Get.toNamed('/list-screen');
                  },
                  child: Container(
                    height: 100,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Image.asset('assets/images/peak.png'),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            child: Center(
                              child: Text(
                                "${'app_peak'.tr}${Get.find<AppState>().listPeak[index].peak}",
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: KUtil.fontSize()),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
