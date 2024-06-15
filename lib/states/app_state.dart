import 'package:get/get.dart';
import 'package:kode4u/utils/k_ads.dart';
import 'package:kode4u/utils/k_utils.dart';

import '../services/db_provider.dart';
import 'peak_item.dart';
import 'story_item.dart';

class AppState extends GetxController {
  KAds ads = KAds();
  var listStory = [].obs;
  var listPeak = [].obs;
  PeakItem? currentPeak;
  StoryItem? currentStory;

  fetchMain() async {
    String lang = KUtil.isEn() ? 'en' : 'kh';
    print('fetch main ${await DBProvider.db.fetchMainItem(lang: lang)}');
    listPeak.value = await DBProvider.db.fetchMainItem(lang: lang);
  }

  fetchItem(String title) async {
    currentStory = await DBProvider.db.fetchItem(title: title);
  }

  fetchTitles({int page = 1, int? bookno}) async {
    String lang = KUtil.isEn() ? 'en' : 'kh';
    print(
        'title: ${await DBProvider.db.fetchTitles(lang: lang, bookno: bookno!)}');
    listStory.value =
        await DBProvider.db.fetchTitles(lang: lang, bookno: bookno);
  }
}
