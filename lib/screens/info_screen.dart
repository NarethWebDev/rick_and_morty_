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
                        'Es una serie de televisión estadounidense de animación para adultos creada por Justin Roiland y Dan Harmon para Adult Swim, también se emitió en Cartoon Network. La serie sigue las desventuras de un científico, Rick Sánchez, y su fácilmente influenciable nieto, Morty, quienes pasan el tiempo entre la vida doméstica y los viajes espaciales e intergalácticos.',
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
                      InfoItem(label: 'Género', value: 'Animación'),
                      InfoItem(label: 'Creacion', value: '2013'),
                      InfoItem(label: 'Estado', value: 'Activa'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Sección Episodios mejor calificados
                  Text(
                    'Episodios Mejor Calificados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.labBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getTopEpisodes()
                          .map((episode) => _buildEpisodeCard(context, episode))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Sección Mejores Temporadas
                  Text(
                    'Mejores Temporadas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.labBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _getTopSeasons()
                        .map((season) => _buildSeasonCard(context, season))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  // Sección Premios
                  _buildSection(
                    title: 'Reconocimientos',
                    content:
                        'Ha sido nominada a tres premios Emmy en la categoría de Mejor Programa de Animación y ganó el galardón en 2018 y 2020. La serie también ha recibido dos premios Annie.',
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

  Widget _buildEpisodeCard(BuildContext context, Episode episode) {
    return GestureDetector(
      onTap: () => _showEpisodeDetails(context, episode),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.labBlue.withOpacity(0.4),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del episodio
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  episode.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.spaceDark.withOpacity(0.5),
                    );
                  },
                ),
              ),
            ),
            // Información del episodio
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: AppColors.labBlue),
                      const SizedBox(width: 4),
                      Text(
                        episode.rating,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.labBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    episode.season,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonCard(BuildContext context, Season season) {
    return GestureDetector(
      onTap: () => _showSeasonDetails(context, season),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.labBlue.withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Imagen de la temporada
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.spaceDark.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.network(
                  season.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.spaceDark.withOpacity(0.5),
                    );
                  },
                ),
              ),
            ),
            // Información de la temporada
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      season.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: AppColors.labBlue),
                        const SizedBox(width: 6),
                        Text(
                          season.rating,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.labBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      season.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Icono de arrow
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.labBlue.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSeasonDetails(BuildContext context, Season season) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.spaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppColors.spaceDark,
            border: Border(
              top: BorderSide(
                color: AppColors.labBlue.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen grande de la temporada
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.labBlue.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        season.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.spaceDark.withOpacity(0.5),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Nombre de la temporada
                  Text(
                    season.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.labBlue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        season.rating,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.labBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.labBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    season.fullDescription,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEpisodeDetails(BuildContext context, Episode episode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.spaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppColors.spaceDark,
            border: Border(
              top: BorderSide(
                color: AppColors.labBlue.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen grande del episodio
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.labBlue.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        episode.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.spaceDark.withOpacity(0.5),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Nombre del episodio
                  Text(
                    episode.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Información general
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.labBlue.withOpacity(0.15),
                          border: Border.all(
                            color: AppColors.labBlue.withOpacity(0.4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          episode.season,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.labBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.star, color: AppColors.labBlue, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        episode.rating,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.labBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Descripción
                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.labBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    episode.description,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Episode> _getTopEpisodes() {
    return [
      Episode(
        name: 'Pickle Rick',
        season: 'T3: E3',
        rating: '9.8',
        description:
            'Rick se convierte en un encurtido para evitar asistir a la terapia familiar. Morty, Summer y Jerry lo buscan en una aventura de infiltración en el edificio de una agencia de espías.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/5/53/Pickle_Rick.jpg/330px-Pickle_Rick.jpg',
      ),
      Episode(
        name: 'El enredo de Ricklantis',
        season: 'T3: E7',
        rating: '9.7',
        description:
            'Un episodio único que sigue a varios Ricks y Mortys en la Ciudadela de Ricks. Explora diferentes versiones de los personajes viviendo en un universo artificial.',
        imageUrl:
         'https://i2.wp.com/bollonegro.com/wp-content/uploads/2017/10/The-Ricklantis-Mixup-600-1-of-1.jpg',
      ),
      Episode(
        name: 'Morty escapa en la noche',
        season: 'T2: E2',
        rating: '9.6',
        description:
            'Rick y Morty se ven atrapados en una carrera nocturna en el futuro. Un episodio accionado con giros inesperados y momentos emocionales para los personajes.',
        imageUrl:
            'https://m.media-amazon.com/images/S/pv-target-images/2a4b90dbdf4f72151540a2579705e0bf78849a070297a3acdcbbdc233220e491.jpg',
      ),
      Episode(
        name: 'Cosas necesarias',
        season: 'T1: E9',
        rating: '9.5',
        description:
            'Morty intenta organizar una cita mientras Rick se ve envuelto en un conflicto con aliados extraterrestres. Combina humor y drama con una narrativa emocionante.',
        imageUrl:
            'https://media.cdn.adultswim.com/uploads/20231031/thumbnails/2_2310311758124-AS_RAM_708_WetKuatAmorticanSummer-4.png',
      ),
      Episode(
        name: 'The Vat of Acid',
        season: 'T5: E8',
        rating: '9.4',
        description:
            'Un episodio emocionante donde Rick y Morty deben resolver un dilema moral. Presenta giros narrativos sorprendentes y momentos profundos entre los personajes.',
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/rick-and-morty-season-5-episode-8-3-1628498167.jpg',
      ),
    ];
  }

  List<Season> _getTopSeasons() {
    return [
      Season(
        name: 'Temporada 3',
        rating: '9.2',
        description: 'La temporada mejor calificada',
        fullDescription:
            'La Temporada 3 es considerada la mejor por su narrativa profunda, personajes bien desarrollados y episodios memorables como "Pickle Rick" y "The Ricklantis Mixup". Introduce muchos cambios importantes y momentos emocionales clave.',
        imageUrl:
            'https://images.justwatch.com/poster/309176032/s166/temporada-3.jpg',
      ),
      Season(
        name: 'Temporada 2',
        rating: '8.9',
        description: 'la segunda de la segunda mas valorada',
        fullDescription:
            'La Temporada 2 consolidó el éxito de la primera, presentando episodios icónicos y desarrollando más las relaciones entre personajes. Tiene un equilibrio perfecto entre comedia y drama.',
        imageUrl:
            'https://images.justwatch.com/poster/309176178/s718/temporada-2.jpg',
      ),
      Season(
        name: 'Temporada 4',
        rating: '8.6',
        description: 'Un crecimiento chueco',
        fullDescription:
            'La Temporada 4 marca un cambio en la dinámica de la serie con nuevos desafíos y enfoques narrativos. A pesar de los cambios de producción, mantiene la esencia de la serie con episodios de calidad.',
        imageUrl:
            'https://images.justwatch.com/poster/309176182/s166/temporada-4.jpg',
      ),
      Season(
        name: 'Temporada 1',
        rating: '8.4',
        description: 'Un debut imperfecto',
        fullDescription:
            'La Temporada 1 inició el fenómeno de Rick and Morty. Aunque no tiene tantos episodios como las demás, establece perfectamente el tono, los personajes y el universo que definiría la serie.',
        imageUrl:
            'https://m.media-amazon.com/images/S/pv-target-images/15012631d465805c42c69313a5587aad0b1b0ab22f12c93ae7a40dd4f9df7d50.jpg',
      ),
      Season(
        name: 'Temporada 5',
        rating: '8.1',
        description: 'Ideas no concretadas',
        fullDescription:
            'La Temporada 5 continúa la exploración de nuevas historias después de los grandes eventos de temporadas anteriores. Tiene momentos destacados pero con una dirección diferente.',
        imageUrl:
            'https://images.justwatch.com/poster/247615255/s166/temporada-5.jpg',
      ),
    ];
  }
}

class InfoItem {
  final String label;
  final String value;

  InfoItem({required this.label, required this.value});
}

class Episode {
  final String name;
  final String season;
  final String rating;
  final String description;
  final String imageUrl;

  Episode({
    required this.name,
    required this.season,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
}

class Season {
  final String name;
  final String rating;
  final String description;
  final String fullDescription;
  final String imageUrl;

  Season({
    required this.name,
    required this.rating,
    required this.description,
    required this.fullDescription,
    required this.imageUrl,
  });
}
