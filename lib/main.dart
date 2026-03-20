import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'components/rm_appbar.dart';
import 'components/rm_footer.dart';
import 'components/rm_navbar.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.spaceDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.portalGreen,
          secondary: AppColors.rickBlue,
          tertiary: AppColors.mortyYellow,
          surface: AppColors.spaceCard,
        ),
      ),
      home: const _AppShell(),
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar superior con logo oficial ───────────────────────────────
      appBar: const RMAppBar(),

      // ── Contenido: mantiene estado al cambiar de tab ───────────────────
      body: IndexedStack(index: _currentIndex, children: _screens),

      // ── Navbar inferior + Footer ────────────────────────────────────────
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RMNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
          const RMFooter(),
        ],
      ),
    );
  }
}
