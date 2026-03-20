import 'package:flutter/material.dart';
import '../app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.spaceDark,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono con glow portal
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.portalGreen.withOpacity(0.08),
                border: Border.all(
                  color: AppColors.portalGreen.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.portalGreen.withOpacity(0.2),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.travel_explore_rounded,
                size: 52,
                color: AppColors.portalGreen,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'EXPLORAR',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aquí irá el listado de personajes',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}