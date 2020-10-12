import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_flutter_web/blog/blog_card.dart';
import 'package:portfolio_flutter_web/components/desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_view_builder.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

class BlogView extends StatelessWidget {
  const BlogView({
    Key key,
  }) : super(key: key);
  static const title = 'Blog';
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<RssItem>>(
      create: (_) => getArticles(),
      child: MobileDesktopViewBuilder(
        mobileView: BlogMobileView(),
        desktopView: BlogDesktopView(),
      ),
    );
  }
}

class BlogDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //watch obtain values from nearest provider
    final articles = context.watch<List<RssItem>>();
    if (articles == null) return CircularProgressIndicator();
    return DesktopViewBuilder(
      titleText: BlogView.title,
      children: [
        Row(
          children: [
            for (final article in articles)
              Expanded(
                child: BlogCard(article: article),
              )
          ],
        ),
        SizedBox(height: 100),
      ],
    );
  }
}

class BlogMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = context.watch<List<RssItem>>();
    if (articles == null) return CircularProgressIndicator();
    return MobileViewBuilder(
      titleText: BlogView.title,
      children: [
        for (final article in articles)
          BlogCard(article: article, isMobile: true),
      ],
    );
  }
}

//future = potential value/failure
//handle value we expect or catch error if there is one
//can either be int or list of rss
Future<List<RssItem>> getArticles() async {
  //CORS = security feature, for medium : block local host
  final url =
      'https://cors-anywhere.herokuapp.com/https://medium.com/feed/@muhamad_haris';
  //'await' --> waits for get function to finish the calling, need 'async' to work
  final response = await http.get(url); //simple get request
  final parsedResponse = RssFeed.parse(response.body);
  //where returns lazy (list)  with all element that satisfy the predicate
  //categories in article = tags
  final haveFlutterTag = (RssItem article) {
    return article.categories.any((category) => category.value == 'flutter');
  };
  final flutterArticles =
      parsedResponse.items.where(haveFlutterTag).take(2).toList();
  return flutterArticles;
}
