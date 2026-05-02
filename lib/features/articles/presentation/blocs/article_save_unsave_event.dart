sealed class ArticleSaveUnsaveEvent {
  const ArticleSaveUnsaveEvent();
}

final class ArticleSaveRequested extends ArticleSaveUnsaveEvent {
  final String articleId;

  const ArticleSaveRequested(this.articleId);
}

final class ArticleUnsaveRequested extends ArticleSaveUnsaveEvent {
  final String articleId;

  const ArticleUnsaveRequested(this.articleId);
}
