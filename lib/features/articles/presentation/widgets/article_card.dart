import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_bloc.dart';
import 'package:fatwa_article_test/features/articles/presentation/blocs/article_save_unsave_state.dart';
import 'package:fatwa_article_test/features/articles/presentation/widgets/article_save_button.dart';
import 'package:fatwa_article_test/features/articles/data/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArticleSaveUnsaveBloc(),
      child: _ArticleCardContent(article: article),
    );
  }
}

class _ArticleCardContent extends StatelessWidget {
  final Article article;

  const _ArticleCardContent({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                BlocBuilder<ArticleSaveUnsaveBloc, ArticleSaveUnsaveState>(
                  builder: (context, state) {
                    return ArticleSaveButton(
                      articleId: article.id,
                      state: state,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(article.author, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            Text(article.preview),
            BlocBuilder<ArticleSaveUnsaveBloc, ArticleSaveUnsaveState>(
              builder: (context, state) {
                if (state is! ArticleSaveUnsaveFailure) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
