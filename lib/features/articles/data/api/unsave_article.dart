import 'package:fatwa_article_test/features/articles/data/models/save_result.dart';

// Succeeds ~80% of the time, fails ~20%.
Future<SaveResult> unsaveArticle(String articleId) async {
  await Future.delayed(const Duration(milliseconds: 800));

  // Fails 50% of the time for higher chance of failure.
  if (DateTime.now().millisecondsSinceEpoch % 10 < 5) {
    throw Exception('Network error — please try again');
  }

  return SaveResult(articleId: articleId, saved: false);
}
