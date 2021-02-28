
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/database/db_helper.dart';
import 'package:rss_news/pages/rss/rss_create_page.dart';
import 'package:rss_news/pages/rss/rss_edit_page.dart';
import 'package:rss_news/pages/rss/rss_page.dart';
import 'package:rss_news/pages/rss/rss_news_page.dart';
import 'package:rss_news/pages/rss/rss_news_detail_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(primaryColor: Colors.black),
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(name: '/', page: () => RssPage()),
        GetPage(name: '/rss/news', page: () => RssNewsPage()),
        GetPage(name: '/rss/news/details', page: () => RssNewsDetailPage()),
        GetPage(name: '/rss/edit/:id', page: () => RssEditPage()),
        GetPage(name: '/rss/create/', page: () => RssCreatePage()),
      ],
    );
  }
}