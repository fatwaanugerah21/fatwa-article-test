import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_bloc.dart';
import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_event.dart';
import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleSaveButton extends StatelessWidget {
  final String articleId;
  final ArticleSaveUnsaveState state;

  const ArticleSaveButton({
    super.key,
    required this.articleId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isSaving = state is ArticleSaveUnsaveInProgress;
    final isSaved = _isSaved;

    return IconButton(
      tooltip: _buildTooltip(isSaving, isSaved),
      onPressed: isSaving
          ? null
          : () {
              final event = isSaved
                  ? ArticleUnsaveRequested(articleId)
                  : ArticleSaveRequested(articleId);

              context.read<ArticleSaveUnsaveBloc>().add(event);
            },
      icon: _buildIcon(context, isSaving, isSaved),
    );
  }

  bool get _isSaved {
    if (state is ArticleSaveUnsaveSuccess) {
      return true;
    }

    if (state case ArticleSaveUnsaveInProgress(isSaved: final isSaved)) {
      return isSaved;
    }

    if (state case ArticleSaveUnsaveFailure(isSaved: final isSaved)) {
      return isSaved;
    }

    return false;
  }

  Widget _buildIcon(BuildContext context, bool isSaving, bool isSaved) {
    if (isSaving) {
      return const SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (isSaved) {
      return Icon(
        Icons.bookmark,
        color: state is ArticleSaveUnsaveFailure
            ? Theme.of(context).colorScheme.error
            : null,
      );
    }

    return Icon(
      Icons.bookmark_border,
      color: state is ArticleSaveUnsaveFailure
          ? Theme.of(context).colorScheme.error
          : null,
    );
  }

  String _buildTooltip(bool isSaving, bool isSaved) {
    if (isSaving) {
      return isSaved ? 'Unsaving article' : 'Saving article';
    }

    if (isSaved) {
      return 'Unsave article';
    }

    if (state is ArticleSaveUnsaveFailure) {
      return 'Retry saving article';
    }

    return 'Save article';
  }
}
