import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAC5AyxYZz-ADhEOg8gHshyRm8cdJWopAE",
      authDomain: "news-web-app-3bcd6.firebaseapp.com",
      projectId: "news-web-app-3bcd6",
      storageBucket: "news-web-app-3bcd6.firebasestorage.app",
      messagingSenderId: "1052922697397",
      appId: "1:1052922697397:web:9166d9b7a283f2427f90fc",
      measurementId: "G-PXBR6Z0S6E",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NewsHomePage());
  }
}

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=caf4227dd2dc47ecbf844064a72ed585'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        articles = data['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Headlines')),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article['title'] ?? ''),
            subtitle: Text(article['source']['name'] ?? ''),
          );
        },
      ),
    );
  }
}
