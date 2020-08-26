import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "dart:convert";

import 'articles.dart';

import 'helper/news.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
 bool _loading = true;

List<Article> artticles = new List<Article>();
void getNews() async {
    News news = News();
    await news.findNews();
    artticles = news.news;
    setState(() {
      _loading = false;
    });
  }



  

  @override
  void initState() {
  
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:(){
          getNews();
      },
      child:Icon(Icons.refresh)),
      appBar: AppBar(
        title: Text("Newsdogs"),
      ),
      body:_loading ? Container(
        child: CircularProgressIndicator(),
      ):
      Container(
            child:ListView.builder(
      shrinkWrap: true,
      itemCount: artticles.length,
      itemBuilder: (context,index){
        return(
          NewsTile(
                    imgUrl: artticles[index].urlToImage,
                    title: artticles[index].title,
                    desc: artticles[index].description,
                    content: artticles[index].content,
                    posturl: artticles[index].articleUrl,
                  )
        );
      })
            
          )
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.posturl});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Image.network(imgUrl,fit: BoxFit.fill,),
        Text(
          title,
          maxLines: 2,
          style: TextStyle(
              color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),
        ),
         SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  )
      ],
    ));
  }
}
