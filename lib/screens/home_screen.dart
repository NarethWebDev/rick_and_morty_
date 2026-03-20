import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_colors.dart';
import '../models/character_model.dart';
import '../widget/character_card.dart';
import '../widget/status_filter.dart';   // ← NUEVO

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedStatus;   

  Future<List<Character>> fetchCharacters() async {
    final List<Character> all = [];
    int page = 1;
    try {
      while (true) {
        final res = await http.get(
          Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
        );
        if (res.statusCode != 200) break;

        final body    = json.decode(res.body);
        final results = body['results'] as List<dynamic>;
        all.addAll(results.map((j) => Character.fromJson(j as Map<String, dynamic>)));

        if (body['info']['next'] == null) break;
        page++;
      }
    } catch (e) {
      debugPrint('Error al conectar con la API: $e');
    }
    return all;
  }

  List<Character> _filter(List<Character> all) {
    if (_selectedStatus == null) return all;
    return all
        .where((c) => c.status.toLowerCase() == _selectedStatus!.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.spaceDark,
      child: FutureBuilder<List<Character>>(
        future: fetchCharacters(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    color: AppColors.portalGreen, strokeWidth: 3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.portalGreen.withOpacity(0.08),
                      boxShadow: [BoxShadow(
                        color: AppColors.portalGreen.withOpacity(0.2),
                        blurRadius: 24, spreadRadius: 4,
                      )],
                    ),
                    child: const Icon(
                      Icons.travel_explore_rounded,
                      size: 52, color: AppColors.portalGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ABRIENDO PORTAL...',
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800,
                      color: AppColors.portalGreen, letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('ERROR AL CARGAR EL MULTIVERSO',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            );
          }

          final filtered = _filter(snapshot.data!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 12),
              StatusFilterBar(
                selectedStatus: _selectedStatus,
                onStatusChanged: (s) => setState(() => _selectedStatus = s),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 2),
                child: Text(
                  '${filtered.length} personajes',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('👽', style: TextStyle(fontSize: 44)),
                            SizedBox(height: 12),
                            Text(
                              'Sin personajes en este estado',
                              style: TextStyle(color: Colors.white38, fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          return CharacterCard(
                            character: filtered[index],
                            onTap: () {
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}