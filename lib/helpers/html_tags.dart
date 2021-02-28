import 'package:html_unescape/html_unescape.dart';

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );
  return htmlText.replaceAll(exp, '');
}

String convertHtmlEntities(String htmlText)  {
  var unescape = HtmlUnescape();
  return unescape.convert(htmlText);
}