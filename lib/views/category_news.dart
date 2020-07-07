import 'package:flutter/material.dart';
import 'package:news_flutter/model/article_model.dart';
import 'package:news_flutter/views/article_view.dart';
import 'package:news_flutter/helper/news.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({@required this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> newsList = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNewsData();
  }

  getCategoryNewsData() async
  {
    CategoriesNews newsObject = new CategoriesNews();
    await newsObject.getNews(widget.category);
    newsList = newsObject.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Flutter"),
            new Text(
              "News",
              style: new TextStyle(
                  color: Colors.blue
              ),
            ),
          ],
        ),
      ),

      body: _loading? new Center(
        child: new Container(
          child: CircularProgressIndicator(),
        ),
      ): new SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 16),
                child: new ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: newsList.length,
                    itemBuilder: (context, index){
                      return new BlogTile(
                        imageUrl: newsList[index].urlToImage ?? "",
                        title: newsList[index].title ?? "",
                        desc: newsList[index].description ?? "",
                        url: newsList[index].url ?? "",
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(webUrl: url,)
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.network(
                  imageUrl
              ),
            ),
            new SizedBox(height: 8.0,),
            new Text(
              title,
              style: new TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600
              ),
            ),

            new SizedBox(height: 8.0,),
            new Text(
              desc,
              style: new TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
