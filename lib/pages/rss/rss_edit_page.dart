import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/controllers/rss_controller.dart';
import 'package:rss_news/models/rss_model.dart';
import 'package:rss_news/utils/loader.dart';
import 'package:rss_news/utils/navigation.dart';

class RssEditPage extends StatelessWidget {
  final rssController = Get.put(RssController());
  get rssId => Get.parameters["id"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modifier un flux RSS'),
        ),
        body: GetBuilder<RssController>(
          initState: (_) {
            rssController.getRss(rssId);
          },
          builder: (api) {
            var rss = api.rssElement;

            if (rssController.loading.value == true) {
              return Loader(
                msg: 'Chargement...',
                color: Colors.red,
              );
            }
            return _buildForm(rss);
          },
        ),
      bottomNavigationBar: Navigation(),
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
                    initialValue: rss.value.nom,
                    decoration: InputDecoration(
                      labelText: 'Nom du flux RSS',
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
                    initialValue: rss.value.lien,
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
                child: RaisedButton(
                  child: Text('Sauvegarder'),
                  onPressed: () async {
                    rssController.actualize(rss.value.id.toString());
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
