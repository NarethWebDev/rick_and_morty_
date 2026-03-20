import 'package:flutter/material.dart';
import '../app_colors.dart';

class RMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RMAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

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
                color: AppColors.appBarBorder.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.portalGreen
                    .withOpacity(0.15 * _pulseAnimation.value),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(width: 45), 

                  Expanded(
                    child: Center(
                      child: _LogoTitle(pulseValue: _pulseAnimation.value),
                    ),
                  ),

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

class _LogoTitle extends StatelessWidget {
  final double pulseValue;
  const _LogoTitle({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.rickBlue.withOpacity(0.2 * pulseValue),
                blurRadius: 40,
                spreadRadius: 10,
              ),
              BoxShadow(
                color: AppColors.portalGreen.withOpacity(0.15 * pulseValue),
                blurRadius: 45,
                spreadRadius: 5,
              ),
            ],
          ),
        ),

        Image.asset(
          'assets/images/logo_letras.png', 
          height: 90, 
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high, 
          errorBuilder: (context, error, stackTrace) {
            return _TextLogo(pulseValue: pulseValue);
          },
        ),
      ],
    );
  }
}

class _TextLogo extends StatelessWidget {
  final double pulseValue;
  const _TextLogo({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return Text(
      'RICK AND MORTY',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        letterSpacing: 2.0,
        shadows: [
          Shadow(
            color: AppColors.portalGreen.withOpacity(0.7 * pulseValue),
            blurRadius: 15,
          ),
        ],
      ),
    );
  }
}

class _PortalButton extends StatelessWidget {
  final double pulseValue;
  const _PortalButton({required this.pulseValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.portalGreen.withOpacity(0.4 + (0.4 * pulseValue)),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.portalGreen.withOpacity(0.2 * pulseValue),
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.search_rounded,
          color: AppColors.portalGreen.withOpacity(0.9),
          size: 22,
        ),
        onPressed: () {
        },
      ),
    );
  }
}