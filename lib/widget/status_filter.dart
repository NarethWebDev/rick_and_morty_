import 'package:flutter/material.dart';
import '../app_colors.dart';

class StatusFilterBar extends StatelessWidget {
  final String?               selectedStatus;
  final ValueChanged<String?> onStatusChanged;

  const StatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  static const _options = <String?>[null, 'Alive', 'Dead', 'unknown'];

  Color _color(String? s) {
    switch (s?.toLowerCase()) {
      case 'alive':   return const Color(0xFF39FF14); 
      case 'dead':    return const Color(0xFFFF4500); 
      case 'unknown': return const Color(0xFFFFD700); 
      default:        return AppColors.rickBlue;      
    }
  }

  String _label(String? s) {
    switch (s?.toLowerCase()) {
      case 'alive':   return '🟢  Vivo';
      case 'dead':    return '🔴  Muerto';
      case 'unknown': return '🟡  Desconocido';
      default:        return '🌀  Todos';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final s      = _options[i];
          final active = selectedStatus == s;
          final color  = _color(s);

          return GestureDetector(
            onTap: () => onStatusChanged(s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: active
                    ? color.withOpacity(0.18)
                    : AppColors.spaceCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? color : Colors.white24,
                  width: active ? 1.5 : 1,
                ),
                boxShadow: active
                    ? [BoxShadow(color: color.withOpacity(0.35), blurRadius: 10)]
                    : [],
              ),
              child: Text(
                _label(s),
                style: TextStyle(
                  color: active ? color : Colors.white54,
                  fontSize: 11,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}