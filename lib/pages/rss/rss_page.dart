import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/controllers/rss_controller.dart';
import 'package:rss_news/utils/loader.dart';
import 'package:rss_news/utils/text_widget.dart';
import 'package:rss_news/utils/navigation.dart';

class RssPage extends StatelessWidget {
  final rssController = Get.put(RssController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des liens RSS'),
      ),
      body: GetBuilder<RssController>(
        assignId: true,
        initState: (_) {
          rssController.getAll();
        },
        init: RssController(),
        autoRemove: true,
        builder: (api) {
          var rss = api.rss;

          if (rssController.loading.value == true) {
            return Loader(
              msg: 'Chargement...',
              color: Colors.red,
            );
          }
          if (rss.length == 0) {
            return Center(
              child: TextWidget(text: 'Aucun flux RSS trouvé', fontSize: null),
            );
          }

          return ListView.builder(
            itemCount: rss.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  Get.toNamed('/rss/edit/${rss[index].id}'),
                },
                child: Dismissible(
                  key: Key(rss[index].id.toString()),
                  child: ListTile(
                    leading: Text(
                      rss[index].nom[0].toUpperCase(),
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    title: Text(rss[index].nom),
                  ),
                  onDismissed: (direction) {
                    //if (direction == DismissDirection.endToStart) {
                      rssController.delete(rss[index].id.toString());
                    //}
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Navigation(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => {
          Get.toNamed('/rss/create/'),
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
