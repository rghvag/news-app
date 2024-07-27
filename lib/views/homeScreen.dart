import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/services/auth_service.dart';
import 'package:newsapplication/services/news_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('homescreen');
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'MyNews',
        ),
        actions: [
          Icon(Icons.language_outlined),
          Text('IN'),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                Provider.of<AuthService>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: newsService.fetchTopHeadlines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('error ${snapshot.error} Failed to load news'));
          } else if (snapshot.hasData) {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Top Headlines',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                final article = articles[index];
                return ListTile(
                  title: Text(
                    article.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: article.description != null &&
                          article.description!.isNotEmpty
                      ? Text(article.description!)
                      : Text("..."),
                  trailing:
                      article.imageUrl != null && article.imageUrl!.isNotEmpty
                          ? Image.network(
                              article.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/breaking_news.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/breaking_news.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                  onTap: () => {_launchURL(article.url)},
                );
              },
            );
          } else {
            return Center(child: Text('No news available'));
          }
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
