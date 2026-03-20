import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colors.dart';
import '../provider/favorite_characters.dart';
import '../widget/character_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteCharacters>().items;

    if (favorites.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.spaceDark,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_rounded,
                size: 64,
                color: AppColors.mortyYellow.withOpacity(0.6),
              ),
              const SizedBox(height: 16),
              const Text(
                'Favoritos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tus personajes guardados aparecerán aquí',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.spaceDark,
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.70,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final character = favorites[index];

          return CharacterCard(
            character: character,
            isFavorite: true,
            onFavoriteToggle: () =>
                context.read<FavoriteCharacters>().remove(character),
            onTap: () {},
          );
        },
      ),
    );
  }
}
