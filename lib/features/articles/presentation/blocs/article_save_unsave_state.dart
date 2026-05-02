sealed class ArticleSaveUnsaveState {
  const ArticleSaveUnsaveState();
}

final class ArticleSaveUnsaveInitial extends ArticleSaveUnsaveState {
  const ArticleSaveUnsaveInitial();
}

final class ArticleSaveUnsaveInProgress extends ArticleSaveUnsaveState {
  final bool isSaved;

  const ArticleSaveUnsaveInProgress({
    required this.isSaved,
  });
}

final class ArticleSaveUnsaveSuccess extends ArticleSaveUnsaveState {
  const ArticleSaveUnsaveSuccess();
}

final class ArticleSaveUnsaveFailure extends ArticleSaveUnsaveState {
  final String message;
  final bool isSaved;

  const ArticleSaveUnsaveFailure({
    required this.message,
    required this.isSaved,
  });
}
