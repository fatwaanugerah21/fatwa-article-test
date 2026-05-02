import 'package:fatwa_article_test/features/articles/data/api/save_article.dart';
import 'package:fatwa_article_test/features/articles/data/api/unsave_article.dart';
import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_event.dart';
import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleSaveUnsaveBloc
    extends Bloc<ArticleSaveUnsaveEvent, ArticleSaveUnsaveState> {
  ArticleSaveUnsaveBloc() : super(const ArticleSaveUnsaveInitial()) {
    on<ArticleSaveRequested>(_onSaveRequested);
    on<ArticleUnsaveRequested>(_onUnsaveRequested);
  }

  Future<void> _onSaveRequested(
    ArticleSaveRequested event,
    Emitter<ArticleSaveUnsaveState> emit,
  ) async {
    emit(const ArticleSaveUnsaveInProgress(isSaved: false));

    try {
      final result = await saveArticle(event.articleId);

      if (!result.saved) {
        emit(
          const ArticleSaveUnsaveFailure(
            message: 'Article was not saved. Please retry.',
            isSaved: false,
          ),
        );
        return;
      }

      emit(const ArticleSaveUnsaveSuccess());
    } catch (_) {
      emit(
        const ArticleSaveUnsaveFailure(
          message: 'Network error. Please try again.',
          isSaved: false,
        ),
      );
    }
  }

  Future<void> _onUnsaveRequested(
    ArticleUnsaveRequested event,
    Emitter<ArticleSaveUnsaveState> emit,
  ) async {
    emit(const ArticleSaveUnsaveInProgress(isSaved: true));

    try {
      final result = await unsaveArticle(event.articleId);

      if (result.saved) {
        emit(
          const ArticleSaveUnsaveFailure(
            message: 'Article was not unsaved. Please retry.',
            isSaved: true,
          ),
        );
        return;
      }

      emit(const ArticleSaveUnsaveInitial());
    } catch (_) {
      emit(
        const ArticleSaveUnsaveFailure(
          message: 'Network error. Please try again.',
          isSaved: true,
        ),
      );
    }
  }
}
