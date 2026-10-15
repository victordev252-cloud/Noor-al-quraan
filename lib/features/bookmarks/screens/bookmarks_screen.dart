import 'package:flutter/material.dart';
import '../../../core/database/database_helper.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Future<List<Map<String, dynamic>>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    setState(() {
      _bookmarksFuture = DatabaseHelper.instance.getBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Bookmarks')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookmarksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookmarks saved yet.'));
          }

          final bookmarks = snapshot.data!;
          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final b = bookmarks[index];
              return ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.amber),
                title: Text('Surah ${b['surah_number']} • Ayah ${b['ayah_number']}'),
                subtitle: Text(b['note'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    await DatabaseHelper.instance.removeBookmark(b['id']);
                    _loadBookmarks();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
