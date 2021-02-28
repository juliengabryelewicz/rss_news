import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rss_news/controllers/rss_controller.dart';
import 'package:rss_news/utils/loader.dart';
import 'package:rss_news/utils/text_widget.dart';
import 'package:rss_news/utils/navigation.dart';

class RssNewsPage extends StatelessWidget {
  final rssController = Get.put(RssController());
  final f = new DateFormat('dd-MM-yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: GetBuilder<RssController>(
        assignId: true,
        initState: (_) {
          rssController.getAllNews();
        },
        init: RssController(),
        autoRemove: true,
        builder: (api) {
          var rssItems = api.rssItems;

          if (rssController.loading.value == true) {
            return Loader(
              msg: 'Chargement...',
              color: Colors.red,
            );
          }
          if (rssItems.length == 0) {
            return Center(
              child: TextWidget(text: 'Aucune actualité trouvée. Veuillez renseigner un flux RSS', fontSize: null),
            );
          }

          return ListView.builder(
            itemCount: rssItems.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  Get.toNamed('/rss/news/details', arguments: [rssItems[index].title, rssItems[index].description, rssItems[index].media.toString(),
                    f.format(rssItems[index].pubDate), rssItems[index].categories.map((category) => category.value).join(", "),
                  rssItems[index].link]),
                },
                child: ListTile(
                  title: Text(rssItems[index].title),
                  subtitle: Text(
                    f.format(rssItems[index].pubDate)
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}