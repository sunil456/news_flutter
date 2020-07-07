import 'dart:convert';

import 'package:news_flutter/model/article_model.dart';
import 'package:http/http.dart' as http;

class News
{
  List<ArticleModel> news = [];

  Future<void> getNews() async
  {
    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=a4c2a3e374e54d8fa7bf5d51469d4303";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok")
      {
        jsonData["articles"].forEach((element){
          if(element["urlToImage"] != null && element["description"] != null)
            {
              ArticleModel articleModel = new ArticleModel(
                author: element["author"],
                title: element["title"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                publishedAt: element["publishedAt"],
                content: element["content"],
              );

              news.add(articleModel);
            }
        });
      }
  }
}


class CategoriesNews
{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async
  {
    String url = "http://newsapi.org/v2/top-headlines?category=$category&country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=a4c2a3e374e54d8fa7bf5d51469d4303";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok")
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null)
        {
          ArticleModel articleModel = new ArticleModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );

          news.add(articleModel);
        }
      });
    }
  }
}