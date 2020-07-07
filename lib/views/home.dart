import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/helper/data.dart';
import 'package:news_flutter/helper/news.dart';
import 'package:news_flutter/model/article_model.dart';
import 'package:news_flutter/model/category_model.dart';
import 'package:news_flutter/views/article_view.dart';
import 'package:news_flutter/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> newsList = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    categories = getCategories();
    getNewsData();
  }

  getNewsData() async
  {
    News newsObject = new News();
    await newsObject.getNews();
    newsList = newsObject.news;

    setState(() {
      _loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

      body: _loading ? Center(
        child: new Container(
          child: CircularProgressIndicator(),
        ),
      ) : new SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: new Column(
            children: <Widget>[

              //This is for Category List START HERE
              new Container(
                height: 70,

                child: new ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context , index){
                    return new CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              //This is for Category List END HERE

              //This is for BLOGS List START HERE
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
              //This is for BLOGS List END HERE


            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final String imageUrl, categoryName;
  CategoryTile({@required this.imageUrl, @required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=> new CategoryNews(category: categoryName)
          ),
        );
      },
      child: new Container(
        margin: EdgeInsets.only(right: 16.0),
        child: new Stack(
          children: <Widget>[
            new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),

            new Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: new Text(
                categoryName,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )

          ],
        ),
      ),
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


