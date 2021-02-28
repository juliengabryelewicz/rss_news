import 'dart:convert';

RssModel rssModelFromJson(String str) =>
    RssModel.fromJson(json.decode(str));

String rssModelToJson(RssModel data) => json.encode(data.toJson());
class RssModel {
  int id;
  String nom;
  String lien;

  RssModel({this.id, this.nom, this.lien});

  RssModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    lien = json['lien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['lien'] = this.lien;
    return data;
  }
}