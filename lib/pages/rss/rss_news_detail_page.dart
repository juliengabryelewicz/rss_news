import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/controllers/rss_controller.dart';
import 'package:rss_news/helpers/html_tags.dart';
import 'package:url_launcher/url_launcher.dart';

class RssNewsDetailPage extends StatelessWidget {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: GetBuilder<RssController>(
          builder: (api) {
            return _buildRssItem();
          },
        )
    );
  }

  Widget _buildRssItem() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child:  SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 25),
                margin: EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        data[0] ?? "",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: 15),
                    Text(
                      data[3].toString() ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      data[4] ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        onPressed: () => _launchURL(data[5]),
                        child: Text("Voir l'article", style: TextStyle(fontSize: 20)),
                        color: Colors.black,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                    ),
                    SizedBox(height: 15),
                    CachedNetworkImage(
                      imageUrl: data[2],
                      placeholder: (context,url) => CircularProgressIndicator(),
                      errorWidget: (context,url,error) => Container(),
                    ),
                    SizedBox(height: 15),
                    Text(
                      removeAllHtmlTags(convertHtmlEntities(data[1])) ?? "",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}