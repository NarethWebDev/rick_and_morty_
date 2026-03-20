import 'package:flutter/material.dart';
import '../app_colors.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.spaceDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con imagen del logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.spaceDark,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.labBlue.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_letras.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Adult Swim',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección Sinopsis
                  _buildSection(
                    title: 'Acerca de la serie',
                    content:
                        'Es una serie de televisión estadounidense de animación para adultos creada por Justin Roiland y Dan Harmon para Adult Swim, también se emitió en Cartoon Network. La serie sigue las desventuras de un científico, Rick Sánchez, y su fácilmente influenciable nieto, Morty, quienes pasan el tiempo entre la vida doméstica y los viajes espaciales e intergalácticos. Dan Harmon, el cocreador de la serie y Justin Roiland son los encargados de las voces principales de Morty y Rick, la serie también incluye las voces de Chris Parnell, Spencer Grammer y Sarah Chalke.',
                  ),
                  const SizedBox(height: 24),
                  // Sección Creadores
                  _buildSection(
                    title: 'Creadores',
                    content: 'Dan Harmon y Justin Roiland',
                  ),
                  const SizedBox(height: 6),
                  // Sección Datos
                  _buildInfoGrid(
                    items: [
                      InfoItem(label: 'Temporadas', value: '7+'),
                      InfoItem(label: 'Episodios', value: '60 y emitiendo'),
                      InfoItem(label: 'Género', value: 'Animación Adulta, Ciencia Ficción, Comedia'),
                      InfoItem(label: 'Creacion', value: '2013 - Actualmente'),
                    ],
                  ),
                  // Sección Personajes Principales• Summer Smith: Hermana d
                  const SizedBox(height: 24),
                  // Sección Premios
                  _buildSection(
                    title: 'Reconocimientos',
                    content:
                        'Ha sido nominada a tres premios Emmy en la categoría de Mejor Programa de Animación y ganó el galardón en 2018 y 2020. La serie también ha recibido dos premios Annie. En ocasiones, ha sido la comedia televisiva más vista entre el público adulto de 18 a 24 años.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.labBlue,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.spaceDark.withOpacity(0.5),
            border: Border.all(
              color: AppColors.labBlue.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid({required List<InfoItem> items}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.labBlue.withOpacity(0.06),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(3),
            color: AppColors.spaceDark.withOpacity(0.06),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                items[index].value,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labBlue,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                items[index].label,
                style: const TextStyle(
                  fontSize: 8,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoItem {
  final String label;
  final String value;

  InfoItem({required this.label, required this.value});
}
