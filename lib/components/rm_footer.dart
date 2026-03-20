import 'package:flutter/material.dart';
import '../app_colors.dart';

class RMFooter extends StatelessWidget {
  final String? customText;

  const RMFooter({super.key, this.customText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.navbarBg,
        border: Border(
          top: BorderSide(
            color: AppColors.portalGreen.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo/Title con personajes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                ),
                backgroundColor: AppColors.navbarBg,
              ),
              const SizedBox(width: 6),
              Text(
                'Rick',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.rickBlue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'And',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Morty',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.portalGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 1),
              CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
                ),
                backgroundColor: AppColors.navbarBg,
              ),
            ],
          ),
          const SizedBox(height: 1),

          // Custom text or description
          Text(
            customText ?? 'observa los personajes de la serie',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 3),



          // Divider
          Container(
            height: 1,
            color: AppColors.portalGreen.withOpacity(0.2),
            margin: const EdgeInsets.symmetric(vertical: 12),
          ),

          // Copyright
          Text(
            ' 2026 Rick And Morty Api',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
