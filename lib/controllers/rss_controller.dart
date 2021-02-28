import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rss_news/models/rss_model.dart';
import 'package:rss_news/database/db_helper.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class RssController extends GetxController {
  DBHelper repository = DBHelper();
  RxBool loading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _selectedIndex = 0.obs;
  get selectedIndex => this._selectedIndex.value;
  set selectedIndex(value) => this._selectedIndex.value = value;

  final _rss = List<RssModel>().obs;
  set rss(List<RssModel> value) => this._rss.assignAll(value);
  get rss => this._rss.value;

  final _rssItems = List<RssItem>().obs;
  set rssItems(List<RssItem> value) => this._rssItems.assignAll(value);
  get rssItems => this._rssItems.value;

  var rssElement = RssModel().obs;

  RxString nom = ''.obs;
  RxString lien = ''.obs;

  setNom(String value) => nom.value = value;
  setLien(String value) => lien.value = value;

  onItemTapped(int index) {
    this.selectedIndex = index;
    switch(index) {
      case 0: {
        Get.offAllNamed('/');
      }
      break;
      case 1: {
        Get.offAllNamed('/rss/news');
      }
      break;
    }
    update();
  }

  getAll() async {
    loading.value = true;
    final response = await repository.query();
    rss = response;
    loading.value = false;
    update();
  }

  getRss(String id) async {
    loading.value = true;
    final response = await repository.get(id);
    rssElement.value = response[0];
    loading.value = false;
    update();
  }

  getAllNews() async {
    loading.value = true;
    List<RssItem> rssList = <RssItem>[];
    final links = await repository.query();
    for (var i=0; i<links.length; i++) {
      var res = await get(links[i].lien);
      if (res.statusCode == 200) {
        var rssFeed = new RssFeed.parse(res.body);
        for (RssItem item in rssFeed.items) {
          rssList.add(item);
        }
      }
    }
    rssList.sort((a,b) {
      var aPubDate = a.pubDate;
      var bPubDate = b.pubDate;
      return bPubDate.compareTo(aPubDate);
    });
    rssItems = rssList;
    loading.value = false;
    update();
  }

  actualize(String id) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await repository.update(RssModel(id: int.parse(id), nom: nom.value, lien: lien.value));
      Get.offAllNamed('/');
      var checkUrl = await checkURL(lien.value);
      if(!checkUrl){
        Get.snackbar('URL du flux RSS invalide', "Aucune actualité ne viendra de cette URL",
            snackPosition: SnackPosition.BOTTOM);
      }
      getAll();
    }
  }

  insert() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      loading.value = true;
      await repository.insert(RssModel(nom: nom.value, lien : lien.value));
      loading.value = false;
      Get.offAllNamed('/');
      var checkUrl = await checkURL(lien.value);
      if(!checkUrl){
        Get.snackbar('URL du flux RSS invalide', "Aucune actualité ne viendra de cette URL",
            snackPosition: SnackPosition.BOTTOM);
      }
      getAll();
    }
  }

  delete(String id) async {
    await repository.delete(int.parse(id));
    Get.snackbar('Suppression réussie', 'Lien RSS supprimé',
        snackPosition: SnackPosition.BOTTOM);
    getAll();
  }

  checkURL(String link) async {
    var res = await get(link);
    return res.statusCode == 200;
  }

}
