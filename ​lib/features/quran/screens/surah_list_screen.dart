import 'package:flutter/material.dart';
import '../../../core/database/database_helper.dart';
import 'surah_reader_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Map<String, dynamic>>> _surahsFuture;

  @override
  void initState() {
    super.initState();
    _surahsFuture = DatabaseHelper.instance.getSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Holy Quran - Surahs')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _surahsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Surahs found. Ensure local database is bundled.'));
          }

          final surahs = snapshot.data!;
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Text('${surah['number']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                title: Text(surah['english_name']),
                subtitle: Text('${surah['revelation_type']} • ${surah['ayah_count']} Ayahs'),
                trailing: Text(
                  surah['arabic_name'],
                  style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 18),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurahReaderScreen(
                        surahNumber: surah['number'],
                        surahName: surah['english_name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
