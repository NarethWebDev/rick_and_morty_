import 'package:flutter/material.dart';
import '../app_colors.dart';

class RMNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const RMNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<RMNavBar> createState() => _RMNavBarState();
}

class _RMNavBarState extends State<RMNavBar> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _glowAnimations;

  final List<_NavItem> _items = const [
    _NavItem(
      icon: Icons.travel_explore_rounded,
      activeIcon: Icons.travel_explore_rounded,
      label: 'Explorar',
    ),
    _NavItem(
      icon: Icons.favorite_border_rounded,
      activeIcon: Icons.favorite_rounded,
      label: 'Favoritos',
    ),
    _NavItem(
      icon: Icons.info_outline_rounded,
      activeIcon: Icons.info_rounded,
      label: 'Info',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _items.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    _scaleAnimations = _controllers
        .map(
          (c) => Tween<double>(begin: 1.0, end: 1.18).animate(
            CurvedAnimation(parent: c, curve: Curves.elasticOut),
          ),
        )
        .toList();

    _glowAnimations = _controllers
        .map(
          (c) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: c, curve: Curves.easeOut),
          ),
        )
        .toList();

    _controllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(RMNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navbarBg,
        border: const Border(
          top: BorderSide(color: AppColors.navbarBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.portalGreen.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final isActive = widget.currentIndex == index;
              return _NavBarItem(
                item: _items[index],
                isActive: isActive,
                scaleAnimation: _scaleAnimations[index],
                glowAnimation: _glowAnimations[index],
                onTap: () => widget.onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─── Item individual ───────────────────────────────────────────────────────────

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final Animation<double> scaleAnimation;
  final Animation<double> glowAnimation;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.scaleAnimation,
    required this.glowAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: Listenable.merge([scaleAnimation, glowAnimation]),
        builder: (context, _) {
          return SizedBox(
            width: 80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono con pill + glow
                Transform.scale(
                  scale: scaleAnimation.value,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.portalGreen.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: isActive
                          ? Border.all(
                              color: AppColors.portalGreen.withOpacity(0.3),
                              width: 1,
                            )
                          : null,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: AppColors.portalGreen.withOpacity(
                                  0.25 * glowAnimation.value,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isActive ? item.activeIcon : item.icon,
                      size: 22,
                      color: isActive
                          ? AppColors.navbarActive
                          : AppColors.navbarInactive,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Label
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive
                        ? AppColors.navbarActive
                        : AppColors.navbarInactive,
                    letterSpacing: isActive ? 0.8 : 0.4,
                  ),
                  child: Text(item.label.toUpperCase()),
                ),

                const SizedBox(height: 2),

                // Dot indicador activo
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  height: 3,
                  width: isActive ? 20 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.portalGreen,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.portalGreen.withOpacity(0.6),
                              blurRadius: 6,
                            ),
                          ]
                        : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Modelo de item ────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}