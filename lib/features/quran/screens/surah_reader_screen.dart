import 'package:flutter/material.dart';
import '../../../core/database/database_helper.dart';

class SurahReaderScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SurahReaderScreen({super.key, required this.surahNumber, required this.surahName});

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  late Future<List<Map<String, dynamic>>> _ayahsFuture;

  @override
  void initState() {
    super.initState();
    _ayahsFuture = DatabaseHelper.instance.getAyahsForSurah(widget.surahNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surahName)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ayahsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Ayahs not available offline for this Surah.'));
          }

          final ayahs = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              child: Text('${ayah['ayah_number']}', style: const TextStyle(fontSize: 12)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark_border, size: 20),
                              onPressed: () async {
                                await DatabaseHelper.instance.addBookmark(
                                  widget.surahNumber,
                                  ayah['ayah_number'],
                                  'Bookmarked from reader',
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Ayah bookmarked successfully')),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ayah['arabic_text'],
                          style: const TextStyle(
                            fontFamily: 'AmiriQuran',
                            fontSize: 22,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
