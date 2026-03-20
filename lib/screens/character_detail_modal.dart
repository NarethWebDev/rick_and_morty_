import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailModal extends StatelessWidget {
  final Character character;
  const CharacterDetailModal({super.key, required this.character});

  Color get _statusColor {
    switch (character.status.toLowerCase()) {
      case 'alive':  return const Color(0xFF39FF14);
      case 'dead':   return const Color(0xFFFF4500);
      default:       return const Color(0xFFFFD700);
    }
  }

  String get _statusLabel {
    switch (character.status.toLowerCase()) {
      case 'alive':  return 'Vivo';
      case 'dead':   return 'Muerto';
      default:       return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor;

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize:     0.5,
      maxChildSize:     0.96,
      builder: (_, sc) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1F0D),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 28, spreadRadius: 3),
          ],
        ),
        child: ListView(
          controller: sc,
          padding: EdgeInsets.zero,
          children: [

            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 4),
                width: 38, height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Stack(children: [
              SizedBox(
                height: 300, width: double.infinity,
                child: Stack(fit: StackFit.expand, children: [
                  Hero(
                    tag: 'char_${character.id}',
                    child: Image.network(
                      character.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFF1A3A1A)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Color(0xFF0D1F0D), Colors.transparent],
                      ),
                    ),
                  ),
                ]),
              ),

              Positioned(
                bottom: 14, left: 16, right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withOpacity(0.85), width: 1),
                        boxShadow: [BoxShadow(color: color.withOpacity(0.35), blurRadius: 8)],
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          width: 8, height: 8,
                          decoration: BoxDecoration(
                            color: color, shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: color, blurRadius: 6)],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(_statusLabel,
                            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                      ]),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      character.name,
                      style: const TextStyle(
                        color: Color(0xFFF0E040), fontSize: 24,
                        fontWeight: FontWeight.w900, height: 1.1,
                        shadows: [Shadow(color: Color(0xFF39FF14), blurRadius: 10)],
                      ),
                    ),

                    Text(character.species,
                        style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
              ),
            ]),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(children: [
                Container(
                  width: 3, height: 16,
                  decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text('FICHA DEL PERSONAJE',
                    style: TextStyle(color: color, fontSize: 11,
                        letterSpacing: 3, fontWeight: FontWeight.bold)),
              ]),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10, mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.6,
                children: [
                  _Tile('⚧  Género',     character.gender,                                 color),
                  _Tile('🔬  Tipo',      character.type.isEmpty ? 'N/A' : character.type,  color),
                  _Tile('🌍  Origen',    character.origin,                                 color),
                  _Tile('📍  Ubicación', character.location,                               color),
                  _Tile('📺  Episodios', '${character.episodeCount} apariciones',          color),
                  _Tile('🆔  ID',        '#${character.id}',                               color),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Text('Cerrar',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white38, fontSize: 14)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String label, value;
  final Color  accent;
  const _Tile(this.label, this.value, this.accent);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF1A3A1A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, letterSpacing: 0.5)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(color: Color(0xFFF0E040), fontSize: 11, fontWeight: FontWeight.w700),
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    ),
  );
}