import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/controllers/rss_controller.dart';
import 'package:rss_news/models/rss_model.dart';
import 'package:rss_news/utils/loader.dart';
import 'package:rss_news/utils/navigation.dart';

class RssCreatePage extends StatelessWidget {
  final rssController = Get.put(RssController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajouter un flux RSS'),
        ),
        body: GetX<RssController>(
          builder: (api) {
            var rss = api.rssElement;

            return _buildForm(rss);
          },
        ),
      bottomNavigationBar: Navigation()
    );
  }

  Widget _buildForm(Rx<RssModel> rss) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: rssController.formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Titre',
                    ),
                    onSaved: rssController.setNom,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Champ obligatoire';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Lien du flux RSS',
                    ),
                    onSaved: rssController.setLien,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Champ obligatoire';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: rssController.loading.value == true
                    ? Loader(
                        msg: 'Chargement...',
                      )
                    : RaisedButton(
                        child: Text('Sauvegarder'),
                        onPressed: () async {
                          rssController.insert();
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
