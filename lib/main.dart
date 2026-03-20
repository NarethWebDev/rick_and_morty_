import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../widgets/character_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick y Morty',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFF6B00),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  Future<List<Character>> fetchCharacters() async {
    final List<Character> all = [];
    for (int page = 1; page <= 2; page++) {
      final res = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body)['results'] as List<dynamic>;
        all.addAll(data.map((j) => Character.fromJson(j as Map<String, dynamic>)));
      }
    }
    return all;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A1A),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Rick y Morty',
          style: TextStyle(
            color: Color(0xFF39FF14), fontSize: 15,
            fontWeight: FontWeight.w900, letterSpacing: 2.5,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6B00), Color(0xFFCC4A00)],
          ),
        ),
        child: FutureBuilder<List<Character>>(
          future: fetchCharacters(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircularProgressIndicator(color: Color(0xFF39FF14), strokeWidth: 3),
                  SizedBox(height: 16),
                  Text('Abriendo portal...',
                      style: TextStyle(color: Color(0xFF39FF14), fontSize: 14,
                          fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                ]),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay personajes disponibles',
                  style: TextStyle(color: Colors.white70)));
            }

            final characters = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, childAspectRatio: 0.68,
                crossAxisSpacing: 8, mainAxisSpacing: 8,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final c = characters[index];
                return CharacterCard(
                  character: c,
                  onTap: () {
                  },
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (i) => setState(() => _currentTab = i),
        backgroundColor: const Color(0xFF1A3A1A),
        selectedItemColor: const Color(0xFF39FF14),
        unselectedItemColor: Colors.white38,
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Mis Favoritos'),
        ],
      ),
    );
  }
}