import 'package:fatwa_article_test/features/articles/data/mocks/mock_articles.dart';
import 'package:fatwa_article_test/features/articles/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Article Feed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('For You')),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mockArticles.length,
          itemBuilder: (context, index) {
            return ArticleCard(article: mockArticles[index]);
          },
        ),
      ),
    );
  }
}
