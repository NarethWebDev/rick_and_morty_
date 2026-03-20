import 'package:flutter/material.dart';
import '../app_colors.dart';

/// AppBar superior con el logo oficial de Rick and Morty.
/// Úsalo como [preferredSize] widget dentro de [Scaffold.appBar].
///
/// Ejemplo:
/// ```dart
/// Scaffold(
///   appBar: RMAppBar(),
///   ...
/// )
/// ```
class RMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RMAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  State<RMAppBar> createState() => _RMAppBarState();
}

class _RMAppBarState extends State<RMAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.appBarBg,
            border: Border(
              bottom: BorderSide(
                color: AppColors.appBarBorder.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            boxShadow: [
              // Glow verde neón pulsante
              BoxShadow(
                color: AppColors.portalGreen
                    .withOpacity(0.18 * _pulseAnimation.value),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
              // Glow azul Rick sutil
              BoxShadow(
                color: AppColors.rickBlue.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // ── Logo / Título ───────────────────────────────────────
                  Expanded(
                    child: Center(
                      child: _LogoTitle(pulseValue: _pulseAnimation.value),
                    ),
                  ),

                  // ── Botón portal (acción derecha) ───────────────────────
                  _PortalButton(pulseValue: _pulseAnimation.value),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Logo con imagen de red + fallback texto ───────────────────────────────────

class _LogoTitle extends StatelessWidget {
  final double pulseValue;
  const _LogoTitle({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow detrás del logo
        Container(
          height: 48,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.rickBlue.withOpacity(0.15 * pulseValue),
                blurRadius: 24,
                spreadRadius: 4,
              ),
              BoxShadow(
                color: AppColors.portalGreen.withOpacity(0.12 * pulseValue),
                blurRadius: 32,
                spreadRadius: 2,
              ),
            ],
          ),
        ),

        Image.network(
          'https://i.pinimg.com/736x/0f/9c/10/0f9c10dd52778bc6c0b0754f8f8f6e2b.jpg',
          height: 52,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _TextLogo(pulseValue: pulseValue);
          },
          errorBuilder: (context, error, stackTrace) {
            return _TextLogo(pulseValue: pulseValue);
          },
        ),
      ],
    );
  }
}

// ─── Fallback: título en texto estilizado ──────────────────────────────────────

class _TextLogo extends StatelessWidget {
  final double pulseValue;
  const _TextLogo({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.rickBlue, AppColors.portalGreen, AppColors.rickBlue],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        'RICK AND MORTY',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 2.5,
          shadows: [
            Shadow(
              color: AppColors.portalGreen.withOpacity(0.8 * pulseValue),
              blurRadius: 12,
            ),
            Shadow(
              color: AppColors.rickBlue.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Botón portal derecho ──────────────────────────────────────────────────────

class _PortalButton extends StatelessWidget {
  final double pulseValue;
  const _PortalButton({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.portalGreen.withOpacity(0.25),
              AppColors.rickBlue.withOpacity(0.15),
              Colors.transparent,
            ],
          ),
          border: Border.all(
            color: AppColors.portalGreen.withOpacity(0.5 + 0.3 * pulseValue),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.portalGreen.withOpacity(0.3 * pulseValue),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          Icons.search_rounded,
          color: AppColors.portalGreen.withOpacity(0.8 + 0.2 * pulseValue),
          size: 18,
        ),
      ),
    );
  }
}