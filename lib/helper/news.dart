import 'dart:convert';
import 'package:http/http.dart' as http;
import '../articles.dart';

class News{

  List<Article> news =[];
  Future<void> findNews() async{

    String url = "http://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=ccaa9021c02849c3ac883a48e99f4e4a";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }
}